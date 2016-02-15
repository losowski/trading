-- Functions to calculate the moving gradient

CREATE OR REPLACE FUNCTION trading_schema.pCalcGradientIntegration(
	p_datestamp1					trading_schema.quote.datestamp%TYPE,
	p_price1						trading_schema.quote.open_price%TYPE,
	p_datestamp2					trading_schema.quote.datestamp%TYPE,
	p_price2						trading_schema.quote.open_price%TYPE
	) RETURNS money AS $$
DECLARE
	v_diff_price					money;
	v_interval_days					numeric;
	v_gradient						numeric; --money/days
BEGIN
	-- Calculate the gradient for this instance
	v_diff_price	= p_price2 - p_price1;
	v_interval_days = DAYS(p_datestamp2 - p_datestamp1);
	v_gradient = v_diff_price / v_diff_days;
	RETURN v_gradient;
END;
$$ LANGUAGE plpgsql;



--- Function to fill in the gradient values for each entry
CREATE OR REPLACE FUNCTION trading_schema.pInsGradient(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_interval						interval
	) RETURNS VOID AS $$
DECLARE
	v_previous_open					trading_schema.quote.open_price%TYPE DEFAULT NULL;
	v_previous_close				trading_schema.quote.close_price%TYPE DEFAULT NULL;
	v_previous_high					trading_schema.quote.high_price%TYPE DEFAULT NULL;
	v_previous_low					trading_schema.quote.low_price%TYPE DEFAULT NULL;
	v_previous_date					trading_schema.quote.datestamp%TYPE DEFAULT NULL;
	v_gradient						RECORD;
BEGIN
	FOR v_gradient IN
		SELECT
			q.quote_id,
			q.datestamp,
			q.open_price,
			q.close_price,
			q.high_price,
			q.low_price,
			qd.id
		FROM
			trading_schema.quote q
			INNER JOIN trading_schema.symbol s ON (s.id = q.symbol_id)
			LEFT OUTER JOIN trading_schema.quote_diff qd ON (qd.id = q.id)
		WHERE
			s.name = p_symbol
		AND
			q.date >= p_date
		AND
			(q.date + p_interval) <=  p_date
		ORDER BY
			q.date ASC
	LOOP
		IF v_previous_open != NULL AND v_previous_close != NULL AND v_previous_high != NULL AND v_previous_low != NULL THEN
		-- For now assume all data is one day apart
		-- Fault detection will use weekday calculations
			IF v_gradient.id == NULL THEN
				INSERT INTO
					trading_schema.quote_diff
					(
						id,
						diff_open_price,
						diff_close_price,
						diff_high_price,
						diff_low_price
					)
				VALUES
					(
						v_gradient.quote_id,
						trading_schema.pCalcGradientIntegration(v_previous_date, v_previous_open,	v_gradient.datestamp, v_gradient.open_price),
						trading_schema.pCalcGradientIntegration(v_previous_date, v_previous_close,	v_gradient.datestamp, v_gradient.close_price),
						trading_schema.pCalcGradientIntegration(v_previous_date, v_previous_high,	v_gradient.datestamp, v_gradient.high_price),
						trading_schema.pCalcGradientIntegration(v_previous_date, v_previous_low,	v_gradient.datestamp, v_gradient.low_price)
					);
			END IF;
		END IF;
		-- Perform assignment. Initialised to NULL to mean first record to diff against is always NULL
		v_previous_open := v_gradient.open_price;
		v_previous_close := v_gradient.close_price;
		v_previous_high := v_gradient.high_price;
		v_previous_low := v_gradient.low_price;
		v_previous_date := v_gradient.datestamp;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;



-- Base function to calculate one moving gradient
CREATE OR REPLACE FUNCTION trading_schema.pCalcGradient(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_inverval						interval
	) RETURNS money AS $$
DECLARE
	v_value							money;
BEGIN
	SELECT
		avg(qd.diff_open_price)
	INTO
		v_value
	FROM
		trading_schema.diff_quote qd
		INNER JOIN trading_schema.quote q ON (q.id = qd.id)
		INNER JOIN trading_schema.symbol s ON (s.id = q.symbol_id)
	WHERE
		s.symbol = p_symbol
	AND
		q.datestamp >= p_datestamp - p_interval
	AND
		q.datestamp <= p_datestamp
	ORDER BY
		q.datestamp
	;
	RETURN v_value;
END;
$$ LANGUAGE plpgsql;



-- Base function to calculate one moving gradient
CREATE OR REPLACE FUNCTION trading_schema.pInsCalcMovingGradient(
	p_symbol						trading_schema.symbol.symbol%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_moving_diff					trading_schema.a_moving_diff.id%TYPE
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
	IF p_moving_diff = NULL THEN
		-- Calcualte values
		SELECT * INTO v_2_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '1 day');
		SELECT * INTO v_5_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '5 days');
		SELECT * INTO v_9_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '9 days');
		SELECT * INTO v_15_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '15 days');
		SELECT * INTO v_21_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '21 days');
		SELECT * INTO v_29_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '29 days');
		SELECT * INTO v_73_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '73 days');
		SELECT * INTO v_91_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '91 days');
		SELECT * INTO v_121_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '121 days');
		SELECT * INTO v_189_days FROM trading_schema.pCalcGradient(p_symbol, p_datestamp, interval '189 days');
		-- Push data
		INSERT INTO
			a_moving_diff
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
	END IF;
END;
$$ LANGUAGE plpgsql;

-- Ensure we have complete records
CREATE OR REPLACE FUNCTION trading_schema.pCalcSymbolDiffAvg(
	p_symbol						trading_schema.symbol.symbol%TYPE
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
			a_diff.id
		FROM
			trading_schema.symbol s
			INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id )
			LEFT OUTER JOIN trading_schema.a_moving_diff a_diff ON (q.id = a_diff.id)
		WHERE
			s.symbol = p_symbol
		AND
			q.datestamp >= v_begin_date
		ORDER BY
			q.datestamp ASC
	LOOP
		PERFORM trading_schema.pInsCalcMovingGradient(p_symbol, v_quote.datestamp, v_quote.id);
		COMMIT;
	END LOOP;
	RETURN;
END;
$$ LANGUAGE plpgsql;
