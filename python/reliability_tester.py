#!/usr/bin/python
'''
Test the reliability of the analysis predictions
'''
import logging
from analysis import reliabilty_application

def main():
	name = "Stock reliabilty reliability"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='reliability.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	reliabilty = reliabilty_application.reliabiltyApplication()
	reliabilty.initialise()
	reliabilty.run()
	reliabilty.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

