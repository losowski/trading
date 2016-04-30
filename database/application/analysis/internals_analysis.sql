-- All functions relating to the internals of the Analysis module

CREATE OR REPLACE FUNCTION trading_schema.pInsAnalysisAssignment(
	p_quote						trading_schema.quote.id%TYPE,
	p_analysis_property			trading_schema.analysis_property.id%TYPE
) RETURNS void AS $$
-- DECLARE
BEGIN
	-- Delete existing records
	DELETE FROM
		trading_schema.analysis_assignment_quote
	WHERE
		analysis_property_id = p_analysis_property
	AND
		quote_id = p_quote
	;
	-- Make new records
	INSERT INTO
		trading_schema.prediction_input
		(
			analysis_property_id,
			quote_id
		)
		VALUES
		(
			p_analysis_property,
			p_quote
		)
	;
END;
$$ LANGUAGE plpgsql;

