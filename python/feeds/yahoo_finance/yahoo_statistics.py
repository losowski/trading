#!/usr/bin/python
import logging
from web_tools import json_scraper

#NOTE: If you are logged in, this will always hang and fail.
# LOGOUT to make this work properly
class YahooStatistics (json_scraper.JSONScraper):
	#Dividend data - web only
	#http://tools.morningstar.co.uk/uk/stockreport/default.aspx?tab=10&vw=div&SecurityToken=0P000000CU%5D3%5D0%5DE0WWE%24%24ALL&Id=0P000000CU&ClientFund=0&CurrencyId=GBP
	#NOTE:
	#	Dividend ratio is the sum of the quarterly dividends / (earnings per share) (diluted_eps)
	# Earnings per share (revenue_per_share) = total_revenue/shares_outstanding
	# diluted_eps = net_income_avi_to_common/shares_outstanding

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
				# Share Statistics (defaultKeyStatistics)
				#								#Scraped only from HTML						#								-	Avg Vol (3 month)
				#								#Scraped only from HTML						#								-	Avg Vol (10 day)
				"shares_outstanding"			:("sharesOutstanding", "raw"),				#shares_outstanding				-	Shares Outstanding
				"float_shares"					:("floatShares", "raw"),					#float_shares					-	Float
				"held_investors_insiders"		:("heldPercentInsiders", "raw"),			#held_investors_insiders		-	% Held by Insiders
				"held_percent_institutions"		:("heldPercentInstitutions", "raw"),		#held_percent_institutions		-	% Held by Institutions
				"shares_short"					:("sharesShort", "raw"),					#shares_short					-	Shares Short
				"short_ratio"					:("shortRatio", "raw"),						#short_ratio					-	Short Ratio
				"short_percent_of_float"		:("shortPercentOfFloat", "raw"),			#short_percent_of_float			-	Short % of Float
				"shares_short_prior_month"		:("sharesShortPriorMonth", "raw"),			#shares_short_prior_month		-	Shares Short (prior month)
				# Dividends & Splits (defaultKeyStatistics)
				#								#Scraped only from HTML						#								-	Forward Annual Dividend Rate
				#								#Scraped only from HTML						#								-	Forward Annual Dividend Yield
				#								#Scraped only from HTML						#								-	Trailing Annual Dividend Rate
				#								#Scraped only from HTML						#								-	Trailing Annual Dividend Yield
				#								#Scraped only from HTML						#								-	5 Year Average Dividend Yield
				#								#Scraped only from HTML						#								-	Payout Ratio
				"dividend_date"					:("dividendDate", "raw"),						#dividend_date					-	Dividend Date
				"ex_dividend_date"				:("exDividendDate", "raw"),						#ex_dividend_date				-	Ex-Dividend Date
				"last_split_factor"				:("lastSplitFactor", "raw"),					#last_split_factor				-	Last Split Factor (new per old)
				"last_split_date"				:("lastSplitDate", "raw"),						#last_split_date				-	Last Split Date
			}

	#JSON-KEY : (database_key, json_field)
	json_mappings = {
		# Valuation Measures (defaultKeyStatistics)
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Market Cap (intraday)
		"enterpriseValue" :("enterprise_value", "raw"),						#Enterprise Value
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Trailing P/E
		"forwardPE" :("price_earnings_ratio", "raw"),						#Forward P/E
		"pegRatio" :("price_earnings_growth", "raw"),						#PEG Ratio (5 yr expected)
		"priceToSalesTrailing12Months" :("price_sales", "raw"),						#Price/Sales
		"priceToBook" :("price_book", "raw"),						#Price/Book
		"enterpriseToRevenue" :("enterprise_value_revenue", "raw"),						#Enterprise Value/Revenue
		"enterpriseToEbitda" :("enterprise_value_ebitda", "raw"),						#Enterprise Value/EBITDA
		# Financial Highlights (defaultKeyStatistics)
		"lastFiscalYearEnd" :("last_fiscal_year", "raw"),						#Fiscal Year Ends
		"mostRecentQuarter" :("most_recent_quater", "raw"),						#Most Recent Quarter
		# Profitability (financialData)
		"profitMargins" :("profit_margin", "raw"),						#Profit Margin
		"operatingMargins" :("operating_margin", "raw"),						#Operating Margin (ttm)
		# Management Effectiveness (financialData)
		"returnOnAssets" :("return_on_assets", "raw"),						#Return on Assets (ttm)
		"returnOnEquity" :("return_on_equity", "raw"),						#Return on Equity (ttm)
		# Income Statement (financialData)
		"totalRevenue" :("total_revenue", "raw"),						#evenue (ttm)
		"revenuePerShare" :("revenue_per_share", "raw"),						#Revenue Per Share (ttm)
		"revenueGrowth" :("quarterly_growth_revenue_yoy", "raw"),						#Quarterly Revenue Growth (yoy)
		"grossProfits" :("gross_profit", "raw"),						#Gross Profit (ttm)
		"ebitda" :("earnings_before_itda", "raw"),						#EBITDA
		# Income Statement (defaultKeyStatistics)
		"netIncomeToCommon" :("net_income_avi_to_common", "raw"),						#Net Income Avi to Common (ttm)
		"trailingEps" :("diluted_eps", "raw"),						#Diluted EPS (ttm)
		"earningsQuarterlyGrowth" :("earnings_quarterly_growth", "raw"),						#Quarterly Earnings Growth (yoy)
		# Balance Sheet (financialData)
		"totalCash" :("total_cash", "raw"),						#Total Cash (mrq)
		"totalCashPerShare" :("total_cash_per_share", "raw"),						#Total Cash Per Share (mrq)
		"totalDebt" :("total_debt", "raw"),						#Total Debt (mrq)
		"debtToEquity" :("debt_to_equity", "raw"),						#Total Debt/Equity (mrq)
		"currentRatio" :("current_debt_ratio", "raw"),						#Current Ratio (mrq)
		# Balance Sheet (defaultKeyStatistics)
		"bookValue" :("book_value_per_share", "raw"),						#Book Value Per Share (mrq)
		# Cash Flow Statement  (financialData)
		"operatingCashflow" :("operating_cash_flow", "raw"),						#Operating Cash Flow (ttm)
		"freeCashflow" :("free_cash_flow", "raw"),						#Levered Free Cash Flow (ttm)
		# Share Statistics (defaultKeyStatistics)
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Avg Vol (3 month)
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Avg Vol (10 day)
		"sharesOutstanding" :("shares_outstanding", "raw"),						#Shares Outstanding
		"floatShares" :("float_shares", "raw"),						#Float
		"heldPercentInsiders" :("held_investors_insiders", "raw"),						#% Held by Insiders
		"heldPercentInstitutions" :("held_percent_institutions", "raw"),						#% Held by Institutions
		"sharesShort" :("shares_short", "raw"),						#Shares Short
		"shortRatio" :("short_ratio", "raw"),						#Short Ratio
		"shortPercentOfFloat" :("short_percent_of_float", "raw"),						#Short % of Float
		"sharesShortPriorMonth" :("shares_short_prior_month", "raw"),						#Shares Short (prior month)
		# Dividends & Splits (defaultKeyStatistics)
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Forward Annual Dividend Rate
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Forward Annual Dividend Yield
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Trailing Annual Dividend Rate
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Trailing Annual Dividend Yield
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#5 Year Average Dividend Yield
		#Scraped only from HTML" :(#Scraped only from HTML", "raw"),						#Payout Ratio
		"dividendDate" :("dividend_date", "raw"),						#Dividend Date
		"exDividendDate" :("ex_dividend_date", "raw"),						#ExDividend Date
		"lastSplitFactor" :("last_split_factor", "raw"),						#Last Split Factor (new per old)
		"lastSplitDate" :("last_split_date", "raw"),						#Last Split Date
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
