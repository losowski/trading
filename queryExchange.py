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
from python.proto import stockdetails_pb2


def buildRequest(symbol, exchange=None, enabled=None, listsym=None):
	sr = stockdetails_pb2.detailsReq()
	# symbol
	if (symbol is not None):
		sr.symbol = symbol
	# exchange
	if (exchange is not None):
		sr.exchange = exchange
	# enabled
	if (enabled is not None):
		sr.enabled = enabled
	# listsym
	if (listsym is not None):
		sr.listsym = listsym
	logging.info("Sending: %s", sr)
	return sr.SerializeToString()

def showEntityData(entityData):
	name = ""
	if(entityData.HasField('name')):
		name = entityData.name
	logging.info("\"%s\"-%s(%s)", entityData.symbol, entityData.enabled, name)

def handleResponse(response):
	msg = stockdetails_pb2.detailsRes.FromString(response)
	if(msg.HasField('exchange')):
		showEntityData(msg.exchange)
	if(msg.HasField('stock')):
		# Exchange
		showEntityData(msg.stock.exchange)
		# Stock
		showEntityData(msg.stock.stock)
		# Details
		logging.info("%s -> %s", msg.stock.earliest, msg.stock.latest)



def main():
	blurb = "Get Stock details using the ticker API"
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
	parser.add_argument('--exchange', dest='exchange', type=str, help='Datestamp - YYYY-MM-DD')
	parser.add_argument('--enabled', dest='enabled', type=str, help='Filter on enabled state (Y/N)', default=False)
	parser.add_argument('--listsym', dest='listsym', type=str, help='Force list of symbols (Y/N)', default=False)
	# Generate the parsed arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)
	# Initilise the client
	cl = client.Client('localhost', 9456)
	cl.initialise()
	#Build request
	data = buildRequest(args.symbol, args.exchange, args.enabled, args.listsym)
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
