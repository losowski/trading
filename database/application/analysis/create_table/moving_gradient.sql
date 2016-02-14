-- Create both the quote_diff table and the moving_diff
CREATE TABLE trading_schema.quote_diff
(
  quote_id bigint NOT NULL,
  diff_close_price money NOT NULL,
  diff_high_price money NOT NULL,
  diff_low_price money NOT NULL,
  diff_open_price money NOT NULL,
  CONSTRAINT pk_quote_diff PRIMARY KEY (quote_id),
  CONSTRAINT fk1_quote_diff FOREIGN KEY (quote_id)
      REFERENCES trading_schema.quote (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.quote_diff
  OWNER TO trading;


CREATE TABLE trading_schema.a_moving_diff
(
	id bigint NOT NULL,
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
	CONSTRAINT pk_moving_diff PRIMARY KEY (id ),
	CONSTRAINT fk_moving_diff FOREIGN KEY (id)
			REFERENCES trading_schema.quote (id) MATCH SIMPLE
			ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
	OIDS=FALSE
);
ALTER TABLE trading_schema.a_moving_diff
	OWNER TO trading;
