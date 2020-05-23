#!/usr/bin/python3
'''
Import the Stock Data from Yahoo Finance
'''
#import
import logging
from python.feeds import feeds_application

def main():
	print ("Quote Importer")
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', filename='quote.log',level=logging.DEBUG)
	feeds = feeds_application.FeedsApplication()
	feeds.initialise()
	feeds.run()
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()
