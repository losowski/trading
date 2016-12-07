#!/usr/bin/python
import logging
from web_tools import json_scraper

#NOTE: If you are logged in, this will always hang and fail.
# LOGOUT to make this work properly
class YahooStatistics (json_scraper.JSONScraper):
	def __init__(self, symbol):
		url = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com".format(symbol)
		json_scraper.JSONScraper.__init__(self, url)
		pass

	def __del__(self):
		json_scraper.JSONScraper.__del__(self)

#https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com

	def register(self):
		json_data = self.fetch_json()
		logging.info("data: %s", json_data)
		result = json_data["quoteSummary"]["result"]
		logging.critical("quote_summary = %s", result)
		self.register_xpath('enterprise_value', result)
		#self.register_xpath('enterprise_value', '////*[@id="FIN-MainCanvas"]/div[3]/div/*[@id="main-0-Quote-Proxy"]/section/div[2]/section/div/section/div[2]/div[1]/div[1]/div/table/tbody/tr[2]/td[2]')
		#self.register_xpath('price_earnings', '//*[@id="quote-header-info"]/div[2]/div[1]/div/span[1]')
		#self.register_xpath('price_earnings_growth', '')
		#self.register_xpath('price_sales', '')
		#self.register_xpath('price_book', '')
		#self.register_xpath('enterprise_value_revenue', '')
		#self.register_xpath('enterprise_value_ebitda', '')
		#self.register_xpath('profit_margin', '')
		#self.register_xpath('operating_margin', '')
		#self.register_xpath('return_on_assets', '')
		#self.register_xpath('return_on_equity', '')
		#self.register_xpath('revenue', '')
		#self.register_xpath('revenue_per_share', '')
		#self.register_xpath('quarterly_revenue_growth', '')
		#self.register_xpath('gross_profit', '')
		#self.register_xpath('earnings_before_tax_ebitda', '')
		#self.register_xpath('diluted_eps', '')
		#self.register_xpath('total_cash', '')
		#self.register_xpath('total_cash_per_share', '')
		#self.register_xpath('total_debt', '')
		#self.register_xpath('total_debt_vs_equity', '')
		#self.register_xpath('current_ratio', '')
		#self.register_xpath('book_value_per_share', '')
		#self.register_xpath('operating_cash_flow', '')
		#self.register_xpath('quarterly_earnings_growth', '')

	def register(self):
		pass
