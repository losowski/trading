#!/usr/bin/python3
'''
Import the Stock Data from Yahoo Finance
'''
#import
import logging
from python.historical import yahoo

def main():
	print ("Quote Importer")
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s',level=logging.INFO)
	feeds = yahoo.Yahoo()
	feeds.initialise()
	feeds.run(True)
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

