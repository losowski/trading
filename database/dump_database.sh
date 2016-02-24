#!/bin/sh
#psql -d tradingdb -U trading -w
#Script to dump everything
#pg_dump Ft  -Utrading tradingdb > sql/tradingdb.tar
#Script to make entire DBi schema, create etc
pg_dump -svc --host=localhost -Utrading tradingdb > sql/tradingdb.sql
#Script to store data only
pg_dump -va --host=localhost -Utrading tradingdb > sql/tradingdb_data.sql
