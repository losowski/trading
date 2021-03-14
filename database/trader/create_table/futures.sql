-- Table: trading_schema.future
CREATE SEQUENCE trading_schema.future_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.future_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.future
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.future_id_seq'::regclass),
  transaction_id bigint NOT NULL,
  symbol_id bigint NOT NULL,
  price numeric NOT NULL,
  strike numeric(6,2) NOT NULL,
  expiry timestamp without time zone NOT NULL,
  future_type character(1) NOT NULL,
  future_cost numeric(6,2) NOT NULL,
  quantity integer NOT NULL,
  CONSTRAINT pk_future_id PRIMARY KEY (id),
  CONSTRAINT fk_future_transaction_id FOREIGN KEY (transaction_id)
      REFERENCES trading_schema.transaction (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_future_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ck_future_future_type CHECK (enabled = ANY (ARRAY['C'::bpchar, 'P'::bpchar])) NOT VALID,
  CONSTRAINT ck_future_quantity CHECK (quantity > 0) NOT VALID,
  CONSTRAINT ck_future_cost CHECK (cost != 0) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.future
  OWNER TO trading;


-- Index: trading_schema.idx_future_transaction_id
CREATE UNIQUE INDEX idx_future_transaction_id
  ON trading_schema.future
  USING btree
  (transaction_id);

-- Index: trading_schema.idx_future_symbol_id
CREATE INDEX idx_future_symbol_id
  ON trading_schema.future
  USING btree
  (symbol_id);

-- Index: trading_schema.idx_future_expiry
CREATE INDEX idx_future_expiry
  ON trading_schema.future
  USING btree
  (expiry);


-- INSERT future
CREATE OR REPLACE FUNCTION trading_schema.pInsfuture(
	p_transaction_id			trading_schema.future.tx_type%TYPE,
	p_symbol					trading_schema.symbol.symbol%TYPE,
	p_price						trading_schema.future.price%TYPE,
	p_strike					trading_schema.future.price%TYPE,
	p_expiry					trading_schema.future.expiry%TYPE,
	p_future_type				trading_schema.future.future_type%TYPE,
	p_future_cost				trading_schema.future.future_cost%TYPE,
	p_quantity					trading_schema.future.quantity%TYPE
	) RETURNS integer AS $$
DECLARE
	v_symbol_id		trading_schema.symbol.id%TYPE := NULL;
	inserted_id		integer := 0;
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
	-- Perform the insert
	INSERT INTO
	trading_schema.future
		(
			transaction_id,
			symbol_id,
			price,
			strike,
			expiry,
			future_type,
			future_cost,
			quantity
		)
	VALUES
		(
			p_transaction_id,
			v_symbol_id,
			p_price,
			p_strike,
			p_expiry,
			p_future_type,
			p_future_cost,
			p_quantity
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
ALTER FUNCTION trading_schema.pInsfuture OWNER TO trading;
