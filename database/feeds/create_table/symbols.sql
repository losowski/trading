-- Table: trading_schema.symbol
CREATE SEQUENCE trading_schema.symbol_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 6
  CACHE 1;
ALTER TABLE trading_schema.symbol_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.symbol
(
  id bigserial NOT NULL,
  exchange_id bigint NOT NULL,
  name text NOT NULL,
  symbol text NOT NULL,
  CONSTRAINT pk_symbol PRIMARY KEY (id),
  CONSTRAINT fk_symbol_exchange_id FOREIGN KEY (exchange_id)
      REFERENCES trading_schema.exchange (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_symbol UNIQUE (symbol)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.symbol
  OWNER TO trading;

-- Index: trading_schema.fki_symbol_exchange_id
CREATE INDEX fki_symbol_exchange_id
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

-- Stored Procedures --
﻿-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsSymbol(
	p_exchange	trading_schema.exchange.name%TYPE,
	p_name		trading_schema.symbol.name%TYPE,
	p_symbol	trading_schema.symbol.symbol%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.symbol
		(
			exchange_id,
			symbol,
			name
		)
	VALUES
		(
			(SELECT id FROM trading_schema.exchange WHERE name=p_exchange),
			p_symbol,
			p_name
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

-- Ownership
ALTER FUNCTION trading_schema.pInsSymbol OWNER TO trading;
