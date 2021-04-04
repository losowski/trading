# Request handling for the financial data

import datetime
import time
import collections
import logging
import os
import sys
import traceback

import psycopg2

#Import Base
from python.fundamentals import request_base

#Database
from python.database import db_connection

# Fundamentals
#from python.yahoo_fundamentals.python.financials import financials
import python.yahoo_fundamentals.python.financials.financials as fin

class RequestFinancials(request_base.RequestBase):

	FinancialsForUpdateSQL = """
	SELECT
		s.symbol
	FROM
		trading_schema.exchange e
		INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND s.enabled = 'Y')
		LEFT JOIN trading_schema.earnings_data ed ON (s.id = ed.symbol_id AND ed.report_type='Q' AND (datestamp IS NULL OR datestamp <= localtimestamp - INTERVAL '89 DAY'))
	WHERE
		e.enabled = 'Y'
	ORDER BY
		s.symbol
	;
	"""

	def __init__(self):
		super(RequestFinancials, self).__init__(fin.financials.Financials)
		self.logger		= logging.getLogger('RequestFinancials')

	def __del__(self):
		super(RequestFinancials, self).__del__()

	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		super(RequestFinancials, self).makeRequest(symbol, timeBegin, timeEnd)
