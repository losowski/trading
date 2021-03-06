-- ALTER TABLES --
-- Add category column
ALTER TABLE trading_schema.symbol
	ADD COLUMN category smallint;

-- Add index too
CREATE INDEX idx_symbol_category ON trading_schema.symbol USING btree (category);


-- Stored Procedures --
-- Categorise the prices
CREATE OR REPLACE FUNCTION trading_schema.pCategorise(
	p_price	numeric
	) RETURNS smallint AS $$
DECLARE
	v_category		smallint := 0;
BEGIN
	IF p_price >= 10000 THEN
		v_category := 4;
	ELSIF p_price >= 1000 THEN
		v_category := 3;
	ELSIF p_price >= 100 THEN
		v_category := 2;
	ELSIF p_price >= 10 THEN
		v_category := 1;
	ELSE
		v_category := 0;
	END IF;
END;
$$ LANGUAGE plpgsql;



-- Procedure to Categorise a single symbol
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseSymbol(
	p_symbol		trading_schema.symbol%TYPE,
	p_date			trading_schema.quote.datestamp%TYPE,
	p_interval		varchar(10) default '365 days'
	) RETURNS void AS $$
DECLARE
	v_price			numeric := 0;
	v_category		smallint := NULL;
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
	SELECT
		trading_schema.pCategorise
	INTO
		v_category
	FROM
		trading_schema.pCategorise(
			p_price => v_price
			)
	;
	-- Update the table
	UPDATE trading_schema.symbol SET category = v_category WHERE symbol = p_symbol;
	-- DONE
END;
$$ LANGUAGE plpgsql;


-- Process all symbols
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseActiveSymbols(
	) RETURNS void AS $$
DECLARE
	v_symbols	refcursor;
BEGIN
	-- Create cursor
	OPEN v_symbols FOR SELECT
			symbol,
			last_update
		FROM
			trading_schema.exchange e
			INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND s.enabled = 'Y')
		WHERE
			e.enabled = 'Y'
		AND
			s.category  IS NULL
		ORDER BY
			s.symbol
		;
	-- Iterate over cursor
	FOR vs IN v_symbols LOOP
		-- Call trading_schema.pCategoriseSymbol
		SELECT trading_schema.pCategoriseSymbol(vs.symbol, vs.last_update);
	END LOOP
	-- DONE
END;
$$ LANGUAGE plpgsql;

-- Running the procedure
