#!/usr/bin/python

from yahoo_finance import yahoo_finance_base

class FeedsCoreAPI:
	def __init__(self):
		self.feed = None
		pass

	def __del__(self):
		self.feed = None
		pass


	def datasource_print(self, datasource):
		print("Using {0}".format(datasource))


	def initialise(self, system = "yahoofinance"):
		if system == "yahoofinance":
	   		self.datasource_print("Yahoo Finance")
	   		self.feed = yahoo_finance_base.YStockQuoteAPI()
		else:
			self.feed = yahoo_finance_base.YStockQuoteAPI()


	def get_current_price (self, symbol):
		return self.feed.get_current_price(symbol)


	def get_historical(self, symbol, start_date, end_date):
		return self.feed.get_historical(symbol, start_date, end_date)
