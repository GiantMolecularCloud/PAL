-- create state

DROP TABLE "#Empty";
DROP TABLE "#Params";
DROP TABLE "State";

CREATE LOCAL TEMPORARY COLUMN TABLE "#Empty" ("id" INTEGER);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "State" ("name" VARCHAR(50), "value" VARCHAR(100));

INSERT INTO "#Params" VALUES ('ALGORITHM', 24, null, null); -- 1: SVM, 2: Random DT, 3: Decision Tree, 4: Cluster Assignment, 5: LDA Inference, 6: Binning, 7: Naive Bayes, 8: PCA, 9: BPNN, 11: FRM, 16: Multiple Linear Regression, 20: Logistic Regression, 24: ALS
INSERT INTO "#Params" VALUES ('STATE_DESCRIPTION', null, null, 'My Trained ALS Model');

CALL "_SYS_AFL"."PAL_CREATE_MODEL_STATE" ("ModelMetadata", "ModelMap", "ModelFactors", "#Empty", "#Empty", "#Params", "State") WITH OVERVIEW;

SELECT * FROM "State";

SELECT * FROM "SYS"."M_AFL_STATES";


-- predict with state

DROP TABLE "RatingsNew";
DROP TABLE "EmptyModelMetadata";
DROP TABLE "EmptyModelMap";
DROP TABLE "EmptyModelFactors";
TRUNCATE TABLE "#Params";

CREATE COLUMN TABLE "RatingsNew" ("id" INTEGER, "user" NVARCHAR(255), "album" NVARCHAR(255));
CREATE COLUMN TABLE "EmptyModelMetadata" LIKE "ModelMetadata";
CREATE COLUMN TABLE "EmptyModelMap" LIKE "ModelMap";
CREATE COLUMN TABLE "EmptyModelFactors" LIKE "ModelFactors";

INSERT INTO "#Params" ("name", "stringArgs") SELECT "name", "value" FROM "State";

TRUNCATE TABLE "RatingsNew";
INSERT INTO "RatingsNew" VALUES (1,'Julie','Led Zeppelin IV');
--INSERT INTO "RatingsNew" VALUES (1,'Jamie','Born in the U.S.A.');

CALL "_SYS_AFL"."PAL_ALS_PREDICT" ("RatingsNew", "EmptyModelMetadata", "EmptyModelMap", "EmptyModelFactors", "#Params", ?);


-- delete state

TRUNCATE TABLE "#Params";

CALL "_SYS_AFL"."PAL_DELETE_MODEL_STATE" ("State", "#Params", ?);

TRUNCATE TABLE "State";

SELECT * FROM "SYS"."M_AFL_STATES";
