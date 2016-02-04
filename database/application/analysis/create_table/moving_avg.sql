CREATE SEQUENCE trading_schema.moving_avg_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE trading_schema.moving_average_id_seq
  OWNER TO trading;


CREATE TABLE trading_schema.a_moving_avg
(
	id bigint NOT NULL DEFAULT nextval('trading_schema.moving_avg_id_seq'::regclass),
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
	days189 money NOT NULL,
	CONSTRAINT pk_moving_avg PRIMARY KEY (id ),
	CONSTRAINT fk_moving_avg_1 FOREIGN KEY (quote_id)
			REFERENCES trading_schema.quote (id) MATCH SIMPLE
			ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.a_moving_avg
	OWNER TO trading;
