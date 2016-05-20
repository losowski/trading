
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

-- NOTE:
-- trading_schema.analysis_property requires a check constraint
-- analysis_type <T|D> (Time|Direction)
-- days < >=0 > (always positive)


CREATE TABLE trading_schema.analysis_conditions
(
	id bigserial NOT NULL,
	analysis_property_id bigint NOT NULL,
	field_name text NOT NULL,
	operator text NOT NULL,
	threshold_type character(1) NOT NULL,
	duration interval,
	value numeric NOT NULL,
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
	reference_id bigint,
	end_date date NOT NULL,
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
