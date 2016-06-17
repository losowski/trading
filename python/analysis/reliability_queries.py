#!/usr/bin/python
#postgres %(name_of_field)s
#python ${name_of_field}

import string

reliability_get_uuid = """
	SELECT DISTINCT
		r.reference,
		r.datestamp		
	FROM
		trading_schema.prediction_input pi
		INNER JOIN trading_schema.reference r ON (r.id = pi.reference_id)
	;
"""
#Evaluate and store
reliability_assignment_storage = "trading_schema.pInsPredictionTest"
