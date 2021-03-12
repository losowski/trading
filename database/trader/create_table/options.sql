-- Table: trading_schema.options
CREATE SEQUENCE trading_schema.options_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.options_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.options
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.options_id_seq'::regclass),
  symbol_id bigint NOT NULL,
  strike numeric (6,2) NOT NULL
  expiry timestamp without time zone NOT NULL,
  option_type character(1) NOT NULL,
  cost numeric(6,2) NOT NULL,
  quantity int NOT NULL,
  CONSTRAINT pk_options_id PRIMARY KEY (id),
  CONSTRAINT fk_options_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ck_options_option_type CHECK (enabled = ANY (ARRAY['C'::bpchar, 'P'::bpchar])) NOT VALID,
  CONSTRAINT ck_options_quantity CHECK (quantity > 0) NOT VALID,
  CONSTRAINT ck_options_cost CHECK (cost != 0) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.options
  OWNER TO trading;

CREATE INDEX idx_options_datestamp
  ON trading_schema.options
  USING btree
  (datestamp);

CREATE INDEX idx_symbol_id
  ON trading_schema.options
  USING btree
  (symbol_id NULLS FIRST);


-- Stored Procedures --
-- InsOptions(%(symbol), %(date), %(open_price), %(high_price), %(low_price), %(close_price), %(adj_close_price), %(volume))
CREATE OR REPLACE FUNCTION trading_schema.pInsOptions(
	p_symbol				trading_schema.symbol.symbol%TYPE,
	p_date					trading_schema.options.datestamp%TYPE,
	p_open_price			trading_schema.options.open_price%TYPE,
	p_high_price			trading_schema.options.high_price%TYPE,
	p_low_price				trading_schema.options.low_price%TYPE,
	p_close_price			trading_schema.options.close_price%TYPE,
	p_adj_close_price		trading_schema.options.adjusted_close_price%TYPE,
	p_volume				trading_schema.options.volume%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
	symbol_id trading_schema.symbol.id%TYPE := NULL;
BEGIN
	-- Get the symbol id
	SELECT
		id
	INTO
		symbol_id
	FROM
		trading_schema.symbol
	WHERE
		symbol = p_symbol
	;
	-- Insert the options
	INSERT INTO
	trading_schema.options
		(
			symbol_id,
			datestamp,
			open_price,
			high_price,
			low_price,
			close_price,
			adjusted_close_price,
			volume
		)
	VALUES
		(
			symbol_id,
			p_date,
			p_open_price,
			p_high_price,
			p_low_price,
			p_close_price,
			p_adj_close_price,
			p_volume
		);

	-- Call the update function
	UPDATE trading_schema.symbol SET last_update = localtimestamp WHERE id = symbol_id;
	-- Get the inserted index
	SELECT
		*
	INTO
		inserted_id
	FROM
		LASTVAL();

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;


-- Ownership
ALTER FUNCTION trading_schema.pInsOptions OWNER TO trading;


-- Categorise the prices
CREATE OR REPLACE FUNCTION trading_schema.pCategorise(
	p_price			numeric
	) RETURNS smallint AS $$
DECLARE
	v_category		smallint := 0;
BEGIN
	-- Calculate category
	IF p_price >= 10000 THEN
		v_category := 4;
	ELSIF p_price >= 1000 THEN
		v_category := 3;
	ELSIF p_price >= 100 THEN
		v_category := 2;
	ELSIF p_price >= 10 THEN
		v_category := 1;
	ELSE
		v_category := 0;
	END IF;

	-- Return value
	RETURN v_category;
END;
$$ LANGUAGE plpgsql;



-- Procedure to Categorise a single symbol
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseSymbol(
	p_symbol		trading_schema.symbol.symbol%TYPE,
	p_date			trading_schema.symbol.last_update%TYPE,
	p_interval		varchar(10) default '365 days'
	) RETURNS void AS $$
DECLARE
	v_price			numeric := 0;
	v_category		smallint := NULL;
BEGIN
	-- Get minimum price
	SELECT
		MIN(q.open_price)
	INTO
		v_price
	FROM
		trading_schema.symbol s
		INNER JOIN trading_schema.options q ON (q.symbol_id = s.id)

	WHERE
		s.symbol = p_symbol
	AND
		q.datestamp <= p_date
	AND
		q.datestamp >= p_date -  p_interval::interval
	;
	-- Generate category
	SELECT
		pcategorise
	INTO
		v_category
	FROM
		trading_schema.pCategorise(v_price)
	;
	-- Update the table
	UPDATE trading_schema.symbol SET category = v_category WHERE symbol = p_symbol;
	-- DONE
END;
$$ LANGUAGE plpgsql;


-- Process all symbols
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseActiveSymbols(
	p_category			trading_schema.symbol.category%TYPE,
	p_timeperiod		varchar(10) default '180 days'
	) RETURNS void AS $$
DECLARE
	v_symbols	RECORD;
	v_looped	text;
BEGIN
	-- Iterate over query
	FOR v_symbols IN SELECT
			symbol,
			last_update
		FROM
			trading_schema.exchange e
			INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND s.enabled = 'Y')
		WHERE
			e.enabled = 'Y'
		AND
			(s.category IS NULL OR s.category = p_category)
		ORDER BY
			s.symbol
		LOOP

		-- Call trading_schema.pCategoriseSymbol
		SELECT pCategoriseSymbol::text INTO v_looped FROM trading_schema.pCategoriseSymbol(v_symbols.symbol::text, v_symbols.last_update::timestamp without time zone, p_timeperiod);
	END LOOP;
	-- DONE
END;
$$ LANGUAGE plpgsql;
