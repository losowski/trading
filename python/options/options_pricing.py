'''
Package to obtain the options pricing
'''
import yahoo_options
import google_options

class OptionPricing:
        GOOGLE, YAHOO = range(1+1)
	def __init__(self, source = YAHOO):
            if source == self.YAHOO:
		self.option_obj = yahoo_options.YahooOptionPricing()
            elif source == self.GOOGLE:
		self.option_obj = google_options.GoogleOptionPricing()

	def __del__(self):
		self.option_obj=None

	def initialise(self):
		pass

	def update(self):
		print self.option_obj.get_option_data('GOOG')

