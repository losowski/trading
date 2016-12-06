#!/usr/bin/python
'''
WebScraper
'''
import logging
from web_tools import html_scraper

def main():
	name = "WebScraper"
	print (name)
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', filename='scraper.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	scrape = html_scraper.WebScraper("https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com")
	scrape.initialise()
	scrape.run()
	scrape.register_xpath('enterprise_value', '//*[@id="yfncsumtab"]/tbody/tr[2]/td[1]/table[2]/tbody/tr/td/table/tbody/tr[2]/td[2]')
	logging.info ("Attribute: %s", scrape.enterprise_value)
	scrape.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

