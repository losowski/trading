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


-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsExchange(
	p_exchange	trading_schema.exchange.name%TYPE
	) RETURNS integer AS $$
DECLARE
    inserted_id integer := 0;
BEGIN
  	INSERT INTO
  	trading_schema.exchange
	  	(
			exchange
	  	)
  	VALUES
	  	(
			p_exchange
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

-- Stored Procedures --
﻿-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsSymbol(
	p_exchange	trading_schema.exchange.name%TYPE,
	p_name		trading_schema.symbol.name%TYPE,
	p_symbol	trading_schema.symbol.symbol%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.symbol
		(
			exchange_id,
			symbol,
			name
		)
	VALUES
		(
			(SELECT id FROM trading_schema.exchange WHERE name=p_exchange),
			p_symbol,
			p_name
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


-- Stored Procedures --
-- InsQuote(%(symbol), %(date), %(open_price), %(high_price), %(low_price), %(close_price), %(adj_close_price), %(volume))
CREATE OR REPLACE FUNCTION trading_schema.pInsQuote(
	p_symbol				trading_schema.symbol.symbol%TYPE,
	p_date					trading_schema.quote.datestamp%TYPE,
	p_open_price			trading_schema.quote.open_price%TYPE,
	p_high_price		  	trading_schema.quote.high_price%TYPE,
	p_low_price				trading_schema.quote.low_price%TYPE,
	p_close_price			trading_schema.quote.close_price%TYPE,
	p_adj_close_price		trading_schema.quote.adjusted_close_price%TYPE,
	p_volume				trading_schema.quote.volume%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.quote
		(
			symbol_id,
			datestamp,
			open_price,
			high_price,
			low_price,
			close_price,
			adjusted_close_price,
			volume
		)
	VALUES
		(
			(SELECT id FROM trading_schema.symbol WHERE symbol=p_symbol),
			p_date,
			p_open_price,
			p_high_price,
			p_low_price,
			p_close_price,
			p_adj_close_price,
			p_volume
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


-- Table: trading_schema.key_statistics
CREATE SEQUENCE trading_schema.key_statistics_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.key_statistics_id_seq
  OWNER TO trading;



CREATE TABLE trading_schema.key_statistics
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.key_statistics_id_seq'::regclass),
  symbol_id bigint,
  datestamp timestamp without time zone NOT NULL,
  enterprise_value numeric NOT NULL,
  price_earnings_ratio numeric NOT NULL,
  price_earnings_growth numeric NOT NULL,
  price_sales_12m_trailing numeric,
  price_book numeric NOT NULL,
  enterprise_value_revenue numeric NOT NULL,
  enterprise_value_ebitda numeric NOT NULL,
  last_fiscal_year timestamp without time zone,
  most_recent_quater timestamp without time zone,
  profit_margin numeric NOT NULL,
  operating_margin numeric NOT NULL,
  return_on_assets numeric NOT NULL,
  return_on_equity numeric NOT NULL,
  total_revenue numeric NOT NULL,
  revenue_per_share numeric NOT NULL,
  quarterly_growth_revenue_yoy numeric NOT NULL,
  gross_profit numeric,
  earnings_before_itda numeric NOT NULL,
  net_income_avi_to_common numeric NOT NULL,
  diluted_eps numeric NOT NULL,
  earnings_quarterly_growth numeric NOT NULL,
  total_cash numeric NOT NULL,
  total_cash_per_share numeric NOT NULL,
  total_debt numeric NOT NULL,
  debt_to_equity numeric NOT NULL,
  current_debt_ratio numeric NOT NULL,
  book_value_per_share numeric NOT NULL,
  operating_cash_flow numeric NOT NULL,
  free_cash_flow numeric NOT NULL,
  shares_outstanding numeric NOT NULL,
  float_shares numeric NOT NULL,
  held_investors_insiders numeric NOT NULL,
  held_percent_institutions numeric NOT NULL,
  shares_short numeric NOT NULL,
  short_ratio numeric NOT NULL,
  short_percent_of_float numeric NOT NULL,
  shares_short_prior_month numeric NOT NULL,
  dividend_date timestamp without time zone,
  ex_dividend_date timestamp without time zone,
  last_split_factor numeric,
  last_split_date timestamp without time zone,
  CONSTRAINT pk_key_statistics_id PRIMARY KEY (id),
  CONSTRAINT fk_key_statistics_symbol_id FOREIGN KEY (symbol_id)
      REFERENCES trading_schema.symbol (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uc_key_statistics_1 UNIQUE (symbol_id, datestamp)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.key_statistics
  OWNER TO trading;

CREATE INDEX idx_key_statistics_datestamp
  ON trading_schema.key_statistics
  USING btree
  (datestamp);

CREATE INDEX idx_key_statistics_symbol_id
  ON trading_schema.key_statistics
  USING btree
  (symbol_id NULLS FIRST);

-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsKeyStatistics(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_date							trading_schema.quote.datestamp%TYPE,
	p_enterprise_value				trading_schema.key_statistics.enterprise_value%TYPE,
	p_price_earnings_ratio			trading_schema.key_statistics.price_earnings_ratio%TYPE,
	p_price_earnings_growth			trading_schema.key_statistics.price_earnings_growth%TYPE,
	p_price_sales_12m_trailing		trading_schema.key_statistics.price_sales_12m_trailing%TYPE,
	p_price_book					trading_schema.key_statistics.price_book%TYPE,
	p_enterprise_value_revenue		trading_schema.key_statistics.enterprise_value_revenue%TYPE,
	p_enterprise_value_ebitda		trading_schema.key_statistics.enterprise_value_ebitda%TYPE,
	p_last_fiscal_year				trading_schema.key_statistics.last_fiscal_year%TYPE,
	p_most_recent_quater			trading_schema.key_statistics.most_recent_quater%TYPE,
	p_profit_margin					trading_schema.key_statistics.profit_margin%TYPE,
	p_operating_margin				trading_schema.key_statistics.operating_margin%TYPE,
	p_return_on_assets				trading_schema.key_statistics.return_on_assets%TYPE,
	p_return_on_equity				trading_schema.key_statistics.return_on_equity%TYPE,
	p_total_revenue					trading_schema.key_statistics.total_revenue%TYPE,
	p_revenue_per_share				trading_schema.key_statistics.revenue_per_share%TYPE,
	p_quarterly_growth_revenue_yoy	trading_schema.key_statistics.quarterly_growth_revenue_yoy%TYPE,
	p_gross_profit					trading_schema.key_statistics.gross_profit%TYPE,
	p_earnings_before_itda			trading_schema.key_statistics.earnings_before_itda%TYPE,
	p_net_income_avi_to_common		trading_schema.key_statistics.net_income_avi_to_common%TYPE,
	p_diluted_eps					trading_schema.key_statistics.diluted_eps%TYPE,
	p_earnings_quarterly_growth		trading_schema.key_statistics.earnings_quarterly_growth%TYPE,
	p_total_cash					trading_schema.key_statistics.total_cash%TYPE,
	p_total_cash_per_share			trading_schema.key_statistics.total_cash_per_share%TYPE,
	p_total_debt					trading_schema.key_statistics.total_debt%TYPE,
	p_debt_to_equity				trading_schema.key_statistics.debt_to_equity%TYPE,
	p_current_debt_ratio			trading_schema.key_statistics.current_debt_ratio%TYPE,
	p_book_value_per_share			trading_schema.key_statistics.book_value_per_share%TYPE,
	p_operating_cash_flow			trading_schema.key_statistics.operating_cash_flow%TYPE,
	p_free_cash_flow				trading_schema.key_statistics.free_cash_flow%TYPE,
	p_shares_outstanding			trading_schema.key_statistics.shares_outstanding%TYPE,
	p_float_shares					trading_schema.key_statistics.float_shares%TYPE,
	p_held_investors_insiders		trading_schema.key_statistics.held_investors_insiders%TYPE,
	p_held_percent_institutions		trading_schema.key_statistics.held_percent_institutions%TYPE,
	p_shares_short					trading_schema.key_statistics.shares_short%TYPE,
	p_short_ratio					trading_schema.key_statistics.short_ratio%TYPE,
	p_short_percent_of_float		trading_schema.key_statistics.short_percent_of_float%TYPE,
	p_shares_short_prior_month		trading_schema.key_statistics.shares_short_prior_month%TYPE,
	p_dividend_date					trading_schema.key_statistics.dividend_date%TYPE,
	p_ex_dividend_date				trading_schema.key_statistics.ex_dividend_date%TYPE,
	p_last_split_factor				trading_schema.key_statistics.last_split_factor%TYPE,
	p_last_split_date				trading_schema.key_statistics.last_split_date%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.key_statistics
		(
			symbol_id,
			datestamp,
			enterprise_value,
			price_earnings_ratio,
			price_earnings_growth,
			price_sales_12m_trailing,
			price_book,
			enterprise_value_revenue,
			enterprise_value_ebitda,
			last_fiscal_year,
			most_recent_quater,
			profit_margin,
			operating_margin,
			return_on_assets,
			return_on_equity,
			total_revenue,
			revenue_per_share,
			quarterly_growth_revenue_yoy,
			gross_profit,
			earnings_before_itda,
			net_income_avi_to_common,
			diluted_eps,
			earnings_quarterly_growth,
			total_cash,
			total_cash_per_share,
			total_debt,
			debt_to_equity,
			current_debt_ratio,
			book_value_per_share,
			operating_cash_flow,
			free_cash_flow,
			shares_outstanding,
			float_shares,
			held_investors_insiders,
			held_percent_institutions,
			shares_short,
			short_ratio,
			short_percent_of_float,
			shares_short_prior_month,
			dividend_date,
			ex_dividend_date,
			last_split_factor,
			last_split_date
		)
	VALUES
		(
			(SELECT id FROM trading_schema.symbol WHERE symbol=p_symbol),
			p_date,
			p_enterprise_value,
			p_price_earnings_ratio,
			p_price_earnings_growth,
			p_price_sales_12m_trailing,
			p_price_book,
			p_enterprise_value_revenue,
			p_enterprise_value_ebitda,
			p_last_fiscal_year,
			p_most_recent_quater,
			p_profit_margin,
			p_operating_margin,
			p_return_on_assets,
			p_return_on_equity,
			p_total_revenue,
			p_revenue_per_share,
			p_quarterly_growth_revenue_yoy,
			p_gross_profit,
			p_earnings_before_itda,
			p_net_income_avi_to_common,
			p_diluted_eps,
			p_earnings_quarterly_growth,
			p_total_cash,
			p_total_cash_per_share,
			p_total_debt,
			p_debt_to_equity,
			p_current_debt_ratio,
			p_book_value_per_share,
			p_operating_cash_flow,
			p_free_cash_flow,
			p_shares_outstanding,
			p_float_shares,
			p_held_investors_insiders,
			p_held_percent_institutions,
			p_shares_short,
			p_short_ratio,
			p_short_percent_of_float,
			p_shares_short_prior_month,
			p_dividend_date,
			p_ex_dividend_date,
			p_last_split_factor,
			p_last_split_date
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

