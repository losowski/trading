#!/usr/bin/python
# Uses the dryscrape library
# git repo: 	https://github.com/niklasb/dryscrape.git
# apt-get install qt5-default libqt5webkit5-dev build-essential python-lxml python-pip xvfb
# pip install dryscrape


import logging
import urllib2
import dryscrape
import sys

class WebScraper:
	def __init__(self, url="http://uk.finance.yahoo.com/q/ks?s=GOOG"):
		self.url = url
		self.urlnetwork = None

	def __del__(self):
		pass

	def initialise(self):
		logging.info("URL:%s", self.url)
		#session = dryscrape.Session(base_url = self.url)
		if 'linux' in sys.platform:
			# start xvfb in case no X is running. Make sure xvfb is installed, otherwise this won't work!
			dryscrape.start_xvfb()


	def run(self):
		self.session = dryscrape.Session()
		self.session.set_attribute('auto_load_images', False) #Don't load any images
		self.session.visit(self.url)

	def shutdown(self):
		pass

	def register_xpath(self, var_name, xpath):
		logging.debug("Variable name: %s, XPATH: %s", var_name, xpath)
		value = self.session.at_xpath(xpath).text
		logging.debug("Variable: %s, value: %s", var_name, value)
		value = self.session.at_xpath(xpath)
		logging.debug("Variable: %s, value: %s", var_name, value)
		#value = self.session.at_xpath(xpath).tag
		#logging.debug("Variable: %s, value: %s", var_name, value)
		setattr(self, var_name, value)
