--
-- File for import into Database to input the function information
--

--
-- INSERT FUNCTION to insert moving_average data into database
--
CREATE OR REPLACE FUNCTION moving_average_calculation_insert(security_symbol TEXT, start_date timestamp without time zone)
RETURNS VOID AS $$
BEGIN
	INSERT INTO tradingdb.trading_schema.moving_average(quote_id, seven_days, fourteen_days, twenty_one_days, twenty_eight_days, fourty_eight_days, ninety_days)
VALUES (
		(SELECT id FROM tradingdb.trading_schema.quote WHERE datestamp = start_date),
		 moving_average_calculation_select(security_symbol, start_date::date, '7 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '14 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '21 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '28 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '48 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '90 days'::interval));
	RETURN;
END; $$
LANGUAGE 'plpgsql';


--
-- INSERT FUNCTION to insert accumulation_distribution data into database
--
CREATE OR REPLACE FUNCTION accumulation_distribution_calculation_insert(security_symbol TEXT, start_date timestamp without time zone)
RETURNS VOID AS $$
BEGIN
	INSERT INTO tradingdb.trading_schema.accumulation_distribution(quote_id, accumulation_distribution, momentum) VALUES (
		(SELECT id FROM tradingdb.trading_schema.quote WHERE datestamp = start_date),
		accumulation_distribution_calculation_select(security_symbol, start_date::date),
		momentum_calculation_select (security_symbol, start_date::date));
	RETURN;
END; $$
LANGUAGE 'plpgsql';


--
-- INSERT FUNCTION to perform calculations on insert into quote on database
--

CREATE OR REPLACE FUNCTION calculation_insert (security_symbol TEXT, start_date timestamp without time zone)
RETURNS VOID AS $$
BEGIN
	PERFORM moving_average_calculation_insert (security_symbol, start_date);
	PERFORM accumulation_distribution_calculation_insert (security_symbol, start_date);
END; $$
LANGUAGE 'plpgsql';
