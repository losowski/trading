#!/usr/bin/python
#postgres %(name_of_field)s
#python ${name_of_field}

import string

reliability_get_uuid = """
	SELECT DISTINCT
		r.reference,
		r.datestamp		
	FROM
		trading_schema.reference r
		INNER JOIN trading_schema.prediction_input pi ON (pi.reference_id = r.id)
	;
"""
#Evaluate and store
reliability_assignment_storage = "trading_schema.pInsPredictionTest"
