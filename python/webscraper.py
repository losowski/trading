#!/usr/bin/python
'''
WebScraper
'''
import logging
from web_tools import scraper

def main():
	name = "WebScraper"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='scraper.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	scrape = scraper.WebScraper()
	scrape.initialise()
	scrape.run()
	scrape.register('enterprise_value', '//*[@id="yfncsumtab"]/tbody/tr[2]/td[1]/table[2]/tbody/tr/td/table/tbody/tr[2]/td[2]')
	logging.info ("Attribute: %s", scrape.enterprise_value)
	scrape.shutdown()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

