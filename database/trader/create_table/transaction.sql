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
  tx_type character(1) NOT NULL,
  open_datestamp timestamp without time zone NOT NULL,
  open_cost numeric(6,2) NOT NULL,
  closed_datestamp timestamp without time zone,
  close_cost numeric(6,2),
  CONSTRAINT pk_transaction PRIMARY KEY (id),
  CONSTRAINT ck_transaction_tx_type CHECK (tx_type = ANY (ARRAY['O'::bpchar, 'S'::bpchar, 'F'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.transaction
  OWNER TO trading;

-- Index: trading_schema.idx_transaction_id
CREATE UNIQUE INDEX idx_transaction_id
  ON trading_schema.transaction
  USING btree
  (id);

-- Index: trading_schema.idx_transaction_open_datestamp
CREATE INDEX idx_transaction_open_datestamp
  ON trading_schema.transaction
  USING btree
  (open_datestamp);


-- Index: trading_schema.idx_transaction_tx_type
CREATE INDEX idx_transaction_tx_type
  ON trading_schema.transaction
  USING btree
  (tx_type COLLATE pg_catalog."default");


-- Index trading_schema.idx_transaction_closed_datestamp
CREATE INDEX idx_transaction_closed_datestamp
  ON trading_schema.transaction
  USING btree
  (closed_datestamp);



-- Stored Procedures --
-- INSERT Open transaction
CREATE OR REPLACE FUNCTION trading_schema.pInsTransaction(
	p_tx_type				trading_schema.transaction.tx_type%TYPE,
	p_open_cost				trading_schema.transaction.open_cost%TYPE,
	p_open_datestamp		trading_schema.transaction.open_datestamp%TYPE default NULL
	) RETURNS integer AS $$
DECLARE
	v_datestamp			trading_schema.transaction.open_datestamp%TYPE;
	inserted_id			integer := 0;
BEGIN
	-- If datestamp is NULL, replace with localtimestamp
	IF p_open_datestamp IS NULL THEN
		SELECT
			localtimestamp
		INTO
			v_datestamp
			;
	ELSE
		v_datestamp = p_open_datestamp;
	END IF;
	-- Perform the insert
	INSERT INTO
	trading_schema.transaction
		(
			tx_type,
			open_cost,
			open_datestamp
		)
	VALUES
		(
			p_tx_type,
			p_open_cost,
			v_datestamp
		);
	-- Get the tansactionID that was inserted
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


-- Close Transaction
CREATE OR REPLACE FUNCTION trading_schema.pCloseTransaction(
	p_id					trading_schema.transaction.id%TYPE,
	p_close_cost			trading_schema.transaction.close_cost%TYPE,
	p_closed_datestamp		trading_schema.transaction.closed_datestamp%TYPE default NULL
	) RETURNS integer AS $$
DECLARE
	v_datestamp			trading_schema.transaction.closed_datestamp%TYPE;
	inserted_id			integer := 0;
BEGIN
	-- If datestamp is NULL, replace with localtimestamp
	IF p_closed_datestamp IS NULL THEN
		SELECT
			localtimestamp
		INTO
			v_datestamp
			;
	ELSE
		v_datestamp = p_closed_datestamp;
	END IF;
	-- Add a select for update if needed
	-- Perform the Update
	UPDATE
	trading_schema.transaction
	SET
		close_cost = p_close_cost,
		closed_datestamp = v_datestamp
	WHERE
		id = p_id;
	-- Get the tansactionID that was inserted
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
ALTER FUNCTION trading_schema.pCloseTransaction OWNER TO trading;
