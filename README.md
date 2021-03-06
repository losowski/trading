README
======

## Dependencies
+	postgresql database
+	Python:
		psycopg

## INSTALL
sudo apt-get install python-psycopg2 python3-psycopg2

sudo pip3 install yahoo-historical pyzmq

## Setup
1) cd database
2) ./create.sh
3) sudo su postgres
4) psql
	-- may need to cd back to directory --
5) \i create_tradedb.sql

# Import Symbols
cd scripts

./AMEX.sh

./NASDAQ.sh

./NYSE.sh

# Database login (Default)
psql -h localhost -U trading -d tradingdb

# Daily running
./stockQuote.py

# Categorisation script
./scripts/categorise.sh

# TEST
## Test Exchanges
./symbol.py --exchange=AMEX

./symbol.py --exchange=NASDAQ

./symbol.py --exchange=NYSE

./symbol.py --exchange=LSE


## Test Symbols
./symbol.py --exchange=NASDAQ --symbol=GOOG --name="Alphabet Inc Class C"

./symbol.py --exchange=NASDAQ --symbol=GOOGL --name="Alphabet Inc."


## Brief
+ Obtains the stock quotes for last years for all stocks by symbol


## Binaries
+ symbol.py
	- Import exchanges
	- Import companie names by symbol

+ stockQuote.py
	- Get the historical data for the stocks mentioned

# ServerAPI
	./stockTickerAPI.py
		- Opens a ZeroMQ port 9456
		- Responds to quote requests

	./queryStock.py
		- User client for communicating with stockTickerAPI.py
