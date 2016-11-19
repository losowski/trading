#!/usr/bin/python
import logging
import urllib

from web_tools import scraper


class YahooStatistics (scraper.WebScraper):
	def __init__(self, symbol):
		params = urllib.urlencode({'s': symbol})
		url = "https://uk.finance.yahoo.com/q/ks?%s" % params
		scraper.WebScraper.__init__(self, url)
		pass

	def __del__(self):
		scraper.WebScraper.__del__(self)

	def register(self):
		self.register_xpath('enterprise_value', '//*[@id="yfncsumtab"]/tbody/tr[2]/td[1]/table[2]/tbody/tr/td/table/tbody/tr[2]/td[2]')
		self.register_xpath('price_earnings', '')
		self.register_xpath('price_earnings_growth', '')
		self.register_xpath('price_sales', '')
		self.register_xpath('price_book', '')
		self.register_xpath('enterprise_value_revenue', '')
		self.register_xpath('enterprise_value_ebitda', '')
		self.register_xpath('profit_margin', '')
		self.register_xpath('operating_margin', '')
		self.register_xpath('return_on_assets', '')
		self.register_xpath('return_on_equity', '')
		self.register_xpath('revenue', '')
		self.register_xpath('revenue_per_share', '')
		self.register_xpath('quarterly_revenue_growth', '')
		self.register_xpath('gross_profit', '')
		self.register_xpath('earnings_before_tax_ebitda', '')
		self.register_xpath('diluted_eps', '')
		self.register_xpath('total_cash', '')
		self.register_xpath('total_cash_per_share', '')
		self.register_xpath('total_debt', '')
		self.register_xpath('total_debt_vs_equity', '')
		self.register_xpath('current_ratio', '')
		self.register_xpath('book_value_per_share', '')
		self.register_xpath('operating_cash_flow', '')
		self.register_xpath('quarterly_earnings_growth', '')
