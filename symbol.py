#!/usr/bin/python3
'''
Import the Stock Data from Yahoo Finance
'''
#import
import logging
import argparse
from python.feeds import database
from python.database import db_connection

insertSymbol = "trading_schema.pInsSymbol"

def addSymbol (db, exchange, symbol, name):
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['exchange']			= exchange
	data_parameters['symbol']			= symbol
	data_parameters['name']				= name
	data_list = list(data_parameters.values())
	#execute the stored procedure
	query.callproc(insertSymbol)
	query.execute()
	update_symbols = query.fetchall()

def main():
	## ARGPARSE
	parser = argparse.ArgumentParser(description = blurb)
	#Model building
	parser.add_argument('--exchange', dest='exchange', type=str, help='Exchange')
	parser.add_argument('--symbol', dest='symbol', type=str, help='Stock symbol')
	parser.add_argument('--name', dest='name', type=str, help='Human readable name')
	#Get the arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)

	#Connect to DB
	db = db_connection.DBConnection()
	db.connect()
	#Perform Query
	query = db.get_query()
	query.execute(feeds_queries.get_symbols_for_quote_update)
	update_symbols = query.fetchall()

	print ("Quote Importer")
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', filename='quote.log',level=logging.DEBUG)
	feeds = feeds_application.FeedsApplication()
	feeds.initialise()
	feeds.run()
	feeds.shutdown()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

