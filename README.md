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

# Database login (Default)
psql -h localhost -U trading -d tradingdb

# Restoring old data (after setup and login)
\i exchange_data.sql
\i symbol_data.sql
\i quote_data.sql

# Fix sequences
select max(id) from trading_schema.exchange;
select max(id) from trading_schema.symbol;
select max(id) from trading_schema.quote;

ALTER SEQUENCE IF EXISTS trading_schema.exchange_id_seq RESTART WITH 5;
ALTER SEQUENCE IF EXISTS trading_schema.symbol_id_seq RESTART WITH 3639;
ALTER SEQUENCE IF EXISTS trading_schema.quote_id_seq RESTART WITH 10773164;


# Import Symbols
cd scripts

./AMEX.sh

./NASDAQ.sh

./NYSE.sh


# Daily running
./stockQuote.py
./fundamentals.py


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



	
