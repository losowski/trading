#!/usr/bin/python
import python.feeds.ystockquote
'''
git clone git://github.com/cgoldberg/ystockquote.git
cd ystockquote
sudo python setup.py install

-- Additional Functions -- 
import ystockquote
help(ystockquote)
'''
class YStockQuoteAPI:
	def __init__(self):
		pass

	def __del__(self):
		pass

	def get_current_price (self, symbol):
		return ystockquote.get_price_book('GOOGL')
		#return ystockquote.get_bid_realtime('GOOGL')

	def get_historical(self, symbol, start_date, end_date):
		return ystockquote.get_historical_prices(symbol, start_date, end_date)
