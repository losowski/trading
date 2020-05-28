#!/usr/bin/python
import logging

from database import db_connection
from database import db_cursor

#Get symbols list
get_list_of_symbols = """
	SELECT
		symbol
	FROM
		trading_schema.symbol
	;
"""

class Symbols (db_cursor.DBCursor):
	def __init__(self):
		db_cursor.DBCursor.__init__(self)
		self.symbols_list	= None #list()

	def __del__(self):
		db_cursor.DBCursor.__del__(self)
		pass

	#def initialise(self):
	#def shutdown(self):

	def get_symbols_list(self):
		if self.symbols_list is None:
			logging.info("Fetching Symbols")
			self.symbols_list	= list()
			self.get_db().execute(get_list_of_symbols)
			symbols_list = self.db_cursor.fetchall()
			for symbol in symbols_list:
				logging.debug("reading symbol: %s", symbol[0])
				self.symbols_list.append(symbol[0])
		return self.symbols_list
