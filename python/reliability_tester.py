#!/usr/bin/python
'''
Test the reliability of the analysis predictions
'''
import logging
from analysis import reliability_application

def main():
	name = "Stock Analysis Reliability Tester"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='reliability.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	reliability = reliability_application.ReliabilityApplication()
	reliability.initialise()
	reliability.run()
	reliability.get_uuid()
	reliability.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

