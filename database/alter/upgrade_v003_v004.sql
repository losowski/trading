-- ALTER TABLES --
-- Add category column
ALTER TABLE trading_schema.symbol
	ADD COLUMN category smallint;

-- Add index too
CREATE INDEX idx_symbol_category ON trading_schema.symbol USING btree (category);


-- Stored Procedures --
-- Categorise the prices
CREATE OR REPLACE FUNCTION trading_schema.pCategorise(
	p_price			numeric
	) RETURNS smallint AS $$
DECLARE
	v_category		smallint := 0;
BEGIN
	-- Calculate category
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

	-- Return value
	RETURN v_category;
END;
$$ LANGUAGE plpgsql;



-- Procedure to Categorise a single symbol
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseSymbol(
	p_symbol		trading_schema.symbol.symbol%TYPE,
	p_date			trading_schema.symbol.last_update%TYPE,
	p_interval		varchar(10) default '365 days'
	) RETURNS void AS $$
DECLARE
	v_price			numeric := 0;
	v_category		smallint := NULL;
BEGIN
	-- Get minimum price
	SELECT
		MIN(q.open_price)
	INTO
		v_price
	FROM
		trading_schema.symbol s
		INNER JOIN trading_schema.quote q ON (q.symbol_id = s.id)

	WHERE
		s.symbol = p_symbol
	AND
		q.datestamp <= p_date
	AND
		q.datestamp >= p_date -  p_interval::interval
	;
	-- Generate category
	SELECT
		pcategorise
	INTO
		v_category
	FROM
		trading_schema.pCategorise(v_price)
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
	v_symbols	RECORD;
BEGIN
	-- Iterate over query
	FOR v_symbols IN SELECT
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
		LOOP

		-- Call trading_schema.pCategoriseSymbol
		SELECT * FROM trading_schema.pCategoriseSymbol(v_symbols.symbol::text, v_symbols.last_update::timestamp without time zone);
		-- Commit the change
		COMMIT;
	END LOOP;
	-- DONE
END;
$$ LANGUAGE plpgsql;

-- Running the procedure
