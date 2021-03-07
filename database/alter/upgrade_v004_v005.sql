-- ALTER the symbol.enabled constraint
-- -- FOREIGN key constraints can be altered
-- DROP constraint
ALTER TABLE trading_schema.symbol DROP CONSTRAINT IF EXISTS ck_symbol_enabled RESTRICT;

-- CREATE NEW CONSTRAINT
ALTER TABLE trading_schema.symbol ADD CONSTRAINT ck_symbol_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar, '-'::bpchar, '?'::bpchar])) NOT VALID;

-- Set new Functionality
-- DROP FUNCTION
DROP FUNCTION trading_schema.pDisableSymbol(text);

-- Disable Symbol new functionality
CREATE OR REPLACE FUNCTION trading_schema.pDisableSymbol(
	p_name		trading_schema.symbol.name%TYPE,
	p_setting		trading_schema.symbol.enabled%TYPE default '-'
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.symbol SET enabled = p_setting WHERE symbol = p_name;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;


-- DROP FUNCTION
DROP FUNCTION trading_schema.pCategoriseActiveSymbols();

-- Process all symbols
CREATE OR REPLACE FUNCTION trading_schema.pCategoriseActiveSymbols(
	p_category			trading_schema.symbol.category%TYPE,
	p_timeperiod		varchar(10) default '180 days'
	) RETURNS void AS $$
DECLARE
	v_symbols	RECORD;
	v_looped	text;
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
			(s.category IS NULL OR s.category = p_category)
		ORDER BY
			s.symbol
		LOOP

		-- Call trading_schema.pCategoriseSymbol
		SELECT pCategoriseSymbol::text INTO v_looped FROM trading_schema.pCategoriseSymbol(v_symbols.symbol::text, v_symbols.last_update::timestamp without time zone, p_timeperiod);
	END LOOP;
	-- DONE
END;
$$ LANGUAGE plpgsql;

-- Running the procedure
SELECT * FROM trading_schema.pCategoriseActiveSymbols('0'::smallint);
SELECT * FROM trading_schema.pCategoriseActiveSymbols(1);
SELECT * FROM trading_schema.pCategoriseActiveSymbols(2);
SELECT * FROM trading_schema.pCategoriseActiveSymbols(3);
SELECT * FROM trading_schema.pCategoriseActiveSymbols(4);
