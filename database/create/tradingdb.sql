
-- Table: trading_schema.exchange
CREATE SEQUENCE trading_schema.exchange_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 25
  CACHE 1;
ALTER TABLE trading_schema.exchange_id_seq
  OWNER TO trading;
CREATE TABLE trading_schema.exchange
(
  id bigserial NOT NULL,
  name text NOT NULL,
  CONSTRAINT pk_exchange PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
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




-- Table: trading_schema.quote
CREATE SEQUENCE trading_schema.quote_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 8938
  CACHE 1;
ALTER TABLE trading_schema.quote_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.quote
(
  id bigserial NOT NULL,
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



-- Table: trading_schema.key_statistics
CREATE SEQUENCE trading_schema.key_statistics_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.key_statistics_id_seq
  OWNER TO trading;


