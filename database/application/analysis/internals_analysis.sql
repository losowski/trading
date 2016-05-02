-- All functions relating to the internals of the Analysis module

CREATE OR REPLACE FUNCTION trading_schema.pInsAnalysisAssignment(
	p_quote						trading_schema.quote.id%TYPE,
	p_analysis_property			trading_schema.analysis_property.id%TYPE,
	p_uuid						trading_schema.reference.reference%TYPE
) RETURNS void AS $$
DECLARE
	v_reference_id				trading_schema.reference.id%TYPE;
BEGIN
	SELECT
		id
	FROM
		trading_schema.reference
	WHERE
		reference = p_uuid
	;
	--TODO: NO RESULT HANDLER
	v_reference_id := 1;
	--Leave in for now Delete existing records
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
			quote_id,
			reference_id
		)
		VALUES
		(
			p_analysis_property,
			p_quote,
			v_reference_id
	
		)
	;
END;
$$ LANGUAGE plpgsql;

