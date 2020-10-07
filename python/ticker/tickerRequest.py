# Ticker request code

import logging

# Pandas driven code
import pandas

class TickerRequest(object):
	SQLBASE	= """
	"""
	def __init__(self, database, symbol, date):
		self.database	=	database
		# Query parameters
		self.symbol		=	symbol
		self.date		=	date
		# Get pandas DataFrame
		self.dataframe	=	None

	def __del__(self):
		self.database = None


	def initialise(self):
		# setup the query
		pass


	def runQuery(self):
		pass

	def getData(self):
		return self.dataframe
