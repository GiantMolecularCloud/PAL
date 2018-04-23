DROP TABLE "HierarchyStructure";
DROP TABLE "SalesHistory";
DROP TABLE "SalesForecast";
DROP TABLE "#Params";
DROP TABLE "SalesPredicted";
DROP TABLE "Statistics";

CREATE COLUMN TABLE "HierarchyStructure" ("id" INTEGER, "geo" NVARCHAR(2), "children" INTEGER);
CREATE COLUMN TABLE "SalesHistory" ("geo" NVARCHAR(2), "year" INTEGER, "sales" DOUBLE, "residual" DOUBLE);
CREATE COLUMN TABLE "SalesForecast" ("geo" NVARCHAR(2), "year" INTEGER, "sales" DOUBLE);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "SalesPredicted" LIKE "SalesForecast";
CREATE COLUMN TABLE "Statistics" ("name" NVARCHAR(100), "value" NVARCHAR(100));

/*
ww		: Worldwide
 na		:  North America
  us	:   United States
  ca	:   Canada
 eu		:  Europe
  fr	:   France
  nl	:   Netherlands
  uk	:   United Kingdom
*/
INSERT INTO "HierarchyStructure" VALUES (1, 'ww', 2);
INSERT INTO "HierarchyStructure" VALUES (2, 'na', 2);
INSERT INTO "HierarchyStructure" VALUES (3, 'eu', 3);
INSERT INTO "HierarchyStructure" VALUES (4, 'us', 0);
INSERT INTO "HierarchyStructure" VALUES (5, 'ca', 0);
INSERT INTO "HierarchyStructure" VALUES (6, 'fr', 0);
INSERT INTO "HierarchyStructure" VALUES (7, 'nl', 0);
INSERT INTO "HierarchyStructure" VALUES (8, 'uk', 0);

INSERT INTO "SalesHistory" VALUES ('ww', 2015, 156, null);
INSERT INTO "SalesHistory" VALUES ('ww', 2016, 157, null);
INSERT INTO "SalesHistory" VALUES ('ww', 2017, 167, null);
INSERT INTO "SalesHistory" VALUES ('na', 2015, 77, null);
INSERT INTO "SalesHistory" VALUES ('na', 2016, 78, null);
INSERT INTO "SalesHistory" VALUES ('na', 2017, 80, null);
INSERT INTO "SalesHistory" VALUES ('eu', 2015, 79, null);
INSERT INTO "SalesHistory" VALUES ('eu', 2016, 79, null);
INSERT INTO "SalesHistory" VALUES ('eu', 2017, 87, null);
INSERT INTO "SalesHistory" VALUES ('us', 2015, 54, null);
INSERT INTO "SalesHistory" VALUES ('us', 2016, 56, null);
INSERT INTO "SalesHistory" VALUES ('us', 2017, 58, null);
INSERT INTO "SalesHistory" VALUES ('ca', 2015, 23, null);
INSERT INTO "SalesHistory" VALUES ('ca', 2016, 22, null);
INSERT INTO "SalesHistory" VALUES ('ca', 2017, 22, null);
INSERT INTO "SalesHistory" VALUES ('fr', 2015, 23, null);
INSERT INTO "SalesHistory" VALUES ('fr', 2016, 21, null);
INSERT INTO "SalesHistory" VALUES ('fr', 2017, 24, null);
INSERT INTO "SalesHistory" VALUES ('nl', 2015, 13, null);
INSERT INTO "SalesHistory" VALUES ('nl', 2016, 14, null);
INSERT INTO "SalesHistory" VALUES ('nl', 2017, 16, null);
INSERT INTO "SalesHistory" VALUES ('uk', 2015, 43, null);
INSERT INTO "SalesHistory" VALUES ('uk', 2016, 44, null);
INSERT INTO "SalesHistory" VALUES ('uk', 2017, 47, null);

-- top-down
INSERT INTO "SalesForecast" VALUES ('ww', 2018, 180);
INSERT INTO "SalesForecast" VALUES ('na', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('eu', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('us', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('ca', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('fr', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('nl', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('uk', 2018, 0);
/*
-- bottom-up
INSERT INTO "SalesForecast" VALUES ('ww', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('na', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('eu', 2018, 0);
INSERT INTO "SalesForecast" VALUES ('us', 2018, 59);
INSERT INTO "SalesForecast" VALUES ('ca', 2018, 21);
INSERT INTO "SalesForecast" VALUES ('fr', 2018, 25);
INSERT INTO "SalesForecast" VALUES ('nl', 2018, 17);
INSERT INTO "SalesForecast" VALUES ('uk', 2018, 49);

-- optimal combination
INSERT INTO "SalesForecast" VALUES ('ww', 2018, 180);
INSERT INTO "SalesForecast" VALUES ('na', 2018, 82);
INSERT INTO "SalesForecast" VALUES ('eu', 2018, 91);
INSERT INTO "SalesForecast" VALUES ('us', 2018, 59);
INSERT INTO "SalesForecast" VALUES ('ca', 2018, 21);
INSERT INTO "SalesForecast" VALUES ('fr', 2018, 25);
INSERT INTO "SalesForecast" VALUES ('nl', 2018, 17);
INSERT INTO "SalesForecast" VALUES ('uk', 2018, 49);
*/

INSERT INTO "#Params" VALUES ('METHOD', 2, null, null); -- 0: optimal combination, 1: bottom-up, 2: top-down
INSERT INTO "#Params" VALUES ('WEIGHTS', 0, null,null); -- 0: ols, 1: MinT, 2: wls (parameter only relevant when METHOD = 0)

CALL "_SYS_AFL"."PAL_HIERARCHICAL_FORECAST" ("SalesHistory", "SalesForecast", "HierarchyStructure", "#Params", "SalesPredicted", "Statistics") WITH OVERVIEW;

SELECT * FROM "SalesPredicted";
