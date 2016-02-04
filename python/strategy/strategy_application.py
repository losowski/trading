#!/usr/bin/python

import datetime
import collections
import string
import logging

from database import db_connection
import strategy_queries


class StrategyApplication:

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
		self.handle_entrances()
		self.handle_live_exits()
		#For each exit strategy:
			#Build the query
			#Run against the database
			#Output the results into ... 

	def handle_entrances(self):	
		#Read in the templates
		strategy_proposal_template = string.Template(strategy_queries.entrance_query_template)
		logging.debug("strategy_proposal_template: %s ", strategy_queries.entrance_query_template) 
		entrance_conditions_template = string.Template(strategy_queries.entrance_conditions_template)
		logging.debug("entrance_conditions_template: %s", strategy_queries.entrance_conditions_template)
		#Get cursor
		entrance_query = self.database.get_query()
		#Get list of symbols
		#TODO: Get a list of symbols for each strategy
		entrance_query.execute(strategy_queries.get_entrance_list_of_symbols)
		symbols_list = entrance_query.fetchall()
		logging.debug("Symbols: %s ", symbols_list)
		#Get list of entrance strategies
		entrance_query.execute(strategy_queries.get_list_of_entrance_strategies)
		entrance_strategies  = entrance_query.fetchall()
		logging.debug("Strategies: %s ", entrance_strategies)
		#For each entrance strategy
		for strategy_id, strategy_code, strategy_name, risk_level in entrance_strategies:
			#Get the conditions
			entrance_query.execute(strategy_queries.get_strategy_proposal_conditions, {'entry_strategy_id' : strategy_id,})
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
				entrance_query.callproc(strategy_queries.entrance_query_output, data_list)
				self.database.commit()
			entrance_query.close()

	def handle_live_exits(self):
		#self.build_exit_queries()
		self.inquire_live_exits()


	def inquire_live_exits(self):
		##For looking for exits##
		#Get list of exit strategies and associated symbols that are in play:
		#	date closed == NULL
		#For each exit strategy:
			#Build the query
			#Run against the database
			#Output the results iinto ... 
		'''
			1) Get the list of entrance strategies that 
					- do not have a currently dated exit strategy
					- Do have an accepted trade on them
					- entry for each day that is available
				DATA: symbol, date, entry_strategy_id
			2) For each entrance strategy:
				get the exit_strategy and paramters
				2.1) Build the exit strategy query to see if it meets any parameters (INGORE)
				2.2) Fill in the exit strategy data and a report if it is met or not
			3) To query the results
				a report on what symbols and when the exit strategy was triggered
		'''
		#Get cursor
		exit_query = self.database.get_query()
		#Get templates
		exit_strategy_template = string.Template(strategy_queries.entrance_query_template)
		logging.debug("exit_strategy_template: %s ", strategy_queries.exit_query_template) 
		exit_conditions_template = string.Template(strategy_queries.entrance_conditions_template)
		logging.debug("entrance_conditions_template: %s", strategy_queries.exit_conditions_template)	
		#Get select temlate for symbols
		#Get template for the exit strategies

		#Get Symbol, date and entry_strategy_id for accepted trades with
		exit_query.execute(strategy_queries.get_exit_strategy_trades)
		exit_symbols_data = exit_query.fetchall()
		logging.debug("Exit Trade data %s ", exit_symbols_data)
		#Get the exit strategy plan - the existing entrance strategies
		for symbol, datestamp, entry_strategy_id in exit_symbols_data:
			logging.info("Symbol %s, date %s (%s)", symbol, datestamp, entry_strategy_id)
			#Get the conditions templates for this 
			exit_query.execute(strategy_queries.get_exit_strategy_conditions, {'entry_strategy_id' : entry_strategy_id,})
			exit_conditions = exit_query.fetchall()
			logging.debug("Exit strategy Conditions: %s", exit_conditions)
			condition_strings = list()
			for variable, operator, value in exit_conditions:
				logging.debug("EXIT CONDITION: %s %s %s ", variable, operator, value)
				condition_sql = exit_conditions_template.safe_substitute(	variable	= variable,
																				operator	= operator,
																				value		= value
																			)
				logging.debug("CONDITION SQL: %s", condition_sql)
				condition_strings.append(condition_sql)
			#Join the additional lines
			additional_conditions = '-'.join(condition_strings)
			logging.debug("CONDITION STRING: %s", additional_conditions)
			#build conditions
			#Build formal SQL statement
		exit_query.close()
