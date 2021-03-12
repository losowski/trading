-- Table: trading_schema.fxsymbols
CREATE SEQUENCE trading_schema.fxsymbols_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.fxsymbols_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.fxsymbols
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.fxsymbols_id_seq'::regclass),
  name text NOT NULL,
  enabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar,
  CONSTRAINT pk_fxsymbols PRIMARY KEY (id),
  CONSTRAINT ck_fxsymbols_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.fxsymbols
  OWNER TO trading;

-- Index: trading_schema.idx_fxsymbols_id
CREATE INDEX idx_fxsymbols_id
  ON trading_schema.fxsymbols
  USING btree
  (id);

-- Index: trading_schema.idx_fxsymbols_name
CREATE UNIQUE INDEX idx_fxsymbols_name
  ON trading_schema.fxsymbols
  USING btree
  (name COLLATE pg_catalog."default");


-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsFxSymbols(
	p_fxsymbols	trading_schema.fxsymbols.name%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.fxsymbols
		(
			name
		)
	VALUES
		(
			p_fxsymbols
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
ALTER FUNCTION trading_schema.pInsFxSymbols OWNER TO trading;

-- Disable FxSymbols
CREATE OR REPLACE FUNCTION trading_schema.pDisableFxSymbols(
	p_fxsymbols	trading_schema.fxsymbols.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.fxsymbols SET enabled = 'N' WHERE name = p_fxsymbols;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableFxSymbols OWNER TO trading;

-- Enable FxSymbols
CREATE OR REPLACE FUNCTION trading_schema.pEnableFxSymbols(
	p_fxsymbols	trading_schema.fxsymbols.name%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.fxsymbols SET enabled = 'Y' WHERE name = p_fxsymbols;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableFxSymbols OWNER TO trading;
