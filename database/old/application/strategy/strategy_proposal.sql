-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsStrategyProposal(
	p_symbol				trading_schema.symbol.symbol%TYPE,
	p_entry_strategy_id		trading_schema.entry_strategy.id%TYPE
	) RETURNS void AS $$
DECLARE
	v_current_price			money;
	v_strategy_proposal_id	trading_schema.strategy_proposal.id%TYPE;
	v_symbol_id				trading_schema.symbol.id%TYPE;
	v_open_price			trading_schema.quote.open_price%TYPE;
	v_close_price			trading_schema.quote.close_price%TYPE;
	v_high_price			trading_schema.quote.high_price%TYPE;
	v_low_price				trading_schema.quote.low_price%TYPE;
	v_template_actions		RECORD;
	v_action				trading_schema.entry_actions.action%TYPE;
	v_investment_type		trading_schema.entry_actions.investment_type%TYPE;
	v_strike_price			trading_schema.entry_actions.strike_price%TYPE;
	v_termination_interval	trading_schema.entry_actions_template.termination_interval%TYPE;
	v_exit_strategy			RECORD;
	v_datestamp				trading_schema.quote.datestamp%TYPE;
BEGIN
	-- Set date
	v_datestamp := current_date - interval '1 day';
	-- Get Select ID
	SELECT
		id
	INTO
		v_symbol_id
	FROM
		trading_schema.symbol
	WHERE
		symbol = p_symbol
	;
	-- Get data
	SELECT
		open_price,
		close_price,
		high_price,
		low_price
	INTO
		v_open_price,
		v_close_price,
		v_high_price,
		v_low_price
	FROM
		trading_schema.quote
	WHERE
		datestamp = v_datestamp
	AND
		symbol_id = v_symbol_id
	;
	-- Insert entrance strategy
	INSERT INTO
		trading_schema.strategy_proposal
		(
			entry_strategy_id,
			symbol_id,
			datestamp
		)
	VALUES
		(
			p_entry_strategy_id,
			v_symbol_id,
			v_datestamp
		)
	;
	-- Get the ID
	SELECT
		*   
	INTO
		v_strategy_proposal_id
	FROM
		LASTVAL()
	;
	-- Maths
	v_current_price := v_close_price;
	-- Insert the Entrance Actions
	FOR v_template_actions IN
		SELECT
			action,
			investment_type,
   		 	strike_price,
   		 	termination_interval
		FROM
			trading_schema.entry_actions_template
		WHERE
			entry_strategy_id = p_entry_strategy_id
	LOOP
		-- Insert data
		PERFORM trading_schema.pInsEntryActions(
					p_entry_strategy_id,
					v_strategy_proposal_id,
					v_template_actions.action,
					v_template_actions.investment_type,
					v_template_actions.strike_price,
					v_template_actions.termination_interval,
					v_current_price
				);
	END LOOP;
	-- Fill in the required exit strategy
	FOR v_exit_strategy IN
		SELECT
			est.code
		FROM
			trading_schema.entry_exit_strategy ee
			INNER JOIN trading_schema.exit_strategy_template est ON (ee.exit_strategy_template_id = est.id)
		WHERE
			ee.entry_strategy_id = p_entry_strategy_id			
	LOOP
		PERFORM trading_schema.pInsExitStrategy(
					p_symbol_id,
					v_strategy_proposal_id,
					v_datestamp,
					v_exit_strategy.code,
					v_strike_price
				);
	END LOOP;
END;
$$ LANGUAGE plpgsql;
