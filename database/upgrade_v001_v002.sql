-- Exchange
ALTER TABLE trading_schema.exchange
    ADD COLUMN enabled character(1) NOT NULL DEFAULT 'Y';

-- Symbol
ALTER TABLE trading_schema.symbol
    ADD COLUMN enabled character(1) NOT NULL DEFAULT 'Y';

-- Disable Exchange
CREATE OR REPLACE FUNCTION trading_schema.pDisableExchange(
	p_exchange	trading_schema.exchange.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.exchange SET enabled = 'N' WHERE name = p_exchange;

	changed := SQL%rowcount;

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableExchange OWNER TO trading;

-- Enable Exchange
CREATE OR REPLACE FUNCTION trading_schema.pEnableExchange(
	p_exchange	trading_schema.exchange.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.exchange SET enabled = 'Y' WHERE name = p_exchange;

	changed := SQL%rowcount;

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableExchange OWNER TO trading;

-- Disable Symbol
CREATE OR REPLACE FUNCTION trading_schema.pDisableSymbol(
	p_name		trading_schema.symbol.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.symbol SET enabled = 'N' WHERE symbol = p_name;

	changed := SQL%rowcount;

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableSymbol OWNER TO trading;

-- Enable Symbol
CREATE OR REPLACE FUNCTION trading_schema.pEnableSymbol(
	p_name		trading_schema.symbol.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.symbol SET enabled = 'Y' WHERE symbol = p_name;

	changed := SQL%rowcount;

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableSymbol OWNER TO trading;
