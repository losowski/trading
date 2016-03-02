#!/usr/bin/python
import datetime
import collections
import logging

from database import db_connection
import analysis_queries


class AnalysisApplication:

	def __init__(self):
		self.database		= db_connection.DBConnection()
		self.symbols_list	= list()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()

	def run(self):
		self.perform_data_analysis()
		self.process_trading_flags()

	def perform_data_analysis(self):
		logging.info("Performing Analysis")
		analysis_data_query = self.database.get_query()
		analysis_data_query.execute(analysis_queries.get_list_of_symbols)
		symbols_list = analysis_data_query.fetchall()
		for symbol in symbols_list:
			logging.debug("Symbol: %s", symbol[0])
			#Add the symbols to make life easier later on
			self.symbols_list.append(symbol[0])
			data_parameters = collections.OrderedDict()
			data_parameters['symbol'] = symbol[0]
			data_list = list(data_parameters.values())
			#Perform the analysis of the data
			analysis_data_query.callproc(analysis_queries.perform_data_analysis, data_list)
			self.database.commit()
		analysis_data_query.close()

	def process_trading_flags(self):
		logging.info("Process the trading flags")
		logging.debug("Get the analysis properties")
		analysis_properties_query = self.database.get_query()
		analysis_properties_query.execute(analysis_queries.get_analysis_properties)
		analysis_properties_list = analysis_properties_query.fetchall()
		for analysis_property in analysis_properties_list:
			logging.debug("Analysis property %s", analysis_property)
			analysis_property_id, analysis_property_name, analysis_property_type, analysis_property_assigned_value = analysis_property
			logging.debug("Property: %s : %s - %s", analysis_property_id, analysis_property_name, analysis_property_type)
			logging.info("Get the analysis conditions for %s : %s", analysis_property_id, analysis_property_name)
			property_data_parameters = collections.OrderedDict()
			property_data_parameters['property_id'] = analysis_property_id
			logging.debug("property_data_parameters = %s", property_data_parameters)
			analysis_property_conditions_query = self.database.get_query()
			analysis_property_conditions_query.execute(analysis_queries.get_analysis_conditions, property_data_parameters)
			analysis_property_conditions_list = analysis_property_conditions_query.fetchall()
			for analysis_condition in analysis_property_conditions_list:
				logging.debug("Conditions: %s", analysis_condition)
				field_name, operator, threshold_type, duration, value = analysis_condition
				logging.debug("%s %s %s %s WHEN datestamp is %s", field_name, operator, threshold_type, value, duration)
				logging.info("Building the SQL statement that runs on the data")
				for symbol in self.symbols_list:
					logging.info("Running query on %s", symbol)
			logging.debug("Closing analysis_conditions_query")
			analysis_property_conditions_query.close()
		logging.debug("Closing analysis_properties_query")
		analysis_properties_query.close()
