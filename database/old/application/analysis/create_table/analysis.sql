
CREATE SEQUENCE trading_schema.analysis_properties_id_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 3
	CACHE 1;
ALTER TABLE trading_schema.analysis_properties_id_seq
	OWNER TO trading;


CREATE TABLE trading_schema.analysis_property
(
	id bigint NOT NULL DEFAULT nextval('trading_schema.analysis_properties_id_seq'::regclass),
	name text NOT NULL,
	analysis_type character(1) NOT NULL,
	price_change numeric NOT NULL,
	days interval NOT NULL,
	CONSTRAINT pk_analysis_property PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_property
	OWNER TO trading;

-- ALTER TABLE trading_schema.analysis_property DROP CONSTRAINT ck_analysis_property_analysis_type;
ALTER TABLE trading_schema.analysis_property ADD CONSTRAINT ck_analysis_property_analysis_type CHECK (analysis_type = ANY (ARRAY['D'::bpchar, 'T'::bpchar]));

-- ALTER TABLE trading_schema.analysis_property DROP CONSTRAINT ck_analysis_property_analysis_type;
ALTER TABLE trading_schema.analysis_property ADD CONSTRAINT ck_analysis_property CHECK (days >=  INTERVAL '0 DAY');

-- NOTE:
-- trading_schema.analysis_property requires a check constraint
-- analysis_type <T|D> (Time|Direction)
-- days < >=0 > (always positive)


CREATE TABLE trading_schema.analysis_conditions
(
	id bigserial NOT NULL,
	analysis_property_id bigint NOT NULL,
	threshold_type character(1) NOT NULL,
	field_name text NOT NULL,
	operator text NOT NULL,
	value numeric NOT NULL,
	days_interval interval,
	days_operator text,
	status character(1) NOT NULL DEFAULT 'A'::bpchar,
	CONSTRAINT pk_analysis_conditions PRIMARY KEY (id),
	CONSTRAINT fk_analysis_conditions FOREIGN KEY (analysis_property_id)
		REFERENCES trading_schema.analysis_property (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_conditions
	OWNER TO trading;

-- ALTER TABLE trading_schema.analysis_conditions DROP CONSTRAINT "ck_analysis_conditions_threshold_type";

ALTER TABLE trading_schema.analysis_conditions
  ADD CONSTRAINT "ck_analysis_conditions_threshold_type" CHECK (status = ANY (ARRAY['A'::bpchar, 'R'::bpchar]));

-- ALTER TABLE trading_schema.analysis_conditions DROP CONSTRAINT "ck_analysis_conditions_status";

ALTER TABLE trading_schema.analysis_conditions
  ADD CONSTRAINT "ck_analysis_conditions_status" CHECK (status = ANY (ARRAY['A'::bpchar, 'D'::bpchar, 'S'::bpchar]));

-- ALTER TABLE trading_schema.analysis_conditions DROP CONSTRAINT "ck_analysis_conditions_operator";

ALTER TABLE trading_schema.analysis_conditions
  ADD CONSTRAINT "ck_analysis_conditions_operator" CHECK (operator = ANY (ARRAY['lt'::text, 'lte'::text, 'eq'::text, 'gt'::text, 'lte'::text]));

-- NOTE:
-- trading_schema.analysis_conditions requires a check constraint
-- threshold_type<A|R> (Absolute|Relative)
-- operator <gt|lt|eq|lte|gte>

-- Reference Table (to be used vaguely for versioning)
CREATE TABLE trading_schema.reference
(
	id bigserial NOT NULL,
	datestamp timestamp without time zone NOT NULL,
	reference uuid NOT NULL,
	CONSTRAINT pk_reference PRIMARY KEY (id),
	CONSTRAINT uc_reference UNIQUE (reference, datestamp)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.reference
	OWNER TO trading;


-- Prediction Input
CREATE SEQUENCE trading_schema.prediction_input_id_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 3
	CACHE 1;
ALTER TABLE trading_schema.prediction_input_id_seq
	OWNER TO trading;

CREATE TABLE trading_schema.prediction_input
(
	id bigserial NOT NULL DEFAULT nextval('trading_schema.prediction_input_id_seq'::regclass),
	analysis_property_id bigint NOT NULL,
	quote_id bigint NOT NULL,
	reference_id bigint NOT NULL,
	end_date timestamp without time zone NOT NULL,
	end_value numeric NOT NULL,
	end_diff numeric NOT NULL,
	CONSTRAINT pk_prediction_input PRIMARY KEY (id),
	CONSTRAINT fk_analysis_assignment_quote_01 FOREIGN KEY (analysis_property_id)
		REFERENCES trading_schema.analysis_property (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_analysis_assignment_quote_02 FOREIGN KEY (quote_id)
		REFERENCES trading_schema.quote (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_reference FOREIGN KEY (reference_id)
		REFERENCES trading_schema.reference (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT uc_prediction_input UNIQUE (analysis_property_id, quote_id, reference_id)
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.analysis_assignment_quote
	OWNER TO trading;
-- TODO: SET prediction_input.reference_id NOT NULL (once added to application)

-- Prediction Testing
CREATE TABLE trading_schema.prediction_test
(
	prediction_input_id bigint NOT NULL,
	change_percentage numeric NOT NULL,
	change_diff numeric NOT NULL,
	minimum numeric NOT NULL,
	maximum numeric NOT NULL,
	average numeric NOT NULL,
	valid character(1) NOT NULL DEFAULT '-'::bpchar,
	CONSTRAINT pk_prediction_test PRIMARY KEY (prediction_input_id),
	CONSTRAINT fk1_prediction_test FOREIGN KEY (prediction_input_id)
		REFERENCES trading_schema.prediction_input (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.prediction_test
	OWNER TO trading;
