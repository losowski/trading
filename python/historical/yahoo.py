#
# Class for Handling the yahoo historical data 
#

#https://github.com/AndrewRPorter/yahoo-historical
import yahoo_historical

import datetime
import collections
import logging


from python.historical import stockBase

class Yahoo (stockBase.StockBase):
	def __init__(self):
		stockBase.StockBase.__init__(self)

	def __del__(self):
		stockBase.StockBase.__del__(self)

	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Do nothing - %s", data)
		# Calls rawInsertQuote

	# Overridden Quote function
	def getHistoricalData(self, symbol, lastUpdate, todayDate):
		self.logger.info("Do nothing - %s: (%s->%s)", symbol, lastUpdate, todayDate)
