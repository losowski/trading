Technical Analysis Specification
================================

PURPOSE
=======
- Iron out the minimal specifications for the SQL statements.

==============
IMPLEMEMTATION
==============

** Performing Calculations **
- Insert new data TRIGGERED on insert of NEW data
	-- Simply performs the appropriate insert function
	
- Insert new data on request
	- Calculates the last update day
		- Presumes that there are no gaps!!

- repair mode:
	- Gaps exist
		- Query entire database for quote.id with out a calculation.quote_id.
		- Perform a calculation in these instances.

** CALCULATION FUNCTIONS **
	-- Performs the actual calculation
	-- Selects a range of values for calculation
** INSERT SQL FUNCTION **
	-- Performs single entry into database
** SELECT SQL FUNCTION **
	-- Provides the input for what quote.ids to act on
