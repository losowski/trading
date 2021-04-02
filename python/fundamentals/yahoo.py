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

# Import the yahoo_fundamentals library
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals', 'python'))
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals'))
sys.path.append(os.path.join(sys.path[0], 'python', 'yahoo_fundamentals', 'python','common'))
print ("PYTHON_PATH: {0}".format(sys.path))

# Fundamentals
#from python.financials import financials
#from python.yahoo_fundamentals.python.financials import financials
#from python.yahoo_fundamentals.python.statistics import statistics



class Yahoo (import_base.ImportBase):
	def __init__(self):
		super(Yahoo, self).__init__()
		self.logger			=	logging.getLogger("Yahoo")


	def __del__(self):
		super(Yahoo, self).__del__()

	#Setup the Database
	def initialise(self):
		super(Yahoo, self).initialise()


	# Run the assigned task
	def run(self, ignore):
		super(Yahoo, self).run()


	# Shutdown
	def shutdown(self):
		super(Yahoo,self).shutdown()
