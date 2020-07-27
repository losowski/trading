-- Add symbol enabled flag
-- NOTE: Not applied to exchange (as that is < 10 rows) so would not appreciably help
CREATE INDEX idx_symbol_enabled ON trading_schema.symbol USING btree (enabled);

-- Add "last_update" column to symbol
ALTER TABLE trading_schema.symbol
	ADD COLUMN last_update timestamp without time zone;

CREATE INDEX idx_symbol_last_update ON trading_schema.symbol USING btree (last_update);

-- Stored Procedures --
-- InsQuote(%(symbol), %(date), %(open_price), %(high_price), %(low_price), %(close_price), %(adj_close_price), %(volume))
CREATE OR REPLACE FUNCTION trading_schema.pInsQuote(
	p_symbol				trading_schema.symbol.symbol%TYPE,
	p_date					trading_schema.quote.datestamp%TYPE,
	p_open_price			trading_schema.quote.open_price%TYPE,
	p_high_price			trading_schema.quote.high_price%TYPE,
	p_low_price				trading_schema.quote.low_price%TYPE,
	p_close_price			trading_schema.quote.close_price%TYPE,
	p_adj_close_price		trading_schema.quote.adjusted_close_price%TYPE,
	p_volume				trading_schema.quote.volume%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
	symbol_id trading_schema.symbol.id%TYPE := NULL;
BEGIN
	-- Get the symbol id
	SELECT
		id
	INTO
		symbol_id
	FROM
		trading_schema.symbol
	WHERE
		symbol = p_symbol
	;
	-- Insert the quote
	INSERT INTO
	trading_schema.quote
		(
			symbol_id,
			datestamp,
			open_price,
			high_price,
			low_price,
			close_price,
			adjusted_close_price,
			volume
		)
	VALUES
		(
			symbol_id,
			p_date,
			p_open_price,
			p_high_price,
			p_low_price,
			p_close_price,
			p_adj_close_price,
			p_volume
		);

	-- Call the update function
	UPDATE trading_schema.symbol SET last_update = localtimestamp WHERE id = p_symbol_id;
	-- Get the inserted index
	SELECT
		*
	INTO
		inserted_id
	FROM
		LASTVAL();

	RETURN inserted_id;
END;
$$ LANGUAGE plpgsql;
