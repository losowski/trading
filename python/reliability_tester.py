#!/usr/bin/python
'''
Test the reliability of the analysis predictions
'''
import logging
import argparse
from analysis import reliability_application

def main():
	name = "Stock Analysis Reliability Tester"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='reliability.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	parser = argparse.ArgumentParser(prog = 'Reliability', description=name)
	parser.add_argument('--list', '-l', action='store_true')
	parser.add_argument('--uuid', dest='uuid', metavar='UUID', nargs='+',  help='Unique identifier of stock to query')
	args = parser.parse_args()
	reliability = reliability_application.ReliabilityApplication()
	reliability.initialise()
	reliability.run()
	if args.list == True:
		reliability.get_uuid()
	elif args.uuid:
		for uuid in args.uuid:
			reliability.run_uuid(uuid);
	reliability.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

