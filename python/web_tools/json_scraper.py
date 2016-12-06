#!/usr/bin/python
# Uses the dryscrape library
# git repo: 	https://github.com/niklasb/dryscrape.git
# apt-get install qt5-default libqt5webkit5-dev build-essential python-lxml python-pip xvfb
# pip install dryscrape


import logging
import urllib2
import httplib
import json

class JSONScraper:
	def __init__(self, url="https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com"):
		self.url = url
		self.conn = None

	def __del__(self):
		pass

	def initialise(self):
		logging.info("URL:%s", self.url)
		self.conn = httplib.HTTPSConnection("self.url")
		self.conn.request("GET", "/")

	def run(self):
		r1 = conn.getresponse()
		print r1.status, r1.reason
		data1 = r1.read()

	def shutdown(self):
		pass

	def fetch_json(self):
		pass
