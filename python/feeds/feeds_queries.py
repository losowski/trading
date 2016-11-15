#!/usr/bin/python

get_symbols_for_quote_update="""
	SELECT
        s.symbol,
		date_trunc('day', MAX(q.datestamp)) as last_update,
		justify_days(age(MAX(q.datestamp))) > '1 days' as update
    FROM
        trading_schema.symbol s
        LEFT OUTER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
    GROUP BY
        s.symbol
    ORDER BY
        s.symbol
    ;
"""
# SELECT <function_name>(args);
#'2013-01-03': {'Adj Close': '723.67',
#                'Close': '723.67',
#                'High': '731.93',
#                'Low': '720.72',
#                'Open': '724.93',
#                'Volume': '2318200'},

insert_quote_data = "trading_schema.pInsQuote"

get_symbols_for_key_statistics_update="""
	SELECT
        s.symbol,
		date_trunc('day', MAX(ks.datestamp)) as last_update,
		justify_days(age(MAX(ks.datestamp))) > '1 days' as update
    FROM
        trading_schema.symbol s
        LEFT OUTER JOIN trading_schema.key_statistics ks ON (s.id = ks.symbol_id)
    GROUP BY
        s.symbol
    ORDER BY
        s.symbol
    ;
"""
# SELECT <function_name>(args);
#'2013-01-03': {'Adj Close': '723.67',
#                'Close': '723.67',
#                'High': '731.93',
#                'Low': '720.72',
#                'Open': '724.93',
#                'Volume': '2318200'},

insert_key_statistics_data = "trading_schema.pInsKeyStatistics"
