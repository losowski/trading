-- Add symbol enabled flag
-- NOTE: Not applied to exchange (as that is < 10 rows) so would not appreciably help
CREATE INDEX idx_symbol_enabled ON trading_schema.symbol USING btree (enabled);
