-- clean up
DROP TABLE "Claims";
DROP TABLE "#Params";

-- training data
CREATE COLUMN TABLE "Claims" ("id" INTEGER, "policy" NVARCHAR(10), "age" INTEGER, "amount" INTEGER, "occupation" NVARCHAR(10), "isFraud" NVARCHAR(10));
INSERT INTO "Claims" VALUES (1,'Home',24,300,'Sales','No');
INSERT INTO "Claims" VALUES (2,'Home',41,1200,'IT','No');
INSERT INTO "Claims" VALUES (3,'Home',38,2800,'Sales','Yes');
INSERT INTO "Claims" VALUES (4,'Home',62,6000,'Marketing','No');
INSERT INTO "Claims" VALUES (5,'Home',51,4000,'Sales','No');
INSERT INTO "Claims" VALUES (6,'Travel',33,200,'Sales','No');
INSERT INTO "Claims" VALUES (7,'Travel',46,800,'IT','No');
INSERT INTO "Claims" VALUES (8,'Travel',42,1000,'Marketing','No');
INSERT INTO "Claims" VALUES (9,'Travel',21,900,'Sales','No');
INSERT INTO "Claims" VALUES (10,'Vehicle',44,4000,'IT','No');
INSERT INTO "Claims" VALUES (11,'Vehicle',64,1000,'Sales','Yes');
INSERT INTO "Claims" VALUES (12,'Vehicle',54,900,'IT','No');
INSERT INTO "Claims" VALUES (13,'Vehicle',26,2500,'Sales','No');
INSERT INTO "Claims" VALUES (14,'Vehicle',44,1300,'Marketing','Yes');

-- parameters
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));

-- standard parameters
INSERT INTO "#Params" VALUES ('HAS_ID', 1, null, null);
INSERT INTO "#Params" VALUES ('DEPENDENT_VARIABLE', null, null, 'isFraud');
INSERT INTO "#Params" VALUES ('CLASS_MAP0', null, null, 'No');
INSERT INTO "#Params" VALUES ('CLASS_MAP1', null, null, 'Yes');
INSERT INTO "#Params" VALUES ('MAX_ITERATION', 1000, null, null);
 
-- model evaluation & parameter search parameters
INSERT INTO "#Params" VALUES ('PROGRESS_INDICATOR_ID', null, null, 'Train Logistic Regression');
INSERT INTO "#Params" VALUES ('RESAMPLING_METHOD', null, null, 'stratified_cv'); -- cv, stratified_cv, bootstrap, stratified_bootstrap
INSERT INTO "#Params" VALUES ('FOLD_NUM', 5, null, null);
INSERT INTO "#Params" VALUES ('EVALUATION_METRIC', null, null, 'AUC'); -- RMSE, MAE, ERROR_RATE, NLL, AUC
INSERT INTO "#Params" VALUES ('REPEAT_TIMES', 2, null, null);
INSERT INTO "#Params" VALUES ('PARAM_SEARCH_STRATEGY', null, null, 'grid'); -- grid, random
--INSERT INTO "#Params" VALUES ('RANDOM_SEARCH_TIMES', 2, null, null); -- use when search strategy = random

-- algorithm specific parameter values
INSERT INTO "#Params" VALUES ('ENET_LAMBDA_VALUES', null, null, '{0.01,0.02,0.005,0.001}'); -- discrete values
INSERT INTO "#Params" VALUES ('ENET_ALPHA_RANGE', null, null, '[0.005,0.001,0.01]'); -- range: start, increment, end

-- train model
CALL "_SYS_AFL"."PAL_LOGISTIC_REGRESSION" ("Claims", "#Params", ?, ?, ?, ?);

-- check progress
SELECT * FROM "_SYS_AFL"."FUNCTION_PROGRESS_IN_AFLPAL" WHERE "EXECUTION_ID" = 'Train Logistic Regression';
