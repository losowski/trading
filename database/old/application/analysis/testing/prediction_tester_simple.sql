-- Query for investigating the prediction input and output.
-- Produces the raw symbol info that the predictor would see, and the outcome
WITH predsymbol AS (
	SELECT
		pi.id AS prediction_input_id,
		pi.quote_id,
		s.id AS symbol_id,
		q.datestamp,
		date_trunc('DAY', q.datestamp) AS prediction_startdate,
		date_trunc('DAY', pi.end_date) AS prediction_enddate
	FROM
		trading_schema.prediction_input pi
		INNER JOIN trading_schema.quote q ON (pi.quote_id = q.id)
		INNER JOIN trading_schema.symbol s ON (q.symbol_id = s.id)
	WHERE
		pi.id = 21
),
prediction AS (
	SELECT
		ps.symbol_id,
		ps.datestamp,
		ps.prediction_startdate,
		ps.prediction_enddate,
		(ps.datestamp - MAX(ac.duration)) AS snapshot_date
	FROM
		predsymbol ps
		INNER JOIN trading_schema.prediction_input pi ON (ps.prediction_input_id = pi.id)
		INNER JOIN trading_schema.analysis_property ap ON (pi.analysis_property_id = ap.id)
		INNER JOIN trading_schema.analysis_conditions ac ON (ap.id = ac.analysis_property_id)
	GROUP BY
		ps.symbol_id,
		ps.datestamp,
		ps.prediction_enddate,
		ps.prediction_startdate
),
quotes AS
(
	SELECT
		pi.snapshot_date AS data_start,
		pi.prediction_startdate AS data_end,
		pi.prediction_enddate,
		q.id					AS	q_id,
		q.datestamp				AS	q_datestamp,
		q.volume				AS	q_volume,
		q.adjusted_close_price	AS	q_adjusted_close_price,
		q.open_price			AS	q_open_price,
		q.close_price			AS	q_close_price,
		q.high_price			AS	q_high_price,
		q.low_price				AS	q_low_price,
		qd.diff_close_price		AS	qd_diff_close_price,
		qd.diff_high_price		AS	qd_diff_high_price,
		qd.diff_low_price		AS	qd_diff_low_price,
		qd.diff_open_price		AS	qd_diff_open_price,
		qd.diff_open_close		AS	qd_diff_open_close,
		qd.diff_high_low		AS	qd_diff_high_low,
		amavg.days2 			AS	amavg_days2,
		amavg.days5 			AS	amavg_days5,
		amavg.days9 			AS	amavg_days9,
		amavg.days15 			AS	amavg_days15,
		amavg.days21			AS	amavg_days21,
		amavg.days29 			AS	amavg_days29,
		amavg.days73 			AS	amavg_days73,
		amavg.days91 			AS	amavg_days91,
		amavg.days121 			AS	amavg_days121,
		amavg.days189 			AS	amavg_days189,
		amdiff.days2 			AS	amdiff_days2,
		amdiff.days5 			AS	amdiff_days5,
		amdiff.days9 			AS	amdiff_days9,
		amdiff.days15 			AS	amdiff_days15,
		amdiff.days21			AS	amdiff_days21,
		amdiff.days29 			AS	amdiff_days29,
		amdiff.days73 			AS	amdiff_days73,
		amdiff.days91 			AS	amdiff_days91,
		amdiff.days121 			AS	amdiff_days121,
		amdiff.days189 			AS	amdiff_days189
	FROM
		prediction pi
		INNER JOIN trading_schema.quote q ON (pi.symbol_id = q.symbol_id AND q.datestamp >= pi.snapshot_date AND q.datestamp <= pi.prediction_enddate)
		LEFT OUTER  JOIN trading_schema.quote_diff qd ON (qd.quote_id = q.id)
		LEFT OUTER JOIN trading_schema.a_moving_avg amavg ON (q.id = amavg.id)
		LEFT OUTER JOIN trading_schema.a_moving_diff amdiff ON (q.id = amdiff.id)
)
SELECT
	*
FROM
	quotes
ORDER BY
	q_datestamp
;