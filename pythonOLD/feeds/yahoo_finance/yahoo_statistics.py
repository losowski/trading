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
				#								#Scraped only from HTML								#								-	Market Cap (intraday)
				"enterprise_value"				:("enterpriseValue", "raw", "num"),					#enterprise_value				-	Enterprise Value
				#								#Scraped only from HTML								#								-	Trailing P/E
				"price_earnings_ratio"			:("forwardPE", "raw", "num"),						#price_earnings_ratio			-	Forward P/E
				"price_earnings_growth"			:("pegRatio", "raw", "num"),						#price_earnings_growth			-	PEG Ratio (5 yr expected)
				"price_sales_12m_trailing"		:("priceToSalesTrailing12Months", "raw", "num"),	#price_sales_12m_trailing		-	Price/Sales
				"price_book"					:("priceToBook", "raw", "num"),						#price_book						-	Price/Book
				"enterprise_value_revenue"		:("enterpriseToRevenue", "raw", "num"),				#enterprise_value_revenue		-	Enterprise Value/Revenue
				"enterprise_value_ebitda"		:("enterpriseToEbitda", "raw", "num"),				#enterprise_value_ebitda		-	Enterprise Value/EBITDA
				# Financial Highlights (defaultKeyStatistics)
				"last_fiscal_year"				:("lastFiscalYearEnd", "fmt", "num"),				#last_fiscal_year				-	Fiscal Year Ends
				"most_recent_quater"			:("mostRecentQuarter", "raw", "num"),				#most_recent_quater				-	Most Recent Quarter
				# Profitability (financialData)
				"profit_margin"					:("profitMargins", "raw", "num"),					#profit_margin					-	Profit Margin
				"operating_margin"				:("operatingMargins", "raw", "num"),				#operating_margin				-	Operating Margin (ttm)
				# Management Effectiveness (financialData)
				"return_on_assets"				:("returnOnAssets", "raw", "num"),					#return_on_assets				-	Return on Assets (ttm)
				"return_on_equity"				:("returnOnEquity", "raw", "num"),					#return_on_equity				-	Return on Equity (ttm)
				# Income Statement (financialData)
				"total_revenue"					:("totalRevenue", "raw", "num"),					#total_revenue					-	#evenue (ttm)
				"revenue_per_share"				:("revenuePerShare", "raw", "num"),					#revenue_per_share				-	Revenue Per Share (ttm)
				"quarterly_growth_revenue_yoy"	:("revenueGrowth", "raw", "num"),					#quarterly_growth_revenue_yoy	-	Quarterly Revenue Growth (yoy)
				"gross_profits"					:("grossProfits", "raw", "num"),					#gross_profit					-	Gross Profit (ttm)
				"earnings_before_itda"			:("ebitda", "raw", "num"),							#earnings_before_itda			-	EBITDA
				# Income Statement (defaultKeyStatistics)
				"net_income_avi_to_common"		:("netIncomeToCommon", "raw", "num"),				#net_income_avi_to_common		-	Net Income Avi to Common (ttm)
				"diluted_eps"					:("trailingEps", "raw", "num"),						#diluted_eps					-	Diluted EPS (ttm)
				"earnings_quarterly_growth"		:("earningsQuarterlyGrowth", "raw", "num"),			#earnings_quarterly_growth		-	Quarterly Earnings Growth (yoy)
				# Balance Sheet (financialData)
				"total_cash"					:("totalCash", "raw", "num"),						#total_cash						-	Total Cash (mrq)
				"total_cash_per_share"			:("totalCashPerShare", "raw", "num"),				#total_cash_per_share			-	Total Cash Per Share (mrq)
				"total_debt"					:("totalDebt", "raw", "num"),						#total_debt						-	Total Debt (mrq)
				"debt_to_equity"				:("debtToEquity", "raw", "num"),					#debt_to_equity					-	Total Debt/Equity (mrq)
				"current_debt_ratio"			:("currentRatio", "raw", "num"),					#current_debt_ratio				-	Current Ratio (mrq)
				# Balance Sheet (defaultKeyStatistics)
				"book_value_per_share"			:("bookValue", "raw", "num"),						#book_value_per_share			-	Book Value Per Share (mrq)
				# Cash Flow Statement  (financialData)
				"operating_cash_flow"			:("operatingCashflow", "raw", "num"),				#operating_cash_flow			-	Operating Cash Flow (ttm)
				"free_cash_flow"				:("freeCashflow", "raw", "num"),					#free_cash_flow					-	Levered Free Cash Flow (ttm)
				# Share Statistics (defaultKeyStatistics)
				#								#Scraped only from HTML								#								-	Avg Vol (3 month)
				#								#Scraped only from HTML								#								-	Avg Vol (10 day)
				"shares_outstanding"			:("sharesOutstanding", "raw", "num"),				#shares_outstanding				-	Shares Outstanding
				"float_shares"					:("floatShares", "raw", "num"),						#float_shares					-	Float
				"held_investors_insiders"		:("heldPercentInsiders", "raw", "num"),				#held_investors_insiders		-	% Held by Insiders
				"held_percent_institutions"		:("heldPercentInstitutions", "raw", "num"),			#held_percent_institutions		-	% Held by Institutions
				"shares_short"					:("sharesShort", "raw", "num"),						#shares_short					-	Shares Short
				"short_ratio"					:("shortRatio", "raw", "num"),						#short_ratio					-	Short Ratio
				"short_percent_of_float"		:("shortPercentOfFloat", "raw", "num"),				#short_percent_of_float			-	Short % of Float
				"shares_short_prior_month"		:("sharesShortPriorMonth", "raw", "num"),			#shares_short_prior_month		-	Shares Short (prior month)
				# Dividends & Splits (defaultKeyStatistics)
				#								#Scraped only from HTML								#								-	Forward Annual Dividend Rate
				#								#Scraped only from HTML								#								-	Forward Annual Dividend Yield
				#								#Scraped only from HTML								#								-	Trailing Annual Dividend Rate
				#								#Scraped only from HTML								#								-	Trailing Annual Dividend Yield
				#								#Scraped only from HTML								#								-	5 Year Average Dividend Yield
				#								#Scraped only from HTML								#								-	Payout Ratio
				"dividend_date"					:("dividendDate", "fmt", "date"),					#dividend_date					-	Dividend Date
				"ex_dividend_date"				:("exDividendDate", "fmt", "date"),					#ex_dividend_date				-	Ex-Dividend Date
				"last_split_factor"				:("lastSplitFactor", "raw", "num"),					#last_split_factor				-	Last Split Factor (new per old)
				"last_split_date"				:("lastSplitDate", "fmt", "date"),					#last_split_date				-	Last Split Date
			}


	#https://query1.finance.yahoo.com/v10/finance/quoteSummary/YHOO?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com
	def __init__(self, symbol):
		url = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/{0}?formatted=true&crumb=GfcEejc1sYm&lang=en-GB&region=GB&modules=defaultKeyStatistics%2CfinancialData%2CcalendarEvents&corsDomain=uk.finance.yahoo.com".format(symbol)
		json_mappings = {
			# Valuation Measures (defaultKeyStatistics)
			#Scraped only from HTML																			#Market Cap (intraday)
			"enterpriseValue"					:("enterprise_value", "raw", "num"),						#Enterprise Value
			#Scraped only from HTML																			#Trailing P/E
			"forwardPE"							:("price_earnings_ratio", "raw", "num"),					#Forward P/E
			"pegRatio"							:("price_earnings_growth", "raw", "num"),					#PEG Ratio (5 yr expected)
			"priceToSalesTrailing12Months"		:("price_sales_12m_trailing", "raw", "num"),				#Price/Sales
			"priceToBook"						:("price_book", "raw", "num"),								#Price/Book
			"enterpriseToRevenue"				:("enterprise_value_revenue", "raw", "num"),				#Enterprise Value/Revenue
			"enterpriseToEbitda"				:("enterprise_value_ebitda", "raw", "num"),					#Enterprise Value/EBITDA
			# Financial Highlights (defaultKeyStatistics)
			"lastFiscalYearEnd"					:("last_fiscal_year", "fmt", "date"),						#Fiscal Year Ends
			"mostRecentQuarter"					:("most_recent_quater", "fmt", "date"),						#Most Recent Quarter
			# Profitability (financialData)
			"profitMargins"						:("profit_margin", "raw", "num"),							#Profit Margin
			"operatingMargins"					:("operating_margin", "raw", "num"),						#Operating Margin (ttm)
			# Management Effectiveness (financialData)
			"returnOnAssets"					:("return_on_assets", "raw", "num"),						#Return on Assets (ttm)
			"returnOnEquity"					:("return_on_equity", "raw", "num"),						#Return on Equity (ttm)
			# Income Statement (financialData)
			"totalRevenue"						:("total_revenue", "raw", "num"),							#revenue (ttm)
			"revenuePerShare"					:("revenue_per_share", "raw", "num"),						#Revenue Per Share (ttm)
			"revenueGrowth"						:("quarterly_growth_revenue_yoy", "raw", "num"),			#Quarterly Revenue Growth (yoy)
			"grossProfits"						:("gross_profit", "raw", "num"),							#Gross Profit (ttm)
			"ebitda"							:("earnings_before_itda", "raw", "num"),					#EBITDA
			# Income Statement (defaultKeyStatistics)
			"netIncomeToCommon"					:("net_income_avi_to_common", "raw", "num"),				#Net Income Avi to Common (ttm)
			"trailingEps"						:("diluted_eps", "raw", "num"),								#Diluted EPS (ttm)
			"earningsQuarterlyGrowth"			:("earnings_quarterly_growth", "raw", "num"),				#Quarterly Earnings Growth (yoy)
			# Balance Sheet (financialData)
			"totalCash"							:("total_cash", "raw", "num"),								#Total Cash (mrq)
			"totalCashPerShare"					:("total_cash_per_share", "raw", "num"),					#Total Cash Per Share (mrq)
			"totalDebt"							:("total_debt", "raw", "num"),								#Total Debt (mrq)
			"debtToEquity"						:("debt_to_equity", "raw", "num"),							#Total Debt/Equity (mrq)
			"currentRatio"						:("current_debt_ratio", "raw", "num"),						#Current Ratio (mrq)
			# Balance Sheet (defaultKeyStatistics)
			"bookValue"							:("book_value_per_share", "raw", "num"),					#Book Value Per Share (mrq)
			# Cash Flow Statement  (financialData)
			"operatingCashflow"					:("operating_cash_flow", "raw", "num"),						#Operating Cash Flow (ttm)
			"freeCashflow"						:("free_cash_flow", "raw", "num"),							#Levered Free Cash Flow (ttm)
			# Share Statistics (defaultKeyStatistics)
			#Scraped only from HTML																			#Avg Vol (3 month)
			#Scraped only from HTML																			#Avg Vol (10 day)
			"sharesOutstanding"					:("shares_outstanding", "raw", "num"),						#Shares Outstanding
			"floatShares"						:("float_shares", "raw", "num"),							#Float
			"heldPercentInsiders"				:("held_investors_insiders", "raw", "num"),					#% Held by Insiders
			"heldPercentInstitutions"			:("held_percent_institutions", "raw", "num"),				#% Held by Institutions
			"sharesShort"						:("shares_short", "raw", "num"),							#Shares Short
			"shortRatio"						:("short_ratio", "raw", "num"),								#Short Ratio
			"shortPercentOfFloat"				:("short_percent_of_float", "raw", "num"),					#Short % of Float
			"sharesShortPriorMonth"				:("shares_short_prior_month", "raw", "num"),				#Shares Short (prior month)
			# Dividends & Splits (defaultKeyStatistics)
			#Scraped only from HTML																			#Forward Annual Dividend Rate
			#Scraped only from HTML																			#Forward Annual Dividend Yield
			#Scraped only from HTML																			#Trailing Annual Dividend Rate
			#Scraped only from HTML																			#Trailing Annual Dividend Yield
			#Scraped only from HTML																			#5 Year Average Dividend Yield
			#Scraped only from HTML																			#Payout Ratio
			"dividendDate"						:("dividend_date", "fmt", "date"),							#Dividend Date
			"exDividendDate"					:("ex_dividend_date", "fmt", "date"),						#ExDividend Date
			"lastSplitFactor"					:("last_split_factor", "raw", "num"),						#Last Split Factor (new per old)
			"lastSplitDate"						:("last_split_date", "fmt", "date"),						#Last Split Date
		}

		json_scraper.JSONScraper.__init__(self, url, json_mappings)
		#Set up the correct mapping
		

	def __del__(self):
		json_scraper.JSONScraper.__del__(self)

