#/bin/sh
# Create the database file
cat create_table/transaction.sql > trader.sql
cat create_table/futures.sql > trader.sql
cat create_table/fxsymbols.sql > trader.sql
cat create_table/forex.sql > trader.sql
