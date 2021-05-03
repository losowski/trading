#!/usr/bin/python
#
# Base class - Contains the queries to run and basic functionality
#
import datetime
import time
import collections
import logging
import sys
import traceback

import pkg_resources
pkg_resources.require("psycopg2==2.9.dev0")
import psycopg2

#Database
from python.database import db_connection


class StockBase:

	#SQL to get the current updates needed
	#	If we have no data, presume we start form 01-Jan-1960
	#	If checking for update, return Y if >1 day to update, or if we have nothing
	symbolsForUpdateBase="""
		WITH data AS (
			SELECT
				s.symbol,
				COALESCE(date_trunc('day', MAX(q.datestamp)) + INTERVAL '1 days', date_trunc('day',s.last_update), '1960-01-01') AS last_update
			FROM
				trading_schema.exchange e
				INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND s.enabled != 'N' AND (s.last_update < %(currentdate)s OR s.last_update IS NULL))
				LEFT JOIN trading_schema.quote q ON (s.id = q.symbol_id AND (q.datestamp >= s.last_update - INTERVAL '3 days' OR s.last_update IS NULL))
			WHERE
				e.enabled = 'Y'
				{where}
			GROUP BY
				s.symbol,
				s.last_update
		)
		SELECT
			d.symbol,
			d.last_update,
			CASE	WHEN justify_days(age(d.last_update)) > '1 days' THEN 'Y'
					ELSE 'N'
			END AS update
		FROM
			data d
		ORDER BY
			d.symbol
		;
	"""
	getSymbolsForUpdate	=	symbolsForUpdateBase.format(where="")
	getExchangeUpdate		=	symbolsForUpdateBase.format(where="AND e.name = %(exchange)s")
	getSymbolUpdate		=	symbolsForUpdateBase.format(where="AND s.symbol = %(symbol)s")
	#TODO: INDEX on s.enabled
	#TODO: Improve speed (takes an age)

	# SELECT <function_name>(args);
	#'2013-01-03': {'Adj Close': '723.67',
	#                'Close': '723.67',
	#                'High': '731.93',
	#                'Low': '720.72',
	#                'Open': '724.93',
	#                'Volume': '2318200'},

	insertQuoteData = "trading_schema.pInsQuote"

	def __init__(self):
		self.database		=	db_connection.DBConnection()
		self.logger			=	logging.getLogger('DataImportTicker')
		self.todayDate		=	None


	def __del__(self):
		self.database		=	None


	#Setup "constants" for this run
	def initialise(self):
		self.database.connect()
		#Get date now
		self.todayDate = self.getTodaysDate()


	# Shutdown
	def shutdown(self):
		self.logger.info("Shutting Down")


	# Perform updates for all symbols
	def run(self, ignore):
		self.updateQuotes(ignore, None, None)
		#self.update_key_statistics() # Temporarily disabled


	# Perform update of only one symbol
	#	Beware that this does not override the restrictions in place
	def runSymbol(self, ignore, symbol):
		self.logger.info("Updating particular symbol: %s", symbol)
		self.updateQuotes(ignore, None, symbol)


	# Perform update of only one exchange
	#	Beware that this does not override the restrictions in place
	def runExchange(self, ignore, exchange):
		self.logger.info("Updating particular exchange: %s", exchange)
		self.updateQuotes(ignore, exchange, None)


	#Disable problem symbols
	def setSymbolDisabled(self, symbol, state ='-'):
		self.logger.warn("Disable %s (%s)", symbol, state)
		query = self.database.get_query()
		data_parameters = collections.OrderedDict()
		data_parameters['symbol']			= symbol
		data_parameters['enable']			= state
		data_list = list(data_parameters.values())
		query.callproc("trading_schema.pDisableSymbol", data_list)
		update_symbols = query.fetchall()
		#commit the data
		self.database.commit()


	# Get Todays date as if it was a 5 day week
	def getTodaysDate(self):
		doy = datetime.date.today().weekday()
		friday = 0
		#Can only get quotes Monday to Friday (0-4)
		if (doy > 4):
			friday = doy - 4
		#Create an interval
		date = datetime.date.today() - datetime.timedelta(days=friday)
		self.logger.info("Weekday date: %s", date)
		return date


	#Generic Function to import data
	def updateQuotes(self, ignore, exchange, symbol):
		# Get the list of Symbols: (Last update)
		updateSymbols = self.getSymbolLastUpdate(exchange, symbol)
		# For each symbol
		for symbol, lastUpdate, update in updateSymbols:
			self.logger.info("Update Check:%s: (%s->%s): %s", symbol, lastUpdate, self.todayDate, update)
			#Check if we are more than 1 day (Monday-Friday)
			#TODO: Implement check for if we are more than 1 day monday-friday
			if ('Y' == update):
				try:
					#	Get the Stock data for that range
					dataRows = self.getHistoricalData(symbol,lastUpdate, self.todayDate, update)
					#	Insert the data
					insertQuery = self.database.get_query()
					psycopg2.extensions.register_type(psycopg2.extensions.UNICODE, insertQuery)
					self.insertQuote(insertQuery, symbol, dataRows)
					#commit the data
					self.database.commit()
				except psycopg2.Error as e:
					self.logger.error("PGCODE: %s", e.pgcode)
					self.logger.error("PGERROR: %s", e.pgerror)
					if (('25P02' == e.pgcode) or ('42883' == e.pgcode)):
						self.database.rollback()
						if (True == ignore):
							self.setSymbolDisabled(symbol, 'P')
					elif ('25P02' != e.pgcode):
						self.logger.critical("Irrecoverable error!")
						self.logger.error("PGCODE: %s", e.pgcode)
						self.logger.error("PGERROR: %s", e.pgerror)
						sys.exit()
				except UnboundLocalError as e:
					self.logger.error("UnboundLocalError: %s", e)
					self.setSymbolDisabled(symbol, '-')
				except:
					self.logger.critical("Unexpected error: %s", sys.exc_info()[0])
					self.logger.critical("Traceback: %s", traceback.format_exc())
					self.setSymbolDisabled(symbol, '?')
				# Sleep to stop Yahoo kicking us
				time.sleep(2)

			else:
				self.logger.warn("No Update needed")


	# Generic Function to get last updates
	#TODO: Pass in FRIDAY here so that we get only the symbols not updated on a weekday
	def getSymbolLastUpdate(self, exchange, symbol):
		selectQuery = self.database.get_query()
		logging.info("Today format: %s", self.todayDate)
		dataDict = dict()
		dataDict['currentdate']			=	self.todayDate.isoformat()
		dataDict['exchange']			=	exchange
		dataDict['symbol']				=	symbol
		self.logger.debug("Query Parameters %s", dataDict)
		self.logger.debug("Symbol: %s", symbol)
		if (exchange is not None):
			self.logger.info("Exchange Query")
			query	=	self.getExchangeUpdate
		elif (symbol is not None):
			self.logger.info("Symbol Query")
			query	=	self.getSymbolUpdate
		else:
			self.logger.info("All Symbols")
			query	=	self.getSymbolsForUpdate
		self.logger.info("Query: %s", query)
		selectQuery.execute(query, dataDict)
		updateSymbols = selectQuery.fetchall()
		logging.info("Got %s symbols for update", len(updateSymbols))
		#get a list of symbols to update
		for symbol, last_entry, update in updateSymbols:
			logging.debug("SYM: %s : %s UPDATE: %s",symbol, last_entry, update)
		return updateSymbols


	#Generic insert quote date
	def rawInsertQuote(self, insertQuery, symbol, date, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume):
		#data_parameters = collections.OrderedDict()
		data_parameters = dict()	
		self.logger.info("symbol: %s (%s) - %s", symbol, type(symbol), repr(symbol))
		data_parameters['p_symbol']				= symbol
		data_parameters['p_date']				= date
		data_parameters['p_open_price']			= openPrice
		data_parameters['p_high_price']			= highPrice
		data_parameters['p_low_price']			= lowPrice
		data_parameters['p_close_price']		= closePrice
		data_parameters['p_adj_close_price']	= adjClosePrice
		data_parameters['p_volume']				= volume
		#dataList = list(data_parameters.values())
		logging.debug("Inserting %s", data_parameters)
		#execute the stored procedure
		#insertQuery.callproc(self.insertQuoteData, data_parameters)
		# Workaround for callproc not working
		insertQuoteDataSQL = "SELECT * FROM trading_schema.pInsQuote('{p_symbol}'::text, '{p_date}'::timestamp without time zone, {p_open_price}, {p_high_price}, {p_low_price}, {p_close_price}, {p_adj_close_price}, {p_volume});"
		sql = insertQuoteDataSQL.format(**data_parameters)
		logging.debug("SQL %s", sql)
		insertQuery.execute(sql)

	# Overridden Quote function
	def getHistoricalData(self, symbol, lastUpdate, todayDate, update):
		self.logger.info("Do nothing - %s: (%s->%s): %s", symbol, lastUpdate, todayDate, update)


	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Do nothing - %s", data)
