#!/usr/bin/python
# Uses the dryscrape library
# git repo: 	https://github.com/niklasb/dryscrape.git
# apt-get install qt5-default libqt5webkit5-dev build-essential python-lxml python-pip xvfb
# pip install dryscrape


import logging
import urllib2
import xml.etree.ElementTree as xml
import dryscrape

class WebScraper:
	def __init__(self, url="https://uk.finance.yahoo.com/q/ks?s=GOOG"):
		self.url = url
		self.urlnetwork = None
		self.tree = None
		self.root = None

	def __del__(self):
		pass

	def initialise(self):
		logging.info("URL:%s", self.url)
		session = dryscrape.Session()
		session.visit(self.url)

	def run(self):
		string = session.body()
		#logging.debug("HTML: %s", string)
		self.tree = xml.fromstring(string)
		self.root = self.tree.getroot()

	def shutdown(self):
		pass

	def register(self, var_name, xpath):
		logging.debug("Variable name: %s, XPATH: %s", var_name, xpath)
		value = self.root.findall(xpath)
		setattr(self, var_name, value)
