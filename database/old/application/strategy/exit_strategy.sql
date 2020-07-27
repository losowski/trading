-- INSERT into exit_strategy FROM exit_strategy_template
CREATE OR REPLACE FUNCTION trading_schema.pInsExitStrategy(
	p_symbol_id						trading_schema.symbol.id%TYPE,
	p_strategy_proposal_id			trading_schema.strategy_proposal.id%TYPE,
	p_datestamp						trading_schema.exit_strategy.datestamp%TYPE,
	p_code							trading_schema.exit_strategy.code%TYPE,
	p_strike_price					money
	) RETURNS void AS $$
DECLARE
	v_exit_strategy_template_id			trading_schema.exit_strategy_template.id%TYPE;
	v_exit_strategy_id					trading_schema.exit_strategy.id%TYPE;
	v_exit_strategy						RECORD;
BEGIN
		-- Get the raw values
	SELECT
		id
	INTO
		v_exit_strategy_template_id
	FROM
		trading_schema.exit_strategy_template
	WHERE
		code = p_code
	;
	-- Insert result
	INSERT INTO
		trading_schema.exit_strategy
		(
			strategy_proposal_id,
			symbol_id,
			datestamp,
			code
		)
	VALUES
		(
			p_strategy_proposal_id,
			p_symbol_id,
			p_datestamp,
			p_code	
		)
	;
	-- Get the ID
	SELECT
		*   
	INTO
		v_exit_strategy_id
	FROM
		LASTVAL()
	;
	-- Loop through the conditions
 	FOR v_exit_strategy IN
		SELECT
			expression,
			operator,
			variable
		FROM
			trading_schema.exit_conditions_template
		WHERE
			exit_stategy_template_id = v_exit_strategy_template_id			
	LOOP
		PERFORM trading_schema.pInsExitConditions(
					v_exit_strategy_id,
					v_exit_strategy.expression,
					v_exit_strategy.operator,
					v_exit_strategy.variable,
					p_strike_price
				);
	END LOOP;
END;
$$ LANGUAGE plpgsql;
