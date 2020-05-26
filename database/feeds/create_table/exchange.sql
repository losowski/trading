-- Table: trading_schema.exchange
CREATE SEQUENCE trading_schema.exchange_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.exchange_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.exchange
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.exchange_id_seq'::regclass),
  name text NOT NULL,
  CONSTRAINT pk_exchange PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.exchange
  OWNER TO trading;

-- Index: trading_schema.idx_exchange_id
CREATE INDEX idx_exchange_id
  ON trading_schema.exchange
  USING btree
  (id);

-- Index: trading_schema.idx_exchange_name
CREATE UNIQUE INDEX idx_exchange_name
  ON trading_schema.exchange
  USING btree
  (name COLLATE pg_catalog."default");


-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsExchange(
	p_exchange	trading_schema.exchange.name%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.exchange
		(
			name
		)
	VALUES
		(
			p_exchange
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
ALTER FUNCTION trading_schema.pInsExchange OWNER TO trading;
