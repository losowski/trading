#!/usr/bin/python

#Get symbols list
get_list_of_symbols = """
	SELECT
		symbol
	FROM
		trading_schema.symbol
	;
"""

#Perform calculation on symbols
generate_analysis_table = "trading_schema.pCalcAnalysis"

#Obtain the full set of analysed prediction data
get_data_analysis = """
	SELECT
		*
	FROM
		trading_schema.symbol s
		INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
		INNER JOIN a_moving_avg ON moving_avg ON (moving_avg.quote_id = q.id)
	WHERE
		s.name = %(symbol.name)s
	;
"""
