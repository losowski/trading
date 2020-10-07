#!/usr/bin/python3
# Build a dataset from the specified data

import sys
import logging
import argparse
import time
import datetime
import signal

#import tensorflow as tf
#import tensorflow_datasets as tfds

# Import the protocol buffer libraries
sys.path.append('python/proto')

#Message client
from python.prediction import stockPredictServer

#Messages
from python.proto import prediction_pb2


def main():
	blurb = "Generate Predictions via API"
	print (blurb)
	#Build a datetime object with Current time
	dt = datetime.datetime.now()
	#Make the logging file
	loggingfile = "/tmp/train_model_{timestamp}.log".format(timestamp = dt.now().isoformat())
	#Setup logging
	logging.basicConfig(format='%(asctime)s\t%(name)-16s\t%(funcName)-16s\t[%(levelname)-8s] %(message)s', level=logging.DEBUG)
	#Let everyone know where we logged tp
	print ("Logfile: {logfile}".format(logfile = loggingfile))
	logger = logging.getLogger('main')
	#Begin normal application
	logger.warning(blurb)
	#Begin Coding for the pandas processing of data
	logger.info("Creating Pandas CSV")
	# Parse the args
	parser = argparse.ArgumentParser(description = blurb)
	#Specifics for the arguments
	# Generate the parsed arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)
	# Server
	ps = stockPredictServer.StockPredictServer(9321)
	ps.initialise()
	ps.start()
	#Clean up everything else...
	#Signal handler needed here to wait before exiting
	sigset = [signal.SIGINT, signal.SIGTERM]
	signal.sigwait(sigset) #3.3 only
	signal.pause()
	#Finally shutdown the server
	ps.shutdown()
	logging.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()
