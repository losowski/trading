#
# Class for Handling the yahoo historical data 
#

#https://github.com/AndrewRPorter/yahoo-historical
import yahoo_historical

import time
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
		logging.info("Date: %s", dateInput)
		logging.debug("Year: %s", dateInput.year)
		logging.debug("Month: %s", dateInput.month)
		logging.debug("Day: %s", dateInput.day)
		dateData = time.mktime(datetime.datetime(dateInput.year, dateInput.month, dateInput.day).timetuple())
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
		#self.logger.info("Doing nothing - %s", data)
		#NOTE: We get data in form of pandas.DataFrame
		for date, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume in zip(data.get('Date'), data.get('Open'), data.get('High'), data.get('Low'), data.get('Close'), data.get('Adj Close'), data.get('Volume')):
			# Convert date into a datetime object
			dateObj = datetime.datetime.fromisoformat(date)
			# Calls rawInsertQuote
			self.rawInsertQuote(dataQuery, symbol, dateObj, openPrice, highPrice, lowPrice, closePrice, adjClosePrice, volume)
