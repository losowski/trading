{code:sql}
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
ORDER BY
	e.name,
	s.symbol
LIMIT 100
;
{code}
{noformat}
{noformat}


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
GROUP BY
	e.id,
	e.name,
	s.id,
	s.name,
	s.symbol,
	s.enabled,
	s.last_update,
	s.category
ORDER BY
	s.symbol
LIMIT
	100
;
{code}


-- Category split
{code:sql}
SELECT
	s.category,
	COUNT(s.category)
FROM
	trading_schema.exchange e
	INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id AND e.enabled = 'Y')
WHERE
	s.enabled = 'Y'
GROUP BY
	s.category
ORDER BY
	s.category
;
{code}


-- Fundamentals Data
{code:sql}
SELECT
	e.name,
	s.name,
	s.symbol,
	ed.*
FROM
	trading_schema.exchange e
	INNER JOIN trading_schema.symbol s ON (e.id = s.exchange_id)
	INNER JOIN trading_schema.earnings_data ed ON  (ed.symbol_id = s.id)
ORDER BY
	s.name
;
{code}
