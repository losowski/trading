-- Functions to calculate the moving average

-- Base function to calculate one moving average
CREATE OR REPLACE FUNCTION trading_schema.pCalcAvg(
	p_symbol						trading_schema.symbol.name%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_interval						interval
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
		s.symbol = p_symbol
	AND
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
	p_quote_id						trading_schema.quote.id%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_average						trading_schema.a_moving_diff.id%TYPE
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
	IF p_average IS NULL THEN
		-- Calculate values
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
		IF v_2_days IS NOT NULL AND v_5_days IS NOT NULL AND v_9_days IS NOT NULL AND v_15_days IS NOT NULL AND v_21_days IS NOT NULL AND v_29_days IS NOT NULL AND v_73_days IS NOT NULL AND v_91_days IS NOT NULL AND v_121_days IS NOT NULL AND v_189_days IS NOT NULL THEN
		-- Push data
			INSERT INTO
				trading_schema.a_moving_avg
			(
				id,
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
				p_quote_id,
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
		END IF;
	END IF;
END;
$$ LANGUAGE plpgsql;

-- Ensure we have complete records
CREATE OR REPLACE FUNCTION trading_schema.pCalcSymbolAvg(
	p_symbol						trading_schema.symbol.name%TYPE
	) RETURNS void AS $$
DECLARE
	v_quote							RECORD;
	v_begin_date					trading_schema.quote.datestamp%TYPE;
BEGIN
	SELECT
		min(q.datestamp)
	INTO
		v_begin_date
	FROM
		trading_schema.quote q
		INNER JOIN trading_schema.symbol s ON (q.symbol_id = s.id)
		LEFT OUTER JOIN trading_schema.a_moving_diff a_diff ON (q.id = a_diff.id)
	WHERE
		s.symbol = p_symbol
	AND
		a_diff.id IS NULL
	;
	-- Now loop over the results - so we can progress the records
	FOR v_quote IN
		SELECT
			q.datestamp,
			q.id,
			a_avg.id AS quote_id
		FROM
			trading_schema.symbol s
			INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id )
			LEFT OUTER JOIN trading_schema.a_moving_avg a_avg ON (q.id = a_avg.id)
		WHERE
			s.symbol = p_symbol
		AND
			q.datestamp >= v_begin_date
		ORDER BY
			q.datestamp ASC
	LOOP
		BEGIN
			PERFORM trading_schema.pInsCalcMovingAvg(p_symbol, v_quote.id, v_quote.datestamp, v_quote.quote_id);
		EXCEPTION
			WHEN no_data_found THEN
				RAISE INFO 'Symbol did not require update';
		END;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
