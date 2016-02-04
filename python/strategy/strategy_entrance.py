#!/usr/bin/python

import datetime
import collections
import string
import logging

from database import db_connection
import strategy_entrance_queries

class StrategyEntrance:

	def __init__(self):
		self.database		= db_connection.DBConnection()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()

	def run(self):
		#Get list of symbols
		#Get list of entrance strategies
		#For each entrance strategy
			#Get the conditions
			#Read in the template
			#Fill in the additional parameters
			#Build the entrance strategy using a template
			#Run the query against the database for each symbol	
			#Output the results into the output table
		##For looking for exits##
		#Get list of exit strategies and associated symbols that are in play:
		#	date closed == NULL
		#For each exit strategy:
			#Build the query
			#Run against the database
			#Output the results into ... 

		#Read in the templates
		strategy_proposal_template = string.Template(strategy_entrance_queries.entrance_query_template)
		logging.debug("strategy_proposal_template: %s ", strategy_entrance_queries.entrance_query_template) 
		entrance_conditions_template = string.Template(strategy_entrance_queries.entrance_conditions_template)
		logging.debug("entrance_conditions_template: %s", strategy_entrance_queries.entrance_conditions_template)
		#Get cursor
		entrance_query = self.database.get_query()
		#Get list of symbols
		#TODO: Get a list of symbols for each strategy
		entrance_query.execute(strategy_entrance_queries.get_entrance_list_of_symbols)
		symbols_list = entrance_query.fetchall()
		logging.debug("Symbols: %s ", symbols_list)
		#Get list of entrance strategies
		entrance_query.execute(strategy_entrance_queries.get_list_of_entrance_strategies)
		entrance_strategies  = entrance_query.fetchall()
		logging.debug("Strategies: %s ", entrance_strategies)
		#For each entrance strategy
		for strategy_id, strategy_code, strategy_name, risk_level in entrance_strategies:
			#Get the conditions
			entrance_query.execute(strategy_entrance_queries.get_strategy_proposal_conditions, {'entry_strategy_id' : strategy_id,})
			entry_conditions = entrance_query.fetchall()
			logging.debug("Strategy Conditions: %s:%s - %s (%s) : %s ", strategy_id, strategy_code, strategy_name, risk_level, entry_conditions)
			condition_strings = list()
			for variable, operator, value in entry_conditions:
				logging.debug("ENTRANCE CONDITION: %s %s %s ", variable, operator, value)
				condition_sql = entrance_conditions_template.safe_substitute(	variable	= variable,
																				operator	= operator,
																				value		= value
																			)
				logging.debug("CONDITION SQL: %s", condition_sql)
				condition_strings.append(condition_sql)
			#Join the additional lines
			additional_conditions = '-'.join(condition_strings)
			logging.debug("CONDITION STRING: %s", additional_conditions)
			#Build the entrance strategy using a template
			entrance_sql = strategy_proposal_template.safe_substitute(entrance_conditions = additional_conditions)
			logging.debug("ENTRANCE SQL: %s", entrance_sql)
			#Run the query against the database for each symbol
			entrance_query.execute(entrance_sql)
			symbols_list = entrance_query.fetchall()	
			logging.debug("Symbols Matching %s : %s", strategy_name ,symbols_list)
			#Output the results into the output table
			for symbol in symbols_list:
				logging.info("Strategy Symbol %s", symbol[0])
				data_parameters = collections.OrderedDict()
				#Push data to results table
				data_parameters['symbol'] = symbol[0]
				data_parameters['strategy_id'] = strategy_id
				logging.debug("Entrance Output: %s", data_parameters)
				data_list = list(data_parameters.values())
				entrance_query.callproc(strategy_entrance_queries.entrance_query_output, data_list)
				self.database.commit()
			entrance_query.close()
