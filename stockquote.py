#!/usr/bin/python3
'''
Import the Stock Data from Yahoo Finance
'''
#import
import logging
from python.feeds import stockHistoricalData

def main():
	print ("Quote Importer")
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s',level=logging.DEBUG)
	feeds = feeds_application.FeedsApplication()
	feeds.initialise()
	feeds.run()
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

