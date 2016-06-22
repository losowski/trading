SELECT
	pi.id AS prediction_input_id,
	s.id AS symbol_id,
	date_trunc('DAY', q.datestamp) AS startdate,
	date_trunc('DAY', pi.end_date) AS enddate,
	pi.end_value,
	pi.end_diff AS end_diff,
	ap.analysis_type,
	ap.price_change,
	ap.days
FROM
	trading_schema.reference r
	INNER JOIN trading_schema.prediction_input pi ON (r.id = pi.reference_id)
	INNER JOIN trading_schema.analysis_property ap ON (pi.analysis_property_id = ap.id)
	INNER JOIN trading_schema.quote q ON (pi.quote_id = q.id)
	INNER JOIN trading_schema.symbol s ON (q.symbol_id = s.id)
	LEFT OUTER JOIN trading_schema.prediction_test pt ON (pi.id = pt.prediction_input_id)
WHERE
	r.reference = CAST ('e98620c5-e05e-4ae1-a0fc-2e59f7870cee' AS uuid)
AND
	pt.prediction_input_id IS NULL