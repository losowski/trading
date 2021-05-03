-- ALTER the symbol.enabled constraint
-- -- FOREIGN key constraints can be altered
-- DROP constraint
ALTER TABLE trading_schema.symbol DROP CONSTRAINT IF EXISTS ck_symbol_enabled RESTRICT;

-- CREATE NEW CONSTRAINT
ALTER TABLE trading_schema.symbol ADD CONSTRAINT ck_symbol_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar, '-'::bpchar, '?'::bpchar, 'P'::bpchar])) NOT VALID;

-- Change type of the query volume column
ALTER TABLE trading_schema.quote ALTER COLUMN volume TYPE numeric(12,0);

