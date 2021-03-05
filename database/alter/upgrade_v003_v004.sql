-- ALTER TABLES --
-- Add category column
ALTER TABLE trading_schema.symbol
	ADD COLUMN category smallint;

-- Add index too
CREATE INDEX idx_symbol_category ON trading_schema.symbol USING btree (category);


-- Stored Procedures --

-- Running the procedure
