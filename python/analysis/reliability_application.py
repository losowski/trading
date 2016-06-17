#!/usr/bin/python
import datetime
import collections
import logging
import uuid

from database import db_connection
import reliabililty_queries


class ReliabilityApplication(db_connection.DBConnection):
	def __init__(self):
		db_connection.DBConnection.__init__(self)

	def __del__(self):
		db_connection.DBConnection.__del__(self)

	def initialise(self):
		pass

	def shutdown(self):
		pass

	def run(self):
		pass

	def get_uuid(self):
		self.get_db().execute(reliability_queries.reliability_assignment_storage)
		analysis_trading_query_results_list = self.get_db().fetchall()
		for ref, date in analysis_trading_query_results_list:
			print ("UUID: {0} - {1}".format(ref, date))

	def run_uuid(self, uuid):
		logging.info("running UUID %s", self.uuid)
		data_parameters = collections.OrderedDict()
		data_parameters['p_uuid'] = uuid
		data_list = list(data_parameters.values())
		self.get_db().callproc(analysis_queries.analysis_assignment_storage, data_list)
		self.database.commit()
