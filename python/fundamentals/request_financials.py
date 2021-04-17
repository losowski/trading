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
from ..yahoo_fundamentals.yfundamentals import fundamentals as yfun

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
					"p_datestamp"						:	"Quarterly.endDate",
					"p_earnings_per_share"				:	"",
					"p_total_revenue"					:	"Quarterly.incomeBeforeTax",
					"p_cost_of_revenue"					:	"Quarterly.costOfRevenue",
					"p_gross_profit"					:	"Quarterly.grossProfit",
					"p_total_assets"					:	"Quarterly.totalAssets",
					"p_total_liabilities"				:	"Quarterly.totalLiab",
					"p_total_income_available_shares"	:	"Quarterly.netIncomeApplicableToCommonShares",
					"p_common_stock"					:	"Quarterly.commonStock",
					"p_retained_earnings"				:	"Quarterly.retainedEarnings",
					"p_total_stockholder_equity"		:	"Quarterly.totalStockholderEquity",
					"p_return_on_equity"				:	"",
				}, # Q
		#'Y':	{
		#			"p_datestamp"						:	"",
		#			"p_earnings_per_share"				:	"",
		#			"p_total_revenue"					:	"",
		#			"p_cost_of_revenue"					:	"",
		#			"p_gross_profit"					:	"",
		#			"p_total_assets"					:	"",
		#			"p_total_liabilities"				:	"",
		#			"p_total_income_available_shares"	:	"",
		#			"p_common_stock"					:	"",
		#			"p_retained_earnings"				:	"",
		#			"p_total_stockholder_equity"		:	"",
		#			"p_return_on_equity"				:	"",
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
