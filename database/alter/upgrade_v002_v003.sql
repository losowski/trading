-- Add symbol enabled flag
-- NOTE: Not applied to exchange (as that is < 10 rows) so would not appreciably help
CREATE INDEX idx_symbol_enabled ON trading_schema.symbol USING btree (enabled);

-- Add "last_update" column to symbol
ALTER TABLE trading_schema.symbol
    ADD COLUMN last_update timestamp without time zone;

CREATE INDEX idx_symbol_last_update ON trading_schema.symbol USING btree (last_update);

-- Set the symbol.last_update
-- Set the last update with NOW (localtimestamp)
CREATE OR REPLACE FUNCTION trading_schema.pSymbolLastUpdate(
    p_symbol_id  trading_schema.symbol.id%TYPE
    ) RETURNS integer AS $$
BEGIN
    UPDATE trading_schema.symbol SET last_update = localtimestamp WHERE id = p_symbol_id;

    GET DIAGNOSTICS changed = ROW_COUNT;

    RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pSymbolLastUpdate OWNER TO trading;
