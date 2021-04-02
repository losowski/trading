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
import financials

class RequestFinancials(request_base.RequestBase):
	def __init__(self):
		super(RequestFinancials, self).__init__()
		self.logger		= logging.getLogger('RequestFinancials')

	def __del__(self):
		super(RequestFinancials, self).__del__()


	# Function template for identifying symbols to update
	def getSymbolsToUpdate(self):
		super(RequestFinancials, self).getSymbolsToUpdate()


	# Make request
	def makeRequest(self, symbol, timeBegin = None, timeEnd = None):
		super(RequestFinancials, self).makeRequest(symbol, timeBegin, timeEnd)
