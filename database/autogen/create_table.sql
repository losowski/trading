--
-- File for import into Database to input the Calculation Table information
--

-- Create the table for moving_average

CREATE TABLE trading_schema.moving_average
(
	quote_id bigint NOT NULL,
	id bigserial NOT NULL,
	seven_days numeric NOT NULL,
	fourteen_days numeric NOT NULL,
	twenty_one_days numeric NOT NULL,
	twenty_eight_days numeric NOT NULL,
	fourty_eight_days numeric NOT NULL,
	ninety_days numeric NOT NULL,
	CONSTRAINT pk_moving_average PRIMARY KEY (id ),
	CONSTRAINT fk_moving_average_quote FOREIGN KEY (quote_id)
	REFERENCES trading_schema.quote (id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH ( OIDS=FALSE );
ALTER TABLE trading_schema.moving_average OWNER TO trading;
CREATE INDEX fki_moving_average_quote ON trading_schema.moving_average USING btree (quote_id );
CREATE INDEX idx_seven ON trading_schema.moving_average USING btree ( seven_days );
CREATE INDEX idx_fourteen ON trading_schema.moving_average USING btree ( fourteen_days );
CREATE INDEX idx_twenty_one ON trading_schema.moving_average USING btree ( twenty_one_days );
CREATE INDEX idx_twenty_eight ON trading_schema.moving_average USING btree ( twenty_eight_days );
CREATE INDEX idx_fourty_eight ON trading_schema.moving_average USING btree ( fourty_eight_days );
CREATE INDEX idx_ninety ON trading_schema.moving_average USING btree ( ninety_days );

-- Create the table for accumulation_distribution

CREATE TABLE trading_schema.accumulation_distribution
(
	quote_id bigint NOT NULL,
	id bigserial NOT NULL,
	accumulation_distribution numeric NOT NULL,
	momentum numeric NOT NULL,
	CONSTRAINT pk_accumulation_distribution PRIMARY KEY (id ),
	CONSTRAINT fk_accumulation_distribution_quote FOREIGN KEY (quote_id)
	REFERENCES trading_schema.quote (id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH ( OIDS=FALSE );
ALTER TABLE trading_schema.accumulation_distribution OWNER TO trading;
CREATE INDEX fki_accumulation_distribution_quote ON trading_schema.accumulation_distribution USING btree (quote_id );
CREATE INDEX idx_accumulation_distribution ON trading_schema.accumulation_distribution USING btree ( accumulation_distribution );
