#!/usr/bin/python3
'''
Import the Fundamentals from Yahoo Finance
'''
#import
import logging
import argparse
import os
import sys

# Yahoo feed data
from python.fundamentals import yahoo

def main():
	blurb = "Fundamentals Importer"
	logging.basicConfig(format='%(asctime)s\t%(name)-16s\t%(funcName)-16s\t[%(levelname)-8s] %(message)s',level=logging.INFO)
	logger	=	logging.getLogger('main')
	logger.warning(blurb)
	#Parse the arguments
	parser = argparse.ArgumentParser(description= blurb)
	#Specify arguments
	parser.add_argument('--symbol', dest='symbol', type=str, help="Symbol to update")
	#Parse the arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)
	#Process
	feeds = yahoo.Yahoo()
	feeds.initialise()
	#TODO: Handle single symbol update
	#if args.symbol is not None:
	#	feeds.runSymbol(True, args.symbol)
	#else:
	#	feeds.run(True)
	feeds.run(True)
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

