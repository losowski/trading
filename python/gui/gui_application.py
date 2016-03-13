#!/usr/bin/python

import wx
import datetime
import collections
import string
import logging

from database import db_connection


class GUIApplication:
	def __init__(self):
		self.database		= db_connection.DBConnection()

	def __del__(self):
		pass

	def initialise(self):
		self.database.connect()

	def run (self):
		app = wx.App(redirect=True)
		top = wx.Frame(None, title="Hello World", size=(300,200))
		top.Show()
		app.MainLoop()
