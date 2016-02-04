-- SELECT date list
CREATE OR REPLACE FUNCTION select_period_dates(symbol_name TEXT) 
RETURNS SETOF timestamp without time zone AS $$
DECLARE
	list_of_dates timestamp without time zone;
BEGIN

SELECT tradingdb.trading_schema.quote.datestamp 
	INTO list_of_dates
		FROM tradingdb.trading_schema.quote 
		INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
		WHERE tradingdb.trading_schema.symbol.symbol = symbol_name 
		ORDER BY tradingdb.trading_schema.quote.datestamp;
RETURN; --Implicit return of output
END;
$$
LANGUAGE 'plpgsql';



-- SELECT Function to calculate the average --
CREATE OR REPLACE FUNCTION select_period_average(symbol_name TEXT, start_date date, interval_period interval) 
RETURNS numeric AS $$
DECLARE
	average_value	numeric;
BEGIN

SELECT avg(open) INTO average_value FROM tradingdb.trading_schema.quote INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
WHERE symbol.symbol = symbol_name AND tradingdb.trading_schema.quote.datestamp 
BETWEEN (start_date - interval_period::interval) AND start_date;

RETURN average_value;
END;
$$
LANGUAGE 'plpgsql';

-- INSERT FUNCTION to insert data into database
CREATE OR REPLACE FUNCTION insert_seven_day_average(symbol_name TEXT, start_date timestamp without time zone) 
RETURNS VOID AS $$
DECLARE
	 duration CONSTANT interval = '7 days';
BEGIN
	INSERT INTO tradingdb.trading_schema.moving_average (quote_id, seven_day) VALUES ( 
		(SELECT id FROM tradingdb.trading_schema.quote WHERE datestamp = start_date)
		, select_period_average(symbol_name, start_date::date, duration));
	RETURN;
END;
$$
LANGUAGE 'plpgsql';

-- LOOP Function to calculate the moving average;
CREATE OR REPLACE FUNCTION loop_moving_average_function_open(symbol_name TEXT) 
RETURNS VOID AS $$
DECLARE
	date_entry timestamp without time zone;
BEGIN
	
	
	FOR date_entry IN SELECT select_period_dates(symbol_name) LOOP
        -- can do some processing here --
	PERFORM insert_seven_day_average(symbol_name, date_entry);
	END LOOP;
    RETURN;
END;
$$
LANGUAGE 'plpgsql' ;


SELECT loop_moving_average_function_open('GOOG');
