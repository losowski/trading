-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsEntryExitStrategy(
	p_entry_strategy_code		trading_schema.entry_strategy.code%TYPE,
	p_exit_strategy_code		trading_schema.exit_strategy.code%TYPE
	) RETURNS void AS $$
DECLARE
	v_entry_strategy_id			trading_schema.entry_strategy.id%TYPE;
	v_exit_strategy_id		trading_schema.exit_strategy.id%TYPE;
BEGIN
	-- Entry Strategy
	SELECT
		id
	INTO
		v_entry_strategy_id
	FROM
		trading_schema.entry_strategy
	WHERE
		code = p_entry_strategy_code
	;

	-- Exit Strategy
	SELECT
		id
	INTO
		v_exit_strategy_id
	FROM
		trading_schema.exit_strategy
	WHERE
		code = p_exit_strategy_code
	;

	-- Insert Link
	INSERT INTO
		trading_schema.entry_exit_strategy
		(
			entry_strategy_id,
			exit_strategy_id
		)
	VALUES
		(
			v_entry_strategy_id,
			v_exit_strategy_id
		)
	;
END;
$$ LANGUAGE plpgsql;
