#/bin/sh
# Create the database file
cat create_table/exchange.sql > feeds.sql
cat create_table/symbols.sql >> feeds.sql
cat create_table/quotes.sql >> feeds.sql
cat create_table/key_statistics.sql >> feeds.sql
