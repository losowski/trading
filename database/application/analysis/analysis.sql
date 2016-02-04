-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pCalcAnalysis(
	p_symbol				trading_schema.symbol.name%TYPE	
	) RETURNS void AS $$
BEGIN
	PERFORM trading_schema.pCalcSymbolAvg(p_symbol);
END;
$$ LANGUAGE plpgsql;
