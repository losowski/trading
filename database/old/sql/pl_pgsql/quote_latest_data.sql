-- Get latest quote
CREATE OR REPLACE FUNCTION quote_latest_date(symbol_name TEXT) 
RETURNS timestamp without time zone AS $$
DECLARE
	last_date timestamp without time zone;
BEGIN

	SELECT datestamp from tradingdb.trading_schema.quote
	INTO last_date
	INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
	WHERE symbol.symbol = symbol_name 
	ORDER BY tradingdb.trading_schema.quote.datestamp DESC 
	LIMIT '1';

	RETURN last_date;
END $$
LANGUAGE 'plpgsql';

SELECT quote_latest_date('GOOG');
