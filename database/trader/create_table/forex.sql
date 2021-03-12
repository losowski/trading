-- Table: trading_schema.forex
CREATE SEQUENCE trading_schema.forex_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.forex_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.forex
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.forex_id_seq'::regclass),
  name text NOT NULL,
  enabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar,
  CONSTRAINT pk_forex PRIMARY KEY (id),
  CONSTRAINT ck_forex_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.forex
  OWNER TO trading;

-- Index: trading_schema.idx_forex_id
CREATE INDEX idx_forex_id
  ON trading_schema.forex
  USING btree
  (id);

-- Index: trading_schema.idx_forex_name
CREATE UNIQUE INDEX idx_forex_name
  ON trading_schema.forex
  USING btree
  (name COLLATE pg_catalog."default");


-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsForex(
	p_forex	trading_schema.forex.name%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.forex
		(
			name
		)
	VALUES
		(
			p_forex
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

-- Ownership
ALTER FUNCTION trading_schema.pInsForex OWNER TO trading;

-- Disable Forex
CREATE OR REPLACE FUNCTION trading_schema.pDisableForex(
	p_forex	trading_schema.forex.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.forex SET enabled = 'N' WHERE name = p_forex;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableForex OWNER TO trading;

-- Enable Forex
CREATE OR REPLACE FUNCTION trading_schema.pEnableForex(
	p_forex	trading_schema.forex.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.forex SET enabled = 'Y' WHERE name = p_forex;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableForex OWNER TO trading;
