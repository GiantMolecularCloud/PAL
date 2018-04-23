DROP TABLE "Data";
DROP TABLE "#Params";
DROP TABLE "Results";

CREATE COLUMN TABLE "Data" ("pageFrom" NVARCHAR(100), "pageTo" NVARCHAR(100));
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Results" ("page" NVARCHAR(100), "rank" DOUBLE);

INSERT INTO "Data" VALUES ('Home', 'About');
INSERT INTO "Data" VALUES ('Home', 'Product');
INSERT INTO "Data" VALUES ('Home', 'Links');
INSERT INTO "Data" VALUES ('About', 'Home');
INSERT INTO "Data" VALUES ('Product', 'Home');
INSERT INTO "Data" VALUES ('Links', 'Home');
INSERT INTO "Data" VALUES ('Links', 'External Site A');
INSERT INTO "Data" VALUES ('Links', 'External Site B');
INSERT INTO "Data" VALUES ('Links', 'External Site C');
INSERT INTO "Data" VALUES ('Links', 'External Site D');
INSERT INTO "Data" VALUES ('External Site A', 'Home');
INSERT INTO "Data" VALUES ('External Site A', 'Product');
INSERT INTO "Data" VALUES ('External Site B', 'Home');
INSERT INTO "Data" VALUES ('External Site C', 'Home');
INSERT INTO "Data" VALUES ('External Site D', 'Home');
INSERT INTO "Data" VALUES ('External Site D', 'Product');

INSERT INTO "#Params" VALUES ('DAMPING', null, 0.85, null); -- default: 0.85

CALL "_SYS_AFL"."PAL_PAGERANK" ("Data", "#Params", "Results") WITH OVERVIEW;

SELECT * FROM "Results";
