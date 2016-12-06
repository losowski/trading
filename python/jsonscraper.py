#!/usr/bin/python
'''
WebScraper
'''
import logging
from web_tools import json_scraper

def main():
	name = "WebScraper"
	print (name)
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', filename='jsonscraper.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	scrape = json_scraper.JSONScraper("https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com")
	scrape.initialise()
	scrape.run()
	print scrape.fetch_json()
	scrape.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

