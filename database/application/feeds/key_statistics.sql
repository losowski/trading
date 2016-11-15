CREATE OR REPLACE FUNCTION trading_schema.pInsKeyStatistics(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_date							trading_schema.quote.datestamp%TYPE,
	p_enterprise_value				trading_schema.key_statistics.enterprise_value%TYPE,
	p_price_earnings				trading_schema.key_statistics.price_earnings%TYPE,
	p_price_earnings_growth			trading_schema.key_statistics.price_earnings_growth%TYPE,
	p_price_sales					trading_schema.key_statistics.price_sales%TYPE,
	p_price_book					trading_schema.key_statistics.price_book%TYPE,
	p_enterprise_value_revenue		trading_schema.key_statistics.enterprise_value_revenue%TYPE,
	p_enterprise_value_ebitda		trading_schema.key_statistics.enterprise_value_ebitda%TYPE,
	p_profit_margin					trading_schema.key_statistics.profit_margin%TYPE,
	p_operating_margin				trading_schema.key_statistics.operating_margin%TYPE,
	p_return_on_assets				trading_schema.key_statistics.return_on_assets%TYPE,
	p_return_on_equity				trading_schema.key_statistics.return_on_equity%TYPE,
	p_revenue						trading_schema.key_statistics.revenue%TYPE,
	p_revenue_per_share				trading_schema.key_statistics.revenue_per_share%TYPE,
	p_quarterly_revenue_growth		trading_schema.key_statistics.quarterly_revenue_growth%TYPE,
	p_gross_profit					trading_schema.key_statistics.gross_profit%TYPE,
	p_earnings_before_tax_ebitda	trading_schema.key_statistics.earnings_before_tax_ebitda%TYPE,
	p_diluted_eps					trading_schema.key_statistics.diluted_eps%TYPE,
	p_total_cash					trading_schema.key_statistics.total_cash%TYPE,
	p_total_cash_per_share			trading_schema.key_statistics.total_cash_per_share%TYPE,
	p_total_debt					trading_schema.key_statistics.total_debt%TYPE,
	p_total_debt_vs_equity			trading_schema.key_statistics.total_debt_vs_equity%TYPE,
	p_current_ratio					trading_schema.key_statistics.current_ratio%TYPE,
	p_book_value_per_share			trading_schema.key_statistics.book_value_per_share%TYPE,
	p_operating_cash_flow			trading_schema.key_statistics.operating_cash_flow%TYPE,
	p_quarterly_earnings_growth		trading_schema.key_statistics.quarterly_earnings_growth%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.quote
		(
			symbol_id,
			datestamp,
			enterprise_value,
			price_earnings,
			price_earnings_growth,
			price_sales,
			price_book,
			enterprise_value_revenue,
			enterprise_value_ebitda,
			profit_margin,
			operating_margin,
			return_on_assets,
			return_on_equity,
			revenue,
			revenue_per_share,
			quarterly_revenue_growth,
			gross_profit,
			earnings_before_tax_ebitda,
			diluted_eps,
			total_cash,
			total_cash_per_share,
			total_debt,
			total_debt_vs_equity,
			current_ratio,
			book_value_per_share,
			operating_cash_flow,
			quarterly_earnings_growth
		)
	VALUES
		(
			(SELECT id FROM trading_schema.symbol WHERE symbol=p_symbol),
			p_date,
			p_enterprise_value,
			p_price_earnings,
			p_price_earnings_growth,
			p_price_sales,
			p_price_book,
			p_enterprise_value_revenue,
			p_enterprise_value_ebitda,
			p_profit_margin,
			p_operating_margin,
			p_return_on_assets,
			p_return_on_equity,
			p_revenue,
			p_revenue_per_share,
			p_quarterly_revenue_growth,
			p_gross_profit,
			p_earnings_before_tax_ebitda,
			p_diluted_eps,
			p_total_cash,
			p_total_cash_per_share,
			p_total_debt,
			p_total_debt_vs_equity,
			p_current_ratio,
			p_book_value_per_share,
			p_operating_cash_flow,
			p_quarterly_earnings_growth
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

