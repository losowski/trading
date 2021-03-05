-- ALTER TABLES --
-- Add category column
ALTER TABLE trading_schema.symbol
	ADD COLUMN category smallint;

-- Add index too
CREATE INDEX idx_symbol_category ON trading_schema.symbol USING btree (category);


-- Stored Procedures --
-- Procedure to Categorise a single symbol
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseSymbol(
	p_symbol		trading_schema.symbol%TYPE,
	p_date			trading_schema.quote.datestamp%TYPE,
	p_interval		varchar(10) default '365 days'
	) RETURNS void AS $$
DECLARE
	v_price		numeric := 0;
BEGIN
	-- Get minimum price
	SELECT
		MIN(open_price)
	INTO
		v_price
	FROM
		trading_schema.symbol
	WHERE
		symbol = p_symbol
	AND
		datestamp >= p_date
	AND
		datestamp <= p_date -  p_interval::interval
	;
	-- Generate category
	-- Update the table
END;
$$ LANGUAGE plpgsql;
-- Running the procedure
