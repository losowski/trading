# Request base

import logging

#Import Base
from python.fundamentals import import_base


class RequestBase(import_base.ImportBase):
	def __init__(self, requestInit):
		super(RequestBase, self).__init__()
		self.logger		= logging.getLogger('RequestBase')
		self.requestObj = requestInit

	def __del__(self):
		super(RequestBase, self).__del__()

	# Initialise the request Object
	def initRequest(self, **kwargs):
		req = self.requestObj(**kwargs)
		req.request()
		req.parse()
		return req

	# Function template for identifying symbols to update
	# returns a list
	def getSymbolsToUpdate(self):
		self.logger.info("Getting Symbols to update")
		return list()


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		self.logger.info("Make Request\"%s\" (%s-%s)", symbol, timeBegin, timeEnd)
