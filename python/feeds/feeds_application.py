#!/usr/bin/python
import datetime
import collections
import logging

from python.database import db_connection
from python.feeds import feeds_core_api
from python.feeds import feeds_queries
#from python.feeds.yahoo_finance import yahoo_statistics


class FeedsApplication:

	def __init__(self):
		self.feeds_object 	= feeds_core_api.FeedsCoreAPI()
		self.database		= db_connection.DBConnection()

	def __del__(self):
		self.feeds_object 	= None
		self.database		= None


	def initialise(self):
		self.feeds_object.initialise()
		self.database.connect()

	def run(self):
		self.update_quotes()
		#self.update_key_statistics() # Temporarily disabled

	def shutdown (self):
		pass

	def update_quotes(self):
		#get a list of symbols to update
			#Inquire how much data we have: None = get all, else get last date
			#Get the missing data
			#Begin a transation to insert the data
			#commit the data

		query = self.database.get_query()
		query.execute(feeds_queries.get_symbols_for_quote_update)
		update_symbols = query.fetchall()
		logging.info("Got %s symbols for update", len(update_symbols))
		#get a list of symbols to update
		for symbol, last_entry, update in update_symbols:
			logging.info("SYM: %s : %s UPDATE: %s",symbol, last_entry, update)

			#Inquire how much data we have: None = get all, else get last date
			if last_entry == None and update == None:
				logging.info("New Symbol: %s", symbol)
				date_interval = datetime.date.today() - datetime.timedelta(366*60) # Go back maximum number of years
				logging.info("Date Interval %s", date_interval)
				last_entry = datetime.datetime( date_interval.year, date_interval.month, date_interval.day )
				last_record = last_entry
				update = True
			else:
				last_record = last_entry + datetime.timedelta(1)

			#Perform the Update			
			if update is True:
				data_to_update = False
				#Get the missing data
				if (last_record.date() <  datetime.date.today()):
					logging.info("Historical: %s < %s", last_record.date(), datetime.date.today())
					symbol_quote = self.feeds_object.get_historical(symbol, last_record.isoformat(), datetime.date.today().isoformat())
					data_to_update = True
				else:
					#TODO: Find suitable call for current details (before historic)
					logging.info("Daily Quote")
					#symbol_quote = self.feeds_object.get_current_price(symbol)
					#logging.info("Daily Data: %s", symbol_quote))
					#data_to_update = True
					pass

				#Handle the update
				if data_to_update is True:
					update_query = self.database.get_query()
					logging.info("Updating %s: from %s to %s", symbol, last_record.isoformat(), datetime.date.today())
					#Begin a transation to insert the data
					for record_date, record_info in symbol_quote.iteritems():
						logging.info("DATE: %s : %s", record_date, record_info)
						data_parameters = collections.OrderedDict()
						data_parameters['symbol']			= symbol
						data_parameters['date']				= record_date
						data_parameters['open_price']		= record_info.get('Open')
						data_parameters['high_price']		= record_info.get('High')
						data_parameters['low_price']		= record_info.get('Low')
						data_parameters['close_price']		= record_info.get('Close')
						data_parameters['adj_close_price']	= record_info.get('Adj Close')
						data_parameters['volume']			= record_info.get('Volume')
						data_list = list(data_parameters.values())
						#execute the stored procedure
						update_query.callproc(feeds_queries.insert_quote_data, data_list)
						#commit the data
						self.database.commit()
					update_query.close()
		query.close()

	# Handle the key Statistics in the same way as the quotes
	def update_key_statistics(self):
		#Get a list of symbols to update, and query if we should update
		#Key statistics, we only care about this once a week, and not historically (of little value)
		#If we should update, get the information using a scraper 
		query = self.database.get_query()
		query.execute(feeds_queries.get_symbols_for_key_statistics_update)
		update_symbols = query.fetchall()
		logging.info("Got %s symbols for key statistics update",  len(update_symbols))
		#get a list of symbols to update, pre-filter appropriate to update
		for symbol, last_entry in update_symbols:
			logging.info("KEY STATS SYM: %s UPDATE: %s", symbol, last_entry)
			stats = yahoo_statistics.YahooStatistics(symbol)
			stats.initialise()
			stats.run()
			stats.register()
			#Handle the update
			update_query = self.database.get_query()
			data_parameters = collections.OrderedDict()
			data_parameters['symbol']			= symbol
			data_parameters['date']				= datetime.date.today().isoformat()
			data_parameters['enterprise_value'] = stats.enterprise_value
			data_parameters['price_earnings_ratio'] = stats.price_earnings_ratio
			data_parameters['price_earnings_growth'] = stats.price_earnings_growth
			data_parameters['price_sales_12m_trailing'] = stats.price_sales_12m_trailing
			data_parameters['price_book'] = stats.price_book
			data_parameters['enterprise_value_revenue'] = stats.enterprise_value_revenue
			data_parameters['enterprise_value_ebitda'] = stats.enterprise_value_ebitda
			data_parameters['last_fiscal_year'] = stats.last_fiscal_year
			data_parameters['most_recent_quater'] = stats.most_recent_quater
			data_parameters['profit_margin'] = stats.profit_margin
			data_parameters['operating_margin'] = stats.operating_margin
			data_parameters['return_on_assets'] = stats.return_on_assets
			data_parameters['return_on_equity'] = stats.return_on_equity
			data_parameters['total_revenue'] = stats.total_revenue
			data_parameters['revenue_per_share'] = stats.revenue_per_share
			data_parameters['quarterly_growth_revenue_yoy'] = stats.quarterly_growth_revenue_yoy
			data_parameters['gross_profit'] = stats.gross_profit
			data_parameters['earnings_before_itda'] = stats.earnings_before_itda
			data_parameters['net_income_avi_to_common'] = stats.net_income_avi_to_common
			data_parameters['diluted_eps'] = stats.diluted_eps
			data_parameters['earnings_quarterly_growth'] = stats.earnings_quarterly_growth
			data_parameters['total_cash'] = stats.total_cash
			data_parameters['total_cash_per_share'] = stats.total_cash_per_share
			data_parameters['total_debt'] = stats.total_debt
			data_parameters['debt_to_equity'] = stats.debt_to_equity
			data_parameters['current_debt_ratio'] = stats.current_debt_ratio
			data_parameters['book_value_per_share'] = stats.book_value_per_share
			data_parameters['operating_cash_flow'] = stats.operating_cash_flow
			data_parameters['free_cash_flow'] = stats.free_cash_flow
			data_parameters['shares_outstanding'] = stats.shares_outstanding
			data_parameters['float_shares'] = stats.float_shares
			data_parameters['held_investors_insiders'] = stats.held_investors_insiders
			data_parameters['held_percent_institutions'] = stats.held_percent_institutions
			data_parameters['shares_short'] = stats.shares_short
			data_parameters['short_ratio'] = stats.short_ratio
			data_parameters['short_percent_of_float'] = stats.short_percent_of_float
			data_parameters['shares_short_prior_month'] = stats.shares_short_prior_month
			data_parameters['dividend_date'] = stats.dividend_date
			data_parameters['ex_dividend_date'] = stats.ex_dividend_date
			data_parameters['last_split_factor'] = stats.last_split_factor
			data_parameters['last_split_date'] = stats.last_split_date
			data_list = list(data_parameters.values())
			#execute the stored procedure
			update_query.callproc(feeds_queries.insert_key_statistics_data, data_list)
			#commit the data
			self.database.commit()
			update_query.close()
		query.close()
