#!/usr/bin/python

import logging
import urllib2
import json

class JSONScraper:
	def __init__(self, url= "https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com"):
		self.url = url
		self.conn = None

	def __del__(self):
		pass

	def initialise(self):
		self.conn = urllib2.urlopen(self.url)

	def run(self):
		#Read the returned buffer
		self.data = self.conn.read()
		pass

	def shutdown(self):
		pass

	def fetch_json(self):
		logging.debug("JSON data: %s", self.data)
		json_obj = json.loads(self.data)
		return json_obj
