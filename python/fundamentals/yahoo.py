# Code to use the fundamentals library and perform the data import

import datetime
import time
import collections
import logging
import os
import sys
import traceback

import psycopg2

#Import Base
from python.fundamentals import import_base

#Database
from python.database import db_connection

# Financials
from python.fundamentals import request_financials

class Yahoo (import_base.ImportBase):
	def __init__(self):
		super(Yahoo, self).__init__()
		self.logger			=	logging.getLogger("Yahoo")
		self.financials		=	request_financials.RequestFinancials()


	def __del__(self):
		super(Yahoo, self).__del__()

	#Setup the Database
	def initialise(self):
		super(Yahoo, self).initialise()
		#Setup Financials
		self.financials.initialise()


	# Run the assigned task
	def run(self, ignore):
		super(Yahoo, self).run()
		self.financials.run()


	# Shutdown
	def shutdown(self):
		super(Yahoo,self).shutdown()
		self.financials.shutdown()
