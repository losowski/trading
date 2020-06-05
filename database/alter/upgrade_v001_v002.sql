-- Exchange
ALTER TABLE trading_schema.exchange
    ADD COLUMN enabled character(1) NOT NULL DEFAULT 'Y';

-- Symbol
ALTER TABLE trading_schema.symbol
    ADD COLUMN enabled character(1) NOT NULL DEFAULT 'Y';
