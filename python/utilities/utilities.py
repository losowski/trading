#!/usr/bin/python

class Utilities:
	def __init__(self):
		pass

	def __del__(self):
		pass

	def operator_to_symbols(self, operator):
		symbols = '='
		if (operator == 'gt'):
			symbols = '>='
		elif (operator == 'lt'):
			symbols = '<='
		elif (operator == 'eq'):
			symbols = '='
		return symbols

