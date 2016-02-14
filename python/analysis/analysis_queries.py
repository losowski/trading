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
		INNER JOIN a_moving_avg amavg ON (amavg.quote_id = q.id)
		INNER JOIN a_moving_diff amdiff ON (amdiff.id = q.id)
	WHERE
		s.name = %(symbol.name)s
	;
"""
