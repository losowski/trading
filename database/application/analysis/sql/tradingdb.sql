--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2016-02-05 22:23:17 GMT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = trading_schema, pg_catalog;

ALTER TABLE ONLY trading_schema.symbol DROP CONSTRAINT fk_symbol_exchange_id;
ALTER TABLE ONLY trading_schema.strategy_proposal DROP CONSTRAINT fk_strategy_proposal_2;
ALTER TABLE ONLY trading_schema.entry_actions DROP CONSTRAINT fk_strategy_proposal_1;
ALTER TABLE ONLY trading_schema.strategy_proposal DROP CONSTRAINT fk_strategy_proposal_1;
ALTER TABLE ONLY trading_schema.quote DROP CONSTRAINT fk_quote_symbol_id;
ALTER TABLE ONLY trading_schema.processing DROP CONSTRAINT fk_processing_1;
ALTER TABLE ONLY trading_schema.a_moving_avg DROP CONSTRAINT fk_moving_avg_1;
ALTER TABLE ONLY trading_schema.moving_average DROP CONSTRAINT fk_moving_average_quote;
ALTER TABLE ONLY trading_schema.exit_strategy DROP CONSTRAINT fk_exit_strategy_2;
ALTER TABLE ONLY trading_schema.exit_strategy DROP CONSTRAINT fk_exit_strategy_1;
ALTER TABLE ONLY trading_schema.exit_proposal DROP CONSTRAINT fk_exit_proposal_2;
ALTER TABLE ONLY trading_schema.exit_proposal DROP CONSTRAINT fk_exit_proposal_1;
ALTER TABLE ONLY trading_schema.exit_conditions_template DROP CONSTRAINT fk_exit_conditions_template;
ALTER TABLE ONLY trading_schema.exit_conditions DROP CONSTRAINT fk_exit_conditions;
ALTER TABLE ONLY trading_schema.entry_exit_strategy DROP CONSTRAINT fk_entry_exit_strategy_2;
ALTER TABLE ONLY trading_schema.entry_exit_strategy DROP CONSTRAINT fk_entry_exit_strategy_1;
ALTER TABLE ONLY trading_schema.entry_conditions DROP CONSTRAINT fk_entry_conditions_1;
ALTER TABLE ONLY trading_schema.entry_actions_template DROP CONSTRAINT fk_entry_actions_template_1;
ALTER TABLE ONLY trading_schema.analysis DROP CONSTRAINT fk_analysis_1;
ALTER TABLE ONLY trading_schema.accumulation_distribution DROP CONSTRAINT fk_accumulation_distribution_quote;
ALTER TABLE ONLY trading_schema.accepted_trades DROP CONSTRAINT fk_accepted_trades_1;
ALTER TABLE ONLY trading_schema.quote_diff DROP CONSTRAINT fk1_quote_diff;
ALTER TABLE ONLY trading_schema.entry_actions DROP CONSTRAINT entry_actions_entry_strategy_id_fkey;
DROP INDEX trading_schema.idx_twenty_one;
DROP INDEX trading_schema.idx_twenty_eight;
DROP INDEX trading_schema.idx_symbol_symbol;
DROP INDEX trading_schema.idx_symbol_name;
DROP INDEX trading_schema.idx_symbol_id;
DROP INDEX trading_schema.idx_seven;
DROP INDEX trading_schema.idx_quote_datestamp;
DROP INDEX trading_schema.idx_ninety;
DROP INDEX trading_schema.idx_fourty_eight;
DROP INDEX trading_schema.idx_fourteen;
DROP INDEX trading_schema.idx_exchange_name;
DROP INDEX trading_schema.idx_exchange_id;
DROP INDEX trading_schema.idx_accumulation_distribution;
DROP INDEX trading_schema.fki_symbol_exchange_id;
DROP INDEX trading_schema.fki_moving_average_quote;
DROP INDEX trading_schema.fki_accumulation_distribution_quote;
ALTER TABLE ONLY trading_schema.symbol DROP CONSTRAINT uc_symbol;
ALTER TABLE ONLY trading_schema.quote DROP CONSTRAINT uc_quote_1;
ALTER TABLE ONLY trading_schema.analysis DROP CONSTRAINT uc_analysis_1;
ALTER TABLE ONLY trading_schema.exit_strategy DROP CONSTRAINT u_exit_strategy;
ALTER TABLE ONLY trading_schema.exit_proposal DROP CONSTRAINT u_exit_proposal_1;
ALTER TABLE ONLY trading_schema.symbol DROP CONSTRAINT pk_symbol;
ALTER TABLE ONLY trading_schema.strategy_proposal DROP CONSTRAINT pk_strategy_proposal;
ALTER TABLE ONLY trading_schema.quote DROP CONSTRAINT pk_quote_id;
ALTER TABLE ONLY trading_schema.quote_diff DROP CONSTRAINT pk_quote_diff;
ALTER TABLE ONLY trading_schema.processing DROP CONSTRAINT pk_processing;
ALTER TABLE ONLY trading_schema.a_moving_avg DROP CONSTRAINT pk_moving_avg;
ALTER TABLE ONLY trading_schema.moving_average DROP CONSTRAINT pk_moving_average;
ALTER TABLE ONLY trading_schema.exit_strategy_template DROP CONSTRAINT pk_exit_strategy_template;
ALTER TABLE ONLY trading_schema.exit_strategy DROP CONSTRAINT pk_exit_strategy;
ALTER TABLE ONLY trading_schema.exit_proposal DROP CONSTRAINT pk_exit_proposal;
ALTER TABLE ONLY trading_schema.exit_conditions_template DROP CONSTRAINT pk_exit_conditions_template;
ALTER TABLE ONLY trading_schema.exit_conditions DROP CONSTRAINT pk_exit_conditions;
ALTER TABLE ONLY trading_schema.exchange DROP CONSTRAINT pk_exchange;
ALTER TABLE ONLY trading_schema.entry_strategy DROP CONSTRAINT pk_entry_strategy;
ALTER TABLE ONLY trading_schema.entry_exit_strategy DROP CONSTRAINT pk_entry_exit_strategy;
ALTER TABLE ONLY trading_schema.entry_conditions DROP CONSTRAINT pk_entry_conditions;
ALTER TABLE ONLY trading_schema.entry_actions_template DROP CONSTRAINT pk_entry_actions_template;
ALTER TABLE ONLY trading_schema.entry_actions DROP CONSTRAINT pk_entry_actions;
ALTER TABLE ONLY trading_schema.analysis DROP CONSTRAINT pk_analysis;
ALTER TABLE ONLY trading_schema.accumulation_distribution DROP CONSTRAINT pk_accumulation_distribution;
ALTER TABLE ONLY trading_schema.accepted_trades DROP CONSTRAINT pk_accepted_trades;
ALTER TABLE trading_schema.symbol ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.strategy_proposal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.quote ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.processing ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.moving_average ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exit_strategy_template ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exit_strategy ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exit_proposal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exit_conditions_template ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exit_conditions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.exchange ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.entry_strategy ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.entry_exit_strategy ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.entry_conditions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.entry_actions_template ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.entry_actions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.analysis ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.accumulation_distribution ALTER COLUMN id DROP DEFAULT;
ALTER TABLE trading_schema.accepted_trades ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE trading_schema.symbol_id_seq;
DROP TABLE trading_schema.symbol;
DROP SEQUENCE trading_schema.strategy_proposal_id_seq;
DROP TABLE trading_schema.strategy_proposal;
DROP SEQUENCE trading_schema.quote_id_seq;
DROP TABLE trading_schema.quote_diff;
DROP TABLE trading_schema.quote;
DROP SEQUENCE trading_schema.processing_id_seq;
DROP TABLE trading_schema.processing;
DROP SEQUENCE trading_schema.moving_average_id_seq;
DROP TABLE trading_schema.moving_average;
DROP SEQUENCE trading_schema.exit_strategy_template_id_seq;
DROP TABLE trading_schema.exit_strategy_template;
DROP SEQUENCE trading_schema.exit_strategy_id_seq;
DROP TABLE trading_schema.exit_strategy;
DROP SEQUENCE trading_schema.exit_proposal_id_seq;
DROP TABLE trading_schema.exit_proposal;
DROP SEQUENCE trading_schema.exit_conditions_template_id_seq;
DROP TABLE trading_schema.exit_conditions_template;
DROP SEQUENCE trading_schema.exit_conditions_id_seq;
DROP TABLE trading_schema.exit_conditions;
DROP SEQUENCE trading_schema.exchange_id_seq;
DROP TABLE trading_schema.exchange;
DROP SEQUENCE trading_schema.entry_strategy_id_seq;
DROP TABLE trading_schema.entry_strategy;
DROP SEQUENCE trading_schema.entry_exit_strategy_id_seq;
DROP TABLE trading_schema.entry_exit_strategy;
DROP SEQUENCE trading_schema.entry_conditions_id_seq;
DROP TABLE trading_schema.entry_conditions;
DROP SEQUENCE trading_schema.entry_actions_template_id_seq;
DROP TABLE trading_schema.entry_actions_template;
DROP SEQUENCE trading_schema.entry_actions_id_seq;
DROP TABLE trading_schema.entry_actions;
DROP SEQUENCE trading_schema.analysis_id_seq;
DROP TABLE trading_schema.analysis;
DROP SEQUENCE trading_schema.accumulation_distribution_id_seq;
DROP TABLE trading_schema.accumulation_distribution;
DROP SEQUENCE trading_schema.accepted_trades_id_seq;
DROP TABLE trading_schema.accepted_trades;
DROP TABLE trading_schema.a_moving_avg;
DROP SEQUENCE trading_schema.moving_avg_id_seq;
DROP FUNCTION trading_schema.pinssymbol(p_exchange text, p_name text, p_symbol text);
DROP FUNCTION trading_schema.pinsstrategyproposal(p_symbol text, p_entry_strategy_id bigint);
DROP FUNCTION trading_schema.pinsquote(p_symbol text, p_date timestamp without time zone, p_open_price numeric, p_high_price numeric, p_low_price numeric, p_close_price numeric, p_adj_close_price numeric, p_volume bigint);
DROP FUNCTION trading_schema.pinsexitstrategy(p_symbol_id bigint, p_strategy_proposal_id bigint, p_datestamp timestamp without time zone, p_code text, p_strike_price money);
DROP FUNCTION trading_schema.pinsexitconditions(p_exit_strategy_id bigint, p_expression text, p_operator text, p_variable text, p_strike_price money);
DROP FUNCTION trading_schema.pinsentryexitstrategy(p_entry_strategy_code text, p_exit_strategy_code text);
DROP FUNCTION trading_schema.pinsentryactions(p_entry_strategy_id bigint, p_strategy_proposal_id bigint, p_action text, p_investment_type text, p_strike_price money, p_termination_interval interval, p_current_price money);
DROP FUNCTION trading_schema.pinscalcmovingavg(p_symbol text, p_datestamp timestamp without time zone);
DROP FUNCTION trading_schema.pcalcsymbolavg(p_symbol text);
DROP FUNCTION trading_schema.pcalcavg(p_symbol text, p_datestamp timestamp without time zone, p_inverval interval);
DROP FUNCTION trading_schema.pcalcanalysis(p_symbol text);
DROP EXTENSION plpgsql;
DROP SCHEMA trading_schema;
DROP SCHEMA public;
--
-- TOC entry 7 (class 2615 OID 19373)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2254 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 6 (class 2615 OID 19374)
-- Name: trading_schema; Type: SCHEMA; Schema: -; Owner: trading
--

CREATE SCHEMA trading_schema;


ALTER SCHEMA trading_schema OWNER TO trading;

--
-- TOC entry 214 (class 3079 OID 19375)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2256 (class 0 OID 0)
-- Dependencies: 214
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = trading_schema, pg_catalog;

--
-- TOC entry 237 (class 1255 OID 19736)
-- Name: pcalcanalysis(text); Type: FUNCTION; Schema: trading_schema; Owner: postgres
--

CREATE FUNCTION pcalcanalysis(p_symbol text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM trading_schema.pCalcSymbolAvg(p_symbol);
END;
$$;


ALTER FUNCTION trading_schema.pcalcanalysis(p_symbol text) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 19387)
-- Name: pcalcavg(text, timestamp without time zone, interval); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pcalcavg(p_symbol text, p_datestamp timestamp without time zone, p_inverval interval) RETURNS money
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_value							money;
BEGIN
	SELECT
		avg(q.open_price)
	INTO
		v_value
	FROM
		trading_schema.quote q
		INNER JOIN trading_schema.symbol s ON (s.id = q.symbol_id)	
	WHERE
		q.datestamp >= p_datestamp - p_interval
	AND
		q.datestamp <= p_datestamp
	;
	RETURN v_value;
END;
$$;


ALTER FUNCTION trading_schema.pcalcavg(p_symbol text, p_datestamp timestamp without time zone, p_inverval interval) OWNER TO trading;

--
-- TOC entry 229 (class 1255 OID 19388)
-- Name: pcalcsymbolavg(text); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pcalcsymbolavg(p_symbol text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_quote							RECORD;
BEGIN
	FOR v_quote IN
		SELECT
			q.datestamp
		FROM
			trading_schema.symbol s
			INNER JOIN trading_schema.quote q ON (s.id = q.symbol_id )
			LEFT OUTER JOIN trading_schema.a_moving_avg a_avg ON (q.id = a_avg.quote_id)
		WHERE
			s.name = p_symbol
		AND
			a_avg.quote_id IS NOT NULL
		ORDER BY
			q.datestamp ASC
	LOOP
		PERFORM trading_schema.pInsCalcMovingAvg(p_symbol, v_quote.datestamp);
		COMMIT;
	END LOOP;
END;
$$;


ALTER FUNCTION trading_schema.pcalcsymbolavg(p_symbol text) OWNER TO trading;

--
-- TOC entry 228 (class 1255 OID 19389)
-- Name: pinscalcmovingavg(text, timestamp without time zone); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinscalcmovingavg(p_symbol text, p_datestamp timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_2_days						money;
	v_5_days						money;
	v_9_days						money;
	v_15_days						money;
	v_21_days						money;
	v_29_days						money;
	v_73_days						money;
	v_91_days						money;
	v_121_days						money;
	v_189_days						money;
BEGIN
	-- Calcualte values
	SELECT * INTO v_2_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '1 day');
	SELECT * INTO v_5_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '5 days');
	SELECT * INTO v_9_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '9 days');
	SELECT * INTO v_15_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '15 days');
	SELECT * INTO v_21_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '21 days');
	SELECT * INTO v_29_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '29 days');
	SELECT * INTO v_73_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '73 days');
	SELECT * INTO v_91_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '91 days');
	SELECT * INTO v_121_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '121 days');
	SELECT * INTO v_189_days FROM trading_schema.pCalcAvg(p_symbol, p_datestamp, interval '189 days');
	-- Push data
	INSERT INTO
		a_moving_avg
	(
		days2,
		days5,
		days9,
		days15,
		days21,
		days29,
		days73,
		days91,
		days121,
		days189
	)
	VALUES
	(
		v_2_days,
		v_5_days,
		v_9_days,
		v_15_days,
		v_21_days,
		v_29_days,
		v_73_days,
		v_91_days,
		v_121_days,
		v_189_days
	)
	;
END;
$$;


ALTER FUNCTION trading_schema.pinscalcmovingavg(p_symbol text, p_datestamp timestamp without time zone) OWNER TO trading;

--
-- TOC entry 231 (class 1255 OID 19390)
-- Name: pinsentryactions(bigint, bigint, text, text, money, interval, money); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsentryactions(p_entry_strategy_id bigint, p_strategy_proposal_id bigint, p_action text, p_investment_type text, p_strike_price money, p_termination_interval interval, p_current_price money) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinsentryactions(p_entry_strategy_id bigint, p_strategy_proposal_id bigint, p_action text, p_investment_type text, p_strike_price money, p_termination_interval interval, p_current_price money) OWNER TO trading;

--
-- TOC entry 232 (class 1255 OID 19391)
-- Name: pinsentryexitstrategy(text, text); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsentryexitstrategy(p_entry_strategy_code text, p_exit_strategy_code text) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinsentryexitstrategy(p_entry_strategy_code text, p_exit_strategy_code text) OWNER TO trading;

--
-- TOC entry 233 (class 1255 OID 19392)
-- Name: pinsexitconditions(bigint, text, text, text, money); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsexitconditions(p_exit_strategy_id bigint, p_expression text, p_operator text, p_variable text, p_strike_price money) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinsexitconditions(p_exit_strategy_id bigint, p_expression text, p_operator text, p_variable text, p_strike_price money) OWNER TO trading;

--
-- TOC entry 234 (class 1255 OID 19393)
-- Name: pinsexitstrategy(bigint, bigint, timestamp without time zone, text, money); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsexitstrategy(p_symbol_id bigint, p_strategy_proposal_id bigint, p_datestamp timestamp without time zone, p_code text, p_strike_price money) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinsexitstrategy(p_symbol_id bigint, p_strategy_proposal_id bigint, p_datestamp timestamp without time zone, p_code text, p_strike_price money) OWNER TO trading;

--
-- TOC entry 235 (class 1255 OID 19394)
-- Name: pinsquote(text, timestamp without time zone, numeric, numeric, numeric, numeric, numeric, bigint); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsquote(p_symbol text, p_date timestamp without time zone, p_open_price numeric, p_high_price numeric, p_low_price numeric, p_close_price numeric, p_adj_close_price numeric, p_volume bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
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
			(SELECT id FROM trading_schema.symbol WHERE symbol=p_symbol),
			p_date,
			p_open_price,
			p_high_price,
			p_low_price,
			p_close_price,
			p_adj_close_price,
			p_volume
		);  
	
	SELECT
		*   
	INTO
		inserted_id
	FROM
		LASTVAL();

	RETURN inserted_id;
END;
$$;


ALTER FUNCTION trading_schema.pinsquote(p_symbol text, p_date timestamp without time zone, p_open_price numeric, p_high_price numeric, p_low_price numeric, p_close_price numeric, p_adj_close_price numeric, p_volume bigint) OWNER TO trading;

--
-- TOC entry 236 (class 1255 OID 19395)
-- Name: pinsstrategyproposal(text, bigint); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsstrategyproposal(p_symbol text, p_entry_strategy_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinsstrategyproposal(p_symbol text, p_entry_strategy_id bigint) OWNER TO trading;

--
-- TOC entry 230 (class 1255 OID 19396)
-- Name: pinssymbol(text, text, text); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinssymbol(p_exchange text, p_name text, p_symbol text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION trading_schema.pinssymbol(p_exchange text, p_name text, p_symbol text) OWNER TO trading;

--
-- TOC entry 173 (class 1259 OID 19397)
-- Name: moving_avg_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE moving_avg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE moving_avg_id_seq OWNER TO trading;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 19399)
-- Name: a_moving_avg; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE a_moving_avg (
    id bigint DEFAULT nextval('moving_avg_id_seq'::regclass) NOT NULL,
    quote_id bigint NOT NULL,
    day2 money NOT NULL,
    days5 money NOT NULL,
    days9 money NOT NULL,
    days15 money NOT NULL,
    days21 money NOT NULL,
    days29 money NOT NULL,
    days73 money NOT NULL,
    days91 money NOT NULL,
    days121 money NOT NULL,
    days189 money NOT NULL
);


ALTER TABLE a_moving_avg OWNER TO trading;

--
-- TOC entry 175 (class 1259 OID 19403)
-- Name: accepted_trades; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE accepted_trades (
    id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    date_closed timestamp without time zone
);


ALTER TABLE accepted_trades OWNER TO trading;

--
-- TOC entry 176 (class 1259 OID 19406)
-- Name: accepted_trades_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE accepted_trades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE accepted_trades_id_seq OWNER TO trading;

--
-- TOC entry 2257 (class 0 OID 0)
-- Dependencies: 176
-- Name: accepted_trades_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE accepted_trades_id_seq OWNED BY accepted_trades.id;


--
-- TOC entry 177 (class 1259 OID 19408)
-- Name: accumulation_distribution; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE accumulation_distribution (
    quote_id bigint NOT NULL,
    id bigint NOT NULL,
    accumulation_distribution numeric NOT NULL,
    momentum numeric NOT NULL
);


ALTER TABLE accumulation_distribution OWNER TO trading;

--
-- TOC entry 178 (class 1259 OID 19414)
-- Name: accumulation_distribution_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE accumulation_distribution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE accumulation_distribution_id_seq OWNER TO trading;

--
-- TOC entry 2258 (class 0 OID 0)
-- Dependencies: 178
-- Name: accumulation_distribution_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE accumulation_distribution_id_seq OWNED BY accumulation_distribution.id;


--
-- TOC entry 179 (class 1259 OID 19416)
-- Name: analysis; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE analysis (
    id bigint NOT NULL,
    date_of_prediction timestamp without time zone NOT NULL,
    start_date timestamp without time zone NOT NULL,
    expected_price money NOT NULL,
    end_date timestamp without time zone NOT NULL,
    symbol_id bigint NOT NULL,
    sw_version text
);


ALTER TABLE analysis OWNER TO trading;

--
-- TOC entry 180 (class 1259 OID 19422)
-- Name: analysis_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE analysis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE analysis_id_seq OWNER TO trading;

--
-- TOC entry 2259 (class 0 OID 0)
-- Dependencies: 180
-- Name: analysis_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE analysis_id_seq OWNED BY analysis.id;


--
-- TOC entry 181 (class 1259 OID 19424)
-- Name: entry_actions; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_actions (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    strike_price money NOT NULL,
    action text NOT NULL,
    investment_type text NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    termination_date timestamp without time zone
);


ALTER TABLE entry_actions OWNER TO trading;

--
-- TOC entry 182 (class 1259 OID 19430)
-- Name: entry_actions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entry_actions_id_seq OWNER TO trading;

--
-- TOC entry 2260 (class 0 OID 0)
-- Dependencies: 182
-- Name: entry_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_actions_id_seq OWNED BY entry_actions.id;


--
-- TOC entry 183 (class 1259 OID 19432)
-- Name: entry_actions_template; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_actions_template (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    action text NOT NULL,
    investment_type text NOT NULL,
    strike_price money NOT NULL,
    termination_interval interval
);


ALTER TABLE entry_actions_template OWNER TO trading;

--
-- TOC entry 184 (class 1259 OID 19438)
-- Name: entry_actions_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_actions_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entry_actions_template_id_seq OWNER TO trading;

--
-- TOC entry 2261 (class 0 OID 0)
-- Dependencies: 184
-- Name: entry_actions_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_actions_template_id_seq OWNED BY entry_actions_template.id;


--
-- TOC entry 185 (class 1259 OID 19440)
-- Name: entry_conditions; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_conditions (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    variable text NOT NULL,
    operator text NOT NULL,
    value text NOT NULL
);


ALTER TABLE entry_conditions OWNER TO trading;

--
-- TOC entry 186 (class 1259 OID 19446)
-- Name: entry_conditions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entry_conditions_id_seq OWNER TO trading;

--
-- TOC entry 2262 (class 0 OID 0)
-- Dependencies: 186
-- Name: entry_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_conditions_id_seq OWNED BY entry_conditions.id;


--
-- TOC entry 187 (class 1259 OID 19448)
-- Name: entry_exit_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_exit_strategy (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    exit_strategy_template_id bigint NOT NULL
);


ALTER TABLE entry_exit_strategy OWNER TO trading;

--
-- TOC entry 188 (class 1259 OID 19451)
-- Name: entry_exit_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_exit_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entry_exit_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2263 (class 0 OID 0)
-- Dependencies: 188
-- Name: entry_exit_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_exit_strategy_id_seq OWNED BY entry_exit_strategy.id;


--
-- TOC entry 189 (class 1259 OID 19453)
-- Name: entry_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_strategy (
    id bigint NOT NULL,
    name text NOT NULL,
    risk_level bigint NOT NULL,
    code text NOT NULL
);


ALTER TABLE entry_strategy OWNER TO trading;

--
-- TOC entry 190 (class 1259 OID 19459)
-- Name: entry_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entry_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2264 (class 0 OID 0)
-- Dependencies: 190
-- Name: entry_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_strategy_id_seq OWNED BY entry_strategy.id;


--
-- TOC entry 191 (class 1259 OID 19461)
-- Name: exchange; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exchange (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE exchange OWNER TO trading;

--
-- TOC entry 192 (class 1259 OID 19467)
-- Name: exchange_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exchange_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exchange_id_seq OWNER TO trading;

--
-- TOC entry 2265 (class 0 OID 0)
-- Dependencies: 192
-- Name: exchange_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exchange_id_seq OWNED BY exchange.id;


--
-- TOC entry 193 (class 1259 OID 19469)
-- Name: exit_conditions; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_conditions (
    id bigint NOT NULL,
    exit_strategy_id bigint NOT NULL,
    variable text NOT NULL,
    value text NOT NULL,
    operator text NOT NULL
);


ALTER TABLE exit_conditions OWNER TO trading;

--
-- TOC entry 194 (class 1259 OID 19475)
-- Name: exit_conditions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exit_conditions_id_seq OWNER TO trading;

--
-- TOC entry 2266 (class 0 OID 0)
-- Dependencies: 194
-- Name: exit_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_conditions_id_seq OWNED BY exit_conditions.id;


--
-- TOC entry 195 (class 1259 OID 19477)
-- Name: exit_conditions_template; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_conditions_template (
    id bigint NOT NULL,
    exit_strategy_template_id bigint NOT NULL,
    expression text NOT NULL,
    operator text NOT NULL,
    variable text NOT NULL
);


ALTER TABLE exit_conditions_template OWNER TO trading;

--
-- TOC entry 196 (class 1259 OID 19483)
-- Name: exit_conditions_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_conditions_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exit_conditions_template_id_seq OWNER TO trading;

--
-- TOC entry 2267 (class 0 OID 0)
-- Dependencies: 196
-- Name: exit_conditions_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_conditions_template_id_seq OWNED BY exit_conditions_template.id;


--
-- TOC entry 197 (class 1259 OID 19485)
-- Name: exit_proposal; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_proposal (
    id bigint NOT NULL,
    exit_strategy_id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    accepted_datestamp timestamp without time zone NOT NULL
);


ALTER TABLE exit_proposal OWNER TO trading;

--
-- TOC entry 198 (class 1259 OID 19488)
-- Name: exit_proposal_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_proposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exit_proposal_id_seq OWNER TO trading;

--
-- TOC entry 2268 (class 0 OID 0)
-- Dependencies: 198
-- Name: exit_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_proposal_id_seq OWNED BY exit_proposal.id;


--
-- TOC entry 199 (class 1259 OID 19490)
-- Name: exit_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_strategy (
    id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL,
    code text NOT NULL
);


ALTER TABLE exit_strategy OWNER TO trading;

--
-- TOC entry 200 (class 1259 OID 19496)
-- Name: exit_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exit_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2269 (class 0 OID 0)
-- Dependencies: 200
-- Name: exit_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_strategy_id_seq OWNED BY exit_strategy.id;


--
-- TOC entry 201 (class 1259 OID 19498)
-- Name: exit_strategy_template; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_strategy_template (
    id bigint NOT NULL,
    name text NOT NULL,
    code text NOT NULL
);


ALTER TABLE exit_strategy_template OWNER TO trading;

--
-- TOC entry 202 (class 1259 OID 19504)
-- Name: exit_strategy_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_strategy_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exit_strategy_template_id_seq OWNER TO trading;

--
-- TOC entry 2270 (class 0 OID 0)
-- Dependencies: 202
-- Name: exit_strategy_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_strategy_template_id_seq OWNED BY exit_strategy_template.id;


--
-- TOC entry 203 (class 1259 OID 19506)
-- Name: moving_average; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE moving_average (
    quote_id bigint NOT NULL,
    id bigint NOT NULL,
    seven_days numeric NOT NULL,
    fourteen_days numeric NOT NULL,
    twenty_one_days numeric NOT NULL,
    twenty_eight_days numeric NOT NULL,
    fourty_eight_days numeric NOT NULL,
    ninety_days numeric NOT NULL
);


ALTER TABLE moving_average OWNER TO trading;

--
-- TOC entry 204 (class 1259 OID 19512)
-- Name: moving_average_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE moving_average_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE moving_average_id_seq OWNER TO trading;

--
-- TOC entry 2271 (class 0 OID 0)
-- Dependencies: 204
-- Name: moving_average_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE moving_average_id_seq OWNED BY moving_average.id;


--
-- TOC entry 205 (class 1259 OID 19514)
-- Name: processing; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE processing (
    id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL
);


ALTER TABLE processing OWNER TO trading;

--
-- TOC entry 206 (class 1259 OID 19517)
-- Name: processing_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE processing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE processing_id_seq OWNER TO trading;

--
-- TOC entry 2272 (class 0 OID 0)
-- Dependencies: 206
-- Name: processing_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE processing_id_seq OWNED BY processing.id;


--
-- TOC entry 207 (class 1259 OID 19519)
-- Name: quote; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE quote (
    id bigint NOT NULL,
    symbol_id bigint,
    datestamp timestamp without time zone NOT NULL,
    volume bigint NOT NULL,
    adjusted_close_price numeric NOT NULL,
    open_price numeric NOT NULL,
    close_price numeric NOT NULL,
    high_price numeric NOT NULL,
    low_price numeric NOT NULL
);


ALTER TABLE quote OWNER TO trading;

--
-- TOC entry 213 (class 1259 OID 19737)
-- Name: quote_diff; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE quote_diff (
    quote_id bigint NOT NULL,
    diff_close_price money NOT NULL,
    diff_high_price money NOT NULL,
    diff_low_price money NOT NULL,
    diff_open_price money NOT NULL
);


ALTER TABLE quote_diff OWNER TO trading;

--
-- TOC entry 208 (class 1259 OID 19525)
-- Name: quote_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE quote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE quote_id_seq OWNER TO trading;

--
-- TOC entry 2273 (class 0 OID 0)
-- Dependencies: 208
-- Name: quote_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE quote_id_seq OWNED BY quote.id;


--
-- TOC entry 209 (class 1259 OID 19527)
-- Name: strategy_proposal; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE strategy_proposal (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL
);


ALTER TABLE strategy_proposal OWNER TO trading;

--
-- TOC entry 210 (class 1259 OID 19530)
-- Name: strategy_proposal_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE strategy_proposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE strategy_proposal_id_seq OWNER TO trading;

--
-- TOC entry 2274 (class 0 OID 0)
-- Dependencies: 210
-- Name: strategy_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE strategy_proposal_id_seq OWNED BY strategy_proposal.id;


--
-- TOC entry 211 (class 1259 OID 19532)
-- Name: symbol; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE symbol (
    id bigint NOT NULL,
    exchange_id bigint NOT NULL,
    name text NOT NULL,
    symbol text NOT NULL
);


ALTER TABLE symbol OWNER TO trading;

--
-- TOC entry 212 (class 1259 OID 19538)
-- Name: symbol_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE symbol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE symbol_id_seq OWNER TO trading;

--
-- TOC entry 2275 (class 0 OID 0)
-- Dependencies: 212
-- Name: symbol_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE symbol_id_seq OWNED BY symbol.id;


--
-- TOC entry 2030 (class 2604 OID 19540)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accepted_trades ALTER COLUMN id SET DEFAULT nextval('accepted_trades_id_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 19541)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accumulation_distribution ALTER COLUMN id SET DEFAULT nextval('accumulation_distribution_id_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 19542)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY analysis ALTER COLUMN id SET DEFAULT nextval('analysis_id_seq'::regclass);


--
-- TOC entry 2033 (class 2604 OID 19543)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions ALTER COLUMN id SET DEFAULT nextval('entry_actions_id_seq'::regclass);


--
-- TOC entry 2034 (class 2604 OID 19544)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions_template ALTER COLUMN id SET DEFAULT nextval('entry_actions_template_id_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 19545)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_conditions ALTER COLUMN id SET DEFAULT nextval('entry_conditions_id_seq'::regclass);


--
-- TOC entry 2036 (class 2604 OID 19546)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy ALTER COLUMN id SET DEFAULT nextval('entry_exit_strategy_id_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 19547)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_strategy ALTER COLUMN id SET DEFAULT nextval('entry_strategy_id_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 19548)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exchange ALTER COLUMN id SET DEFAULT nextval('exchange_id_seq'::regclass);


--
-- TOC entry 2039 (class 2604 OID 19549)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions ALTER COLUMN id SET DEFAULT nextval('exit_conditions_id_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 19550)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions_template ALTER COLUMN id SET DEFAULT nextval('exit_conditions_template_id_seq'::regclass);


--
-- TOC entry 2041 (class 2604 OID 19551)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal ALTER COLUMN id SET DEFAULT nextval('exit_proposal_id_seq'::regclass);


--
-- TOC entry 2042 (class 2604 OID 19552)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy ALTER COLUMN id SET DEFAULT nextval('exit_strategy_id_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 19553)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy_template ALTER COLUMN id SET DEFAULT nextval('exit_strategy_template_id_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 19554)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY moving_average ALTER COLUMN id SET DEFAULT nextval('moving_average_id_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 19555)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY processing ALTER COLUMN id SET DEFAULT nextval('processing_id_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 19556)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY quote ALTER COLUMN id SET DEFAULT nextval('quote_id_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 19557)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal ALTER COLUMN id SET DEFAULT nextval('strategy_proposal_id_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 19558)
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY symbol ALTER COLUMN id SET DEFAULT nextval('symbol_id_seq'::regclass);


--
-- TOC entry 2052 (class 2606 OID 19560)
-- Name: pk_accepted_trades; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY accepted_trades
    ADD CONSTRAINT pk_accepted_trades PRIMARY KEY (id);


--
-- TOC entry 2056 (class 2606 OID 19562)
-- Name: pk_accumulation_distribution; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY accumulation_distribution
    ADD CONSTRAINT pk_accumulation_distribution PRIMARY KEY (id);


--
-- TOC entry 2058 (class 2606 OID 19564)
-- Name: pk_analysis; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT pk_analysis PRIMARY KEY (id);


--
-- TOC entry 2062 (class 2606 OID 19566)
-- Name: pk_entry_actions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT pk_entry_actions PRIMARY KEY (id);


--
-- TOC entry 2064 (class 2606 OID 19568)
-- Name: pk_entry_actions_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_actions_template
    ADD CONSTRAINT pk_entry_actions_template PRIMARY KEY (id);


--
-- TOC entry 2066 (class 2606 OID 19570)
-- Name: pk_entry_conditions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_conditions
    ADD CONSTRAINT pk_entry_conditions PRIMARY KEY (id);


--
-- TOC entry 2068 (class 2606 OID 19572)
-- Name: pk_entry_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT pk_entry_exit_strategy PRIMARY KEY (id);


--
-- TOC entry 2070 (class 2606 OID 19574)
-- Name: pk_entry_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_strategy
    ADD CONSTRAINT pk_entry_strategy PRIMARY KEY (id);


--
-- TOC entry 2074 (class 2606 OID 19576)
-- Name: pk_exchange; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exchange
    ADD CONSTRAINT pk_exchange PRIMARY KEY (id);


--
-- TOC entry 2076 (class 2606 OID 19578)
-- Name: pk_exit_conditions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_conditions
    ADD CONSTRAINT pk_exit_conditions PRIMARY KEY (id);


--
-- TOC entry 2078 (class 2606 OID 19580)
-- Name: pk_exit_conditions_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_conditions_template
    ADD CONSTRAINT pk_exit_conditions_template PRIMARY KEY (id);


--
-- TOC entry 2080 (class 2606 OID 19582)
-- Name: pk_exit_proposal; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT pk_exit_proposal PRIMARY KEY (id);


--
-- TOC entry 2084 (class 2606 OID 19584)
-- Name: pk_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT pk_exit_strategy PRIMARY KEY (id);


--
-- TOC entry 2088 (class 2606 OID 19586)
-- Name: pk_exit_strategy_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy_template
    ADD CONSTRAINT pk_exit_strategy_template PRIMARY KEY (id);


--
-- TOC entry 2097 (class 2606 OID 19588)
-- Name: pk_moving_average; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY moving_average
    ADD CONSTRAINT pk_moving_average PRIMARY KEY (id);


--
-- TOC entry 2050 (class 2606 OID 19590)
-- Name: pk_moving_avg; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY a_moving_avg
    ADD CONSTRAINT pk_moving_avg PRIMARY KEY (id);


--
-- TOC entry 2099 (class 2606 OID 19592)
-- Name: pk_processing; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT pk_processing PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 19741)
-- Name: pk_quote_diff; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY quote_diff
    ADD CONSTRAINT pk_quote_diff PRIMARY KEY (quote_id);


--
-- TOC entry 2103 (class 2606 OID 19594)
-- Name: pk_quote_id; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT pk_quote_id PRIMARY KEY (id);


--
-- TOC entry 2107 (class 2606 OID 19596)
-- Name: pk_strategy_proposal; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT pk_strategy_proposal PRIMARY KEY (id);


--
-- TOC entry 2112 (class 2606 OID 19598)
-- Name: pk_symbol; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT pk_symbol PRIMARY KEY (id);


--
-- TOC entry 2082 (class 2606 OID 19600)
-- Name: u_exit_proposal_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT u_exit_proposal_1 UNIQUE (exit_strategy_id, strategy_proposal_id, accepted_datestamp);


--
-- TOC entry 2086 (class 2606 OID 19602)
-- Name: u_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT u_exit_strategy UNIQUE (strategy_proposal_id, datestamp, symbol_id);


--
-- TOC entry 2060 (class 2606 OID 19604)
-- Name: uc_analysis_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT uc_analysis_1 UNIQUE (date_of_prediction, symbol_id);


--
-- TOC entry 2105 (class 2606 OID 19606)
-- Name: uc_quote_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT uc_quote_1 UNIQUE (symbol_id, datestamp);


--
-- TOC entry 2114 (class 2606 OID 19608)
-- Name: uc_symbol; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT uc_symbol UNIQUE (symbol);


--
-- TOC entry 2053 (class 1259 OID 19609)
-- Name: fki_accumulation_distribution_quote; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_accumulation_distribution_quote ON accumulation_distribution USING btree (quote_id);


--
-- TOC entry 2089 (class 1259 OID 19610)
-- Name: fki_moving_average_quote; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_moving_average_quote ON moving_average USING btree (quote_id);


--
-- TOC entry 2108 (class 1259 OID 19611)
-- Name: fki_symbol_exchange_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_symbol_exchange_id ON symbol USING btree (exchange_id);


--
-- TOC entry 2054 (class 1259 OID 19612)
-- Name: idx_accumulation_distribution; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_accumulation_distribution ON accumulation_distribution USING btree (accumulation_distribution);


--
-- TOC entry 2071 (class 1259 OID 19613)
-- Name: idx_exchange_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_exchange_id ON exchange USING btree (id);


--
-- TOC entry 2072 (class 1259 OID 19614)
-- Name: idx_exchange_name; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE UNIQUE INDEX idx_exchange_name ON exchange USING btree (name);


--
-- TOC entry 2090 (class 1259 OID 19615)
-- Name: idx_fourteen; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_fourteen ON moving_average USING btree (fourteen_days);


--
-- TOC entry 2091 (class 1259 OID 19616)
-- Name: idx_fourty_eight; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_fourty_eight ON moving_average USING btree (fourty_eight_days);


--
-- TOC entry 2092 (class 1259 OID 19617)
-- Name: idx_ninety; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_ninety ON moving_average USING btree (ninety_days);


--
-- TOC entry 2100 (class 1259 OID 19618)
-- Name: idx_quote_datestamp; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_quote_datestamp ON quote USING btree (datestamp);


--
-- TOC entry 2093 (class 1259 OID 19619)
-- Name: idx_seven; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_seven ON moving_average USING btree (seven_days);


--
-- TOC entry 2101 (class 1259 OID 19620)
-- Name: idx_symbol_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_id ON quote USING btree (symbol_id NULLS FIRST);


--
-- TOC entry 2109 (class 1259 OID 19621)
-- Name: idx_symbol_name; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_name ON symbol USING btree (name);


--
-- TOC entry 2110 (class 1259 OID 19622)
-- Name: idx_symbol_symbol; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_symbol ON symbol USING btree (symbol);


--
-- TOC entry 2094 (class 1259 OID 19623)
-- Name: idx_twenty_eight; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_twenty_eight ON moving_average USING btree (twenty_eight_days);


--
-- TOC entry 2095 (class 1259 OID 19624)
-- Name: idx_twenty_one; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_twenty_one ON moving_average USING btree (twenty_one_days);


--
-- TOC entry 2121 (class 2606 OID 19625)
-- Name: entry_actions_entry_strategy_id_fkey; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT entry_actions_entry_strategy_id_fkey FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2139 (class 2606 OID 19742)
-- Name: fk1_quote_diff; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY quote_diff
    ADD CONSTRAINT fk1_quote_diff FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2118 (class 2606 OID 19630)
-- Name: fk_accepted_trades_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accepted_trades
    ADD CONSTRAINT fk_accepted_trades_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2119 (class 2606 OID 19635)
-- Name: fk_accumulation_distribution_quote; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accumulation_distribution
    ADD CONSTRAINT fk_accumulation_distribution_quote FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2120 (class 2606 OID 19640)
-- Name: fk_analysis_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT fk_analysis_1 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2123 (class 2606 OID 19645)
-- Name: fk_entry_actions_template_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions_template
    ADD CONSTRAINT fk_entry_actions_template_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2124 (class 2606 OID 19650)
-- Name: fk_entry_conditions_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_conditions
    ADD CONSTRAINT fk_entry_conditions_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2125 (class 2606 OID 19655)
-- Name: fk_entry_exit_strategy_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT fk_entry_exit_strategy_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2126 (class 2606 OID 19660)
-- Name: fk_entry_exit_strategy_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT fk_entry_exit_strategy_2 FOREIGN KEY (exit_strategy_template_id) REFERENCES exit_strategy_template(id);


--
-- TOC entry 2127 (class 2606 OID 19665)
-- Name: fk_exit_conditions; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions
    ADD CONSTRAINT fk_exit_conditions FOREIGN KEY (exit_strategy_id) REFERENCES exit_strategy(id);


--
-- TOC entry 2128 (class 2606 OID 19670)
-- Name: fk_exit_conditions_template; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions_template
    ADD CONSTRAINT fk_exit_conditions_template FOREIGN KEY (exit_strategy_template_id) REFERENCES exit_strategy_template(id);


--
-- TOC entry 2129 (class 2606 OID 19675)
-- Name: fk_exit_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT fk_exit_proposal_1 FOREIGN KEY (exit_strategy_id) REFERENCES exit_strategy(id);


--
-- TOC entry 2130 (class 2606 OID 19680)
-- Name: fk_exit_proposal_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT fk_exit_proposal_2 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2131 (class 2606 OID 19685)
-- Name: fk_exit_strategy_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT fk_exit_strategy_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2132 (class 2606 OID 19690)
-- Name: fk_exit_strategy_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT fk_exit_strategy_2 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2133 (class 2606 OID 19695)
-- Name: fk_moving_average_quote; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY moving_average
    ADD CONSTRAINT fk_moving_average_quote FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2117 (class 2606 OID 19700)
-- Name: fk_moving_avg_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY a_moving_avg
    ADD CONSTRAINT fk_moving_avg_1 FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2134 (class 2606 OID 19705)
-- Name: fk_processing_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT fk_processing_1 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2135 (class 2606 OID 19710)
-- Name: fk_quote_symbol_id; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT fk_quote_symbol_id FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2136 (class 2606 OID 19715)
-- Name: fk_strategy_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT fk_strategy_proposal_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2122 (class 2606 OID 19720)
-- Name: fk_strategy_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT fk_strategy_proposal_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2137 (class 2606 OID 19725)
-- Name: fk_strategy_proposal_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT fk_strategy_proposal_2 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2138 (class 2606 OID 19730)
-- Name: fk_symbol_exchange_id; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT fk_symbol_exchange_id FOREIGN KEY (exchange_id) REFERENCES exchange(id);


--
-- TOC entry 2255 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-02-05 22:23:17 GMT

--
-- PostgreSQL database dump complete
--

