#
# Class for Handling the yahoo historical data 
#

#https://github.com/AndrewRPorter/yahoo-historical
import yahoo_historical

import datetime
import collections
import logging


from python.historical import stockDataBase

class Yahoo (stockDataBase.StockDataBase):
	def __init__(self):
		stockDataBase.StockDataBase.__init__(self)

	def __del__(self):
		stockDataBase.StockDataBase.__del__(self)

	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Do nothing - %s", data)
		# Calls rawInsertQuote

	# Overridden Quote function
	def getHistoricalData(symbol, lastUpdate, todayDate):
		self.logger.info("Do nothing - %s: (%s->%s)", symbol, lastUpdate, todayDate)
