#!/bin/sh
# Script to perform categorisation
psql -h localhost -U trading -d tradingdb -c "SELECT trading_schema.pCategoriseActiveSymbols();"
