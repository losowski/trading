#!/usr/bin/python

import logging
import urllib2
import json
#import datetime

class JSONScraper:
	def __init__(self, url , json_mappings):
		logging.debug("URL: %s", url)
		self.url = url
		self.conn = None
		self.data = None
		self.json_mappings = json_mappings #JSON-KEY : (database_key, json_field)


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

	def xpand_json(self, data):
		if isinstance(data, list):
			for d in data:
				logging.debug("LIST: %s\n", d)
				self.xpand_json(d)
		elif isinstance (data, dict):
			for dk,  dv in data.iteritems():
				logging.debug("DICT DK: %s -> DV: %s", dk, dv)
				if dk in self.json_mappings:
					attr, key,  datatype = self.json_mappings[dk]
					value = None
					if key in dv:
						value = dv[key]
					#TODO: Add a handler for the specific datatype
					#Set the attribute
					setattr(self, attr, value)

				else:
					#Not matching parameter
					self.xpand_json(dv)

	def register(self):
		logging.debug("importing JSON data")
		self.xpand_json(self.fetch_json())
