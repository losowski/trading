-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsExitConditions(
	p_exit_strategy_id					trading_schema.exit_strategy.id%TYPE,
	p_expression						trading_schema.exit_conditions_template.expression%TYPE,
	p_operator							trading_schema.exit_conditions_template.operator%TYPE,
	p_variable							trading_schema.exit_conditions_template.variable%TYPE,
	p_strike_price						money
	) RETURNS void AS $$
DECLARE
	v_strike_price						money;	
	v_operator							trading_schema.exit_conditions_template.operator%TYPE;
	v_variable							trading_schema.exit_conditions_template.variable%TYPE;
BEGIN	
	-- Calculate new values
	CASE p_operator
		WHEN '+' THEN
			v_operator := '>=';
		WHEN '-' THEN	
			v_operator := '<=';
		ELSE
			v_operator := '=';
	END CASE;
	v_variable := p_strike_price + p_variable;
	-- Insert result
	INSERT INTO
		trading_schema.exit_conditions
		(
			expression,
			operator,
			variable
		)
	VALUES
		(
			p_expression,
			v_operator,
			v_variable	
		)
	;
END;
$$ LANGUAGE plpgsql;
