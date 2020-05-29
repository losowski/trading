#!/usr/bin/python
#
# Base class - Contains the queries to run and basic functionality
#

import datetime
import collections
import logging

#Database
from python.database import db_connection

class StockBase:

	getSymbolsForUpdate="""
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
	#TODO: "update" should return Y on NONE
	#TODO: "last_update" should return today +1 by default

	# SELECT <function_name>(args);
	#'2013-01-03': {'Adj Close': '723.67',
	#                'Close': '723.67',
	#                'High': '731.93',
	#                'Low': '720.72',
	#                'Open': '724.93',
	#                'Volume': '2318200'},

	insertQuoteData = "trading_schema.pInsQuote"

	def __init__(self):
		self.database		= db_connection.DBConnection()
		self.logger		= logging.getLogger('DataImportTicker')


	def __del__(self):
		self.database		= None


	def initialise(self):
		self.database.connect()


	def run(self):
		self.updateQuotes()
		#self.update_key_statistics() # Temporarily disabled


	def shutdown (self):
		pass


	#Generic Function to import data
	def updateQuotes(self):
		#Get date now
		todayDate = datetime.date.today()
		# Get the list of Symbols: (Last update)
		updateSymbols = self.getSymbolLastUpdate()
		# For each symbol
		for symbol, lastUpdate, update in updateSymbols:
			self.logger.info("Update Check:%s: (%s->%s): %s", symbol, lastUpdate, todayDate, update)
			#	Get the Stock data for that range
			dataRows = self.getHistoricalData(symbol,lastUpdate, todayDate, update)
			#	Insert the data
			dataQuery = self.database.get_query()
			self.insertQuote(dataQuery, symbol, dataRows)
			#commit the data
			self.database.commit()


	# Generic Function to get last updates
	def getSymbolLastUpdate(self):
		selectQuery = self.database.get_query()
		selectQuery.execute(self.getSymbolsForUpdate)
		updateSymbols = selectQuery.fetchall()
		logging.info("Got %s symbols for update", len(updateSymbols))
		#get a list of symbols to update
		for symbol, last_entry, update in updateSymbols:
			logging.debug("SYM: %s : %s UPDATE: %s",symbol, last_entry, update)
		return updateSymbols


	#Generic insert quote date
	def rawInsertQuote(query, symbol, date, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume):
		data_parameters = collections.OrderedDict()
		data_parameters['symbol']			= symbol
		data_parameters['date']				= date
		data_parameters['open_price']		= openPrice
		data_parameters['high_price']		= highPrice
		data_parameters['low_price']		= lowPrice
		data_parameters['close_price']		= closePrice
		data_parameters['adj_close_price']	= adjClosePrice
		data_parameters['volume']			= volume
		data_list = list(data_parameters.values())
		logging.info("Inserting %s", data_list)
		#execute the stored procedure
		update_query.callproc(feeds_queries.insert_quote_data, data_list)


	# Overridden Quote function
	def getHistoricalData(self, symbol, lastUpdate, todayDate, update):
		self.logger.info("Do nothing - %s: (%s->%s): %s", symbol, lastUpdate, todayDate, update)


	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Do nothing - %s", data)



