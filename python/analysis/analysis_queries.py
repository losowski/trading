#!/usr/bin/python
#postgres %(name_of_field)s
#python ${name_of_field}

import string
#Get symbols list
get_list_of_symbols = """
	SELECT
		symbol
	FROM
		trading_schema.symbol
	;
"""

#Perform data analysis
perform_data_analysis = "trading_schema.pCalcAnalysis"

#Perform calculation on symbols
generate_analysis_table = "trading_schema.pCalcAnalysis"

#Obtain the full set of analysed prediction data
get_data_analysis = """
	SELECT
		*
	FROM
		trading_schema.symbol s
		INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
		LEFT OUTER JOIN trading_schema.quote_diff qd ON (qd.quote_id = q.id)
		LEFT OUTER JOIN trading_schema.a_moving_avg amavg ON (amavg.id = q.id)
		LEFT OUTER JOIN trading_schema.a_moving_diff amdiff ON (amdiff.id = q.id)
	WHERE
		s.name = %(symbol.name)s
	;
"""

# backbone for the logic that will allow DB based analysis
get_analysis_properties = """
	SELECT
		id,
		name,
		analysis_type,
		assigned_value
	FROM
		trading_schema.analysis_properties
	;
"""

get_analysis_conditions = """
	SELECT
		c.field_name,
		c.operator,
		c.threshold_type,
		c.duration,
		c.value
	FROM
		trading_schema.analysis_properties p
		INNER JOIN trading_schema.analysis_conditions c ON (c.analysis_property_id = p.id)
	WHERE
		p.id = %(property_id)s
	;
"""
#Only using Python string replace
analysis_absolute_parameter_fragment = """
			AND
				${field_name} ${operator} ${value}
"""

AnalysisAbsoluteParameterTemplate = string.Template(analysis_absolute_parameter_fragment)

analysis_relative_parameter_fragment = """
	INNER JOIN
		symbol_quote ${relative_index} ON (${relative_index}.q_datestamp <= sa.q_datestamp AND ${relative_index}.q_datestamp >= sa.q_datestamp - ${duration}::interval AND ${relative_index}.${field_name}>= sa.${field_name} + ${value}
"""

AnalysisRelativeParameterTemplate = string.Template(analysis_relative_parameter_fragment)

analysis_backbone_query = """
	WITH symbol_quote AS (
	SELECT
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
		trading_schema.symbol s
		INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
		LEFT OUTER  JOIN trading_schema.quote_diff qd ON (qd.quote_id = q.id)
		LEFT OUTER JOIN trading_schema.a_moving_avg amavg ON (q.id = amavg.id)
		LEFT OUTER JOIN trading_schema.a_moving_diff amdiff ON (q.id = amdiff.id)
	WHERE
		s.symbol = %(symbol)s
	),
	symbol_absolute AS
	(
		SELECT
			q_id,
			q_datestamp,
			q_volume,
			q_adjusted_close_price,
			q_open_price,
			q_close_price,
			q_high_price,
			q_low_price,
			qd_diff_close_price,
			qd_diff_high_price,
			qd_diff_low_price,
			qd_diff_open_price,
			qd_diff_open_close,
			qd_diff_high_low,
			amavg_days2,
			amavg_days5,
			amavg_days9,
			amavg_days15,
			amavg_days21,
			amavg_days29,
			amavg_days73,
			amavg_days91,
			amavg_days121,
			amavg_days189,
			amdiff_days2,
			amdiff_days5,
			amdiff_days9,
			amdiff_days15,
			amdiff_days21,
			amdiff_days29,
			amdiff_days73,
			amdiff_days91,
			amdiff_days121,
			amdiff_days189
		FROM
			symbol_quote
		WHERE
			TRUE
			-- Absolute comparators
			${absolute_comparators}
	)
SELECT
	sa.*
FROM
	symbol_absolute sa
	-- Relative Comparators
	${relative_comparators}
ORDER BY
	q_id
;
"""

AnalysisBackboneQueryTemplate = string.Template(analysis_backbone_query)
