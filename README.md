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


# K8S and Ansible
The K8S stuff might be broken out into it's own repo later

## Ansible
### Current Setup
Currently in the xml directory there is a file called db_connection.xml, this file holds the connection data for the database, including the password. This is a major security issue, passwords should never be in the code base.

To solve this issue the current ansible has it's own version of db_connection.xml that contains place holders for an automatically generated password.

### Current Process - setup.yml
1. Generate a random password string and save to a reusable variable
1. Import db_connection.xml and replace 'PSQL_PASSWORD' with the generated password and store in variable 'xml'
1. import trading_user.sql and replace 'PSQL_PASSWORD' with the generated password and store in variable 'trading_user'.
1. Base64 encrypt the xml variable and append it to '1_db_connection.yml'
1. Run feeds.yml
1. Create and append the below files to 'create_tradedb.sql'
* trading_user
* trading_database.sql
* trading_grant.sql
* feeds.sql
* Schema creation and authorization sql.

### Current Process - feeds.yml
1. Create and append the following to feeds.sql
* create_table/exchange.sql
* create_table/symbols.sql
* create_table/quotes.sql
* create_table/key_statistics.sql

### 0_namespace.yml
* The trading namespace, needs to be run first
### 1_db_connection.yml
* the database connection secret
* contains the db_connection.xml file
### jobs/symbol.yml
* Runs a specified script in the scripts directory
* Script is currently hard coded but will end up being an environment variable
* Dockerfile: symbol_Dockerfile
* added files & directories
  * symbol.py
  * scripts/
  * python/database
  * xml/db_connection.db
### jobs/stockquote.yml
* sets up a cronjob to update all the symbols in the database
* curently set to run at midnight every day
* Dockerfile: stockQuote_Dockerfile
* added files & directories
  * stockQuote.py
  * python/database
### kube-registry.yaml
* For dev purposes only
* sets up the registry to be able to transfer images from localhost to minikube
### database.yaml
* For dev purposes only
* sets up a postgres database in minikube
* obviously this is not nearly suitable for production
* Only there until we get proper infra setup
### ubuntu.yaml
* For dev purposes only
* sets up an ubuntu pod running in minikube
* makes troubleshooting/hacking a little easier