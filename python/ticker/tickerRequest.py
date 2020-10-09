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
			s.symbol = '{symbol}'
		{where}
		ORDER BY
			s.symbol,
			q.datestamp
		;
		"""

	def __init__(self, database, symbol, date, ahead, behind, endDate):
		self.logger		=	logging.getLogger('TickerRequest')
		# Database
		self.database	=	database
		# Query parameters
		self.symbol		=	symbol
		self.date		=	date
		self.ahead		=	ahead
		self.behind		=	behind
		self.endDate	=	endDate
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
		# Build the "where" statement
		whereSQL = ""
		if (0 < self.ahead) and (0 < self.behind):
			self.logger.debug("Ahead:Behind (%s:%s)", self.ahead, self.behind)
			whereSQL = "AND q.datestamp >= date '{datestamp}' - INTERVAL '{behind} DAYS' AND q.datestamp <= date '{datestamp}' + INTERVAL '{ahead} DAYS' ".format(datestamp = self.date, behind = self.behind, ahead = self.ahead)
		elif (0 < self.ahead):
			self.logger.debug("Ahead: %s", self.ahead)
			whereSQL = "AND q.datestamp >= date '{datestamp}' AND q.datestamp <= date '{datestamp}' + INTERVAL '{ahead} DAYS' ".format(datestamp = self.date, ahead = self.ahead)
		elif (0 < self.behind):
			self.logger.debug("Behind: %s", self.ahead)
			whereSQL = "AND q.datestamp <= date '{datestamp}' AND q.datestamp >= date '{datestamp}' - INTERVAL '{behind} DAYS' ".format(datestamp = self.date, behind = self.behind)
		else:
			whereSQL = "AND q.datestamp = date '{datestamp}'".format(datestamp = self.date)
		# Build using default query
		query	=	self.BaseSQL.format(symbol = self.symbol, datestamp = self.date, where = whereSQL)
		self.logger.debug("Query: %s", query)
		#TODO: Build using other queries
		self.dataset = pd.read_sql_query(query, con=self.database.get_connection())
		self.logger.debug("Loaded dataset:\n%s", self.dataset)

		pass

	def getData(self):
		return self.dataset
