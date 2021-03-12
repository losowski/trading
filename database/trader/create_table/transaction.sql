-- Table: trading_schema.transaction
CREATE SEQUENCE trading_schema.transaction_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.transaction_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.transaction
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.transaction_id_seq'::regclass),
  datestamp timestamp without time zone NOT NULL,
  tx_type character(1) NOT NULL,
  cost numeric(6,2) NOT NULL,
  current_price numeric NOT NULL,
  prediction numeric,
  closed_datestamp timestamp without time zone,
  cost numeric(6,2),
  CONSTRAINT pk_transaction PRIMARY KEY (id),
  CONSTRAINT ck_transaction_enabled CHECK (enabled = ANY (ARRAY['O'::bpchar, 'S'::bpchar, 'F'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.transaction
  OWNER TO trading;

-- Index: trading_schema.idx_transaction_id
CREATE INDEX idx_transaction_id
  ON trading_schema.transaction
  USING btree
  (id);

-- Index: trading_schema.idx_transaction_datestamp
CREATE UNIQUE INDEX idx_transaction_datestamp
  ON trading_schema.transaction
  USING btree
  (datestamp COLLATE pg_catalog."default");


-- Index: trading_schema.idx_transaction_tx_type
CREATE UNIQUE INDEX idx_transaction_tx_type
  ON trading_schema.transaction
  USING btree
  (tx_type COLLATE pg_catalog."default");


-- Index: trading_schema.idx_transaction_closed_datestamp
CREATE UNIQUE INDEX idx_transaction_closed_datestamp
  ON trading_schema.transaction
  USING btree
  (closed_datestamp COLLATE pg_catalog."default");



-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsTransaction(
	p_transaction	trading_schema.transaction.name%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.transaction
		(
			name
		)
	VALUES
		(
			p_transaction
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
ALTER FUNCTION trading_schema.pInsTransaction OWNER TO trading;
