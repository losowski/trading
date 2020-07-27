#!/bin/sh
#psql -d tradingdb -U trading -w
#Script to dump everything
#pg_dump Ft  -Utrading tradingdb > sql/tradingdb.tar
#Store Tables in separate files
pg_dump -v --host=localhost --data-only -Utrading tradingdb --table=trading_schema.exchange --format=plain > backup/exchange_data.sql
pg_dump -v --host=localhost --data-only -Utrading tradingdb --table=trading_schema.symbol --format=plain > backup/symbol_data.sql
pg_dump -v --host=localhost --data-only -Utrading tradingdb --table=trading_schema.quote --format=plain > backup/quote_data.sql
