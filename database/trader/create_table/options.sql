-- Table: trading_schema.option
CREATE SEQUENCE trading_schema.option_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.option_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.option
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.option_id_seq'::regclass),
  transaction_id bigint NOT NULL,
  symbol_id bigint NOT NULL,
  strike numeric(6,2) NOT NULL
  expiry timestamp without time zone NOT NULL,
  option_type character(1) NOT NULL,
  cost numeric(6,2) NOT NULL,
  quantity integer NOT NULL,
  CONSTRAINT pk_option_id PRIMARY KEY (id),
  CONSTRAINT fk_option_transaction_id FOREIGN KEY (transaction_id)
      REFERENCES trading_schema.transaction (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_option_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT ck_option_option_type CHECK (enabled = ANY (ARRAY['C'::bpchar, 'P'::bpchar])) NOT VALID,
  CONSTRAINT ck_option_quantity CHECK (quantity > 0) NOT VALID,
  CONSTRAINT ck_option_cost CHECK (cost != 0) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.option
  OWNER TO trading;


-- Index: trading_schema.idx_option_transaction_id
CREATE INDEX idx_option_transaction_id
  ON trading_schema.option
  USING btree
  (transaction_id);

-- Index: trading_schema.idx_option_symbol_id
CREATE INDEX idx_option_symbol_id
  ON trading_schema.option
  USING btree
  (symbol_id);

-- Index: trading_schema.idx_option_expiry
CREATE INDEX idx_option_expiry
  ON trading_schema.option
  USING btree
  (expiry);

-- TODO: INSERT option
