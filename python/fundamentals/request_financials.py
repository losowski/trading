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
from ..yahoo_fundamentals.python.yfundamentals import fundamentals as yfun

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

	# Keys
	RequestKeyDict = {
		'Q':	{
					"p_datestamp"						:	("Quarterly.endDate", datetime.datetime.fromisoformat),
					"p_earnings_per_share"				:	("Quarterly.BasicEPS", float ),
					"p_total_revenue"					:	("Quarterly.incomeBeforeTax", float ),
					"p_cost_of_revenue"					:	("Quarterly.costOfRevenue", float ),
					"p_gross_profit"					:	("Quarterly.grossProfit", float ),
					"p_total_assets"					:	("Quarterly.totalAssets", float ),
					"p_total_liabilities"				:	("Quarterly.totalLiab", float ),
					"p_total_income_available_shares"	:	("Quarterly.netIncomeApplicableToCommonShares", float ),
					"p_common_stock"					:	("Quarterly.commonStock", float ),
					"p_retained_earnings"				:	("Quarterly.retainedEarnings", float ),
					"p_total_stockholder_equity"		:	("Quarterly.totalStockholderEquity", float ),
				}, # Q
		#'Y':	{
		#			"p_datestamp"						:	("", str ),
		#			"p_earnings_per_share"				:	("", str ),
		#			"p_total_revenue"					:	("", str ),
		#			"p_cost_of_revenue"					:	("", str ),
		#			"p_gross_profit"					:	("", str ),
		#			"p_total_assets"					:	("", str ),
		#			"p_total_liabilities"				:	("", str ),
		#			"p_total_income_available_shares"	:	("", str ),
		#			"p_common_stock"					:	("", str ),
		#			"p_retained_earnings"				:	("", str ),
		#			"p_total_stockholder_equity"		:	("", str ),
		#		}, # Y
	} # RequestKeyDict


    # Stored procedure
	InsertStoredProcedure = "trading_schema.pInsertEarningDataList"


	def __init__(self):
		super(RequestFinancials, self).__init__(yfun.Fundamentals)
		self.logger		= logging.getLogger('RequestFinancials')

	def __del__(self):
		super(RequestFinancials, self).__del__()

	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		super(RequestFinancials, self).makeRequest(symbol, timeBegin, timeEnd)
