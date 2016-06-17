#!/usr/bin/python
import datetime
import collections
import logging
import uuid

from database import db_connection
from database import db_cursor
import reliability_queries


class ReliabilityApplication(db_cursor.DBCursor):
	def __init__(self):
		db_cursor.DBCursor.__init__(self)

	def __del__(self):
		db_cursor.DBCursor.__del__(self)

	def initialise(self):
		db_cursor.DBCursor.initialise(self)

	def shutdown(self):
		db_cursor.DBCursor.shutdown(self)

	def run(self):
		pass

	def get_uuid(self):
		self.get_db().execute(reliability_queries.reliability_get_uuid)
		uuid_list = self.get_db().fetchall()
		for ref, date in uuid_list:
			print ("UUID: {0} - {1}".format(ref, date))

	def run_uuid(self, uuid):
		logging.info("running UUID %s", self.uuid)
		data_parameters = collections.OrderedDict()
		data_parameters['p_uuid'] = uuid
		data_list = list(data_parameters.values())
		self.get_db().callproc(reliability_queries.reliability_assignment_storage, data_list)
		self.database.commit()
