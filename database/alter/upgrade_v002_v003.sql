-- Add symbol enabled flag
-- NOTE: Not applied to exchange (as that is < 10 rows) so would not appreciably help
CREATE INDEX idx_symbol_enabled ON trading_schema.symbol USING btree (enabled);

-- Add "last_update" column to symbol
ALTER TABLE trading_schema.symbol
    ADD COLUMN last_update timestamp without time zone;

CREATE INDEX idx_symbol_last_update ON trading_schema.symbol USING btree (last_update);
