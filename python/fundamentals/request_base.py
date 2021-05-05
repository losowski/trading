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
		self.logger.info("Constructing: Request \"%s\" (%s)", className, kwargs)
		req = self.requestObj(**kwargs)
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
		query = self.database.get_query()
		for reportType, paramMap in self.RequestKeyDict.items():
			self.logger.debug("Param: %s: (%s)", reportType, paramMap)
			# Build in the basics
			data_parameters = collections.OrderedDict()
			data_parameters['p_symbol'] = symbol
			data_parameters['p_length'] = 4 # Magic number
			data_parameters['p_report_type'] = reportType
			# Fill in the data using the key map to populate it
			for params, details in paramMap.items():
				self.logger.info("Param: %s : %s",params, details)
				# Get and format the data
				data = requestObject[ details[0] ]
				self.logger.debug("data: %s", data)
				fmt = details[1]
				# format the data
				fdata = self.__applyFormatting(data, fmt)
				self.logger.info("Formatted Data: %s", fdata)
				# Build the data parameters
				data_parameters[params] = fdata
			self.logger.info("%s Params: %s", self.InsertStoredProcedure, data_parameters)
			#TODO: Run the stored procedure
			data_list = list(data_parameters.values())
			query.callproc(self.InsertStoredProcedure, data_list)

	# Apply formatting
	def __applyFormatting(self, data, formatting):
		retVal = None
		if type(data) is str:
			retVal = formatting(data)
		if type(data) is list:
			retVal = list()
			for d in data:
				fd = formatting(d)
				retVal.append(fd)
		return retVal


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		self.logger.info("Make Request\"%s\" (%s-%s)", symbol, timeBegin, timeEnd)
