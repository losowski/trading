	#!/usr/bin/python
import datetime
import collections
import logging
import uuid

from database import db_connection
from utilities import symbols
from utilities import utilities
import analysis_queries


class AnalysisApplication(symbols.Symbols, utilities.Utilities):
	def __init__(self):
		symbols.Symbols.__init__(self)
		utilities.Utilities.__init__(self)

	def __del__(self):
		utilities.Utilities.__del__(self)
		symbols.Symbols.__del__(self)

	def initialise(self):
		symbols.Symbols.initialise(self)
		self.uuid = str(uuid.uuid4())
		self.datestamp = datetime.datetime.now()

	def shutdown(self):
		symbols.Symbols.shutdown(self)

	def run(self):
		self.perform_data_analysis()
		self.process_trading_flags()

	def perform_data_analysis(self):
		logging.info("Performing Analysis")
		for symbol in self.get_symbols_list():
			logging.debug("Symbol: %s", symbol)
			#Prepare to run the query
			data_parameters = collections.OrderedDict()
			data_parameters['symbol'] = symbol
			data_list = list(data_parameters.values())
			#Perform the analysis of the data
			self.db_cursor.callproc(analysis_queries.perform_data_analysis, data_list)
			self.database.commit()

	def __joining_names(self, index):
		return "sq{0}".format(index)

	def get_analysis_properties(self):
		logging.debug("Get the analysis properties")
		self.get_db().execute(analysis_queries.get_analysis_properties)
		return list(self.db_cursor.fetchall())

	def get_analysis_conditions(self, analysis_property_id):
		property_data_parameters = collections.OrderedDict()
		property_data_parameters['property_id'] = analysis_property_id
		logging.debug("property_data_parameters = %s", property_data_parameters)
		self.get_db().execute(analysis_queries.get_analysis_conditions, property_data_parameters)
		return list(self.db_cursor.fetchall())

	def build_analysis_query(self, analysis_property_id):
		analysis_property_conditions_list = self. get_analysis_conditions(analysis_property_id)
		#Build the Query
		absolute_parameters 	= list()
		relative_parameters		 = list()
		relative_join_parameters = list()
		for index, analysis_condition in enumerate(analysis_property_conditions_list, 1):
			logging.debug("Conditions: %s", analysis_condition)
			field_name, operator, threshold_type, value, days_interval, days_operator = analysis_condition
			logging.debug("%s %s %s %s WHEN datestamp is %s %s", field_name, operator, threshold_type, value, days_operator, days_interval)
			logging.info("Building the SQL statement that runs on the data")
			data =	{
						'relative_index'	: self.__joining_names(index),
						'field_name'		: field_name,
						'operator'			: self.operator_to_symbols(operator),
						'value'				: value,
						'days_operator'		: self.operator_to_symbols(days_operator),
						'days_interval'		: days_interval,
					}
			#Absolute
			if (threshold_type == 'A'):
				absolute_fragment = analysis_queries.AnalysisAbsoluteParameterTemplate.safe_substitute(data)
				logging.debug("Absolute Fragment: %s", absolute_fragment)
				absolute_parameters.append(absolute_fragment)
			#Relative
			elif (threshold_type == 'R'):
				relative_fragment = analysis_queries.AnalysisRelativeParameterTemplate.safe_substitute(data)
				logging.debug("Relative Fragment: %s", relative_fragment)
				relative_parameters.append(relative_fragment)

				relative_join_fragment = analysis_queries.AnalysisRelativeParameterJoinTemplate.safe_substitute(data)
				logging.debug("Relative Join Fragment: %s", relative_join_fragment)
				relative_join_parameters.append(relative_join_fragment)
			else:
				logging.error("Threshold type %s is invalid", threshold_type)
		#Mash this all into one enormous Query
		absolute = str()
		len_absolute = len(absolute_parameters)
		if  len_absolute > 0:
			absolute = " ".join(absolute_parameters)
			logging.debug("Analysis absolute: %s", absolute)
		#Build relative parameters
		relative = str()
		len_relative = len(relative_parameters)
		if len(relative_parameters) > 0:
			relative = " ".join(relative_parameters)
			logging.debug("Analysis relative: %s", relative)
		relative_join = str()
		len_relative_join = len(relative_join_parameters)
		if len(relative_join_parameters) > 0:
			relative_join = " ".join(relative_join_parameters)
			logging.debug("Analysis relative join: %s", relative_join)
		#Build hte complete replace functions
		data = 	{
					'conditions_available'		: 'FALSE',
					'absolute_comparators'		: absolute,
					'relative_comparators'		: relative,
					'relative_join_comparators'	: relative_join
				}
		if (len_absolute > 0) or ((len_relative > 0) and (len_relative_join > 0)) :
			logging.debug("We have some conditions: %s", relative)
			data['conditions_available'] = 'TRUE'
		analysis_query = analysis_queries.AnalysisBackboneQueryTemplate.safe_substitute(data)
		logging.info("Analysis Query: %s", analysis_query)
		return analysis_query

	def process_analysis_query_symbol(self, analysis_query, analysis_property_id, symbol):
		logging.info("Running query on %s", symbol)
		#Perform the query per symbol
		data_parameters = collections.OrderedDict()
		data_parameters['symbol'] = symbol
		#Run the query
		self.get_db().execute(analysis_query, data_parameters)
		#Get the results
		analysis_trading_query_results_list = self.get_db().fetchall()
		logging.info("Matches Returned %s", len(analysis_trading_query_results_list))
		logging.info("UUID %s", self.uuid)
		for analysis_trading_result in analysis_trading_query_results_list:
			logging.debug("analysis_trading_result %s", analysis_trading_result)
			data_parameters = collections.OrderedDict()
			data_parameters['p_quote'] = analysis_trading_result[0]
			data_parameters['p_analysis_property'] = analysis_property_id
			data_parameters['p_uuid'] = self.uuid
			data_parameters['p_datestamp'] = self.datestamp
			data_list = list(data_parameters.values())
			#Perform the analysis of the data
			self.get_db().callproc(analysis_queries.analysis_assignment_storage, data_list)
			self.database.commit()

	def process_analysis_query(self, analysis_query, analysis_property_id, symbols=None):
		if symbols is None:
			#With query built, apply to the symbols that we have
			for symbol in self.get_symbols_list():
				self.process_analysis_query_symbol(analysis_query, analysis_property_id, symbol)
		else:
			self.process_analysis_query_symbol(analysis_query, analysis_property_id, symbols)


	def process_trading_flags(self):
		logging.info("Process the trading flags")
		for analysis_property in self.get_analysis_properties():
			logging.debug("Analysis property %s", analysis_property)
			analysis_property_id, analysis_property_name, analysis_property_type = analysis_property
			logging.debug("Property: %s : %s - %s", analysis_property_id, analysis_property_name, analysis_property_type)
			logging.info("Get the analysis conditions for %s : %s", analysis_property_id, analysis_property_name)
			analysis_query = self.build_analysis_query(analysis_property_id)
			self.process_analysis_query(analysis_query, analysis_property_id, None)

