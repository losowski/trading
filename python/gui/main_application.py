#!/usr/bin/python

import wx
import datetime
import collections
import string
import logging
from utilities.symbols import Symbols

from database import db_connection

class MainApplicationWindow(wx.Frame):
	def __init__(self, parent = None, title="Stock Analysis User Interface"):
		wx.Frame.__init__(self, parent, title = title, size=(1200,800))
		self.sizer = wx.GridBagSizer(2,4)
		self.symbols = Symbols()
		self.symbols.initialise()
		#Add elements
		self.symbols = wx.ComboBox(self, size=wx.Size(40, 50), choices = self.symbols.get_symbols_list())
		self.CreateStatusBar() # Status bar at the bottom
		#Show
		self.Show()
		pass #__init__ functions

	def __del__(self):
		self.symbols.shutdown()
