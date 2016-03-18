#!/usr/bin/python
from database import db_connection

class DBCursor:
	def __init__(self):
		self.database		= db_connection.DBConnection()
		self.db_cursor		= None

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()
		if self.db_cursor is None:
			self.db_cursor = self.database.get_query()

	def shutdown(self):
		if self.db_cursor is not None:
			self.db_cursor.close()

	def get_db(self):
		if self.db_cursor is None:
			self.db_cursor = self.database.get_query()
		return self.db_cursor
