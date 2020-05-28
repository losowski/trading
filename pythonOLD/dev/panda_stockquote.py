#!/usr/bin/python
'''
Import the Stock Data
'''
#import
import pandas.io.data as web
import datetime

def main():
	print ("Quote Importer")
        start = datetime.datetime(2010, 1, 1)
        end = datetime.datetime(2013, 1, 27)
        f = web.DataReader("F", 'yahoo', start, end)
        print f.ix['2010-01-04']
        print "High: {0}".format(f.ix['2010-01-04'].High)
#       print dir(f.ix['2010-01-04'])
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

