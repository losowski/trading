#!/usr/bin/python
import logging

from database import db_connection

#Get symbols list
get_list_of_symbols = """
	SELECT
		symbol
	FROM
		trading_schema.symbol
	;
"""

class Symbols:
	def __init__(self):
		self.database		= db_connection.DBConnection()
		self.symbols_list	= list()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()
		self.db_cursor = self.database.get_query()

	def shutdown(self):
		self.db_cursor.close()

	def get_symbols_list(self):
		if len(self.symbols_list) == 0:
			logging.info("Fetching Symnbols")
			self.db_cursor.execute(get_list_of_symbols)
			symbols_list = self.db_cursor.fetchall()
			for symbol in symbols_list:
				logging.debug("reading symbol: %s", symbol[0])
			self.symbols_list.append(symbol[0])
		return self.symbols_list
