#!/usr/bin/python
#Uses psycopg package: python-psycopg2 (python-native libpq driver)
#sudo apt-get install python-psycopg2

import psycopg2
import xml.etree.ElementTree as xml

class DBConnection:
	def __init__(self, configuration="../xml/db_connection.xml"):
		self.connection = None
		#XML
		self.tree = xml.parse(configuration)
		self.root = self.tree.getroot()
		#Connection Data
		self.database_type	= "postgres"
		self.host			= "localhost"
		self.port			= "5432"
		self.database		= None
		self.username		= None
		self.password		= None
		#Connection object
		self.connection		= None

	def __del__(self):
		if self.connection != None:
			self.connection.close()

	def __read_xml(self):
	   for db_connection in list(self.root):
			#print ("DB Connection: {0}".format(db_connection.tag))
			if (db_connection.tag == "type"):
				self.database_type = db_connection.text
			if (db_connection.tag == "connection"):
				for connection_info in list(db_connection):
					#print ("Connection DATA: {0} : {1}".format(connection_info.tag, connection_info.text))
					if (connection_info.tag == "host"):
						self.host = connection_info.text
					elif (connection_info.tag == "port"):
						self.port = connection_info.text
					elif (connection_info.tag == "database"):
						self.database = connection_info.text
					elif (connection_info.tag == "username"):
						self.username = connection_info.text
					elif (connection_info.tag == "password"):
						self.password = connection_info.text


	def connect(self):
		if self.connection is None:
			#Read the XML data
			self.__read_xml()
			#Connect to the database - throws!
			dsn = {
						'database'	:	self.database,
						'user'		:	self.username,
						'host'		:	self.host,
						'port'		:	self.port
					}
			if self.password != None:
				dsn['password'] = self.password

			#Connect
			self.connection = psycopg2.connect(**dsn)

	def get_connection(self):
		return self.connection

	def get_query(self):
		return self.connection.cursor()

	def commit(self):
		self.connection.commit()

	def rollback(self):
		self.connection.rollback()
