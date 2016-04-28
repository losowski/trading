--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.6
-- Dumped by pg_dump version 9.4.6
-- Started on 2016-04-28 23:47:47 BST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = trading_schema, pg_catalog;

--
-- TOC entry 2166 (class 0 OID 19461)
-- Dependencies: 191
-- Data for Name: exchange; Type: TABLE DATA; Schema: trading_schema; Owner: trading
--

COPY exchange (id, name) FROM stdin;
1	G
3	NYSE
\.


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 192
-- Name: exchange_id_seq; Type: SEQUENCE SET; Schema: trading_schema; Owner: trading
--

SELECT pg_catalog.setval('exchange_id_seq', 25, true);


--
-- TOC entry 2168 (class 0 OID 19532)
-- Dependencies: 211
-- Data for Name: symbol; Type: TABLE DATA; Schema: trading_schema; Owner: trading
--

COPY symbol (id, exchange_id, name, symbol) FROM stdin;
1	3	Google Inc.	GOOG
5	1	Yahoo	YHOO
\.


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 212
-- Name: symbol_id_seq; Type: SEQUENCE SET; Schema: trading_schema; Owner: trading
--

SELECT pg_catalog.setval('symbol_id_seq', 6, true);


-- Completed on 2016-04-28 23:47:47 BST

--
-- PostgreSQL database dump complete
--

