#!/usr/bin/python
# Class to process the historical data

import datetime
import logging


#https://github.com/AndrewRPorter/yahoo-historical
import yahoo_historical

class YStockQuoteAPI:
	def __init__(self):
		pass

	def __del__(self):
		pass

	def get_historical(self, symbol, startDate, endDate):
		#Fetcher("AAPL", [2007,1,1], [2017,1,1])
		logging.debug("Start Stamp: %s", startDate)
		logging.debug("End Date Stamp: %s", endDate)
		sd = self.convertDateToHistoricalFormat(startDate)
		ed = self.convertDateToHistoricalFormat(endDate)
		data = yahoo_historical.Fetcher(symbol, sd, ed)
		return data.get_historical()

	def convertDateToHistoricalFormat(self, dateInput):
		logging.debug("Date: %s", dateInput)
		logging.debug("Year: %s", dateInput.year)
		logging.debug("Month: %s", dateInput.month)
		logging.debug("Day: %s", dateInput.day)
		dateData = [dateInput.year,dateInput.month, dateInput.day]
		return dateData
