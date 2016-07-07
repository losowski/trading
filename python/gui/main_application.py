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
		
		self.symbols = Symbols()
		self.symbols.initialise()
		panel = wx.Panel(self, -1)

		# Status bar at the bottom
		self.CreateStatusBar()
		#Memn
		menubar = wx.MenuBar()
		file_menu = wx.Menu()
		file_menu.Append(22, '&Quit', 'Exit Stock GUI')
		menubar.Append(file_menu, '&File')
		self.SetMenuBar(menubar)
		wx.EVT_MENU(self, 22, self.OnClose)
		#Sizer
		sizer = wx.GridSizer(8,1)
		box_sizer = wx.BoxSizer(wx.VERTICAL)
		#Create element
		symbols = wx.ComboBox(self, 2, pos = (30,60), size= (100,20), choices = self.symbols.get_symbols_list(), style=wx.CB_READONLY)
		#Add element
		sizer.Add(symbols)
		#BULLSHIT
		#grid_sizer =  wx.GridSizer(4, 4, 3, 3)
		#Add elements
		#
		#wx.ComboBox(self, -1, pos=(50, 170), size=(150, -1), choices=authors, style=wx.CB_READONLY)
		#wx.Button(self, 1, 'Close', (80, 220))		
		#grid_sizer.Add(self.symbols, 1, wx.EXPAND)
		#Show Everything (last action)
		self.Show()
		pass #__init__ functions

	def __del__(self):
		self.symbols.shutdown()

	def OnClose(self, event):
		self.Close()
