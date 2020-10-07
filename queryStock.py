#!/usr/bin/python3
# Build a dataset from the specified data

import sys
import logging
import argparse
import time
import datetime
import signal

# Import the protocol buffer libraries
sys.path.append('python/proto')

#Message client
from python.comms import client

#Messages
from python.proto import stockticker_pb2


def buildRequest(symbol, ISODate, ahead=None, behind=None, enddate=None):
	tr = stockticker_pb2.tickerReq()
	# Symbol
	tr.symbol = symbol
	# Date
	dateObj = datetime.date.today()
	if (ISODate is not None):
		dateObj = datetime.date.fromisoformat(ISODate)
	tr.date = dateObj.isoformat()
	# Optional fields
	# tr.ahead = ??
	# tr.behind = ??
	# tr.enddate = ??
	logging.info("Sending: %s", tr)
	return tr.SerializeToString()

def handleResponse(response):
	msg = stockticker_pb2.tickerRes.FromString(response)
	logging.info("Symbol: %s", msg.symbol)
	logging.info("Date: %s", msg.date)
	for sy in msg.ticker:
		logging.info("Symbol: %s: H: %s; L: %s; O: %s; C: %s; AC: %s;", msg.symbol, sy.high, sy.low, sy.open, sy.close, sy.adj_close)
		


def main():
	blurb = "Get a Stock Quote using the ticker API"
	print (blurb)
	#Build a datetime object with Current time
	dt = datetime.datetime.now()
	#Make the logging file
	loggingfile = "/tmp/query_ticker_{timestamp}.log".format(timestamp = dt.now().isoformat())
	#Setup logging
	logging.basicConfig(format='%(asctime)s\t%(name)-16s\t%(funcName)-16s\t[%(levelname)-8s] %(message)s', level=logging.INFO)
	#Let everyone know where we logged tp
	print ("Logfile: {logfile}".format(logfile = loggingfile))
	logger = logging.getLogger('main')
	#Begin normal application
	logger.warning(blurb)
	# Parse the args
	parser = argparse.ArgumentParser(description = blurb)
	# Specifics for the arguments
	parser.add_argument('--symbol', dest='symbol', type=str, help='Symbol to get ticker for')
	parser.add_argument('--isodate', dest='isodate', type=str, help='Datestamp - YYYY-MM-DD')
	# Generate the parsed arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)
	# Initilise the client
	cl = client.Client('localhost', 9456)
	cl.initialise()
	#Build request
	data = buildRequest(args.symbol, args.isodate)
	# Process response
	cl.send(data)
	# Get response
	recv = cl.receive()
	handleResponse(recv)
	#Clean up everything else...
	#Signal handler needed here to wait before exiting
	#sigset = [signal.SIGINT, signal.SIGTERM]
	#signal.sigwait(sigset) #3.3 only
	#signal.pause()
	#Finally shutdown the server
	logging.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()
