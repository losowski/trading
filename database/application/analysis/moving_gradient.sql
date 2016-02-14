-- Functions to calculate the moving gradient

CREATE OR REPLACE FUNCTION trading_schema.pCalcGradient(
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
	p_symbol						trading_schema.symbol.name%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_interval						interval
	) RETURNS VOID AS $$
DECLARE
	v_previous_open					trading_schema.quote.open_price%TYPE;
	v_previous_close				trading_schema.quote.close_price%TYPE;
	v_previous_high					trading_schema.quote.high_price%TYPE;
	v_previous_low					trading_schema.quote.low_price%TYPE;
	v_previous_date					trading_schema.quote.datestamp%TYPE;
	v_gradient						RECORD;
BEGIN
	FOR v_gradient IN
		SELECT
			q.datestamp,
			q.open_price,
			q.close_price,
			q.high_price,
			q.low_price
		FROM
			trading_schema.quote q
			INNER JOIN trading_schema.symbol s ON (s.id = q.symbol_id)
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
			INSERT INTO
				trading_schema.quote_diff
				(
					diff_open_price,
					diff_close_price,
					diff_high_price,
					diff_low_price
				)
			VALUES
				(
					trading_schema.pCalcGradient(v_previous_date, v_previous_open,	v_gradient.datestamp, v_gradient.open_price),
					trading_schema.pCalcGradient(v_previous_date, v_previous_close,	v_gradient.datestamp, v_gradient.close_price),
					trading_schema.pCalcGradient(v_previous_date, v_previous_high,	v_gradient.datestamp, v_gradient.high_price),
					trading_schema.pCalcGradient(v_previous_date, v_previous_low,	v_gradient.datestamp, v_gradient.low_price)
				);
		END IF;
		IF v_previous_open == NULL THEN
			v_previous_open := v_gradient.open_price;
		END IF;
		IF v_previous_close == NULL THEN
			v_previous_close := v_gradient.close_price;
		END IF;
		IF v_previous_high == NULL THEN
			v_previous_high := v_gradient.high_price;
		END IF;
		IF v_previous_low == NULL THEN
			v_previous_low := v_gradient.low_price;
		END IF;
		IF v_previous_date == NULL THEN
			v_previous_date := v_gradient.datestamp;
		END IF;
	END LOOP;
	RETURN; 
END;
$$ LANGUAGE plpgsql;





-- Base function to calculate one moving gradient
CREATE OR REPLACE FUNCTION trading_schema.pCalcAvg(
	p_symbol						trading_schema.symbol.name%TYPE,
	p_datestamp						trading_schema.quote.datestamp%TYPE,
	p_inverval						interval
	) RETURNS money AS $$
DECLARE
	v_value							money;
BEGIN
	-- This function needs a select and an internal loop to produce a list of gradients. 
	-- START UNFINISHED WORK
	SELECT
		q.datestamp,
		q.open_price
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
	-- END UNFINISHED WORK
	RETURN v_value;
END;
$$ LANGUAGE plpgsql;

-- Base function to calculate one moving gradient
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
