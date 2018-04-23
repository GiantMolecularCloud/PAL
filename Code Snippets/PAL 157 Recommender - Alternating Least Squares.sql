-- train

DROP TABLE "Ratings";
DROP TABLE "#Params";
DROP TABLE "ModelMetadata";
DROP TABLE "ModelMap";
DROP TABLE "ModelFactors";
DROP TABLE "IterationInfo";
DROP TABLE "Statistics";
DROP TABLE "OptimalParameters";

CREATE COLUMN TABLE "Ratings" ("user" NVARCHAR(255), "album" NVARCHAR(255), "rating" INTEGER);
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "ModelMetadata" ("id" INTEGER, "content" NVARCHAR(5000));
CREATE COLUMN TABLE "ModelMap" ("id" INTEGER, "map" NVARCHAR(1000));
CREATE COLUMN TABLE "ModelFactors" ("factorId" INTEGER, "factors" DOUBLE);
CREATE COLUMN TABLE "IterationInfo" ("iteration" NVARCHAR(100), "costFunctionValue" NVARCHAR(100), "rootMeanSquareError" NVARCHAR(100));
CREATE COLUMN TABLE "Statistics" ("name" NVARCHAR(255), "value" NVARCHAR(1000));
CREATE COLUMN TABLE "OptimalParameters" ("param" NVARCHAR(255), "int" INTEGER, "double" DOUBLE, "string" NVARCHAR(1000));

INSERT INTO "Ratings" VALUES ('Julie','Thriller',9);
INSERT INTO "Ratings" VALUES ('Julie','The Dark Side of the Moon',10);
INSERT INTO "Ratings" VALUES ('Julie','Bat Out of Hell',8);
INSERT INTO "Ratings" VALUES ('Julie','Bad',6);
INSERT INTO "Ratings" VALUES ('Julie','Hotel California',10);
INSERT INTO "Ratings" VALUES ('Julie','Dangerous',6);
INSERT INTO "Ratings" VALUES ('Julie','Dirty Dancing',8);
INSERT INTO "Ratings" VALUES ('Julie','Abbey Road',8);
INSERT INTO "Ratings" VALUES ('Julie','Born in the U.S.A.',9);
INSERT INTO "Ratings" VALUES ('Julie','Brothers in Arms',8);
INSERT INTO "Ratings" VALUES ('Julie','Metallica',4);
INSERT INTO "Ratings" VALUES ('Julie','Nevermind',8);
INSERT INTO "Ratings" VALUES ('Julie','The Wall',10);
INSERT INTO "Ratings" VALUES ('Bob','The Dark Side of the Moon',10);
INSERT INTO "Ratings" VALUES ('Bob','Bat Out of Hell',2);
INSERT INTO "Ratings" VALUES ('Bob','Led Zeppelin IV',8);
INSERT INTO "Ratings" VALUES ('Bob','Bad',3);
INSERT INTO "Ratings" VALUES ('Bob','Hotel California',8);
INSERT INTO "Ratings" VALUES ('Bob','Dangerous',2);
INSERT INTO "Ratings" VALUES ('Bob','Dirty Dancing',1);
INSERT INTO "Ratings" VALUES ('Bob','Abbey Road',8);
INSERT INTO "Ratings" VALUES ('Bob','Born in the U.S.A.',7);
INSERT INTO "Ratings" VALUES ('Bob','Brothers in Arms',8);
INSERT INTO "Ratings" VALUES ('Bob','Metallica',7);
INSERT INTO "Ratings" VALUES ('Bob','Nevermind',8);
INSERT INTO "Ratings" VALUES ('Bob','The Wall',7);
INSERT INTO "Ratings" VALUES ('Joe','The Dark Side of the Moon',8);
INSERT INTO "Ratings" VALUES ('Joe','Bat Out of Hell',1);
INSERT INTO "Ratings" VALUES ('Joe','Led Zeppelin IV',4);
INSERT INTO "Ratings" VALUES ('Joe','Bad',5);
INSERT INTO "Ratings" VALUES ('Joe','Hotel California',10);
INSERT INTO "Ratings" VALUES ('Joe','Dangerous',4);
INSERT INTO "Ratings" VALUES ('Joe','Dirty Dancing',7);
INSERT INTO "Ratings" VALUES ('Joe','Abbey Road',10);
INSERT INTO "Ratings" VALUES ('Joe','Born in the U.S.A.',4);
INSERT INTO "Ratings" VALUES ('Joe','Brothers in Arms',5);
INSERT INTO "Ratings" VALUES ('Joe','Metallica',1);
INSERT INTO "Ratings" VALUES ('Joe','Nevermind',1);
INSERT INTO "Ratings" VALUES ('Joe','The Wall',9);
INSERT INTO "Ratings" VALUES ('Denys','The Dark Side of the Moon',1);
INSERT INTO "Ratings" VALUES ('Denys','Bat Out of Hell',1);
INSERT INTO "Ratings" VALUES ('Denys','Led Zeppelin IV',5);
INSERT INTO "Ratings" VALUES ('Denys','Bad',1);
INSERT INTO "Ratings" VALUES ('Denys','Hotel California',6);
INSERT INTO "Ratings" VALUES ('Denys','Dangerous',1);
INSERT INTO "Ratings" VALUES ('Denys','Dirty Dancing',6);
INSERT INTO "Ratings" VALUES ('Denys','Abbey Road',6);
INSERT INTO "Ratings" VALUES ('Denys','Born in the U.S.A.',7);
INSERT INTO "Ratings" VALUES ('Denys','Brothers in Arms',5);
INSERT INTO "Ratings" VALUES ('Denys','Metallica',7);
INSERT INTO "Ratings" VALUES ('Denys','Nevermind',7);
INSERT INTO "Ratings" VALUES ('Denys','The Wall',1);
INSERT INTO "Ratings" VALUES ('Tom','The Dark Side of the Moon',10);
INSERT INTO "Ratings" VALUES ('Tom','Bat Out of Hell',7);
INSERT INTO "Ratings" VALUES ('Tom','Led Zeppelin IV',10);
INSERT INTO "Ratings" VALUES ('Tom','Bad',5);
INSERT INTO "Ratings" VALUES ('Tom','Hotel California',6);
INSERT INTO "Ratings" VALUES ('Tom','Dangerous',4);
INSERT INTO "Ratings" VALUES ('Tom','Dirty Dancing',6);
INSERT INTO "Ratings" VALUES ('Tom','Abbey Road',5);
INSERT INTO "Ratings" VALUES ('Tom','Born in the U.S.A.',5);
INSERT INTO "Ratings" VALUES ('Tom','Brothers in Arms',8);
INSERT INTO "Ratings" VALUES ('Tom','Metallica',10);
INSERT INTO "Ratings" VALUES ('Tom','Nevermind',9);
INSERT INTO "Ratings" VALUES ('Tom','The Wall',9);
INSERT INTO "Ratings" VALUES ('Jamie','The Dark Side of the Moon',6);
INSERT INTO "Ratings" VALUES ('Jamie','Bat Out of Hell',4);
INSERT INTO "Ratings" VALUES ('Jamie','Led Zeppelin IV',3);
INSERT INTO "Ratings" VALUES ('Jamie','Bad',2);
INSERT INTO "Ratings" VALUES ('Jamie','Hotel California',5);
INSERT INTO "Ratings" VALUES ('Jamie','Dangerous',2);
INSERT INTO "Ratings" VALUES ('Jamie','Dirty Dancing',2);
INSERT INTO "Ratings" VALUES ('Jamie','Abbey Road',2);
INSERT INTO "Ratings" VALUES ('Jamie','Brothers in Arms',3);
INSERT INTO "Ratings" VALUES ('Jamie','Metallica',7);
INSERT INTO "Ratings" VALUES ('Jamie','Nevermind',7);
INSERT INTO "Ratings" VALUES ('Jamie','The Wall',6);
INSERT INTO "Ratings" VALUES ('Philip','The Dark Side of the Moon',10);
INSERT INTO "Ratings" VALUES ('Philip','Bat Out of Hell',7);
INSERT INTO "Ratings" VALUES ('Philip','Led Zeppelin IV',8);
INSERT INTO "Ratings" VALUES ('Philip','Bad',6);
INSERT INTO "Ratings" VALUES ('Philip','Hotel California',8);
INSERT INTO "Ratings" VALUES ('Philip','Dangerous',5);
INSERT INTO "Ratings" VALUES ('Philip','Dirty Dancing',4);
INSERT INTO "Ratings" VALUES ('Philip','Abbey Road',8);
INSERT INTO "Ratings" VALUES ('Philip','Born in the U.S.A.',5);
INSERT INTO "Ratings" VALUES ('Philip','Brothers in Arms',7);
INSERT INTO "Ratings" VALUES ('Philip','Metallica',6);
INSERT INTO "Ratings" VALUES ('Philip','Nevermind',6);
INSERT INTO "Ratings" VALUES ('Philip','The Wall',9);

INSERT INTO "#Params" VALUES ('IMPLICIT_TRAIN', 0, null, null); -- 0: explicit ALS, 1: implicit ALS
INSERT INTO "#Params" VALUES ('FACTOR_NUMBER', 2, null, null); -- default: 8
INSERT INTO "#Params" VALUES ('LINEAR_SYSTEM_SOLVER', 0, null, null); -- default: 0 cholesky, 1: cg solver
INSERT INTO "#Params" VALUES ('MAX_ITERATION', 100, null, null); -- default: 20
INSERT INTO "#Params" VALUES ('SEED', 0, null, null); -- default: 0 use current time

CALL "_SYS_AFL"."PAL_ALS" ("Ratings", "#Params", "ModelMetadata", "ModelMap", "ModelFactors", "IterationInfo", "Statistics", "OptimalParameters") WITH OVERVIEW;

SELECT * FROM "ModelMetadata";
SELECT * FROM "ModelMap";
SELECT * FROM "ModelFactors";
SELECT * FROM "IterationInfo";
SELECT * FROM "Statistics";
SELECT * FROM "OptimalParameters";


-- predict

DROP TABLE "RatingsNew";
DROP TABLE "#Params";
DROP TABLE "Predictions";

CREATE COLUMN TABLE "RatingsNew" ("id" INTEGER, "user" NVARCHAR(255), "album" NVARCHAR(255));
CREATE LOCAL TEMPORARY COLUMN TABLE "#Params" ("name" VARCHAR(60), "intArgs" INTEGER, "doubleArgs" DOUBLE, "stringArgs" VARCHAR(100));
CREATE COLUMN TABLE "Predictions" ("id" INTEGER, "user" NVARCHAR(255), "album" NVARCHAR(255), "predictedRating" INTEGER);

INSERT INTO "RatingsNew" VALUES (1,'Julie','Led Zeppelin IV');
INSERT INTO "RatingsNew" VALUES (2,'Jamie','Born in the U.S.A.');

CALL "_SYS_AFL"."PAL_ALS_PREDICT" ("RatingsNew", "ModelMetadata", "ModelMap", "ModelFactors", "#Params", "Predictions") WITH OVERVIEW;

SELECT * FROM "Predictions";
