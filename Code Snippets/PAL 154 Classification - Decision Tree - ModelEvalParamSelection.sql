-- clean up
DROP TABLE "Claims";
DROP TABLE "#Params";
DROP TABLE "Model";
DROP TABLE "Rules";
DROP TABLE "Confusion";
DROP TABLE "Statistics";
DROP TABLE "OptimalParameters";
DROP TABLE "ClaimsNew";

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
INSERT INTO "#Params" VALUES ('ALGORITHM', 1, null, null); -- 1: C45, 2: CHAID, 3: CART
 
-- model evaluation & parameter search parameters
INSERT INTO "#Params" VALUES ('PROGRESS_INDICATOR_ID', null, null, 'Train Decision Tree');
INSERT INTO "#Params" VALUES ('RESAMPLING_METHOD', null, null, 'stratified_bootstrap'); -- cv, stratified_cv, bootstrap, stratified_bootstrap
--INSERT INTO "#Params" VALUES ('FOLD_NUM', 3, null, null);
INSERT INTO "#Params" VALUES ('EVALUATION_METRIC', null, null, 'AUC'); -- RMSE, MAE, ERROR_RATE, NLL, AUC
INSERT INTO "#Params" VALUES ('REPEAT_TIMES', 2, null, null);
INSERT INTO "#Params" VALUES ('PARAM_SEARCH_STRATEGY', null, null, 'random'); -- grid, random
INSERT INTO "#Params" VALUES ('RANDOM_SEARCH_TIMES', 2, null, null); -- use when search strategy = random

-- algorithm specific parameter values
INSERT INTO "#Params" VALUES ('DISCRETIZATION_TYPE_VALUES', null, null, '{0, 1}'); -- discrete VALUES
INSERT INTO "#Params" VALUES ('SPLIT_THRESHOLD_VALUES', null, null, '{1e-3, 1e-4, 1e-5}'); -- discrete VALUES
INSERT INTO "#Params" VALUES ('MAX_DEPTH_RANGE', null, null, '[1, 1, 20]'); -- range: start, increment, end

-- result tables
CREATE COLUMN TABLE "Model" ("id" INTEGER, "content" NVARCHAR(5000));
CREATE COLUMN TABLE "Rules" ("id" INTEGER, "content" NVARCHAR(5000));
CREATE COLUMN TABLE "Confusion" ("actual" NVARCHAR(1000), "predicted" NVARCHAR(1000), "count" INTEGER);
CREATE COLUMN TABLE "Statistics" ("name" NVARCHAR(1000), "value" NVARCHAR(1000));
CREATE COLUMN TABLE "OptimalParameters" ("param" NVARCHAR(256), "int" INTEGER, "double" DOUBLE, "string" NVARCHAR(1000));

-- train model
CALL "_SYS_AFL"."PAL_DECISION_TREE" ("Claims", "#Params", "Model", "Rules", "Confusion", "Statistics", "OptimalParameters") WITH OVERVIEW;
SELECT * FROM "Model";
SELECT * FROM "Rules";
SELECT * FROM "Confusion";
SELECT * FROM "Statistics";
SELECT * FROM "OptimalParameters";

-- data for prediction
CREATE COLUMN TABLE "ClaimsNew" ("id" INTEGER, "policy" NVARCHAR(10), "age" INTEGER, "amount" INTEGER, "occupation" NVARCHAR(10));
INSERT INTO "ClaimsNew" VALUES (1, 'Travel', 56, 350, 'IT');
INSERT INTO "ClaimsNew" VALUES (2, 'Vehicle', 26, 6230, 'Marketing');
INSERT INTO "ClaimsNew" VALUES (3, 'Home', 55, 2300, 'Marketing');
INSERT INTO "ClaimsNew" VALUES (4, 'Vehicle', 31, 2134, 'Marketing');
INSERT INTO "ClaimsNew" VALUES (5, 'Home', 37, 2900, 'Sales');

-- predict
CALL "_SYS_AFL"."PAL_DECISION_TREE_PREDICT" ("ClaimsNew", "Model", "#Params", ?);
