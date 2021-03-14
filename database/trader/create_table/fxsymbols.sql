-- Table: trading_schema.fxsymbol
CREATE SEQUENCE trading_schema.fxsymbol_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.fxsymbol_id_seq
  OWNER TO trading;

CREATE TABLE trading_schema.fxsymbol
(
  id bigint NOT NULL DEFAULT nextval('trading_schema.fxsymbol_id_seq'::regclass),
  code text NOT NULL,
  enabled character(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'Y'::bpchar,
  CONSTRAINT pk_fxsymbol PRIMARY KEY (id),
  CONSTRAINT ck_fxsymbol_enabled CHECK (enabled = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])) NOT VALID
)
WITH (
  OIDS=FALSE
);
-- Ownership
ALTER TABLE trading_schema.fxsymbol
  OWNER TO trading;

-- Index: trading_schema.idx_fxsymbol_id
CREATE UNIQUE INDEX idx_fxsymbol_id
  ON trading_schema.fxsymbol
  USING btree
  (id);

-- Index: trading_schema.idx_fxsymbol_code
CREATE INDEX idx_fxsymbol_code
  ON trading_schema.fxsymbol
  USING btree
  (code COLLATE pg_catalog."default");


-- Stored Procedures --
-- INSERT
CREATE OR REPLACE FUNCTION trading_schema.pInsFxSymbol(
	p_fxsymbol	trading_schema.fxsymbol.code%TYPE
	) RETURNS integer AS $$
DECLARE
	inserted_id integer := 0;
BEGIN
	INSERT INTO
	trading_schema.fxsymbol
		(
			code
		)
	VALUES
		(
			p_fxsymbol
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
ALTER FUNCTION trading_schema.pInsFxSymbol OWNER TO trading;

-- Disable FxSymbol
CREATE OR REPLACE FUNCTION trading_schema.pDisableFxSymbol(
	p_fxsymbol	trading_schema.fxsymbol.code%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.fxsymbol SET enabled = 'N' WHERE code = p_fxsymbol;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pDisableFxSymbol OWNER TO trading;

-- Enable FxSymbol
CREATE OR REPLACE FUNCTION trading_schema.pEnableFxSymbol(
	p_fxsymbol	trading_schema.fxsymbol.code%TYPE
	) RETURNS integer AS $$
DECLARE
	changed integer := 0;
BEGIN
	UPDATE trading_schema.fxsymbol SET enabled = 'Y' WHERE code = p_fxsymbol;

	GET DIAGNOSTICS changed = ROW_COUNT;

	RETURN changed;
END;
$$ LANGUAGE plpgsql;

-- Ownership
ALTER FUNCTION trading_schema.pEnableFxSymbol OWNER TO trading;
