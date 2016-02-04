#!/usr/bin/python
'''
Retrieves the options data from sources such as yahoo
Ideally we should use python-pandas across the board (standard package)
'''
#import
from options import options_pricing

def main():
	print ("Options Quote Importer")
	option = options_pricing.OptionPricing()
	option.initialise()
	option.update()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

