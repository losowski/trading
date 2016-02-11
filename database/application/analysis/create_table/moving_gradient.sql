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

-- Create the moving diff table with the required indexes
