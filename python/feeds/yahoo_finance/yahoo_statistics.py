#!/usr/bin/python
import logging
from web_tools import json_scraper

#NOTE: If you are logged in, this will always hang and fail.
# LOGOUT to make this work properly
class YahooStatistics (json_scraper.JSONScraper):


	ValuationMeasures = {
				# Valuation Measures (defaultKeyStatistics)
				#								#Scraped only from HTML						#								-	Market Cap (intraday)
				"enterprise_value"				:("enterpriseValue", "raw"),				#enterprise_value				-	Enterprise Value
				#								#Scraped only from HTML						#								-	Trailing P/E
				"price_earnings_ratio"			:("forwardPE", "raw"),						#price_earnings_ratio			-	Forward P/E
				"price_earnings_growth"			:("pegRatio", "raw"),						#price_earnings_growth			-	PEG Ratio (5 yr expected)
				"price_sales"					:("priceToSalesTrailing12Months", "raw"),	#price_sales					-	Price/Sales
				"price_book"					:("priceToBook", "raw"),					#price_book						-	Price/Book
				"enterprise_value_revenue"		:("enterpriseToRevenue", "raw"),			#enterprise_value_revenue		-	Enterprise Value/Revenue
				"enterprise_value_ebitda"		:("enterpriseToEbitda", "raw"),				#enterprise_value_ebitda		-	Enterprise Value/EBITDA
				# Financial Highlights (defaultKeyStatistics)
				"last_fiscal_year"				:("lastFiscalYearEnd", "raw"),				#last_fiscal_year				-	Fiscal Year Ends
				"most_recent_quater"			:("mostRecentQuarter", "raw"),				#most_recent_quater				-	Most Recent Quarter
				# Profitability (financialData)
				"profit_margin"					:("profitMargins", "raw"),					#profit_margin					-	Profit Margin
				"operating_margin"				:("operatingMargins", "raw"),				#operating_margin				-	Operating Margin (ttm)
				# Management Effectiveness (financialData)
				"return_on_assets"				:("returnOnAssets", "raw"),					#return_on_assets				-	Return on Assets (ttm)
				"return_on_equity"				:("returnOnEquity", "raw"),					#return_on_equity				-	Return on Equity (ttm)
				# Income Statement (financialData)
				"total_revenue"					:("totalRevenue", "raw"),					#total_revenue					-	#evenue (ttm)
				"revenue_per_share"				:("revenuePerShare", "raw"),				#revenue_per_share				-	Revenue Per Share (ttm)
				"quarterly_growth_revenue_yoy"	:("revenueGrowth", "raw"),					#quarterly_growth_revenue_yoy	-	Quarterly Revenue Growth (yoy)
				"gross_profits"					:("grossProfits", "raw"),					#gross_profit					-	Gross Profit (ttm)
				"earnings_before_itda"			:("ebitda", "raw"),							#earnings_before_itda			-	EBITDA
				# Income Statement (defaultKeyStatistics)
				"net_income_avi_to_common"		:("netIncomeToCommon", "raw"),				#net_income_avi_to_common		-	Net Income Avi to Common (ttm)
				"diluted_eps"					:("trailingEps", "raw"),					#diluted_eps					-	Diluted EPS (ttm)
				"earnings_quarterly_growth"		:("earningsQuarterlyGrowth", "raw"),		#earnings_quarterly_growth		-	Quarterly Earnings Growth (yoy)
				# Balance Sheet (financialData)
				"total_cash"					:("totalCash", "raw"),						#total_cash						-	Total Cash (mrq)
				"total_cash_per_share"			:("totalCashPerShare", "raw"),				#total_cash_per_share			-	Total Cash Per Share (mrq)
				"total_debt"					:("totalDebt", "raw"),						#total_debt						-	Total Debt (mrq)
				"debt_to_equity"				:("debtToEquity", "raw"),					#debt_to_equity					-	Total Debt/Equity (mrq)
				"current_debt_ratio"			:("currentRatio", "raw"),					#current_debt_ratio				-	Current Ratio (mrq)
				# Balance Sheet (defaultKeyStatistics)
				"book_value_per_share"			:("bookValue", "raw"),						#book_value_per_share			-	Book Value Per Share (mrq)
				# Cash Flow Statement  (financialData)
				"operating_cash_flow"			:("operatingCashflow", "raw"),				#operating_cash_flow			-	Operating Cash Flow (ttm)
				"free_cash_flow"				:("freeCashflow", "raw"),					#free_cash_flow					-	Levered Free Cash Flow (ttm)
	}

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
