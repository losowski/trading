# Request base

import logging

#Import Base
from python.fundamentals import import_base


class RequestBase(import_base.ImportBase):
	def __init__(self):
		super(RequestBase, self).__init__()
		self.logger		= logging.getLogger('RequestBase')

	def __del__(self):
		super(RequestBase, self).__del__()

	# Function template for identifying symbols to update
	def getSymbolsToUpdate(self):
		self.logger.info("Getting Symbols to update")


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		self.logger.info("Make Request\"%s\" (%s-%s)", symbol, timeBegin, timeEnd)
