# Base class for ticker server

import logging
import sys
import traceback

from python.comms import server

# Request handler
from python.ticker import tickerRequest

#Messages
from python.proto import stockticker_pb2

class StockTickerServer (server.Server):
	def __init__(self, port, database):
		super(StockTickerServer, self).__init__(port)
		self.logger				=	logging.getLogger('StockTickerServer')
		# Service of data retrieval
		self.database			=	database


	def __del__(self):
		super(StockTickerServer, self).__del__()


	# Setup the various components of the service
	def initialise(self):
		super(StockTickerServer, self).initialise()


	# ReceiveHandler is the only code we need to write
	# Default functionality is all you need
	def receiveHandler(self, data):
		resp = stockticker_pb2.tickerRes()
		# Interprets the message
		msg = stockticker_pb2.tickerReq.FromString(data)
		self.logger.info("Msg: %s", msg)
		ahead	=	0
		behind	=	0
		endDate	=	""
		if(msg.HasField('ahead')):
			ahead = msg.ahead
		if(msg.HasField('behind')):
			behind = msg.behind
		if(msg.HasField('enddate')):
			endDate = msg.enddate
		try:
			# Get the data from the database
			tr = tickerRequest.TickerRequest(self.database, msg.symbol, msg.date, ahead, behind, endDate)
			# Initialise
			tr.initialise()
			# Run the query
			tr.load()
			# Return the data
			data = tr.getData()
			#Dataset might be empty (not a function)
			if (True != data.empty):
				# For loop entering into td
				for row in data.itertuples():
					# Build the response
					td = stockticker_pb2.tickerData()
					#Append the response
					td.high			=	row.high_price
					td.low			=	row.low_price
					td.open			=	row.open_price
					td.close		=	row.close_price
					td.adj_close	=	row.adjusted_close_price
					td.volume		=	row.volume
					resp.ticker.append(td)
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
