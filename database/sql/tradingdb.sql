--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.16
-- Dumped by pg_dump version 9.1.16
-- Started on 2015-08-20 19:20:20 BST

SET statement_timeout = 0;
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
SET search_path = public, pg_catalog;

DROP FUNCTION public.moving_average_calculation_insert(security_symbol text, start_date timestamp without time zone);
DROP FUNCTION public.moving_average_calculation(symbol_name text, start date, period interval);
DROP FUNCTION public.calculation_insert(security_symbol text, start_date timestamp without time zone);
DROP FUNCTION public.calculate_for_symbol(security_symbol text, start_date timestamp without time zone, end_date timestamp without time zone);
DROP FUNCTION public.calculate_dates_for_all_symbols(start_date timestamp without time zone, end_date timestamp without time zone);
DROP FUNCTION public.accumulation_distribution_calculation_select(symbol_name text, start date);
DROP FUNCTION public.accumulation_distribution_calculation_insert(security_symbol text, start_date timestamp without time zone);
DROP EXTENSION plpgsql;
DROP SCHEMA trading_schema;
DROP SCHEMA public;
--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2143 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 7 (class 2615 OID 16569)
-- Name: trading_schema; Type: SCHEMA; Schema: -; Owner: trading
--

CREATE SCHEMA trading_schema;


ALTER SCHEMA trading_schema OWNER TO trading;

--
-- TOC entry 202 (class 3079 OID 11677)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2145 (class 0 OID 0)
-- Dependencies: 202
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 220 (class 1255 OID 17187)
-- Dependencies: 5 634
-- Name: accumulation_distribution_calculation_insert(text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION accumulation_distribution_calculation_insert(security_symbol text, start_date timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO tradingdb.trading_schema.accumulation_distribution(quote_id, accumulation_distribution, momentum) VALUES (
		(SELECT id FROM tradingdb.trading_schema.quote WHERE datestamp = start_date),
		accumulation_distribution_calculation_select(security_symbol, start_date::date),
		momentum_calculation_select (security_symbol, start_date::date));
	RETURN;
END; $$;


ALTER FUNCTION public.accumulation_distribution_calculation_insert(security_symbol text, start_date timestamp without time zone) OWNER TO trading;

--
-- TOC entry 219 (class 1255 OID 17137)
-- Dependencies: 5 634
-- Name: accumulation_distribution_calculation_select(text, date); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION accumulation_distribution_calculation_select(symbol_name text, start date) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
	momemtum numeric;
BEGIN
	-- Calculate new accumulation value
	momemtum := ((((NEW.close - NEW.low) - (NEW.high - NEW.close))* NEW.volume )/(NEW.high - NEW.low));
RETURN momemtum;

END $$;


ALTER FUNCTION public.accumulation_distribution_calculation_select(symbol_name text, start date) OWNER TO trading;

--
-- TOC entry 214 (class 1255 OID 17120)
-- Dependencies: 5 634
-- Name: calculate_dates_for_all_symbols(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION calculate_dates_for_all_symbols(start_date timestamp without time zone, end_date timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    security_symbol TEXT;
BEGIN

	FOR security_symbol IN SELECT symbol FROM tradingdb.trading_schema.symbol ORDER BY symbol ASC LOOP
		-- Call the function
		EXECUTE calculate_for_symbol (security_symbol::text, start_date::timestamp without time zone, end_date::timestamp without time zone);
	END LOOP;

	RETURN;
END;
$$;


ALTER FUNCTION public.calculate_dates_for_all_symbols(start_date timestamp without time zone, end_date timestamp without time zone) OWNER TO trading;

--
-- TOC entry 215 (class 1255 OID 17119)
-- Dependencies: 634 5
-- Name: calculate_for_symbol(text, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION calculate_for_symbol(security_symbol text, start_date timestamp without time zone, end_date timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    date_input timestamp without time zone;
BEGIN

	FOR date_input IN SELECT tradingdb.trading_schema.quote.datestamp FROM tradingdb.trading_schema.quote
		INNER JOIN tradingdb.trading_schema.symbol ON (tradingdb.trading_schema.quote.symbol_id = tradingdb.trading_schema.symbol.id)
		WHERE tradingdb.trading_schema.symbol.symbol = security_symbol ORDER BY datestamp ASC LOOP

		-- Call the function
		EXECUTE calculation_insert (security_symbol::text, date_input::timestamp without time zone);
	END LOOP;

	RETURN;
END;
$$;


ALTER FUNCTION public.calculate_for_symbol(security_symbol text, start_date timestamp without time zone, end_date timestamp without time zone) OWNER TO trading;

--
-- TOC entry 218 (class 1255 OID 17116)
-- Dependencies: 5 634
-- Name: calculation_insert(text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION calculation_insert(security_symbol text, start_date timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM moving_average_calculation_insert (security_symbol, start_date);
	PERFORM accumulation_distribution_calculation_insert (security_symbol, start_date);
END; $$;


ALTER FUNCTION public.calculation_insert(security_symbol text, start_date timestamp without time zone) OWNER TO trading;

--
-- TOC entry 216 (class 1255 OID 17111)
-- Dependencies: 5 634
-- Name: moving_average_calculation(text, date, interval); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION moving_average_calculation(symbol_name text, start date, period interval) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
	average numeric;
BEGIN

average := avg(close) FROM tradingdb.trading_schema.quote INNER JOIN tradingdb.trading_schema.symbol ON (quote.symbol_id = symbol.id)
WHERE symbol.symbol = symbol_name AND quote.datestamp 
BETWEEN (start - period::interval) AND start;

RETURN average;

END $$;


ALTER FUNCTION public.moving_average_calculation(symbol_name text, start date, period interval) OWNER TO trading;

--
-- TOC entry 217 (class 1255 OID 17114)
-- Dependencies: 5 634
-- Name: moving_average_calculation_insert(text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: trading
--

CREATE FUNCTION moving_average_calculation_insert(security_symbol text, start_date timestamp without time zone) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO tradingdb.trading_schema.moving_average(quote_id, seven_days, fourteen_days, twenty_one_days, twenty_eight_days, fourty_eight_days, ninety_days)
VALUES (
		(SELECT id FROM tradingdb.trading_schema.quote WHERE datestamp = start_date),
		 moving_average_calculation_select(security_symbol, start_date::date, '7 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '14 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '21 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '28 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '48 days'::interval),
		 moving_average_calculation_select(security_symbol, start_date::date, '90 days'::interval));
	RETURN;
END; $$;


ALTER FUNCTION public.moving_average_calculation_insert(security_symbol text, start_date timestamp without time zone) OWNER TO trading;

SET search_path = trading_schema, pg_catalog;

--
-- TOC entry 228 (class 1255 OID 26373)
-- Dependencies: 7 634
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
-- TOC entry 230 (class 1255 OID 26375)
-- Dependencies: 7 634
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
		AND
			a_avg.datestamp IS NOT NULL
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
-- TOC entry 229 (class 1255 OID 26374)
-- Dependencies: 634 7
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
-- TOC entry 225 (class 1255 OID 26268)
-- Dependencies: 634 7
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
-- TOC entry 226 (class 1255 OID 26321)
-- Dependencies: 7 634
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
-- TOC entry 223 (class 1255 OID 26325)
-- Dependencies: 7 634
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
-- TOC entry 227 (class 1255 OID 26328)
-- Dependencies: 634 7
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
-- TOC entry 222 (class 1255 OID 26186)
-- Dependencies: 634 7
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
-- TOC entry 224 (class 1255 OID 26270)
-- Dependencies: 634 7
-- Name: pinsstrategyproposal(text, bigint); Type: FUNCTION; Schema: trading_schema; Owner: trading
--

CREATE FUNCTION pinsstrategyproposal(p_symbol text, p_entry_strategy_id bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_current_price			money;
	v_strategy_proposal_id	trading_schema.entrance_strategy.id%TYPE;
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
BEGIN
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
		datestamp = current_date - interval '1 day'
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
			current_date
		)
	;
	-- Get the ID
	SELECT
		*   
	INTO
		v_strategy_proposal_id
	FROM
		LASTVAL();
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
END;
$$;


ALTER FUNCTION trading_schema.pinsstrategyproposal(p_symbol text, p_entry_strategy_id bigint) OWNER TO trading;

--
-- TOC entry 221 (class 1255 OID 25949)
-- Dependencies: 634 7
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
-- TOC entry 200 (class 1259 OID 26360)
-- Dependencies: 7
-- Name: moving_avg_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE moving_avg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.moving_avg_id_seq OWNER TO trading;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 201 (class 1259 OID 26362)
-- Dependencies: 1948 7
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


ALTER TABLE trading_schema.a_moving_avg OWNER TO trading;

--
-- TOC entry 189 (class 1259 OID 26127)
-- Dependencies: 7
-- Name: accepted_trades; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE accepted_trades (
    id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    date_closed timestamp without time zone
);


ALTER TABLE trading_schema.accepted_trades OWNER TO trading;

--
-- TOC entry 188 (class 1259 OID 26125)
-- Dependencies: 7 189
-- Name: accepted_trades_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE accepted_trades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.accepted_trades_id_seq OWNER TO trading;

--
-- TOC entry 2146 (class 0 OID 0)
-- Dependencies: 188
-- Name: accepted_trades_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE accepted_trades_id_seq OWNED BY accepted_trades.id;


--
-- TOC entry 171 (class 1259 OID 17164)
-- Dependencies: 7
-- Name: accumulation_distribution; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE accumulation_distribution (
    quote_id bigint NOT NULL,
    id bigint NOT NULL,
    accumulation_distribution numeric NOT NULL,
    momentum numeric NOT NULL
);


ALTER TABLE trading_schema.accumulation_distribution OWNER TO trading;

--
-- TOC entry 170 (class 1259 OID 17162)
-- Dependencies: 7 171
-- Name: accumulation_distribution_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE accumulation_distribution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.accumulation_distribution_id_seq OWNER TO trading;

--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 170
-- Name: accumulation_distribution_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE accumulation_distribution_id_seq OWNED BY accumulation_distribution.id;


--
-- TOC entry 173 (class 1259 OID 25953)
-- Dependencies: 7
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


ALTER TABLE trading_schema.analysis OWNER TO trading;

--
-- TOC entry 172 (class 1259 OID 25951)
-- Dependencies: 7 173
-- Name: analysis_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE analysis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.analysis_id_seq OWNER TO trading;

--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 172
-- Name: analysis_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE analysis_id_seq OWNED BY analysis.id;


--
-- TOC entry 179 (class 1259 OID 25997)
-- Dependencies: 7
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


ALTER TABLE trading_schema.entry_actions OWNER TO trading;

--
-- TOC entry 178 (class 1259 OID 25995)
-- Dependencies: 7 179
-- Name: entry_actions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.entry_actions_id_seq OWNER TO trading;

--
-- TOC entry 2149 (class 0 OID 0)
-- Dependencies: 178
-- Name: entry_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_actions_id_seq OWNED BY entry_actions.id;


--
-- TOC entry 193 (class 1259 OID 26189)
-- Dependencies: 7
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


ALTER TABLE trading_schema.entry_actions_template OWNER TO trading;

--
-- TOC entry 192 (class 1259 OID 26187)
-- Dependencies: 193 7
-- Name: entry_actions_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_actions_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.entry_actions_template_id_seq OWNER TO trading;

--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 192
-- Name: entry_actions_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_actions_template_id_seq OWNED BY entry_actions_template.id;


--
-- TOC entry 191 (class 1259 OID 26150)
-- Dependencies: 7
-- Name: entry_conditions; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_conditions (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    variable text NOT NULL,
    operator text NOT NULL,
    value text NOT NULL
);


ALTER TABLE trading_schema.entry_conditions OWNER TO trading;

--
-- TOC entry 190 (class 1259 OID 26148)
-- Dependencies: 7 191
-- Name: entry_conditions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.entry_conditions_id_seq OWNER TO trading;

--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 190
-- Name: entry_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_conditions_id_seq OWNED BY entry_conditions.id;


--
-- TOC entry 197 (class 1259 OID 26273)
-- Dependencies: 7
-- Name: entry_exit_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_exit_strategy (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    exit_strategy_template_id bigint NOT NULL
);


ALTER TABLE trading_schema.entry_exit_strategy OWNER TO trading;

--
-- TOC entry 196 (class 1259 OID 26271)
-- Dependencies: 7 197
-- Name: entry_exit_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_exit_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.entry_exit_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 196
-- Name: entry_exit_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_exit_strategy_id_seq OWNED BY entry_exit_strategy.id;


--
-- TOC entry 177 (class 1259 OID 25986)
-- Dependencies: 7
-- Name: entry_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE entry_strategy (
    id bigint NOT NULL,
    name text NOT NULL,
    risk_level bigint NOT NULL,
    code text NOT NULL
);


ALTER TABLE trading_schema.entry_strategy OWNER TO trading;

--
-- TOC entry 176 (class 1259 OID 25984)
-- Dependencies: 7 177
-- Name: entry_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE entry_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.entry_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 176
-- Name: entry_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE entry_strategy_id_seq OWNED BY entry_strategy.id;


--
-- TOC entry 163 (class 1259 OID 16572)
-- Dependencies: 7
-- Name: exchange; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exchange (
    id bigint NOT NULL,
    name text NOT NULL
);


ALTER TABLE trading_schema.exchange OWNER TO trading;

--
-- TOC entry 162 (class 1259 OID 16570)
-- Dependencies: 7 163
-- Name: exchange_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exchange_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exchange_id_seq OWNER TO trading;

--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 162
-- Name: exchange_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exchange_id_seq OWNED BY exchange.id;


--
-- TOC entry 183 (class 1259 OID 26079)
-- Dependencies: 7
-- Name: exit_conditions; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_conditions (
    id bigint NOT NULL,
    exit_strategy_id bigint NOT NULL,
    variable text NOT NULL,
    value text NOT NULL,
    operator text NOT NULL
);


ALTER TABLE trading_schema.exit_conditions OWNER TO trading;

--
-- TOC entry 182 (class 1259 OID 26077)
-- Dependencies: 183 7
-- Name: exit_conditions_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exit_conditions_id_seq OWNER TO trading;

--
-- TOC entry 2155 (class 0 OID 0)
-- Dependencies: 182
-- Name: exit_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_conditions_id_seq OWNED BY exit_conditions.id;


--
-- TOC entry 186 (class 1259 OID 26106)
-- Dependencies: 7
-- Name: exit_conditions_template; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_conditions_template (
    id bigint NOT NULL,
    exit_strategy_template_id bigint NOT NULL,
    expression text NOT NULL,
    operator text NOT NULL,
    variable text NOT NULL
);


ALTER TABLE trading_schema.exit_conditions_template OWNER TO trading;

--
-- TOC entry 187 (class 1259 OID 26109)
-- Dependencies: 186 7
-- Name: exit_conditions_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_conditions_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exit_conditions_template_id_seq OWNER TO trading;

--
-- TOC entry 2156 (class 0 OID 0)
-- Dependencies: 187
-- Name: exit_conditions_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_conditions_template_id_seq OWNED BY exit_conditions_template.id;


--
-- TOC entry 199 (class 1259 OID 26296)
-- Dependencies: 7
-- Name: exit_proposal; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_proposal (
    id bigint NOT NULL,
    exit_strategy_id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    accepted_datestamp timestamp without time zone NOT NULL
);


ALTER TABLE trading_schema.exit_proposal OWNER TO trading;

--
-- TOC entry 198 (class 1259 OID 26294)
-- Dependencies: 7 199
-- Name: exit_proposal_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_proposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exit_proposal_id_seq OWNER TO trading;

--
-- TOC entry 2157 (class 0 OID 0)
-- Dependencies: 198
-- Name: exit_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_proposal_id_seq OWNED BY exit_proposal.id;


--
-- TOC entry 181 (class 1259 OID 26057)
-- Dependencies: 7
-- Name: exit_strategy; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_strategy (
    id bigint NOT NULL,
    strategy_proposal_id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL,
    code text NOT NULL
);


ALTER TABLE trading_schema.exit_strategy OWNER TO trading;

--
-- TOC entry 180 (class 1259 OID 26055)
-- Dependencies: 181 7
-- Name: exit_strategy_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_strategy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exit_strategy_id_seq OWNER TO trading;

--
-- TOC entry 2158 (class 0 OID 0)
-- Dependencies: 180
-- Name: exit_strategy_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_strategy_id_seq OWNED BY exit_strategy.id;


--
-- TOC entry 185 (class 1259 OID 26095)
-- Dependencies: 7
-- Name: exit_strategy_template; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE exit_strategy_template (
    id bigint NOT NULL,
    name text NOT NULL,
    code text NOT NULL
);


ALTER TABLE trading_schema.exit_strategy_template OWNER TO trading;

--
-- TOC entry 184 (class 1259 OID 26093)
-- Dependencies: 7 185
-- Name: exit_strategy_template_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE exit_strategy_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.exit_strategy_template_id_seq OWNER TO trading;

--
-- TOC entry 2159 (class 0 OID 0)
-- Dependencies: 184
-- Name: exit_strategy_template_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE exit_strategy_template_id_seq OWNED BY exit_strategy_template.id;


--
-- TOC entry 169 (class 1259 OID 17141)
-- Dependencies: 7
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


ALTER TABLE trading_schema.moving_average OWNER TO trading;

--
-- TOC entry 168 (class 1259 OID 17139)
-- Dependencies: 169 7
-- Name: moving_average_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE moving_average_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.moving_average_id_seq OWNER TO trading;

--
-- TOC entry 2160 (class 0 OID 0)
-- Dependencies: 168
-- Name: moving_average_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE moving_average_id_seq OWNED BY moving_average.id;


--
-- TOC entry 175 (class 1259 OID 25971)
-- Dependencies: 7
-- Name: processing; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE processing (
    id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL
);


ALTER TABLE trading_schema.processing OWNER TO trading;

--
-- TOC entry 174 (class 1259 OID 25969)
-- Dependencies: 175 7
-- Name: processing_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE processing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.processing_id_seq OWNER TO trading;

--
-- TOC entry 2161 (class 0 OID 0)
-- Dependencies: 174
-- Name: processing_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE processing_id_seq OWNED BY processing.id;


--
-- TOC entry 167 (class 1259 OID 16630)
-- Dependencies: 7
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


ALTER TABLE trading_schema.quote OWNER TO trading;

--
-- TOC entry 166 (class 1259 OID 16628)
-- Dependencies: 7 167
-- Name: quote_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE quote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.quote_id_seq OWNER TO trading;

--
-- TOC entry 2162 (class 0 OID 0)
-- Dependencies: 166
-- Name: quote_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE quote_id_seq OWNED BY quote.id;


--
-- TOC entry 195 (class 1259 OID 26225)
-- Dependencies: 7
-- Name: strategy_proposal; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE strategy_proposal (
    id bigint NOT NULL,
    entry_strategy_id bigint NOT NULL,
    symbol_id bigint NOT NULL,
    datestamp timestamp without time zone NOT NULL
);


ALTER TABLE trading_schema.strategy_proposal OWNER TO trading;

--
-- TOC entry 194 (class 1259 OID 26223)
-- Dependencies: 7 195
-- Name: strategy_proposal_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE strategy_proposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.strategy_proposal_id_seq OWNER TO trading;

--
-- TOC entry 2163 (class 0 OID 0)
-- Dependencies: 194
-- Name: strategy_proposal_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE strategy_proposal_id_seq OWNED BY strategy_proposal.id;


--
-- TOC entry 165 (class 1259 OID 16603)
-- Dependencies: 7
-- Name: symbol; Type: TABLE; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE TABLE symbol (
    id bigint NOT NULL,
    exchange_id bigint NOT NULL,
    name text NOT NULL,
    symbol text NOT NULL
);


ALTER TABLE trading_schema.symbol OWNER TO trading;

--
-- TOC entry 164 (class 1259 OID 16601)
-- Dependencies: 165 7
-- Name: symbol_id_seq; Type: SEQUENCE; Schema: trading_schema; Owner: trading
--

CREATE SEQUENCE symbol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE trading_schema.symbol_id_seq OWNER TO trading;

--
-- TOC entry 2164 (class 0 OID 0)
-- Dependencies: 164
-- Name: symbol_id_seq; Type: SEQUENCE OWNED BY; Schema: trading_schema; Owner: trading
--

ALTER SEQUENCE symbol_id_seq OWNED BY symbol.id;


--
-- TOC entry 1942 (class 2604 OID 26130)
-- Dependencies: 189 188 189
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accepted_trades ALTER COLUMN id SET DEFAULT nextval('accepted_trades_id_seq'::regclass);


--
-- TOC entry 1933 (class 2604 OID 17167)
-- Dependencies: 170 171 171
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accumulation_distribution ALTER COLUMN id SET DEFAULT nextval('accumulation_distribution_id_seq'::regclass);


--
-- TOC entry 1934 (class 2604 OID 25956)
-- Dependencies: 172 173 173
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY analysis ALTER COLUMN id SET DEFAULT nextval('analysis_id_seq'::regclass);


--
-- TOC entry 1937 (class 2604 OID 26000)
-- Dependencies: 178 179 179
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions ALTER COLUMN id SET DEFAULT nextval('entry_actions_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 26192)
-- Dependencies: 193 192 193
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions_template ALTER COLUMN id SET DEFAULT nextval('entry_actions_template_id_seq'::regclass);


--
-- TOC entry 1943 (class 2604 OID 26153)
-- Dependencies: 190 191 191
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_conditions ALTER COLUMN id SET DEFAULT nextval('entry_conditions_id_seq'::regclass);


--
-- TOC entry 1946 (class 2604 OID 26276)
-- Dependencies: 197 196 197
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy ALTER COLUMN id SET DEFAULT nextval('entry_exit_strategy_id_seq'::regclass);


--
-- TOC entry 1936 (class 2604 OID 25989)
-- Dependencies: 176 177 177
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_strategy ALTER COLUMN id SET DEFAULT nextval('entry_strategy_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 16575)
-- Dependencies: 163 162 163
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exchange ALTER COLUMN id SET DEFAULT nextval('exchange_id_seq'::regclass);


--
-- TOC entry 1939 (class 2604 OID 26082)
-- Dependencies: 182 183 183
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions ALTER COLUMN id SET DEFAULT nextval('exit_conditions_id_seq'::regclass);


--
-- TOC entry 1941 (class 2604 OID 26111)
-- Dependencies: 187 186
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions_template ALTER COLUMN id SET DEFAULT nextval('exit_conditions_template_id_seq'::regclass);


--
-- TOC entry 1947 (class 2604 OID 26299)
-- Dependencies: 198 199 199
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal ALTER COLUMN id SET DEFAULT nextval('exit_proposal_id_seq'::regclass);


--
-- TOC entry 1938 (class 2604 OID 26060)
-- Dependencies: 181 180 181
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy ALTER COLUMN id SET DEFAULT nextval('exit_strategy_id_seq'::regclass);


--
-- TOC entry 1940 (class 2604 OID 26098)
-- Dependencies: 184 185 185
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy_template ALTER COLUMN id SET DEFAULT nextval('exit_strategy_template_id_seq'::regclass);


--
-- TOC entry 1932 (class 2604 OID 17144)
-- Dependencies: 168 169 169
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY moving_average ALTER COLUMN id SET DEFAULT nextval('moving_average_id_seq'::regclass);


--
-- TOC entry 1935 (class 2604 OID 25974)
-- Dependencies: 174 175 175
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY processing ALTER COLUMN id SET DEFAULT nextval('processing_id_seq'::regclass);


--
-- TOC entry 1931 (class 2604 OID 16633)
-- Dependencies: 167 166 167
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY quote ALTER COLUMN id SET DEFAULT nextval('quote_id_seq'::regclass);


--
-- TOC entry 1945 (class 2604 OID 26228)
-- Dependencies: 195 194 195
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal ALTER COLUMN id SET DEFAULT nextval('strategy_proposal_id_seq'::regclass);


--
-- TOC entry 1930 (class 2604 OID 16606)
-- Dependencies: 164 165 165
-- Name: id; Type: DEFAULT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY symbol ALTER COLUMN id SET DEFAULT nextval('symbol_id_seq'::regclass);


--
-- TOC entry 2000 (class 2606 OID 26132)
-- Dependencies: 189 189 2139
-- Name: pk_accepted_trades; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY accepted_trades
    ADD CONSTRAINT pk_accepted_trades PRIMARY KEY (id);


--
-- TOC entry 1978 (class 2606 OID 17172)
-- Dependencies: 171 171 2139
-- Name: pk_accumulation_distribution; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY accumulation_distribution
    ADD CONSTRAINT pk_accumulation_distribution PRIMARY KEY (id);


--
-- TOC entry 1980 (class 2606 OID 25961)
-- Dependencies: 173 173 2139
-- Name: pk_analysis; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT pk_analysis PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 26002)
-- Dependencies: 179 179 2139
-- Name: pk_entry_actions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT pk_entry_actions PRIMARY KEY (id);


--
-- TOC entry 2004 (class 2606 OID 26197)
-- Dependencies: 193 193 2139
-- Name: pk_entry_actions_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_actions_template
    ADD CONSTRAINT pk_entry_actions_template PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 26159)
-- Dependencies: 191 191 2139
-- Name: pk_entry_conditions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_conditions
    ADD CONSTRAINT pk_entry_conditions PRIMARY KEY (id);


--
-- TOC entry 2008 (class 2606 OID 26281)
-- Dependencies: 197 197 2139
-- Name: pk_entry_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT pk_entry_exit_strategy PRIMARY KEY (id);


--
-- TOC entry 1986 (class 2606 OID 25991)
-- Dependencies: 177 177 2139
-- Name: pk_entry_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY entry_strategy
    ADD CONSTRAINT pk_entry_strategy PRIMARY KEY (id);


--
-- TOC entry 1952 (class 2606 OID 16613)
-- Dependencies: 163 163 2139
-- Name: pk_exchange; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exchange
    ADD CONSTRAINT pk_exchange PRIMARY KEY (id);


--
-- TOC entry 1994 (class 2606 OID 26084)
-- Dependencies: 183 183 2139
-- Name: pk_exit_conditions; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_conditions
    ADD CONSTRAINT pk_exit_conditions PRIMARY KEY (id);


--
-- TOC entry 1998 (class 2606 OID 26119)
-- Dependencies: 186 186 2139
-- Name: pk_exit_conditions_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_conditions_template
    ADD CONSTRAINT pk_exit_conditions_template PRIMARY KEY (id);


--
-- TOC entry 2010 (class 2606 OID 26301)
-- Dependencies: 199 199 2139
-- Name: pk_exit_proposal; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT pk_exit_proposal PRIMARY KEY (id);


--
-- TOC entry 1990 (class 2606 OID 26064)
-- Dependencies: 181 181 2139
-- Name: pk_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT pk_exit_strategy PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 26100)
-- Dependencies: 185 185 2139
-- Name: pk_exit_strategy_template; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy_template
    ADD CONSTRAINT pk_exit_strategy_template PRIMARY KEY (id);


--
-- TOC entry 1974 (class 2606 OID 17149)
-- Dependencies: 169 169 2139
-- Name: pk_moving_average; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY moving_average
    ADD CONSTRAINT pk_moving_average PRIMARY KEY (id);


--
-- TOC entry 2014 (class 2606 OID 26367)
-- Dependencies: 201 201 2139
-- Name: pk_moving_avg; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY a_moving_avg
    ADD CONSTRAINT pk_moving_avg PRIMARY KEY (id);


--
-- TOC entry 1984 (class 2606 OID 25978)
-- Dependencies: 175 175 2139
-- Name: pk_processing; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT pk_processing PRIMARY KEY (id);


--
-- TOC entry 1963 (class 2606 OID 16635)
-- Dependencies: 167 167 2139
-- Name: pk_quote_id; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT pk_quote_id PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 26230)
-- Dependencies: 195 195 2139
-- Name: pk_strategy_proposal; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT pk_strategy_proposal PRIMARY KEY (id);


--
-- TOC entry 1957 (class 2606 OID 16611)
-- Dependencies: 165 165 2139
-- Name: pk_symbol; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT pk_symbol PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 26313)
-- Dependencies: 199 199 199 199 2139
-- Name: u_exit_proposal_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT u_exit_proposal_1 UNIQUE (exit_strategy_id, strategy_proposal_id, accepted_datestamp);


--
-- TOC entry 1992 (class 2606 OID 26267)
-- Dependencies: 181 181 181 181 2139
-- Name: u_exit_strategy; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT u_exit_strategy UNIQUE (strategy_proposal_id, datestamp, symbol_id);


--
-- TOC entry 1982 (class 2606 OID 25968)
-- Dependencies: 173 173 173 2139
-- Name: uc_analysis_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT uc_analysis_1 UNIQUE (date_of_prediction, symbol_id);


--
-- TOC entry 1965 (class 2606 OID 25938)
-- Dependencies: 167 167 167 2139
-- Name: uc_quote_1; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT uc_quote_1 UNIQUE (symbol_id, datestamp);


--
-- TOC entry 1959 (class 2606 OID 25936)
-- Dependencies: 165 165 2139
-- Name: uc_symbol; Type: CONSTRAINT; Schema: trading_schema; Owner: trading; Tablespace: 
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT uc_symbol UNIQUE (symbol);


--
-- TOC entry 1975 (class 1259 OID 17178)
-- Dependencies: 171 2139
-- Name: fki_accumulation_distribution_quote; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_accumulation_distribution_quote ON accumulation_distribution USING btree (quote_id);


--
-- TOC entry 1966 (class 1259 OID 17155)
-- Dependencies: 169 2139
-- Name: fki_moving_average_quote; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_moving_average_quote ON moving_average USING btree (quote_id);


--
-- TOC entry 1953 (class 1259 OID 16619)
-- Dependencies: 165 2139
-- Name: fki_symbol_exchange_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX fki_symbol_exchange_id ON symbol USING btree (exchange_id);


--
-- TOC entry 1976 (class 1259 OID 17179)
-- Dependencies: 171 2139
-- Name: idx_accumulation_distribution; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_accumulation_distribution ON accumulation_distribution USING btree (accumulation_distribution);


--
-- TOC entry 1949 (class 1259 OID 17197)
-- Dependencies: 163 2139
-- Name: idx_exchange_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_exchange_id ON exchange USING btree (id);


--
-- TOC entry 1950 (class 1259 OID 16642)
-- Dependencies: 163 2139
-- Name: idx_exchange_name; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE UNIQUE INDEX idx_exchange_name ON exchange USING btree (name);


--
-- TOC entry 1967 (class 1259 OID 17157)
-- Dependencies: 169 2139
-- Name: idx_fourteen; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_fourteen ON moving_average USING btree (fourteen_days);


--
-- TOC entry 1968 (class 1259 OID 17160)
-- Dependencies: 169 2139
-- Name: idx_fourty_eight; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_fourty_eight ON moving_average USING btree (fourty_eight_days);


--
-- TOC entry 1969 (class 1259 OID 17161)
-- Dependencies: 169 2139
-- Name: idx_ninety; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_ninety ON moving_average USING btree (ninety_days);


--
-- TOC entry 1960 (class 1259 OID 25950)
-- Dependencies: 167 2139
-- Name: idx_quote_datestamp; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_quote_datestamp ON quote USING btree (datestamp);


--
-- TOC entry 1970 (class 1259 OID 17156)
-- Dependencies: 169 2139
-- Name: idx_seven; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_seven ON moving_average USING btree (seven_days);


--
-- TOC entry 1961 (class 1259 OID 16645)
-- Dependencies: 167 2139
-- Name: idx_symbol_id; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_id ON quote USING btree (symbol_id NULLS FIRST);


--
-- TOC entry 1954 (class 1259 OID 16654)
-- Dependencies: 165 2139
-- Name: idx_symbol_name; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_name ON symbol USING btree (name);


--
-- TOC entry 1955 (class 1259 OID 16653)
-- Dependencies: 165 2139
-- Name: idx_symbol_symbol; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_symbol_symbol ON symbol USING btree (symbol);


--
-- TOC entry 1971 (class 1259 OID 17159)
-- Dependencies: 169 2139
-- Name: idx_twenty_eight; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_twenty_eight ON moving_average USING btree (twenty_eight_days);


--
-- TOC entry 1972 (class 1259 OID 17158)
-- Dependencies: 169 2139
-- Name: idx_twenty_one; Type: INDEX; Schema: trading_schema; Owner: trading; Tablespace: 
--

CREATE INDEX idx_twenty_one ON moving_average USING btree (twenty_one_days);


--
-- TOC entry 2021 (class 2606 OID 26010)
-- Dependencies: 179 177 1985 2139
-- Name: entry_actions_entry_strategy_id_fkey; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT entry_actions_entry_strategy_id_fkey FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2027 (class 2606 OID 26246)
-- Dependencies: 195 2005 189 2139
-- Name: fk_accepted_trades_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accepted_trades
    ADD CONSTRAINT fk_accepted_trades_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2018 (class 2606 OID 17173)
-- Dependencies: 1962 171 167 2139
-- Name: fk_accumulation_distribution_quote; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY accumulation_distribution
    ADD CONSTRAINT fk_accumulation_distribution_quote FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2019 (class 2606 OID 26165)
-- Dependencies: 173 1956 165 2139
-- Name: fk_analysis_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY analysis
    ADD CONSTRAINT fk_analysis_1 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2029 (class 2606 OID 26198)
-- Dependencies: 1985 177 193 2139
-- Name: fk_entry_actions_template_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions_template
    ADD CONSTRAINT fk_entry_actions_template_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2028 (class 2606 OID 26160)
-- Dependencies: 177 191 1985 2139
-- Name: fk_entry_conditions_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_conditions
    ADD CONSTRAINT fk_entry_conditions_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2032 (class 2606 OID 26282)
-- Dependencies: 1985 197 177 2139
-- Name: fk_entry_exit_strategy_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT fk_entry_exit_strategy_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2033 (class 2606 OID 26334)
-- Dependencies: 1995 185 197 2139
-- Name: fk_entry_exit_strategy_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_exit_strategy
    ADD CONSTRAINT fk_entry_exit_strategy_2 FOREIGN KEY (exit_strategy_template_id) REFERENCES exit_strategy_template(id);


--
-- TOC entry 2025 (class 2606 OID 26085)
-- Dependencies: 181 1989 183 2139
-- Name: fk_exit_conditions; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions
    ADD CONSTRAINT fk_exit_conditions FOREIGN KEY (exit_strategy_id) REFERENCES exit_strategy(id);


--
-- TOC entry 2026 (class 2606 OID 26120)
-- Dependencies: 186 1995 185 2139
-- Name: fk_exit_conditions_template; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_conditions_template
    ADD CONSTRAINT fk_exit_conditions_template FOREIGN KEY (exit_strategy_template_id) REFERENCES exit_strategy_template(id);


--
-- TOC entry 2034 (class 2606 OID 26302)
-- Dependencies: 181 1989 199 2139
-- Name: fk_exit_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT fk_exit_proposal_1 FOREIGN KEY (exit_strategy_id) REFERENCES exit_strategy(id);


--
-- TOC entry 2035 (class 2606 OID 26307)
-- Dependencies: 199 2005 195 2139
-- Name: fk_exit_proposal_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_proposal
    ADD CONSTRAINT fk_exit_proposal_2 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2024 (class 2606 OID 26261)
-- Dependencies: 181 2005 195 2139
-- Name: fk_exit_strategy_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT fk_exit_strategy_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2023 (class 2606 OID 26070)
-- Dependencies: 165 181 1956 2139
-- Name: fk_exit_strategy_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY exit_strategy
    ADD CONSTRAINT fk_exit_strategy_2 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2017 (class 2606 OID 17150)
-- Dependencies: 167 1962 169 2139
-- Name: fk_moving_average_quote; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY moving_average
    ADD CONSTRAINT fk_moving_average_quote FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2036 (class 2606 OID 26368)
-- Dependencies: 201 1962 167 2139
-- Name: fk_moving_avg_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY a_moving_avg
    ADD CONSTRAINT fk_moving_avg_1 FOREIGN KEY (quote_id) REFERENCES quote(id);


--
-- TOC entry 2020 (class 2606 OID 26177)
-- Dependencies: 1956 165 175 2139
-- Name: fk_processing_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY processing
    ADD CONSTRAINT fk_processing_1 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2016 (class 2606 OID 16636)
-- Dependencies: 167 165 1956 2139
-- Name: fk_quote_symbol_id; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY quote
    ADD CONSTRAINT fk_quote_symbol_id FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2030 (class 2606 OID 26231)
-- Dependencies: 177 1985 195 2139
-- Name: fk_strategy_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT fk_strategy_proposal_1 FOREIGN KEY (entry_strategy_id) REFERENCES entry_strategy(id);


--
-- TOC entry 2022 (class 2606 OID 26256)
-- Dependencies: 179 195 2005 2139
-- Name: fk_strategy_proposal_1; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY entry_actions
    ADD CONSTRAINT fk_strategy_proposal_1 FOREIGN KEY (strategy_proposal_id) REFERENCES strategy_proposal(id);


--
-- TOC entry 2031 (class 2606 OID 26236)
-- Dependencies: 1956 165 195 2139
-- Name: fk_strategy_proposal_2; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY strategy_proposal
    ADD CONSTRAINT fk_strategy_proposal_2 FOREIGN KEY (symbol_id) REFERENCES symbol(id);


--
-- TOC entry 2015 (class 2606 OID 16614)
-- Dependencies: 165 1951 163 2139
-- Name: fk_symbol_exchange_id; Type: FK CONSTRAINT; Schema: trading_schema; Owner: trading
--

ALTER TABLE ONLY symbol
    ADD CONSTRAINT fk_symbol_exchange_id FOREIGN KEY (exchange_id) REFERENCES exchange(id);


--
-- TOC entry 2144 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-08-20 19:20:21 BST

--
-- PostgreSQL database dump complete
--

