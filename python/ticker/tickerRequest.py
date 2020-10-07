# Ticker request code

import logging

# Pandas driven code
import pandas as pd

class TickerRequest(object):
	BaseSQL	= """
		SELECT
			q.open_price,
			q.close_price,
			q.high_price,
			q.low_price,
			q.adjusted_close_price,
			q.volume
		FROM
			trading_schema.symbol s
		INNER JOIN trading_schema.quote q ON (q.symbol_id = s.id)
		WHERE
		{where}
		ORDER BY
			s.symbol,
			q.datestamp
		;
		"""
	#Adapt SQL for generic case
	SimpleSQL = BaseSQL.format(where = """
		s.symbol = '{symbol}'
	AND
		q.datestamp = '{datestamp}'
		""")


	def __init__(self, database, symbol, date):
		self.logger		=	logging.getLogger('TickerRequest')
		# Database
		self.database	=	database
		# Query parameters
		self.symbol		=	symbol
		self.date		=	date
		# Get pandas DataFrame
		self.dataset	=	None

	def __del__(self):
		self.database = None


	def initialise(self):
		# setup the query
		pass


	def load(self):
		# Log out data
		self.logger.info("Loading Symbol: %s @ %s", self.symbol, self.date)
		# Build using default query
		query	=	self.SimpleSQL.format(symbol = self.symbol, datestamp = self.date)
		#TODO: Build using other queries
		self.dataset = pd.read_sql_query(query, con=self.database.get_connection())
		self.logger.debug("Loaded dataset:\n%s", self.dataset)

		pass

	def getData(self):
		return self.dataset
