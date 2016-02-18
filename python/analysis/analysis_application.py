#!/usr/bin/python
import datetime
import collections
import logging

from database import db_connection
import analysis_queries


class AnalysisApplication:

	def __init__(self):
		self.database		= db_connection.DBConnection()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()

	def run(self):
		self.perform_data_analysis()
		self.generate_predictions()

	def perform_data_analysis(self):
		logging.info("Performing Analysis")
		analysis_data_query = self.database.get_query()
		analysis_data_query.execute(analysis_queries.get_list_of_symbols)
		symbols_list = analysis_data_query.fetchall()
		for symbol in symbols_list:
			logging.debug("Symbol: %s", symbol[0])
			data_parameters = collections.OrderedDict()
			data_parameters['symbol'] = symbol[0]
			data_list = list(data_parameters.values())
			#Perform the analysis of the data
			analysis_data_query.callproc(analysis_queries.perform_data_analysis, data_list)
			self.database.commit()
		analysis_data_query.close()

	def generate_predictions(self):
		logging.info("Generating Predictions")
		analysis_data_query = self.database.get_query()
		analysis_data_query.execute(analysis_queries.get_list_of_symbols)
		symbols_list = analysis_data_query.fetchall()
		for symbol in symbols_list:
			logging.debug("Symbol: %s", symbol[0])
			data_parameters = collections.OrderedDict()
			data_parameters['symbol'] = symbol[0]
			data_list = list(data_parameters.values())
			#analysis_data_query.callproc(analysis_queries.generate_analysis_table, data_list)
			self.database.commit()
		analysis_data_query.close()

