CREATE TABLE trading_schema.a_moving_avg
(
	id bigint NOT NULL,
	days2 numeric NOT NULL,
	days5 numeric NOT NULL,
	days9 numeric NOT NULL,
	days15 numeric NOT NULL,
	days21 numeric NOT NULL,
	days29 numeric NOT NULL,
	days73 numeric NOT NULL,
	days91 numeric NOT NULL,
	days121 numeric NOT NULL,
	days189 numeric NOT NULL,
	CONSTRAINT pk_moving_avg PRIMARY KEY (id ),
	CONSTRAINT fk_moving_avg FOREIGN KEY (id)
		REFERENCES trading_schema.quote (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.a_moving_avg
	OWNER TO trading;
