#!/usr/bin/python

import wx
import datetime
import collections
import string
import logging

from database import db_connection

class MainApplicationWindow(wx.Frame):
	def __init__(self, parent = None, title="Stock Analysis User Interface"):
		wx.Frame.__init__(self, parent, title = title, size=(1200,800))
		self.Show()
		pass #__init__ functions
