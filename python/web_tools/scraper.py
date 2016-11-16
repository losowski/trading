#!/usr/bin/python
# Uses the dryscrape library
# git repo: 	https://github.com/niklasb/dryscrape.git
# apt-get install qt5-default libqt5webkit5-dev build-essential python-lxml python-pip xvfb
# pip install dryscrape


import logging
import urllib2
import xml.etree.ElementTree as xml
import dryscrape
import sys

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
		#session = dryscrape.Session(base_url = self.url)
		if 'linux' in sys.platform:
			# start xvfb in case no X is running. Make sure xvfb is installed, otherwise this won't work!
			dryscrape.start_xvfb()
		session = dryscrape.Session()
		session.visit(self.url)
		session.set_attribute('auto_load_images', False) #Don't load any images
		self.string = session.body()
		#print self.string

	def run(self):
		#logging.debug("HTML: %s", self.string)
		#result = self.buf.read_line().decode("utf-8")
		#self.tree = xml.fromstring(self.string.decode("utf-8"))
		self.tree = xml.fromstring(self.string)
		self.root = self.tree.getroot()

	def shutdown(self):
		pass

	def register(self, var_name, xpath):
		logging.debug("Variable name: %s, XPATH: %s", var_name, xpath)
		value = self.root.findall(xpath)
		setattr(self, var_name, value)
