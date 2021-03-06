SELECT
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category
FROM
	trading_schema.exchange e
	INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND e.enabled = 'Y')
WHERE
	s.enabled = 'Y'
AND
	s.symbol LIKE 'A%'
LIMIT 10;
