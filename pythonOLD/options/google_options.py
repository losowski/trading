'''
Package to obtain the options pricing from yahoo finance
	URL:	https://finance.yahoo.com/q/op?s=GOOG+Options

Dependencies:
    python-pandas
GitHub:
    git clone https://github.com/pydata/pandas
'''
from pandas.io.data import Options

class GoogleOptionPricing:
	def __init__(self):
		pass

	def __del__(self):
		pass

	def get_option_data(self, symbol):
		aapl = Options(symbol, 'google')
		data = aapl.get_all_data()
		return data
