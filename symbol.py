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
enableExchange = "trading_schema.pEnableExchange"
disableExchange = "trading_schema.pDisableExchange"
insertSymbol = "trading_schema.pInsSymbol"
enableSymbol = "trading_schema.pEnableSymbol"
disableSymbol = "trading_schema.pDisableSymbol"

NONE		=	None
ENABLE		=	'Y'
DISABLE		=	'N'

def getEnableState(enabled):
	logger = logging.getLogger('getEnableState')
	logger.debug("Enabled: %s", enabled)
	state = NONE
	if enabled in (ENABLE, DISABLE):
		state = enabled
	logger.debug("State: %s", state)
	return state


# -- Exchange
def addExchange (db, exchange):
	logger = logging.getLogger('addExchange')
	logger.debug("Exchange: %s", exchange)
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['exchange']			= exchange
	data_list = list(data_parameters.values())
	#execute the stored procedure
	query.callproc(insertExchange, data_list)
	update_symbols = query.fetchall()


def setExchangeEnabled(db, exchange, state):
	logger = logging.getLogger('setExchangeEnabled')
	logger.debug("Exchange: %s", exchange)
	logger.debug("State: %s", state)
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['exchange']			= exchange
	data_list = list(data_parameters.values())
	if (ENABLE == state):
		#execute the stored procedure - Enable
		query.callproc(enableExchange, data_list)
	elif (DISABLE == state):
		#execute the stored procedure - Disable
		query.callproc(disableExchange, data_list)
	update_symbols = query.fetchall()


# -- Symbol
def addSymbol (db, exchange, symbol, name):
	logger = logging.getLogger('addSymbol')
	logger.debug("Exchange: %s", exchange)
	logger.debug("Name: %s", name)
	logger.debug("Symbol: %s", symbol)
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['exchange']			= exchange
	data_parameters['name']				= name
	data_parameters['symbol']			= symbol
	data_list = list(data_parameters.values())
	#execute the stored procedure
	query.callproc(insertSymbol, data_list)
	update_symbols = query.fetchall()


def setSymbolEnabled(db, symbol, state):
	logger = logging.getLogger('setSymbolEnabled')
	logger.debug("Symbol: %s", symbol)
	logger.debug("State: %s", state)
	query = db.get_query()
	data_parameters = collections.OrderedDict()
	data_parameters['symbol']			= symbol
	data_list = list(data_parameters.values())
	if (ENABLE == state):
		#execute the stored procedure - Enable
		query.callproc(enableSymbol, data_list)
	elif (DISABLE == state):
		#execute the stored procedure - Disable
		query.callproc(disableSymbol, data_list)
	update_symbols = query.fetchall()

def main():
	logging.basicConfig(format='%(asctime)s\t%(name)-16s\t%(funcName)-16s\t[%(levelname)-8s] %(message)s', level=logging.INFO)
	logger = logging.getLogger('main')
	blurb = "Symbol Adder"
	logger.warning(blurb)
	## ARGPARSE
	parser = argparse.ArgumentParser(description = blurb)
	#Model building
	parser.add_argument('--exchange', dest='exchange', type=str, help='Exchange')
	parser.add_argument('--symbol', dest='symbol', type=str, help='Stock symbol')
	parser.add_argument('--name', dest='name', type=str, help='Human readable name')
	parser.add_argument('--enable', dest='enable', type=str, default='Y', help='Enable')
	#Get the arguments
	args = parser.parse_args()
	logger.info("Args: %s", args)


	#Connect to DB
	db = db_connection.DBConnection()
	db.connect()
	#Get change state
	state = getEnableState(args.enable)
	# Change DB
	if (None != args.symbol):
		if (None != state):
			setSymbolEnabled(db, args.symbol, state)
		else:
			addSymbol(db, args.exchange, args.symbol, args.name)
	else:
		if (None != state):
			setExchangeEnabled(db, args.exchange, state)
		else:
			addExchange(db, args.exchange)
	#Commit
	logger.info("Commiting transaction")
	db.commit()

# Assign a start point to the executable
if __name__ == "__main__":
	main()

