#!/usr/bin/python
'''
Import the Stock Data
'''
#import
from feeds import feeds_application

def main():
	print ("Quote Importer")
	feeds = feeds_application.FeedsApplication()
	feeds.initialise()
	feeds.update()
	print("Exiting...")


# Assign a start point to the executable
if __name__ == "__main__":
	main()

