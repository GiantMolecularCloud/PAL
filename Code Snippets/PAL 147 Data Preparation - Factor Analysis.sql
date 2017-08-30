-- clean up
DROP VIEW "DATA";
DROP TABLE "#PARAMS";

-- input data
CREATE VIEW "DATA" AS 
 SELECT "ID", "LIFESPEND", "NEWSPEND", "INCOME", "LOYALTY" 
  FROM "PAL"."CUSTOMERS";
 
-- parameters
CREATE LOCAL TEMPORARY COLUMN TABLE "#PARAMS" ("NAME" VARCHAR(60), "INTARGS" INTEGER, "DOUBLEARGS" DOUBLE, "STRINGARGS" VARCHAR(100));
INSERT INTO "#PARAMS" VALUES ('THREAD_RATIO', null, 1.0, null); -- Between 0 and 1
INSERT INTO "#PARAMS" VALUES ('FACTOR_NUMBER', 2, null, null); -- Number of factors
--INSERT INTO "#PARAMS" VALUES ('METHOD', 0, null, null); -- 0: PCM
--INSERT INTO "#PARAMS" VALUES ('ROTATION', 1, null, null); -- 0: None, 1: Varimax, 2: Promax
--INSERT INTO "#PARAMS" VALUES ('SCORE', 1, null, null); -- 0: None, 1: Regression
--INSERT INTO "#PARAMS" VALUES ('COR', 1, null, null); -- 0: Covariance matrix, 1: Correlation matrix
--INSERT INTO "#PARAMS" VALUES ('KAPPA', null, 4.0, null); -- Power of Promax (when ROTATION:2) Default:4

-- call : results inline
CALL "_SYS_AFL"."PAL_FACTOR_ANALYSIS" ("DATA", "#PARAMS", ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
