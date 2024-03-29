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
  datestamp date NOT NULL,
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
	p_total_stockholder_equity		trading_schema.earnings_data.total_stockholder_equity%TYPE
	) RETURNS integer AS $$
DECLARE
	v_inserted_id	integer := 0;
	v_symbol_id		trading_schema.symbol.id%TYPE := NULL;
BEGIN
	-- Get the symbol id
	SELECT
		id
	INTO
		v_symbol_id
	FROM
		trading_schema.symbol s
	WHERE
		s.symbol = p_symbol
	;
	-- Insert the details
	INSERT INTO
		trading_schema.earnings_data
		(
			symbol_id,
			datestamp,
			report_type,
			earnings_per_share,
			total_revenue,
			cost_of_revenue,
			gross_profit,
			total_assets,
			total_liabilities,
			total_income_available_shares,
			common_stock,
			retained_earnings,
			total_stockholder_equity
		)
	VALUES
		(
			v_symbol_id,
			p_datestamp,
			p_report_type,
			p_earnings_per_share,
			p_total_revenue,
			p_cost_of_revenue,
			p_gross_profit,
			p_total_assets,
			p_total_liabilities,
			p_total_income_available_shares,
			p_common_stock,
			p_retained_earnings,
			p_total_stockholder_equity
		)
		ON CONFLICT ON CONSTRAINT uc_earnings_data_1 DO UPDATE SET
				earnings_per_share				=	EXCLUDED.earnings_per_share,
				total_revenue					=	EXCLUDED.total_revenue,
				cost_of_revenue					=	EXCLUDED.cost_of_revenue,
				gross_profit					=	EXCLUDED.gross_profit,
				total_assets					=	EXCLUDED.total_assets,
				total_liabilities				=	EXCLUDED.total_liabilities,
				total_income_available_shares	=	EXCLUDED.total_income_available_shares,
				common_stock					=	EXCLUDED.common_stock,
				retained_earnings				=	EXCLUDED.retained_earnings,
				total_stockholder_equity		=	EXCLUDED.total_stockholder_equity
		;
	-- Get the inserted index
	SELECT
		*
	INTO
		v_inserted_id
	FROM
		LASTVAL();
	-- DONE
	RETURN v_inserted_id;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pInsertEarningData OWNER TO trading;

-- Procedure to Categorise a single symbol LIST
CREATE OR REPLACE FUNCTION trading_schema.pInsertEarningDataList(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_length						integer,
	p_report_type					trading_schema.earnings_data.report_type%TYPE,
	--
	p_datestamp						date[],
	p_earnings_per_share			numeric[],
	p_total_revenue					numeric[],
	p_cost_of_revenue				numeric[],
	p_gross_profit					numeric[],
	p_total_assets					numeric[],
	p_total_liabilities				numeric[],
	p_total_income_available_shares	numeric[],
	p_common_stock					numeric[],
	p_retained_earnings				numeric[],
	p_total_stockholder_equity		numeric[]
	) RETURNS void AS $$
DECLARE
	v_looped		text;
	v_iterator		integer;

BEGIN
	-- Call the trading_schema.pInsertEarningData for each entry
	-- NOTE: PSQL is 1-indexed (not zero!)
	FOR v_iterator IN (SELECT * FROM generate_series(1,p_length)) LOOP
		SELECT
			*
		INTO
			v_looped
		FROM
		trading_schema.pInsertEarningData(
			p_symbol,
			p_datestamp[v_iterator],
			p_report_type,
			p_earnings_per_share[v_iterator],
			p_total_revenue[v_iterator],
			p_cost_of_revenue[v_iterator],
			p_gross_profit[v_iterator],
			p_total_assets[v_iterator],
			p_total_liabilities[v_iterator],
			p_total_income_available_shares[v_iterator],
			p_common_stock[v_iterator],
			p_retained_earnings[v_iterator],
			p_total_stockholder_equity[v_iterator]
		);
		raise notice 'Looped rows changed %', v_looped;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pInsertEarningDataList OWNER TO trading;

