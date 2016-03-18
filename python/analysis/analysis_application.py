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
		self.db_cursor = self.database.get_query()

	def shutdown(self):
		self.db_cursor.close()

	def run(self):
		self.perform_data_analysis()
		self.process_trading_flags()

	def get_symbols_list(self):
		if len(self.symbols_list) == 0:
			logging.info("Fetching Symnbols")
			self.db_cursor.execute(analysis_queries.get_list_of_symbols)
			symbols_list = self.db_cursor.fetchall()
			for symbol in symbols_list:
				logging.debug("reading symbol: %s", symbol[0])
			self.symbols_list.append(symbol[0])
		return self.symbols_list

	def perform_data_analysis(self):
		logging.info("Performing Analysis")
		for symbol in self.get_symbols_list():
			logging.debug("Symbol: %s", symbol[0])
			#Prepare to run the query
			data_parameters = collections.OrderedDict()
			data_parameters['symbol'] = symbol[0]
			data_list = list(data_parameters.values())
			#Perform the analysis of the data
			self.db_cursor.callproc(analysis_queries.perform_data_analysis, data_list)
			self.database.commit()

	def __operator_to_symbols(self, operator):
		symbols = '='
		if (operator == 'gt'):
			symbols = '>='
		elif (operator == 'lt'):
			symbols = '<='
		elif (operator == 'eq'):
			symbols = '='
		return symbols

	def __joining_names(self, index):
		return "sq{0}".format(index)

	def process_trading_flags(self):
		logging.info("Process the trading flags")
		logging.debug("Getting analysis_trading_query")
		analysis_trading_query = self.database.get_query()
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
			#Build the Query
			absolute_parameters 	= list()
			relative_parameters		 = list()
			relative_join_parameters = list()
			for index, analysis_condition in enumerate(analysis_property_conditions_list, 1):
				logging.debug("Conditions: %s", analysis_condition)
				field_name, operator, threshold_type, duration, value = analysis_condition
				logging.debug("%s %s %s %s WHEN datestamp is %s", field_name, operator, threshold_type, value, duration)
				logging.info("Building the SQL statement that runs on the data")
				data =	{
							'relative_index'	: self.__joining_names(index),
							'field_name'		: field_name,
							'duration'			: duration,
							'operator'			: self.__operator_to_symbols(operator),
							'value'				: value
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
			#With query built, apply to the symbols that we have
			for symbol in self.symbols_list:
				logging.info("Running query on %s", symbol)
				#Perform the query per symbol
				data_parameters = collections.OrderedDict()
				data_parameters['symbol'] = symbol
				#Run the query
				analysis_trading_query.execute(analysis_query, data_parameters)
				#Get the results
				analysis_trading_query_results_list = analysis_trading_query.fetchall()
				for analysis_trading_result in analysis_trading_query_results_list:
					logging.debug("analysis_trading_result %s", analysis_trading_result)
					analysis_input_query = self.database.get_query()
					data_parameters = collections.OrderedDict()
					data_parameters['p_quote'] = analysis_trading_result[0]
					data_parameters['p_analysis_property'] = analysis_property_id
					data_list = list(data_parameters.values())
					#Perform the analysis of the data
					analysis_input_query.callproc(analysis_queries.analysis_assignment_storage, data_list)
					self.database.commit()
					analysis_input_query.close()

			logging.debug("Closing analysis_conditions_query")
			analysis_property_conditions_query.close()
		logging.debug("Closing analysis_trading_query")
		analysis_trading_query.close()
		logging.debug("Closing analysis_properties_query")
		analysis_properties_query.close()

