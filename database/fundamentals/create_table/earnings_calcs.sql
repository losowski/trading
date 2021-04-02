CREATE TABLE trading_schema.earnings_calcs
(
  earnings_data_id bigint NOT NULL DEFAULT,
  -- Data
  profit_margin numeric,
  valuation numeric,
  CONSTRAINT fk_earnings_calcs_symbol_id FOREIGN KEY (earnings_data_id)
      REFERENCES trading_schema.earnings_data (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trading_schema.earnings_calcs
  OWNER TO trading;


-- Index: trading_schema.idx_earnings_calcs_earnings_data_id
CREATE INDEX idx_earnings_calcs_earnings_data_id
  ON trading_schema.earnings_calcs
  USING btree
  (earnings_data_id);

-- Index: trading_schema.idx_earnings_calcs_profit_margin
CREATE INDEX idx_earnings_calcs_profit_margin
  ON trading_schema.earnings_calcs
  USING btree
  (profit_margin);

-- Index: trading_schema.idx_earnings_calcs_valuation
CREATE INDEX idx_earnings_calcs_valuation
  ON trading_schema.earnings_calcs
  USING btree
  (valuation);

-- Stored Procedures --
