#!/usr/bin/python

import wx
import datetime
import collections
import string
import logging

from database import db_connection

import main_application

class GUIApplication:
	def __init__(self):
		self.database		= db_connection.DBConnection()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()

	def run (self):
		#Create an App
		app = wx.App()
		#Create a Frame from that app (static function)
		guiMainWindow = main_application.MainApplicationWindow()
		#Show the windows
		guiMainWindow.Show()
		#Main User Interface processing loop
		app.MainLoop()
