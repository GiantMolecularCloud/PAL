-- train

DROP TABLE "AdServed";
DROP TABLE "#Params";
DROP TABLE "Meta";
DROP TABLE "Coefficient";
DROP TABLE "Statistics";
DROP TABLE "CV";

CREATE COLUMN TABLE "AdServed" ("advertId" INTEGER, "hour" INTEGER, "click" INTEGER, deviceType NVARCHAR(100), site NVARCHAR(100));
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Meta" ("id" INTEGER, "metaValue" NVARCHAR(5000));
CREATE COLUMN TABLE "Coefficient" ("id" INTEGER, "feature" NVARCHAR(1000), "field" NVARCHAR(1000), "k" INTEGER, "coeff" DOUBLE);
CREATE COLUMN TABLE "Statistics" ("name" NVARCHAR(100), "value" NVARCHAR(100));
CREATE COLUMN TABLE "CV" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));

INSERT INTO "AdServed" VALUES (1, 1, 0, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (1, 1, 0, 'Desktop', 'Google');
INSERT INTO "AdServed" VALUES (1, 2, 1, 'Tablet', 'Google');
INSERT INTO "AdServed" VALUES (1, 2, 0, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (1, 2, 1, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (1, 3, 0, 'Desktop', 'CNN');
INSERT INTO "AdServed" VALUES (1, 3, 0, 'Phone', 'CNN');
INSERT INTO "AdServed" VALUES (1, 3, 0, 'Phone', 'CNN');
INSERT INTO "AdServed" VALUES (1, 4, 0, 'Desktop', 'CNN');
INSERT INTO "AdServed" VALUES (1, 4, 1, 'Phone', 'CNN');
INSERT INTO "AdServed" VALUES (1, 5, 1, 'Tablet', 'CNN');
INSERT INTO "AdServed" VALUES (2, 1, 0, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (2, 1, 0, 'Desktop', 'Google');
INSERT INTO "AdServed" VALUES (2, 1, 0, 'Desktop', 'Google');
INSERT INTO "AdServed" VALUES (2, 2, 0, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (2, 2, 1, 'Phone', 'Google');
INSERT INTO "AdServed" VALUES (2, 2, 0, 'Desktop', 'CNN');
INSERT INTO "AdServed" VALUES (2, 3, 0, 'Desktop', 'CNN');
INSERT INTO "AdServed" VALUES (2, 3, 1, 'Phone', 'CNN');
INSERT INTO "AdServed" VALUES (2, 4, 0, 'Tablet', 'CNN');
INSERT INTO "AdServed" VALUES (2, 5, 0, 'Phone', 'CNN');
INSERT INTO "AdServed" VALUES (2, 5, 1, 'Tablet', 'CNN');

INSERT INTO "#Params" VALUES ('HAS_ID', 1, null, null); 
INSERT INTO "#Params" VALUES ('CATEGORICAL_VARIABLE', null, null, 'hour'); 
INSERT INTO "#Params" VALUES ('CATEGORICAL_VARIABLE', null, null, 'click'); 
INSERT INTO "#Params" VALUES ('DEPENDENT_VARIABLE', null, null, 'click'); 

CALL "_SYS_AFL"."PAL_FFM" ("AdServed", "#Params", "Meta", "Coefficient", "Statistics", "CV") WITH OVERVIEW;

SELECT * FROM "Meta";
SELECT * FROM "Coefficient";
SELECT * FROM "Statistics";
SELECT * FROM "CV";


-- predict

DROP TABLE "Data";
DROP TABLE "#Params";
DROP TABLE "Predictions";

CREATE COLUMN TABLE "Data" ("id" INTEGER, "hour" INTEGER, deviceType NVARCHAR(100), site NVARCHAR(100));
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Predictions" ("id" INTEGER, "score" NVARCHAR(100), "confidence" DOUBLE);

INSERT INTO "Data" VALUES (1, 1, 'Tablet', 'Google');
INSERT INTO "Data" VALUES (2, 3, 'Phone', 'CNN');
INSERT INTO "Data" VALUES (3, 5, 'Tablet', 'CNN');

CALL "_SYS_AFL"."PAL_FFM_PREDICT" ("Data", "Meta", "Coefficient", "#Params", "Predictions") WITH OVERVIEW;

SELECT * FROM "Predictions";
