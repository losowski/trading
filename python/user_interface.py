#!/usr/bin/python
'''
GUI User Interface
'''
import logging
from gui import gui_application

def main():
	name = "GUI User Interface"
	print (name)
	logging.basicConfig(format='%(levelname)s:%(message)s', filename='gui_application.log',level=logging.DEBUG)
	logging.debug("%s Started", name)
	analysis = gui_application.GUIApplication()
	analysis.initialise()
	analysis.run()
	print("Exiting...")

# Assign a start point to the executable
if __name__ == "__main__":
	main()

