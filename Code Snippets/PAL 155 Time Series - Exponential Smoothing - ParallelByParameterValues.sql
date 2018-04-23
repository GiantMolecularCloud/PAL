-- single group, generic parameters

DROP TABLE "StockPrices";
DROP TABLE "#Params";
DROP TABLE "Forecast";
DROP TABLE "Statistics";

CREATE TABLE "StockPrices" ("timeId" INTEGER, "price" DOUBLE);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Forecast" ("timeId" INTEGER, "predictedPrice" DOUBLE, "pi1Lower" DOUBLE, "pi1Upper" DOUBLE, "pi2Lower" DOUBLE, "pi2Upper" DOUBLE);
CREATE COLUMN TABLE "Statistics" ("name" NVARCHAR(100), "value" NVARCHAR(100));

INSERT INTO "StockPrices" VALUES (1, 362);
INSERT INTO "StockPrices" VALUES (2, 385);
INSERT INTO "StockPrices" VALUES (3, 432);
INSERT INTO "StockPrices" VALUES (4, 341);
INSERT INTO "StockPrices" VALUES (5, 382);
INSERT INTO "StockPrices" VALUES (6, 409);
INSERT INTO "StockPrices" VALUES (7, 498);
INSERT INTO "StockPrices" VALUES (8, 387);
INSERT INTO "StockPrices" VALUES (9, 473);
INSERT INTO "StockPrices" VALUES (10, 513);
INSERT INTO "StockPrices" VALUES (11, 582);
INSERT INTO "StockPrices" VALUES (12, 474);

INSERT INTO "#Params" VALUES ('MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES ('FORECAST_NUM', 3, null, null); 

CALL "_SYS_AFL"."PAL_AUTO_EXPSMOOTH" ("StockPrices", "#Params", "Forecast", "Statistics") WITH OVERVIEW;


-- single group, multiple parameter sets

DROP TABLE "StockPrices";
DROP TABLE "#Params";
DROP TABLE "Forecast";
DROP TABLE "Statistics";

CREATE TABLE "StockPrices" ("timeId" INTEGER, "price" DOUBLE);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("modelId" INTEGER, "name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Forecast" ("modelId" INTEGER, "timeId" INTEGER, "predictedPrice" DOUBLE, "pi1Lower" DOUBLE, "pi1Upper" DOUBLE, "pi2Lower" DOUBLE, "pi2Upper" DOUBLE);
CREATE COLUMN TABLE "Statistics" ("modelId" INTEGER, "name" NVARCHAR(100), "value" NVARCHAR(100));

INSERT INTO "StockPrices" VALUES (1, 362);
INSERT INTO "StockPrices" VALUES (2, 385);
INSERT INTO "StockPrices" VALUES (3, 432);
INSERT INTO "StockPrices" VALUES (4, 341);
INSERT INTO "StockPrices" VALUES (5, 382);
INSERT INTO "StockPrices" VALUES (6, 409);
INSERT INTO "StockPrices" VALUES (7, 498);
INSERT INTO "StockPrices" VALUES (8, 387);
INSERT INTO "StockPrices" VALUES (9, 473);
INSERT INTO "StockPrices" VALUES (10, 513);
INSERT INTO "StockPrices" VALUES (11, 582);
INSERT INTO "StockPrices" VALUES (12, 474);

INSERT INTO "#Params" VALUES (1, 'MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES (1, 'FORECAST_NUM', 3, null, null); 
INSERT INTO "#Params" VALUES (1, 'INITIAL_METHOD', 0, null, null); 
INSERT INTO "#Params" VALUES (2, 'MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES (2, 'FORECAST_NUM', 3, null, null); 
INSERT INTO "#Params" VALUES (2, 'INITIAL_METHOD', 1, null, null); 
INSERT INTO "#Params" VALUES (2, 'PREDICTION_CONFIDENCE_1', null, 0.75, null); 
INSERT INTO "#Params" VALUES (2, 'PREDICTION_CONFIDENCE_2', null, 0.90, null); 

CALL "_SYS_AFL"."PAL_AUTO_EXPSMOOTH" ("StockPrices", "#Params", "Forecast", "Statistics") WITH OVERVIEW WITH HINT (PARALLEL_BY_PARAMETER_VALUES(p2."modelId"));


-- multiple groups, generic parameters

DROP TABLE "StockPrices";
DROP TABLE "#Params";
DROP TABLE "Forecast";
DROP TABLE "Statistics";

CREATE TABLE "StockPrices" ("stockId" VARCHAR(3), "timeId" INTEGER, "price" DOUBLE);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Forecast" ("stockId" VARCHAR(3), "timeId" INTEGER, "predictedPrice" DOUBLE, "pi1Lower" DOUBLE, "pi1Upper" DOUBLE, "pi2Lower" DOUBLE, "pi2Upper" DOUBLE);
CREATE COLUMN TABLE "Statistics" ("stockId" VARCHAR(3), "name" NVARCHAR(100), "value" NVARCHAR(100));

INSERT INTO "StockPrices" VALUES ('ABC', 1, 362);
INSERT INTO "StockPrices" VALUES ('ABC', 2, 385);
INSERT INTO "StockPrices" VALUES ('ABC', 3, 432);
INSERT INTO "StockPrices" VALUES ('ABC', 4, 341);
INSERT INTO "StockPrices" VALUES ('ABC', 5, 382);
INSERT INTO "StockPrices" VALUES ('ABC', 6, 409);
INSERT INTO "StockPrices" VALUES ('ABC', 7, 498);
INSERT INTO "StockPrices" VALUES ('ABC', 8, 387);
INSERT INTO "StockPrices" VALUES ('ABC', 9, 473);
INSERT INTO "StockPrices" VALUES ('ABC', 10, 513);
INSERT INTO "StockPrices" VALUES ('ABC', 11, 582);
INSERT INTO "StockPrices" VALUES ('ABC', 12, 474);
INSERT INTO "StockPrices" VALUES ('XYZ', 1, 544);
INSERT INTO "StockPrices" VALUES ('XYZ', 2, 582);
INSERT INTO "StockPrices" VALUES ('XYZ', 3, 681);
INSERT INTO "StockPrices" VALUES ('XYZ', 4, 557);
INSERT INTO "StockPrices" VALUES ('XYZ', 5, 626);
INSERT INTO "StockPrices" VALUES ('XYZ', 6, 654);
INSERT INTO "StockPrices" VALUES ('XYZ', 7, 691);
INSERT INTO "StockPrices" VALUES ('XYZ', 8, 712);
INSERT INTO "StockPrices" VALUES ('XYZ', 9, 674);
INSERT INTO "StockPrices" VALUES ('XYZ', 10, 732);
INSERT INTO "StockPrices" VALUES ('XYZ', 11, 745);
INSERT INTO "StockPrices" VALUES ('XYZ', 12, 775);

INSERT INTO "#Params" VALUES ('MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES ('FORECAST_NUM', 3, null, null); 

CALL "_SYS_AFL"."PAL_AUTO_EXPSMOOTH" ("StockPrices", "#Params", "Forecast", "Statistics") WITH OVERVIEW WITH HINT (PARALLEL_BY_PARAMETER_VALUES(p1."stockId"));


-- multiple groups, group-specific parameters

DROP TABLE "StockPrices";
DROP TABLE "#Params";
DROP TABLE "Forecast";
DROP TABLE "Statistics";

CREATE TABLE "StockPrices" ("stockId" VARCHAR(3), "timeId" INTEGER, "price" DOUBLE);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("stockId" VARCHAR(3), "name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Forecast" ("stockId" VARCHAR(3), "timeId" INTEGER, "predictedPrice" DOUBLE, "pi1Lower" DOUBLE, "pi1Upper" DOUBLE, "pi2Lower" DOUBLE, "pi2Upper" DOUBLE);
CREATE COLUMN TABLE "Statistics" ("stockId" VARCHAR(3), "name" NVARCHAR(100), "value" NVARCHAR(100));

INSERT INTO "StockPrices" VALUES ('ABC', 1, 362);
INSERT INTO "StockPrices" VALUES ('ABC', 2, 385);
INSERT INTO "StockPrices" VALUES ('ABC', 3, 432);
INSERT INTO "StockPrices" VALUES ('ABC', 4, 341);
INSERT INTO "StockPrices" VALUES ('ABC', 5, 382);
INSERT INTO "StockPrices" VALUES ('ABC', 6, 409);
INSERT INTO "StockPrices" VALUES ('ABC', 7, 498);
INSERT INTO "StockPrices" VALUES ('ABC', 8, 387);
INSERT INTO "StockPrices" VALUES ('ABC', 9, 473);
INSERT INTO "StockPrices" VALUES ('ABC', 10, 513);
INSERT INTO "StockPrices" VALUES ('ABC', 11, 582);
INSERT INTO "StockPrices" VALUES ('ABC', 12, 474);
INSERT INTO "StockPrices" VALUES ('XYZ', 1, 544);
INSERT INTO "StockPrices" VALUES ('XYZ', 2, 582);
INSERT INTO "StockPrices" VALUES ('XYZ', 3, 681);
INSERT INTO "StockPrices" VALUES ('XYZ', 4, 557);
INSERT INTO "StockPrices" VALUES ('XYZ', 5, 626);
INSERT INTO "StockPrices" VALUES ('XYZ', 6, 654);
INSERT INTO "StockPrices" VALUES ('XYZ', 7, 691);
INSERT INTO "StockPrices" VALUES ('XYZ', 8, 712);
INSERT INTO "StockPrices" VALUES ('XYZ', 9, 674);
INSERT INTO "StockPrices" VALUES ('XYZ', 10, 732);
INSERT INTO "StockPrices" VALUES ('XYZ', 11, 745);
INSERT INTO "StockPrices" VALUES ('XYZ', 12, 775);

INSERT INTO "#Params" VALUES ('ABC', 'MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES ('ABC', 'FORECAST_NUM', 3, null, null); 
INSERT INTO "#Params" VALUES ('ABC', 'INITIAL_METHOD', 0, null, null); 
INSERT INTO "#Params" VALUES ('XYZ', 'MODELSELECTION', 1, null, null); 
INSERT INTO "#Params" VALUES ('XYZ', 'FORECAST_NUM', 3, null, null); 
INSERT INTO "#Params" VALUES ('XYZ', 'INITIAL_METHOD', 1, null, null); 
INSERT INTO "#Params" VALUES ('XYZ', 'PREDICTION_CONFIDENCE_1', null, 0.75, null); 
INSERT INTO "#Params" VALUES ('XYZ', 'PREDICTION_CONFIDENCE_2', null, 0.90, null); 

CALL "_SYS_AFL"."PAL_AUTO_EXPSMOOTH" ("StockPrices", "#Params", "Forecast", "Statistics") WITH OVERVIEW WITH HINT (PARALLEL_BY_PARAMETER_VALUES(p1."stockId", p2."stockId"));
