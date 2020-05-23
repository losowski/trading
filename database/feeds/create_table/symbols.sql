-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsSymbol(
	p_exchange	trading_schema.exchange.name%TYPE,
	p_name		trading_schema.symbol.name%TYPE,
	p_symbol	trading_schema.symbol.symbol%TYPE
	) RETURNS integer AS $$
DECLARE
    inserted_id integer := 0;
BEGIN
  	INSERT INTO
  	trading_schema.symbol
	  	(
			exchange_id,
		  	symbol,
			name
	  	)
  	VALUES
	  	(
		  	(SELECT id FROM trading_schema.exchange WHERE name=p_exchange),
			p_symbol,
		  	p_name
	  	);
  	
  	SELECT
  		*
  	INTO
  		inserted_id
  	FROM
		LASTVAL();

    RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;
