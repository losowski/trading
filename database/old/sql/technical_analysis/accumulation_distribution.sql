-- Accumulation Distribution Calculation

CREATE OR REPLACE FUNCTION accumulation_distribution_calculation_select (symbol_name TEXT, start date) 
RETURNS numeric AS $$
DECLARE
	accumulation numeric;
	momentum numeric;
	output numeric;
BEGIN
	-- Get Previous value to make current_accumulation
	accumulation := accumulation_distribution FROM tradingdb.trading_schema.accumulation_distribution 
		INNER JOIN tradingdb.trading_schema.quote ON (accumulation_distribution.quote_id = quote.id)
		INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
		WHERE symbol.id = NEW.symbol_id
		ORDER BY tradingdb.trading_schema.quote.datestamp ASC
		FETCH FIRST ROW ONLY;
	IF accumulation == NULL THEN
		accumulation := 0;
	END IF;
	-- Get momentum
	momentum := accumulation_distribution_calculation_select(symbol, start);

RETURN (accumulation + momentum);

END $$
LANGUAGE 'plpgsql';


/* Accumulation Distribution Momemtum Calculation */

CREATE OR REPLACE FUNCTION accumulation_distribution_calculation_select (symbol_name TEXT, start date) 
RETURNS numeric AS $$
DECLARE
	momemtum numeric;
BEGIN
	-- Calculate new accumulation value
	momemtum := ((((NEW.close - NEW.low) - (NEW.high - NEW.close))* NEW.volume )/(NEW.high - NEW.low));
RETURN momemtum;

END $$
LANGUAGE 'plpgsql';


-- Accumulation Distribution Calculation

CREATE OR REPLACE FUNCTION accumulation_distribution_calculation_trigger () RETURNS trigger AS $$
DECLARE
	symbol text;
	current_accumulation numeric;
	accumulation numeric;
	previous_accumulation numeric;
BEGIN
	-- Get symbol
	symbol := symbol FROM tradingdb.trading_schema.symbol 
	WHERE symbol.id = NEW.symbol_id;
	-- Perform the insert function
	EXECUTE accumulation_distribution_calculation_insert(symbol, start_date);
RETURN NEW;

END $$
LANGUAGE 'plpgsql';

-- Previous Accumulation
