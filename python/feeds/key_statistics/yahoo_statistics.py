#!/usr/bin/python
import logging
from web_tools import json_scraper

#NOTE: If you are logged in, this will always hang and fail.
# LOGOUT to make this work properly
class YahooStatistics (json_scraper.JSONScraper):

	defaultKeyStatistics = {
				"enterprise_value"				:("enterpriseValue", "raw"),				#enterprise_value
				"price_earnings"				:("trailingEps", "raw"),					#price_earnings
				"price_earnings_growth"			:("pegRatio", "raw"),						#price_earnings_growth
				"priceToSalesTrailing12Months"	:("priceToSalesTrailing12Months", "raw"),	#price_sales
				"price_book"					:("priceToBook", "raw"),					#price_book
				"enterprise_value_revenue"		:("enterpriseToRevenue", "raw"),			#enterprise_value_revenue
				"enterprise_value_ebitda"		:("enterpriseToEbitda", "raw"),				#enterprise_value_ebitda
				#profit_margin
				#operating_margin
				#return_on_assets
				#return_on_equity
				#revenue
				#revenue_per_share
				#quarterly_revenue_growth
				#gross_profit
				#earnings_before_tax_ebitda
				#diluted_eps
				#total_cash
				#total_cash_per_share
				#total_debt
				#total_debt_vs_equity
				#current_ratio
				#book_value_per_share
				#operating_cash_flow
				#quarterly_earnings_growth
			}

	financialData = {
				#enterprise_value
				#price_earnings
				#price_earnings_growth
				#price_sales
				#price_book
				#enterprise_value_revenue
				#enterprise_value_ebitda
				"profit_margin"					:("profitMargins", "raw"),					#profit_margin
				"operatingMargins"				:("operatingMargins", "raw"),				#operating_margin
				"returnOnAssets"				:("returnOnAssets", "raw"),				#return_on_assets
				"returnOnEquity"				:("returnOnEquity", "raw"),				#return_on_equity
				"totalRevenue"					:("totalRevenue", "raw"),				#revenue
				"revenuePerShare"		:("revenuePerShare", "raw"),#revenue_per_share
				#quarterly_revenue_growth
				#"grossMargins"		:("grossMargins", "raw"),
				"gross_profit"		:("grossProfits", "raw"),#gross_profit
				"ebitda"		:("ebitda", "raw"),#earnings_before_tax_ebitda
				#diluted_eps
				"totalCash"		:("totalCash", "raw"),#total_cash
				"totalCashPerShare"		:("totalCashPerShare", "raw"),#total_cash_per_share
				"totalDebt"		:("totalDebt", "raw"),#total_debt
				"debtToEquity"		:("debtToEquity", "raw"),#total_debt_vs_equity
				"currentRatio"		:("currentRatio", "raw"),#current_ratio
				#book_value_per_share
				"operatingCashflow"		:("operatingCashflow", "raw"),#operating_cash_flow
				#quarterly_earnings_growth
		}

"!!FinancialData!!"		:("!!FinancialData!!", "raw"),


"maxAge"		:("maxAge", "raw"),
"targetLowPrice"		:("targetLowPrice", "raw"),
"currentPrice"		:("currentPrice", "raw"),
"numberOfAnalystOpinions"		:("numberOfAnalystOpinions", "raw"),
"freeCashflow"		:("freeCashflow", "raw"),
"ebitdaMargins"		:("ebitdaMargins", "raw"),
"targetMedianPrice"		:("targetMedianPrice", "raw"),
"targetHighPrice"		:("targetHighPrice", "raw"),
"recommendationKey"		:("recommendationKey", "raw"),
"targetMeanPrice"		:("targetMeanPrice", "raw"),
"recommendationMean"		:("recommendationMean", "raw"),
"earningsGrowth"		:("earningsGrowth", "raw"),
"revenueGrowth"		:("revenueGrowth", "raw"),
"quickRatio"		:("quickRatio", "raw"),
""		:("", "raw"),


		}
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
		business_stats = json_data["quoteSummary"]["result"][0]["defaultKeyStatistics"]
		logging.critical("quote_summary = %s", busine)
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
