#!/usr/bin/python
import datetime
import collections

from database import db_connection
from feeds import feeds_core_api
from feeds import feeds_queries

class FeedsApplication:

	def __init__(self):
		self.feeds_object 	= feeds_core_api.FeedsCoreAPI()
		self.database		= db_connection.DBConnection()

	def __del__(self):
		pass

	def initialise(self):
		self.feeds_object.initialise()
		self.database.connect()

	def update(self):
		#get a list of symbols to update
			#Inquire how much data we have: None = get all, else get last date
			#Get the missing data
			#Begin a transation to insert the data
			#commit the data

		query = self.database.get_query()
		query.execute(feeds_queries.get_symbols_for_update)
		update_symbols = query.fetchall()
		print ("Got {0} symbols for update".format( len(update_symbols)))
		#get a list of symbols to update
		for symbol, last_entry, update in update_symbols:
			print ("SYM: {0} : {1} UPDATE: {2}".format(symbol, last_entry, update))

			#Inquire how much data we have: None = get all, else get last date
			if last_entry == None and update == None:
				print("New Symbol: {0}".format(symbol))
				date_interval = datetime.date.today() - datetime.timedelta(365*6)
				print("Date Interval {0}".format(date_interval))
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
					print ("Historical: {0} < {1}".format(last_record.date(), datetime.date.today()))
					symbol_quote = self.feeds_object.get_historical(symbol, last_record.isoformat(), datetime.date.today().isoformat())
					data_to_update = True
				else:
					#TODO: Find suitable call for current details (before historic)
					print("Daily Quote")
					#symbol_quote = self.feeds_object.get_current_price(symbol)
					#print("Daily Data: {0}".format(symbol_quote))
					#data_to_update = True
					pass

				#Handle the update
				if data_to_update is True:
					update_query = self.database.get_query()
					print ("Updating {0}: from {1} to {2}".format(symbol, last_record.isoformat(), datetime.date.today()))
					#Begin a transation to insert the data
					for record_date, record_info in symbol_quote.iteritems():
						print ("DATE: {0} : {1}".format(record_date, record_info))
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
						update_query.callproc(feeds_queries.insert_symbol_data, data_list)
						#commit the data
						self.database.commit()
					update_query.close()
		query.close()
