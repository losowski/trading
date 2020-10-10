# Base class for details server

import logging
import sys
import traceback

from python.comms import server

# Request handler
from python.details import stockDetailRequest

#Messages
from python.proto import stockdetails_pb2

class StockDetailsServer (server.Server):
	def __init__(self, port, database):
		super(StockDetailsServer, self).__init__(port)
		self.logger				=	logging.getLogger('StockDetailsServer')
		# Service of data retrieval
		self.database			=	database


	def __del__(self):
		super(StockDetailsServer, self).__del__()


	# Setup the various components of the service
	def initialise(self):
		super(StockDetailsServer, self).initialise()


	# ReceiveHandler is the only code we need to write
	# Default functionality is all you need
	def receiveHandler(self, data):
		resp = stockdetails_pb2.detailsRes()
		# Interprets the message
		msg = stockdetails_pb2.detailsReq.FromString(data)
		self.logger.info("Msg: %s", msg)
		symbol		=	""
		exchange	=	""
		enabled		=	""
		if(msg.HasField('symbol')):
			symbol = msg.symbol
		if(msg.HasField('exchange')):
			exchange = msg.exchange
		if(msg.HasField('enabled')):
			enabled = msg.enabled
		try:
			# Initialise
			tr.initialise()
			if (symbol is not None):
				logging.info("Symbol query")
				# Get the data from the database
				tr = stockDetailRequest.StockDetailRequest(self.database, symbol, exchange, enabled)
				# Run the query
				tr.load()
				# Return the data
				data = tr.getData()
				#Dataset might be empty (not a function)
				if (True != data.empty):
					for row in data.itertuples():
						# Build the response message
						sd = stock_details_pb2.symbolData()
						# Build the response message
						# Exchange
						ex = stock_details_pb2.entityData()
						ex.symbol	=	row.exchange_name # Weirdly named column in DB
						ex.enabled	=	row.exchange_enabled
						sd.exchange = ex
						# Stock
						sym = stock_details_pb2.entityData()
						sym.symbol	=	row.stock_symbol
						sym.name	=	row.stock_name
						sym.enabled	=	row.stock_enabled
						sd.stock = sym
						resp.stock.append(sd)
			else if (exchange is not None):
				logging.info("Exchange query")
				# Run the query
				tr.load()
				# Return the data
				data = tr.getData()
			else:
				logging.info("Random query")
				# Run the query
				tr.load()
				# Return the data
				data = tr.getData()
			## Additional code
			#Dataset might be empty (not a function)
			if (True != data.empty):
				#TODO: Build the output properly
				# For loop entering into td
				#for row in data.itertuples():
				#	# Build the response
				#	td = stockdetails_pb2.detailsData()
				#	#Append the response
				#	td.high			=	row.high_price
				#	td.low			=	row.low_price
				#	td.open			=	row.open_price
				#	td.close		=	row.close_price
				#	td.adj_close	=	row.adjusted_close_price
				#	td.volume		=	row.volume
				#	resp.stock.append(td)
				pass
		except:
			self.logger.critical("Unexpected error: %s", sys.exc_info()[0])
			self.logger.critical("Traceback: %s", traceback.format_exc())
		# Build the response
		resp.symbol	=	msg.symbol
		resp.date	=	msg.date
		# Check the response
		self.logger.info("Response: %s", resp)
		# Encode the response
		return resp.SerializeToString()
