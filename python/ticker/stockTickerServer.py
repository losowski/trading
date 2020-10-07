# Base class for ticker server

import logging
import sys
import traceback
import zmq

from python.comms import server

from python.database import db_connection

# Request handler
from python.ticker import tickerRequest

#Messages
from python.proto import stockticker_pb2

class StockTickerServer (server.Server):
	def __init__(self, port):
		super(StockTickerServer, self).__init__(port)
		self.logger				=	logging.getLogger('StockTickerServer')
		# Service of data retrieval
		self.database			=	db_connection.DBConnection()


	def __del__(self):
		super(StockTickerServer, self).__del__()


	# Setup the various components of the service
	def initialise(self):
		super(StockTickerServer, self).initialise()
		#Connect to the DB
		self.database.connect()


	# ReceiveHandler is the only code we need to write
	# Default functionality is all you need
	def receiveHandler(self, data):
		resp = stockticker_pb2.tickerRes()
		# Interprets the message
		msg = stockticker_pb2.tickerReq.FromString(data)
		try:
			# Get the data from the database
			tr = tickerRequest.TickerRequest(self.database, msg.symbol, msg.date)
			# Initialise
			tr.initialise()
			# Run the query
			tr.runQuery()
			# return the data
			data = tr.getData()
			# For loop entering into td
			#	# Build the response
			#	td = stockticker_pb2.tickerData()
			#	#Append the response
			#	td.high			=	data['high']
			#	td.low			=	data['low']
			#	td.open			=	data['open']
			#	td.close		=	data['close']
			#	td.adj_close	=	data['adj_close']
			#	resp.tickerData.append(td)
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
