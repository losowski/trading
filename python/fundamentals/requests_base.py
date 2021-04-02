# Request base

import logging

class RequestBase:
	def __init__(self):
		self.logger		= logging.getLogger('RequestBase')
		pass

	def __del__(self):
		pass

	# Function template for identifying symbols to update
	def getSymbolsToUpdate(self):
		self.logger.info("Getting Symbols to update")


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		self.logger.info("Make Request\"%s\" (%s-%s)", symbol, timeBegin, timeEnd)
