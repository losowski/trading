#!/usr/bin/python
'''
Generate the predictions of what is expected to happen
'''
import logging
from strategy import strategy_application

def main():
	name = "Stock Strategy"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='strategy.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	strategy = strategy_application.StrategyApplication()
	strategy.initialise()
	strategy.run()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

