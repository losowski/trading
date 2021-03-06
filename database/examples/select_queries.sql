{code:sql}
SELECT
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category,
	MIN(q.open_price)
FROM
	trading_schema.exchange e
	INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND e.enabled = 'Y')
	INNER JOIN trading_schema.quote q ON (q.symbol_id = s.id)
WHERE
	s.enabled = 'Y'
AND
	s.symbol LIKE 'A%'
GROUP BY
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category
LIMIT
	10
;
{code}

-- Debugging Category
{code:sql}
SELECT
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category,
	MIN(q.open_price)
FROM
	trading_schema.exchange e
	INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND e.enabled = 'Y')
	INNER JOIN trading_schema.quote q ON (q.symbol_id = s.id AND q.datestamp < s.last_update AND q.datestamp >= s.last_update - INTERVAL '365 days')
WHERE
	s.enabled = 'Y'
AND
	s.symbol LIKE 'A%'
GROUP BY
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category
LIMIT 10
;
{code}
