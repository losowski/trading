-- Actions that are fed from the entry_strategy
CREATE OR REPLACE FUNCTION trading_schema.pInsEntryActions(
	p_entry_strategy_id					trading_schema.entry_strategy.id%TYPE,
	p_strategy_proposal_id				trading_schema.strategy_proposal.id%TYPE,
	p_action							trading_schema.entry_actions.action%TYPE,
	p_investment_type					trading_schema.entry_actions.investment_type%TYPE,
	p_strike_price						trading_schema.entry_actions.strike_price%TYPE,
	p_termination_interval				trading_schema.entry_actions_template.termination_interval%TYPE,
	p_current_price						money
) RETURNS void AS $$
DECLARE
	v_strike_price						trading_schema.entry_actions.strike_price%TYPE;
	v_termination_date					trading_schema.entry_actions.termination_date%TYPE;
BEGIN
	-- Pricing
	CASE
		WHEN p_investment_type = 'PUT' THEN
			v_strike_price := (FLOOR(CAST(p_current_price AS numeric)/ 5)*5) + CAST(p_strike_price AS numeric);
		WHEN p_investment_type = 'CALL' THEN
			v_strike_price := (CEILING(CAST(p_current_price AS numeric)/ 5)*5) + CAST(p_strike_price AS numeric);
		ELSE
			v_strike_price := p_current_price;
	END CASE;
	-- Termination dates
	IF p_termination_interval IS NOT NULL THEN
		v_termination_date := date_trunc('month', current_date) + CAST(p_termination_interval AS interval);
	ELSE
		v_termination_date := NULL;
	END IF;
	-- Insert
	INSERT INTO
		trading_schema.entry_actions
	(
		entry_strategy_id,
		strategy_proposal_id,
		action,
		investment_type,
		strike_price,
		termination_date
	)
	VALUES
	(
		p_entry_strategy_id,
		p_strategy_proposal_id,
		p_action,
		p_investment_type,
		v_strike_price,
		v_termination_date
	)
	;
END;
$$ LANGUAGE plpgsql;
