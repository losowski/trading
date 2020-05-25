#!/usr/bin/python3
'''
Add specific symbols to the database
'''
#import
import argparse
import collections
import logging

from python.database import db_connection

insertExchange = "trading_schema.pinsexchange"
insertSymbol = "trading_schema.pInsSymbol"


def addExchange (db, exchange):
	logger = logging.getLogger('addExchange')
	logger.info("Exchange: %s", exchange)
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['exchange']			= exchange
	data_list = list(data_parameters.values())
	#execute the stored procedure
	query.callproc(insertExchange)
	query.execute()
	update_symbols = query.fetchall()

def addSymbol (db, exchange, symbol, name):
	logger = logging.getLogger('addSymbol')
	logger.info("Exchange: %s", exchange)
	logger.info("Symbol: %s", symbol)
	logger.info("Name: %s", name)
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
	logging.basicConfig(format='%(asctime)s [%(levelname)s] %(message)s', level=logging.DEBUG)
	logger = logging.getLogger('main')
	blurb = "Symbol Adder"
	logger.warning(blurb)
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
	# Change DB
	if (None != args.symbol):
		addSymbol(db, args.exchange, args.symbol, args.name)
	else:
		addExchange(db, args.exchange)
	#Commit
	logger.info("Commiting transaction")
	db.commit()

# Assign a start point to the executable
if __name__ == "__main__":
	main()

