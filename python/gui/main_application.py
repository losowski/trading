#!/usr/bin/python

import wx
import datetime
import collections
import string
import logging

from database import db_connection

class MainApplicationWindow(wx.Frame):
	def __init__(self):
		wx.Frame.__init__(self, None, size=(1200,800), name="Stock Analysis User Interface")
		pass #__init__ functions
