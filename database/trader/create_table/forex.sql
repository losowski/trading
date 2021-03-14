-- Table: trading_schema.forex
CREATE SEQUENCE trading_schema.forex_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.forex_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.forex
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.forex_id_seq'::regclass),
  transaction_id bigint NOT NULL,
  fxsymbol_from bigint NOT NULL,
  fxsymbol_to bigint NOT NULL,
  exchange_rate numeric NOT NULL,
  quantity integer NOT NULL,
  CONSTRAINT pk_forex_id PRIMARY KEY (id),
  CONSTRAINT fk_forex_transaction_id FOREIGN KEY (transaction_id)
      REFERENCES trading_schema.transaction (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_forex_fxsymbol_from FOREIGN KEY (fxsymbol_from)
      REFERENCES trading_schema.fxsymbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_forex_fxsymbol_to FOREIGN KEY (fxsymbol_to)
      REFERENCES trading_schema.fxsymbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION, 
  CONSTRAINT ck_forex_quantity CHECK (quantity > 0) NOT VALID,
  CONSTRAINT ck_forex_exchange_rate CHECK (exchange_rate > 0) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.forex
  OWNER TO trading;


-- Index: trading_schema.idx_forex_transaction_id
CREATE UNIQUE INDEX idx_forex_transaction_id
  ON trading_schema.forex
  USING btree
  (transaction_id);

-- Index: trading_schema.idx_forex_fx_symbol_from
CREATE INDEX idx_forex_fxsymbol_from
  ON trading_schema.forex
  USING btree
  (fxsymbol_from);

-- Index: trading_schema.idx_forex_fx_symbol_to
CREATE INDEX idx_forex_fxsymbol_to
  ON trading_schema.forex
  USING btree
  (fxsymbol_to);
