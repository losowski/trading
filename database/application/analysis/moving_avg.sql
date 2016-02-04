-- Functions to calculate the moving average

-- Base function to calculate one moving average
CREATE OR REPLACE FUNCTION trading_schema.pCalcAvg(
	p_symbol						trading_schema.symbol.name%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_inverval						interval
	) RETURNS money AS $$
DECLARE
	v_value							money;
BEGIN
	SELECT
		avg(q.open_price)
	INTO
		v_value
	FROM
		trading_schema.quote q
		INNER JOIN trading_schema.symbol s ON (s.id = q.symbol_id)	
	WHERE
		q.datestamp >= p_datestamp - p_interval
	AND
		q.datestamp <= p_datestamp
	;
	RETURN v_value;
END;
$$ LANGUAGE plpgsql;

-- Base function to calculate one moving average
CREATE OR REPLACE FUNCTION trading_schema.pInsCalcMovingAvg(
	p_symbol						trading_schema.symbol.name%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE
	) RETURNS void AS $$
DECLARE
	v_2_days						money;
	v_5_days						money;
	v_9_days						money;
	v_15_days						money;
	v_21_days						money;
	v_29_days						money;
	v_73_days						money;
	v_91_days						money;
	v_121_days						money;
	v_189_days						money;
BEGIN
	-- Calcualte values
	SELECT * INTO v_2_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '1 day');
	SELECT * INTO v_5_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '5 days');
	SELECT * INTO v_9_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '9 days');
	SELECT * INTO v_15_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '15 days');
	SELECT * INTO v_21_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '21 days');
	SELECT * INTO v_29_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '29 days');
	SELECT * INTO v_73_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '73 days');
	SELECT * INTO v_91_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '91 days');
	SELECT * INTO v_121_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '121 days');
	SELECT * INTO v_189_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '189 days');
	-- Push data
	INSERT INTO
		a_moving_avg
	(
		days2,
		days5,
		days9,
		days15,
		days21,
		days29,
		days73,
		days91,
		days121,
		days189
	)
	VALUES
	(
		v_2_days,
		v_5_days,
		v_9_days,
		v_15_days,
		v_21_days,
		v_29_days,
		v_73_days,
		v_91_days,
		v_121_days,
		v_189_days
	)
	;
END;
$$ LANGUAGE plpgsql;

-- Ensure we have complete records
CREATE OR REPLACE FUNCTION trading_schema.pCalcSymbolAvg(
	p_symbol						trading_schema.symbol.name%TYPE
	) RETURNS void AS $$
DECLARE
	v_quote							RECORD;
BEGIN
	FOR v_quote IN
		SELECT
			q.datestamp
		FROM
			trading_schema.symbol s
			INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id )
			LEFT OUTER JOIN trading_schema.a_moving_avg a_avg ON (q.id = a_avg.quote_id)
		WHERE
			s.name = p_symbol
		AND
			a_avg.quote_id IS NOT NULL
		ORDER BY
			q.datestamp ASC
	LOOP
		PERFORM trading_schema.pInsCalcMovingAvg(p_symbol, v_quote.datestamp);
		COMMIT;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
