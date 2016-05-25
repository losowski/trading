-- All functions relating to the internals of the Analysis module
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
			v_end_date = v_current_date + v_days;
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
		v_end_date := localtimestamp + v_days;
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
	v_reference_id				trading_schema.reference.id%TYPE;
	v_end_date					trading_schema.prediction_input.end_date%TYPE;
	v_end_value					trading_schema.prediction_input.end_value%TYPE;
	v_end_diff					trading_schema.prediction_input.end_diff%TYPE;
BEGIN
	-- Obtain the reference ID
	SELECT
		q.datestamp,
		pi.end_date,
		pi.end_value,
		pi.end_diff
	FROM
		trading_schema.prediction_input pi
		INNER JOIN trading_schema.quote q ON (pi.quote_id = q.id)
	WHERE
		reference = CAST (p_uuid AS uuid)
	;
END;
$$ LANGUAGE plpgsql;
