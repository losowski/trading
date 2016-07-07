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
		

		# Status bar at the bottom
		self.CreateStatusBar()
		#Memn
		menubar = wx.MenuBar()
		file_menu = wx.Menu()
		file_menu.Append(22, '&Quit', 'Exit Stock GUI')
		menubar.Append(file_menu, '&File')
		self.SetMenuBar(menubar)
		wx.EVT_MENU(self, 22, self.OnClose)

		#Panels
		menu_panel = wx.Panel(self, -1)
		#Sizer
		#sizer = wx.GridSizer(8,1)
		v_menu_box_sizer = wx.BoxSizer(wx.VERTICAL)
		h_menu_box_sizer = wx.BoxSizer(wx.HORIZONTAL)
		#Create element
		symbol_label = wx.StaticText(menu_panel, -1, "Symbols", size=(140,20),style=wx.ALIGN_RIGHT)
		symbols = wx.ComboBox(menu_panel, -1, size=(140,20),choices = self.symbols.get_symbols_list(), style=wx.CB_READONLY)
		#Add element
		v_menu_box_sizer.Add(symbol_label)
		v_menu_box_sizer.Add(symbols)

		h_menu_box_sizer.Add(v_menu_box_sizer, 1, wx.EXPAND)
		#Add panels
		menu_panel.SetSizer(h_menu_box_sizer)
		#Show Everything (last action)
		self.Show()
		pass #__init__ functions

	def __del__(self):
		self.symbols.shutdown()

	def OnClose(self, event):
		self.Close()
