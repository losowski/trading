README
======

## Dependencies
+	postgresql database
+	Python:
		psycopg

## INSTALL
sudo apt-get install python-psycopg2 python3-psycopg2
sudo pip3 install yahoo-historical

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

# Daily running
./stockquote.py

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

+ stockquote.py
	- Get the historical data for the stocks mentioned

