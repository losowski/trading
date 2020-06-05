#!/usr/bin/python
#
# Base class - Contains the queries to run and basic functionality
#
import datetime
import collections
import logging
import sys

import psycopg2

#Database
from python.database import db_connection


class StockBase:

	#SQL to get the current updates needed
	#	If we have no data, presume we start form 01-Jan-1960
	#	If checking for update, return Y if >1 day to update, or if we have nothing
	getSymbolsForUpdate="""
		SELECT
			s.symbol,
			COALESCE(date_trunc('day', MAX(q.datestamp)) + INTERVAL '1 days', '1960-01-01') as last_update,
			CASE	WHEN justify_days(age(MAX(q.datestamp))) > '1 days' THEN 'Y'
					WHEN MAX(q.datestamp) IS NULL THEN 'Y'
					ELSE 'N'
				END AS update
		FROM
			trading_schema.exchange e
			INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND s.enabled = 'Y')
			LEFT OUTER JOIN trading_schema.quote q ON (s.id = q.symbol_id)
		WHERE
			e.enabled = 'Y'
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

	insertQuoteData = "trading_schema.pInsQuote"

	def __init__(self):
		self.database		= db_connection.DBConnection()
		self.logger		= logging.getLogger('DataImportTicker')


	def __del__(self):
		self.database		= None


	def initialise(self):
		self.database.connect()


	def run(self, ignore):
		self.updateQuotes(ignore)
		#self.update_key_statistics() # Temporarily disabled


	def shutdown (self):
		pass

	#Disable problem symbols
	def setSymbolDisabled(self, symbol, state):
		query = self.database.get_query()
		data_parameters = collections.OrderedDict()
		data_parameters['symbol']			= symbol
		data_list = list(data_parameters.values())
		query.callproc("trading_schema.pDisableSymbol", data_list)
		update_symbols = query.fetchall()
		#commit the data
		self.database.commit()

	#Generic Function to import data
	def updateQuotes(self, ignore):
		#Get date now
		todayDate = datetime.date.today()
		# Get the list of Symbols: (Last update)
		updateSymbols = self.getSymbolLastUpdate()
		# For each symbol
		for symbol, lastUpdate, update in updateSymbols:
			self.logger.info("Update Check:%s: (%s->%s): %s", symbol, lastUpdate, todayDate, update)
			if ('Y' == update):
				#	Get the Stock data for that range
				dataRows = self.getHistoricalData(symbol,lastUpdate, todayDate, update)
				try:
					#	Insert the data
					insertQuery = self.database.get_query()
					self.insertQuote(insertQuery, symbol, dataRows)
					#commit the data
					self.database.commit()
				except psycopg2.Error as e:
					logging.error("PGCODE: %s", e.pgcode)
					logging.error("PGERROR: %s", e.pgerror)
					if (('25P02' == e.pgcode) or ('42883' == e.pgcode)):
						self.database.rollback()
						if (True == ignore):
							self.setSymbolDisabled(symbol, 'N')
					elif ('25P02' != e.pgcode):
						logging.critical("Irrecoverable error!")
						logging.error("PGCODE: %s", e.pgcode)
						logging.error("PGERROR: %s", e.pgerror)
						sys.exit()

			else:
				self.logger.warn("No Update needed")


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
	def rawInsertQuote(self, insertQuery, symbol, date, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume):
		data_parameters = collections.OrderedDict()
		data_parameters['symbol']			= symbol
		data_parameters['date']				= date
		data_parameters['open_price']		= openPrice
		data_parameters['high_price']		= highPrice
		data_parameters['low_price']		= lowPrice
		data_parameters['close_price']		= closePrice
		data_parameters['adj_close_price']	= adjClosePrice
		data_parameters['volume']			= volume
		dataList = list(data_parameters.values())
		logging.debug("Inserting %s", dataList)
		#execute the stored procedure
		insertQuery.callproc(self.insertQuoteData, dataList)


	# Overridden Quote function
	def getHistoricalData(self, symbol, lastUpdate, todayDate, update):
		self.logger.info("Do nothing - %s: (%s->%s): %s", symbol, lastUpdate, todayDate, update)


	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Do nothing - %s", data)



