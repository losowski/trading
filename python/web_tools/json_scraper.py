#!/usr/bin/python
# Uses the dryscrape library
# git repo: 	https://github.com/niklasb/dryscrape.git
# apt-get install qt5-default libqt5webkit5-dev build-essential python-lxml python-pip xvfb
# pip install dryscrape


import logging
import urllib2
import sys
import json

class WebScraper:
	def __init__(self, url="https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com"):
		self.url = url

	def __del__(self):
		pass

	def initialise(self):
		logging.info("URL:%s", self.url)

	def run(self):
		pass

	def shutdown(self):
		pass

	def fetch_json(self):
		pass
