-- Get dates from quote in the desired range

CREATE OR REPLACE FUNCTION get_dates_in_period(symbol_name TEXT, start_date date, end_date date) 
RETURNS SETOF timestamp without time zone AS $$
BEGIN
	RETURN QUERY SELECT datestamp
	FROM tradingdb.trading_schema.quote
	INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
	WHERE symbol.symbol = symbol_name 
	AND tradingdb.trading_schema.quote.datestamp BETWEEN start_date AND end_date;
	RETURN;
END;
$$
LANGUAGE 'plpgsql';

SELECT get_dates_in_period('GOOG', '04-02-2013 00:00', '06-06-2013 00:00');
