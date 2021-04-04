-- Table: trading_schema.earnings_data
CREATE SEQUENCE trading_schema.earnings_data_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.earnings_data_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.earnings_data
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.earnings_data_id_seq'::regclass),
  symbol_id bigint NOT NULL,
  datestamp timestamp without time zone NOT NULL,
  report_type character(1) NOT NULL default 'Q'::bpchar,
  enabled character(1) NOT NULL default 'Y'::bpchar,
  -- Data
  earnings_per_share numeric,
  total_revenue numeric,
  cost_of_revenue numeric,
  gross_profit numeric,
  total_assets numeric,
  total_liabilities numeric,
  total_income_available_shares numeric,
  common_stock numeric,
  retained_earnings numeric,
  total_stockholder_equity numeric,
  return_on_equity numeric,
  CONSTRAINT pk_earnings_data_id PRIMARY KEY (id),
  CONSTRAINT fk_earnings_data_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_earnings_data_1 UNIQUE (symbol_id, datestamp, report_type),
  CONSTRAINT ck_earnings_data_report_type CHECK (report_type = ANY (ARRAY['Q'::bpchar, 'Y'::bpchar])) NOT VALID,
  CONSTRAINT ck_symbol_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar, '-'::bpchar, '?'    ::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.earnings_data
  OWNER TO trading;


-- Index: trading_schema.idx_earnings_data_id
CREATE UNIQUE INDEX idx_earnings_data_id
  ON trading_schema.earnings_data
  USING btree
  (id);


-- Index: trading_schema.idx_earnings_data_datestamp_report_type
CREATE INDEX idx_earnings_data_datestamp_report_type
  ON trading_schema.earnings_data
  USING btree
  (datestamp, report_type);


-- Index: trading_schema.idx_earnings_data_symbol_datestamp_report_type
CREATE INDEX idx_earnings_data_symbol_datestamp_report_type
  ON trading_schema.earnings_data
  USING btree
  (symbol_id, datestamp, report_type);


-- Index: trading_schema.idx_earnings_data_enabled
CREATE INDEX idx_earnings_data_enabled
  ON trading_schema.earnings_data
  USING btree
  (enabled COLLATE pg_catalog."default");


-- Stored Procedures --
