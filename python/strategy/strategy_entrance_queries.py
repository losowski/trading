#!/usr/bin/python

#Entrance to a trade
get_entrance_list_of_symbols = """
	SELECT
		s.symbol
	FROM
		trading_schema.symbol AS s
	;
"""

get_list_of_entrance_strategies = """
	SELECT
		id,
		code,
		name,
		risk_level
	FROM
		trading_schema.entry_strategy
	;
"""

get_strategy_proposal_conditions = """
	SELECT
		variable,
		operator,
		value
	FROM
		trading_schema.entry_conditions
	WHERE
		entry_strategy_id = %(entry_strategy_id)s
	;
"""

#NOTE: string.template
entrance_conditions_template = """
	AND
		${variable} ${operator} '${value}'
"""

entrance_query_template = """
	SELECT
		symbol
	FROM
		trading_schema.analysis a
		INNER JOIN trading_schema.symbol s ON (a.symbol_id = s.id)
		INNER JOIN trading_schema.quote q ON ((q.symbol_id = s.id) AND (a.date_of_prediction = q.datestamp))
	WHERE
		a.date_of_prediction < a.start_date
	AND
		a.end_date > current_timestamp
	${entrance_conditions}
	;
"""

entrance_query_output="trading_schema.pInsStrategyProposal"
"""
