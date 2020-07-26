DECLARE
	v_uuid				trading_schema.reference.reference%TYPE;
BEGIN
	SELECT
		reference 
	INTO
		v_uuid
	FROM
		trading_schema.reference
	ORDER BY
		datestamp
	LIMIT 1
	;
	PERFORM trading_schema.pInsPredictionTest(v_uuid);
END;
