-- Table: trading_schema.earnings
CREATE SEQUENCE trading_schema.earnings_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.earnings_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.earnings
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.earnings_id_seq'::regclass),
  symbol_id bigint NOT NULL,
  datestamp timestamp without time zone NOT NULL,
  report_type character(1) NOT NULL,
  date_start timestamp without time zone NOT NULL,
  date_end timestamp without time zone NOT NULL,
  CONSTRAINT pk_earnings_id PRIMARY KEY (id),
  CONSTRAINT fk_earnings_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_earnings_1 UNIQUE (symbol_id, year, quarter),
  CONSTRAINT ck_earnings_report_type CHECK (report_type = ANY (ARRAY['Q'::bpchar, 'Y'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.earnings
  OWNER TO trading;

CREATE UNIQUE INDEX idx_earnings_id
  ON trading_schema.earnings
  USING btree
  (id);

CREATE INDEX idx_datestamp_type
  ON trading_schema.earnings
  USING btree
  (datestamp, report_type);

CREATE INDEX idx_symbol_datestamp_report_type
  ON trading_schema.earnings
  USING btree
  (symbol_id, datestamp, report_type);

CREATE INDEX idx_earnings_date_start
  ON trading_schema.earnings
  USING btree
  (date_start);

CREATE INDEX idx_earnings_date_end
  ON trading_schema.earnings
  USING btree
  (date_end);


-- Stored Procedures --
