-- Calls the Calculation functions for the symbols

CREATE OR REPLACE FUNCTION calculate_dates_for_all_symbols (start_date timestamp without time zone, end_date timestamp without time zone) 
RETURNS VOID AS $$
DECLARE
    security_symbol TEXT;
BEGIN

	FOR security_symbol IN SELECT symbol FROM tradingdb.trading_schema.symbol ORDER BY symbol ASC LOOP
		-- Call the function
		EXECUTE calculate_for_symbol (security_symbol::text, start_date::timestamp without time zone, end_date::timestamp without time zone);
	END LOOP;

	RETURN;
END;
$$
LANGUAGE 'plpgsql';
