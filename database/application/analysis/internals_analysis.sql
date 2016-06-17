﻿-- All functions relating to the internals of the Analysis module
--	p_uuid						trading_schema.reference.reference%TYPE,

CREATE OR REPLACE FUNCTION trading_schema.pInsPredictionInput(
	p_quote_id					trading_schema.quote.id%TYPE,
	p_analysis_property_id		trading_schema.analysis_property.id%TYPE,
	p_uuid						text,
	p_datestamp					trading_schema.reference.datestamp%TYPE
) RETURNS void AS $$
DECLARE
	v_reference_id				trading_schema.reference.id%TYPE;
	v_end_date					trading_schema.prediction_input.end_date%TYPE;
	v_end_value					trading_schema.prediction_input.end_value%TYPE;
	v_end_diff					trading_schema.prediction_input.end_diff%TYPE;
	-- Intermediate values
	v_current_date				trading_schema.quote.datestamp%TYPE;
	v_current_close				trading_schema.quote.close_price%TYPE;
	v_analysis_type				trading_schema.analysis_property.analysis_type%TYPE;
	v_price_change				trading_schema.analysis_property.price_change%TYPE;
	v_days						trading_schema.analysis_property.days%TYPE;
BEGIN
	-- Obtain the reference ID
	SELECT
		id
	INTO
		v_reference_id
	FROM
		trading_schema.reference
	WHERE
		reference = CAST (p_uuid AS uuid)
	;
	IF NOT FOUND THEN
		INSERT INTO
			trading_schema.reference
		(
			reference,
			datestamp
		)
		VALUES
		(
			CAST (p_uuid AS uuid),
			p_datestamp
		)
		;
	-- current_user
	v_reference_id := currval('trading_schema.reference_id_seq');
	END IF;
	--
	-- Calculate the calculated values
	--
	BEGIN
		-- Quote information
		SELECT
			datestamp,
			close_price
		INTO
			v_current_date,
			v_current_close
		FROM
			trading_schema.quote
		WHERE
			id = p_quote_id
		;
		-- Analysis Property information
		SELECT
			analysis_type,
			price_change,
			days
		INTO
			v_analysis_type,
			v_price_change,
			v_days
		FROM
			trading_schema.analysis_property
		WHERE
			id = p_analysis_property_id
		;
		-- Fancy maths with these arbitrary values
		IF v_analysis_type = 'T' THEN
			-- Both time and direction prdicted
			v_end_value = v_current_close + v_price_change;
		ELSIF v_analysis_type = 'D' THEN
			IF @v_price_change = v_price_change THEN
				-- positive
				v_end_value = v_current_close + 1;
			ELSE
				-- negative
				v_end_value = v_current_close - 1;
			END IF;
		ELSE
			RAISE INFO 'Invalid AnalysisProperty.analysis_type';
		END IF;
		v_end_diff := v_end_value - v_current_close;
		v_end_date = v_current_date + v_days;
		-- Make new records
		INSERT INTO
			trading_schema.prediction_input
			(
				analysis_property_id,
				quote_id,
				reference_id,
				end_date,
				end_value,
				end_diff
			)
			VALUES
			(
				p_analysis_property_id,
				p_quote_id,
				v_reference_id,
				v_end_date,
				v_end_value,
				v_end_diff
			)
		;
	EXCEPTION
		WHEN no_data_found THEN
			RAISE INFO 'Unable to form prediction';
	END;
END;
$$ LANGUAGE plpgsql;

-- Prediction Test
CREATE OR REPLACE FUNCTION trading_schema.pInsPredictionTest(
	p_uuid						text
) RETURNS void AS $$
DECLARE
	predictions RECORD;
	v_change_percentage			trading_schema.prediction_test.change_percentage%TYPE;
	v_grading_percentage		trading_schema.prediction_test.change_percentage%TYPE;
	v_change_diff				trading_schema.prediction_test.change_diff%TYPE;
	v_minimum					trading_schema.prediction_test.minimum%TYPE;
	v_maximum					trading_schema.prediction_test.maximum%TYPE;
	v_average					trading_schema.prediction_test.average%TYPE;
	v_valid						trading_schema.prediction_test.valid%TYPE;
	v_start_price				numeric;
	v_ending_price				numeric;
BEGIN

	FOR predictions IN (
		SELECT
			date_trunc('DAY', q.datestamp) AS startdate,
			date_trunc('DAY', pi.end_date) AS enddate,
			pi.end_value,
			pi.end_diff AS end_diff,
			ap.analysis_type,
			ap.price_change,
			ap.days
		FROM
			trading_schema.prediction_input pi
			INNER JOIN trading_schema.analysis_property ap ON (pi.analysis_property_id = ap.id)
			INNER JOIN trading_schema.quote q ON (pi.quote_id = q.id)
		WHERE
			reference = CAST (p_uuid AS uuid)
		)
	LOOP
		-- Get the data and form a decisison
		-- Grouped data
		SELECT
			MIN(q.low_price) AS minimum,
			MAX(q.high_price) AS maximum,
			AVG(q.open_price) AS average
		INTO
			v_minimum,
			v_maximum,
			v_average
		FROM
			trading_schema.quote q
		WHERE
			q.datestamp >= predictions.startdate
		AND
			q.datestamp <= predictions.enddate
		;
		-- Single level data start_price
		SELECT
			q.open_price
		INTO
			v_start_price
		FROM
			trading_schema.quote q
		WHERE
			q.datestamp = startdate
		;
		-- Single level data end_price
		SELECT
			q.open_price
		INTO
			v_ending_price
		FROM
			trading_schema.quote q
		WHERE
			q.datestamp = enddate
		;
		v_change_percentage := (v_ending_price * 100) / v_start_price;
		v_change_diff := v_ending_price - v_start_price;
		-- Check for validity
		v_valid := '-';
		-- Provide rating
		IF predictions.analysis_type == 'D' THEN
			-- Direction Only
			v_valid := 'N';
			-- Up
			IF v_change_percentage > 0 AND v_start_price > v_minimum AND predictions.end_diff > 0 THEN
				v_valid := 'A';
			-- Down
			ELSIF v_change_percentage < 0 AND v_start_price < v_maximum AND predictions.end_diff < 0 THEN
				v_valid := 'A';
			END IF;
		ELSIF predictions.analysis_type == 'T' THEN
			-- ELSE: Time and Direction
			v_valid := 'N';
			IF (v_change_percentage > 0 AND v_start_price > v_minimum AND predictions.end_diff > 0) OR
				(v_change_percentage < 0 AND v_start_price < v_maximum AND predictions.end_diff < 0) THEN
				-- grdaing percentage is indifferent to direction
				v_grading_percentage := ((v_ending_price - v_start_price) * 100) / (predictions.end_vale - v_start_price);
				IF v_grading_percentage > 0 THEN
					IF v_grading_percentage > 200 THEN
						v_valid := 'E';
					ELSIF v_grading_percentage > 100 THEN
						v_valid := 'G';
					ELSIF v_grading_percentage > 90 THEN
						v_valid := 'A';
					ELSIF v_grading_percentage > 50 THEN
						v_valid := 'B';
					ELSIF v_grading_percentage > 25 THEN
						v_valid := 'U';
					END IF;
				END IF;
			END IF;
		END IF;
		-- Output result
		INSERT INTO
			trading_schema.prediction_test
			(
				change_percentage,
				change_diff,
				minimum,
				maximum,
				average,
				valid
			)
			VALUES
			(
				v_change_percentage,
				v_change_diff,
				v_minimum,
				v_maximum,
				v_average,
				v_valid
			)
			;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
