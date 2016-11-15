#!/usr/bin/python
#Uses psycopg package: python-webkit (python- javascript handler)
#sudo apt-get install python-pwebkit

import logging
import urllib2
#import python-webkit
import xml.etree.ElementTree as xml

class WebScraper:
	def __init__(self, url="https://uk.finance.yahoo.com/q/ks?s=GOOG"):
		self.url = url
		self.urlnetwork = None
		self.tree = None
		self.root = None
		pass

	def __del__(self):
		pass

	def initialise(self):
		logging.info("URL:%s", self.url)
		self.urlnetwork = urllib2.urlopen(self.url)
		#logging.debug("WEB:%s", self.urlnetwork.read())
		pass

	def run(self):
		string = self.urlnetwork.read()
		#logging.debug("HTML: %s", string)
		self.tree = xml.fromstring(string)
		self.root = self.tree.getroot()
		pass

	def shutdown(self):
		pass

	def register(self, var_name, xpath):
		logging.debug("Variable name: %s, XPATH: %s", var_name, xpath)
		value = self.root.findall(xpath)
		setattr(self, var_name, value)
