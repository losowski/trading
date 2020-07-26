-- Moving Average Calculation

CREATE OR REPLACE FUNCTION moving_average_calculation_select (symbol_name TEXT, start date, period interval) 
RETURNS numeric AS $$
DECLARE
	average numeric;
BEGIN

average := avg(close) FROM tradingdb.trading_schema.quote INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
WHERE symbol.symbol = symbol_name AND quote.datestamp 
BETWEEN (start - period::interval) AND start;

RETURN average;

END $$
LANGUAGE 'plpgsql';


-- Moving Average Calculation

CREATE OR REPLACE FUNCTION moving_average_calculation_trigger () RETURNS trigger AS $$
DECLARE
	symbol text;
BEGIN

	symbol := symbol FROM tradingdb.trading_schema.symbol 
	WHERE symbol.id = NEW.symbol_id;

	-- Link back to autogen function
	EXECUTE moving_average_calculation_insert(symbol, NEW.datestamp);
RETURN NEW;

END $$
LANGUAGE 'plpgsql';
