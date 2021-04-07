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
  CONSTRAINT ck_earnings_data_report_type CHECK (report_type = ANY (ARRAY['Q'::bpchar, 'Y'::bpchar])) NOT VALID
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


-- Stored Procedures --

-- Procedure to Categorise a single symbol
CREATE OR REPLACE FUNCTION trading_schema.pInsertEarningData(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_datestamp						trading_schema.earnings_data.datestamp%TYPE,
	p_report_type					trading_schema.earnings_data.report_type%TYPE,
	--
	p_earnings_per_share			trading_schema.earnings_data.earnings_per_share%TYPE,
	p_total_revenue					trading_schema.earnings_data.total_revenue%TYPE,
	p_cost_of_revenue				trading_schema.earnings_data.cost_of_revenue%TYPE,
	p_gross_profit					trading_schema.earnings_data.gross_profit%TYPE,
	p_total_assets					trading_schema.earnings_data.total_assets%TYPE,
	p_total_liabilities				trading_schema.earnings_data.total_liabilities%TYPE,
	p_total_income_available_shares	trading_schema.earnings_data.total_income_available_shares%TYPE,
	p_common_stock					trading_schema.earnings_data.common_stock%TYPE,
	p_retained_earnings				trading_schema.earnings_data.retained_earnings%TYPE,
	p_total_stockholder_equity		trading_schema.earnings_data.total_stockholder_equity%TYPE,
	p_return_on_equity				trading_schema.earnings_data.return_on_equity%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
	symbol_id trading_schema.symbol.id%TYPE := NULL;
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
	-- Inser the details
	-- Get the inserted index
	SELECT
		*
	INTO
		inserted_id
	FROM
	-- DONE
	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

