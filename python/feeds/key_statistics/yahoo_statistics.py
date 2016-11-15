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
		self.register('enterprise_value', '//*[@id="yfncsumtab"]/tbody/tr[2]/td[1]/table[2]/tbody/tr/td/table/tbody/tr[2]/td[2]')
		self.register('price_earnings', '')
		self.register('price_earnings_growth', '')
		self.register('price_sales', '')
		self.register('price_book', '')
		self.register('enterprise_value_revenue', '')
		self.register('enterprise_value_ebitda', '')
		self.register('profit_margin', '')
		self.register('operating_margin', '')
		self.register('return_on_assets', '')
		self.register('return_on_equity', '')
		self.register('revenue', '')
		self.register('revenue_per_share', '')
		self.register('quarterly_revenue_growth', '')
		self.register('gross_profit', '')
		self.register('earnings_before_tax_ebitda', '')
		self.register('diluted_eps', '')
		self.register('total_cash', '')
		self.register('total_cash_per_share', '')
		self.register('total_debt', '')
		self.register('total_debt_vs_equity', '')
		self.register('current_ratio', '')
		self.register('book_value_per_share', '')
		self.register('operating_cash_flow', '')
		self.register('quarterly_earnings_growth', '')
