#!/usr/bin/python

get_exit_strategy_trades= """
	SELECT
		s.symbol,
		es.datestamp,
		es.entry_strategy_id
	FROM
		trading_schema.accepted_trades at
		INNER JOIN trading_schema.strategy_proposal es ON (at.entrance_strategy_id = es.id)
		INNER JOIN trading_schema.symbol s ON (es.symbol_id = s.id)
	WHERE
		at.date_closed IS NULL
	;
"""
exit_query_template = """
"""

get_exit_strategy_conditions = """
	SELECT
		variable,
		operator,
		value
	FROM
		trading_schema.exit_conditions
	WHERE
		entry_strategy_id = %(entry_strategy_id)s
	;
"""


#NOTE: string.template
exit_conditions_template = """
	AND
		${variable} ${operator} '${value}'
"""

exit_strategy_template = """
"""

exit_strategy_outputs = """
"""
