-- Calls the Calculation functions for the symbols

CREATE OR REPLACE FUNCTION calculate_for_symbol (security_symbol TEXT, start_date timestamp without time zone, end_date timestamp without time zone) 
RETURNS VOID AS $$
DECLARE
    date_input timestamp without time zone;
BEGIN

	FOR date_input IN SELECT tradingdb.trading_schema.quote.datestamp FROM tradingdb.trading_schema.quote
		INNER JOIN tradingdb.trading_schema.symbol ON (tradingdb.trading_schema.quote.symbol_id = tradingdb.trading_schema.symbol.id)
		WHERE tradingdb.trading_schema.symbol.symbol = security_symbol ORDER BY datestamp ASC LOOP

		-- Call the function
		EXECUTE calculation_insert (security_symbol::text, date_input::timestamp without time zone);
	END LOOP;

	RETURN;
END;
$$
LANGUAGE 'plpgsql';
