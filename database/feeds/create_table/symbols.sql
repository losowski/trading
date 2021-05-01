-- Table: trading_schema.symbol
CREATE SEQUENCE trading_schema.symbol_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.symbol_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.symbol
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.symbol_id_seq'::regclass),
  exchange_id bigint NOT NULL,
  name text NOT NULL,
  symbol text NOT NULL,
  enabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar,
  last_update timestamp without time zone,
  category smallint,
  CONSTRAINT pk_symbol PRIMARY KEY (id),
  CONSTRAINT fk_symbol_exchange_id FOREIGN KEY (exchange_id)
      REFERENCES trading_schema.exchange (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_symbol UNIQUE (symbol),
  CONSTRAINT ck_symbol_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar, '-'::bpchar, '?'::bpchar, 'P'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.symbol
  OWNER TO trading;

-- Index: trading_schema.idx_symbol_exchange_id
CREATE INDEX idx_symbol_exchange_id
  ON trading_schema.symbol
  USING btree
  (exchange_id);

-- Index: trading_schema.idx_symbol_name
CREATE INDEX idx_symbol_name
  ON trading_schema.symbol
  USING btree
  (name COLLATE pg_catalog."default");

-- Index: trading_schema.idx_symbol_symbol
CREATE INDEX idx_symbol_symbol
  ON trading_schema.symbol
  USING btree
  (symbol COLLATE pg_catalog."default");

-- Index: trading_schema.idx_symbol_enabled
CREATE INDEX idx_symbol_enabled
  ON trading_schema.symbol
  USING btree
  (enabled COLLATE pg_catalog."default");

-- Index: trading_schema.idx_symbol_last_update
CREATE INDEX idx_symbol_last_update
  ON trading_schema.symbol
  USING btree
  (last_update COLLATE pg_catalog."default");

-- Index: trading_schema.idx_symbol_category
CREATE INDEX idx_symbol_category
  ON trading_schema.symbol
  USING btree
  (category COLLATE pg_catalog."default");

-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsSymbol(
	p_exchange	trading_schema.exchange.name%TYPE,
	p_name		trading_schema.symbol.name%TYPE,
	p_symbol	trading_schema.symbol.symbol%TYPE
	) RETURNS integer AS $$
DECLARE
	ex_id trading_schema.symbol.exchange_id%TYPE := NULL;
	inserted_id integer := 0;
BEGIN
	-- Get Exchange ID
	SELECT
		id
	INTO
		ex_id
	FROM
		trading_schema.exchange
	WHERE
		name = p_exchange
	;
	-- TODO: Break on "no_data" with RAISE "Exchange not found"
	-- Insert data
	INSERT INTO trading_schema.symbol (exchange_id, symbol, name) VALUES (ex_id, p_symbol, p_name);

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
ALTER FUNCTION trading_schema.pInsSymbol OWNER TO trading;


-- Disable Symbol
CREATE OR REPLACE FUNCTION trading_schema.pDisableSymbol(
	p_name		trading_schema.symbol.name%TYPE,
	p_setting		trading_schema.symbol.enabled%TYPE default '-'
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.symbol SET enabled = p_setting WHERE symbol = p_name;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableSymbol OWNER TO trading;

-- Enable Symbol
CREATE OR REPLACE FUNCTION trading_schema.pEnableSymbol(
	p_name		trading_schema.symbol.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.symbol SET enabled = 'Y' WHERE symbol = p_name;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableSymbol OWNER TO trading;
