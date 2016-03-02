#!/usr/bin/python

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

analysis_backbone_query = """
	SELECT
		*
	FROM
	(
		SELECT
			*
		FROM
			trading_schema.symbol s
			INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
			LEFT OUTER JOIN trading_schema.quote_diff qd ON (qd.quote_id = q.id)
			LEFT OUTER JOIN trading_schema.a_moving_avg amavg ON (amavg.id = q.id)
			LEFT OUTER JOIN trading_schema.a_moving_diff amdiff ON (amdiff.id = q.id)
		WHERE
			s.symbol = %(symbol)s
	)
	WHERE
		%(analysis_conditions)s
	ORDER BY
		symbol_datestamp
"""
