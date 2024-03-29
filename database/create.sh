#!/bin/sh
#
# Script to read back backups of the database
#
#Create a blank file
echo "" > create_tradedb.sql

#Setup the basics of the database
cat create/trading_user.sql >> create_tradedb.sql
cat create/trading_database.sql >> create_tradedb.sql
cat create/trading_grant.sql >> create_tradedb.sql

#Setup Database and schema
# Triple backslash to work with debian (ignores arguments)
echo "-- SCRIPT BEGIN: set up connection and schema" >> create_tradedb.sql
echo "\\\connect tradingdb" >> create_tradedb.sql
echo "--\n-- Create the schema\n--" >> create_tradedb.sql
echo "CREATE SCHEMA IF NOT EXISTS trading_schema AUTHORIZATION trading;\n" >> create_tradedb.sql
echo "set schema 'trading_schema';" >> create_tradedb.sql
echo "-- SCRIPT END" >> create_tradedb.sql

#Build schema
# Feeds
(
	cd feeds
	sh create.sh
)
cat feeds/feeds.sql >> create_tradedb.sql

# Trade tracking
(
	cd trader
	sh create.sh
)
cat feeds/trader.sql >> create_tradedb.sql
