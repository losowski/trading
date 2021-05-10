# Base Class for the importer

import datetime
import time
import collections
import logging
import sys
import traceback

import psycopg2

#Database
from python.database import db_connection

class ImportBase:
	def __init__(self):
		self.database		=	db_connection.DBConnection()
		self.logger			=	logging.getLogger("ImportBase")
		pass

	def __del__(self):
		self.database		=	None
		pass

	#Setup the Database
	def initialise(self):
		self.database.connect()


	# Run the assigned task
	def run(self):
		pass

	# Shutdown
	def shutdown(self):
		self.logger.info("Shutting Down")
