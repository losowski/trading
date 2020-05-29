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


	def __convertDateToHistoricalFormat(self, dateInput):
		logging.debug("Date: %s", dateInput)
		logging.debug("Year: %s", dateInput.year)
		logging.debug("Month: %s", dateInput.month)
		logging.debug("Day: %s", dateInput.day)
		dateData = [dateInput.year,dateInput.month, dateInput.day]
		return dateData


	# Overridden Quote function
	def getHistoricalData(self, symbol, lastUpdate, todayDate, update):	
		logging.debug("Start Stamp: %s", lastUpdate)
		logging.debug("End Date Stamp: %s", todayDate)
		sd = self.__convertDateToHistoricalFormat(lastUpdate)
		ed = self.__convertDateToHistoricalFormat(todayDate)
		data = yahoo_historical.Fetcher(symbol, sd, ed)
		return data.get_historical()


	# Overridden Quote function
	def insertQuote(self, dataQuery, symbol, data):
		self.logger.info("Doing nothing - %s", data)
		for rowData in data.iteritems():
			date			=	rowData.get('Date')
			openPrice		=	rowData.get('Open')
			highPrice		=	rowData.get('High')
			lowPrice		=	rowData.get('Low')
			closePrice		=	rowData.get('Close')
			adjClosePrice	=	rowData.get('Adj Close')
			volume			=	rowData.get('Volume')
			# Calls rawInsertQuote
			self.rawInsertQuote(query, symbol, date, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume)
