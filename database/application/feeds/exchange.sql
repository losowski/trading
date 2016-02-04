-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsExchange(
	p_exchange	trading_schema.exchange.name%TYPE
	) RETURNS integer AS $$
DECLARE
    inserted_id integer := 0;
BEGIN
  	INSERT INTO
  	trading_schema.exchange
	  	(
			exchange
	  	)
  	VALUES
	  	(
			p_exchange
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
