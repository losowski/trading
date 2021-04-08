# Request base

import logging
import collections

#Import Base
from python.fundamentals import import_base


class RequestBase(import_base.ImportBase):

	#Query to identify and get the list of SYMBOLs to update
	FinancialsForUpdateSQL = None

	# Map of Request keys
	# (reportType) : dict(psqlParameter : Key)
	RequestKeyDict = dict()

	# Stored procedure
	InsertStoredProcedure = None


	def __init__(self, requestInit):
		super(RequestBase, self).__init__()
		self.logger		= logging.getLogger('RequestBase')
		self.requestObj = requestInit

	def __del__(self):
		super(RequestBase, self).__del__()

	#Run the scripts
	def run(self):
		super(RequestBase, self).run()
		symbolsToUpdate = self.getSymbolsToUpdate()
		for symbol in symbolsToUpdate:
			req = self.initRequest(symbol = symbol[0])
			#Get the data from the request and build args for the stored procedure
			# Build args for stored procedure using a map and run
			self.runStoredProcedure(req, symbol[0])


	# Initialise the request Object
	def initRequest(self, **kwargs):
		className = self.requestObj.__name__
		self.logger.info("Request \"%s\" (%s)", className, kwargs)
		req = self.requestObj(**kwargs)
		req.request()
		req.parse()
		return req


	# Function template for identifying symbols to update
	# returns a list
	def getSymbolsToUpdate(self):
		self.logger.info("Getting Symbols to update")
		symbolsForUpdateQ = self.database.get_query()
		#dataDict = dict()
		#self.logger.debug("Query Parameters %s", dataDict)
		query = self.FinancialsForUpdateSQL
		self.logger.info("Query: %s", query)
		symbolsForUpdateQ.execute(query)
		updateSymbols = symbolsForUpdateQ.fetchall()
		return updateSymbols


	# Build the arguments for the stored request
	def runStoredProcedure(self,requestObject, symbol):
		for reportType, paramMap in self.RequestKeyDict.items():
			self.logger.debug("Param: %s: (%s)", reportType, paramMap)
			# Build in the basics
			paramDict = collections.OrderedDict()
			paramDict['p_symbol'] = symbol
			paramDict['report_type'] = paramMap
			#TODO: Get details from the request
			#TODO: Run the stored procedure


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		self.logger.info("Make Request\"%s\" (%s-%s)", symbol, timeBegin, timeEnd)
