-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pCalcAnalysis(
	p_symbol				trading_schema.symbol.name%TYPE	
	) RETURNS void AS $$
BEGIN
	PERFORM trading_schema.pCalcSymbolAvg(p_symbol);
	PERFORM trading_schema.pCalcSymbolDiff(p_symbol);
	PERFORM trading_schema.pCalcSymbolDiffAvg(p_symbol);
END;
$$ LANGUAGE plpgsql;
