-- Table: trading_schema.quote
CREATE SEQUENCE trading_schema.quote_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.quote_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.quote
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.quote_id_seq'::regclass),
  symbol_id bigint,
  datestamp timestamp without time zone NOT NULL,
  volume bigint NOT NULL,
  adjusted_close_price numeric NOT NULL,
  open_price numeric NOT NULL,
  close_price numeric NOT NULL,
  high_price numeric NOT NULL,
  low_price numeric NOT NULL,
  CONSTRAINT pk_quote_id PRIMARY KEY (id),
  CONSTRAINT fk_quote_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_quote_1 UNIQUE (symbol_id, datestamp)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.quote
  OWNER TO trading;

CREATE INDEX idx_quote_datestamp
  ON trading_schema.quote
  USING btree
  (datestamp);

CREATE INDEX idx_symbol_id
  ON trading_schema.quote
  USING btree
  (symbol_id NULLS FIRST);


-- Stored Procedures --
-- InsQuote(%(symbol), %(date), %(open_price), %(high_price), %(low_price), %(close_price), %(adj_close_price), %(volume))
CREATE OR REPLACE FUNCTION trading_schema.pInsQuote(
	p_symbol				trading_schema.symbol.symbol%TYPE,
	p_date					trading_schema.quote.datestamp%TYPE,
	p_open_price			trading_schema.quote.open_price%TYPE,
	p_high_price		  	trading_schema.quote.high_price%TYPE,
	p_low_price				trading_schema.quote.low_price%TYPE,
	p_close_price			trading_schema.quote.close_price%TYPE,
	p_adj_close_price		trading_schema.quote.adjusted_close_price%TYPE,
	p_volume				trading_schema.quote.volume%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.quote
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
			(SELECT id FROM trading_schema.symbol WHERE symbol=p_symbol),
			p_date,
			p_open_price,
			p_high_price,
			p_low_price,
			p_close_price,
			p_adj_close_price,
			p_volume
		);

	SELECT
		*
	INTO
		inserted_id
	FROM
		LASTVAL();

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

