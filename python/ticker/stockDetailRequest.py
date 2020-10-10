# Ticker request code

import logging

# Pandas driven code
import pandas as pd

class StockDetailRequest(object):
	SymbolSQL	= """
		SELECT
			e.name,	
			e.enabled,
			s.name,
			s.symbol,
			s.enabled,
			MIN(q.datestamp) AS earliest,
			MAX(q.datestamp) AS latest,
		FROM
			trading_schema.exchange e
			INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id)
			INNER JOIN trading_schema.quote q ON (q.symbol_id = s.id)
		WHERE
			s.symbol = '{symbol}'
		{where}
		ORDER BY
			s.symbol,
			q.datestamp
		;
		"""
	# Code Truth table
	#	Symbol	|	Exchange	|	enabled	|	Outcome
	#-------------------------------------------------------
	#			|				|			|	Random symbol details
	#	X		|				|			|	Show the symbol details + exchange for this symbol
	#			|	X			|			|	Show the exchange details
	#	X		|	X			|			|	Show symbol details ONLY if in this exchange
	#			|				|	X		|	Random (enabled) stock
	#	X		|				|	X		|	Show symbol details ONLY if enabled
	#			|	X			|	X		|	Show exchange details ONLY if enabled
	#	X		|	X			|	X		|	Show symbol details ONLY if symbol AND exchange enabled
	def __init__(self, database, symbol, exchange, enabled):
		self.logger			=	logging.getLogger('StockDetailRequest')
		# Database
		self.database		=	database
		# Query parameters
		self.symbol			=	symbol
		self.exchange		=	exchange
		self.enabled		=	enabled
		# Get pandas DataFrame
		self.dataset	=	None

	def __del__(self):
		self.database = None


	def initialise(self):
		# setup the query
		pass


	def load(self):
		# Log out data
		self.logger.info("Loading Symbol: %s @ %s", self.symbol)
		# Build the "where" statement
		whereSQL = ""
		if ("" != self.exchange):
			self.logger.debug("exchange: %s", self.exchange)
			#TODO: Add code to ensure correct order
			whereSQL += "AND e.name = '{exchange}'".format(exchange = self.exchange)
		if ("" != self.enabled):
			self.logger.debug("enabled: %s", self.enabled)
			#TODO: Add code to ensure correct order
			whereSQL += "AND s.enabled = '{enabled}' AND e.enabled = '{enabled}'".format(enabled = self.enabled)
		# Produce the final query
		query	=	self.SymbolSQL.format(symbol = self.symbol, where = whereSQL)
		self.logger.debug("Query: %s", query)
		#TODO: Build using other queries
		self.dataset = pd.read_sql_query(query, con=self.database.get_connection())
		self.logger.debug("Loaded dataset:\n%s", self.dataset)

	def getData(self):
		return self.dataset
