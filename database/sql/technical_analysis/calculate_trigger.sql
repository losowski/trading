-- TRIGGER: calculation_trigger

CREATE OR REPLACE FUNCTION calculation_trigger () RETURNS trigger AS $$
DECLARE
	symbol text;
BEGIN
	symbol := symbol FROM tradingdb.trading_schema.symbol 
	WHERE symbol.id = NEW.symbol_id;

	-- Link back to calculation functions
	EXECUTE calculate_for_symbol(symbol, NEW.datestamp);
	
RETURN NEW;

END $$
LANGUAGE 'plpgsql';

/* Create the trigger to perform the calculations */
CREATE TRIGGER trg_calculation_trigger 
AFTER INSERT ON tradingdb.trading_schema.quote
FOR EACH ROW EXECUTE PROCEDURE calculation_trigger();
