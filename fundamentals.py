#!/usr/bin/python3
'''
Import the Fundamentals from Yahoo Finance
'''
#import
import logging
import argparse
import os
import sys

# Import the yahoo_fundamentals library
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals', 'python'))
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals', 'python','financials'))
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals', 'python','common'))

# Output the current paths
print ("PYTHON_PATH: {0}".format(sys.path))

# Yahoo feed data
from python.fundamentals import yahoo

def main():
	blurb = "Fundamentals Importer"
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s',level=logging.INFO)
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
	if args.symbol is not None:
		feeds.runSymbol(True, args.symbol)
	else:
		feeds.run(True)
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

