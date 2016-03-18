#!/usr/bin/python
'''
Generate the predictions of what is expected to happen
'''
import logging
from analysis import analysis_application

def main():
	name = "Stock Analysis and Predictions"
	print ("Stock Analysis and Predictions")
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='analysis.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	analysis = analysis_application.AnalysisApplication()
	analysis.initialise()
	analysis.run()
	analysis.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

