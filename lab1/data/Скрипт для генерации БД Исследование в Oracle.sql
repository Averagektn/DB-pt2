/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.0 		*/
/* ---------------------------------------------------- */

/* Drop Triggers, Sequences for Autonumber Columns */

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_cities_ct_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_cities_ct_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_cities_ct_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_cities_ct_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_computers_c_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_computers_c_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_computers_c_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_computers_c_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_library_in_json_lij_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_library_in_json_lij_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_library_in_json_lij_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_library_in_json_lij_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_rooms_r_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_rooms_r_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_rooms_r_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_rooms_r_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_shopping_sh_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_shopping_sh_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_shopping_sh_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_shopping_sh_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_site_pages_sp_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_site_pages_sp_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_site_pages_sp_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_site_pages_sp_id"'; 
END IF; 
END;
/


DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_TRIGGERS 
  WHERE TRIGGER_NAME = 'TRG_test_counts_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP TRIGGER "TRG_test_counts_id"'; 
END IF; 
END;
/

DECLARE 
  C NUMBER; 
BEGIN 
SELECT COUNT(*) INTO C 
FROM USER_SEQUENCES 
  WHERE SEQUENCE_NAME = 'SEQ_test_counts_id'; 
  IF (C > 0) THEN 
    EXECUTE IMMEDIATE 'DROP SEQUENCE "SEQ_test_counts_id"'; 
END IF; 
END;
/


/* Drop Tables */

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "cities" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "computers" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "connections" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "dates" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "library_in_json" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "overflow" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "rooms" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "shopping" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "site_pages" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "table_with_nulls" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

begin
	EXECUTE IMMEDIATE 'DROP TABLE   "test_counts" CASCADE CONSTRAINTS';
	EXCEPTION WHEN OTHERS THEN NULL;
end;
/

/* Create Tables */

CREATE TABLE  "cities"
(
	"ct_id" NUMBER(10) NOT NULL,
	"ct_name" NVARCHAR2(50) NOT NULL
)
;

CREATE TABLE  "computers"
(
	"c_id" NUMBER(10) NOT NULL,
	"c_room" NUMBER(10) NULL,
	"c_name" NVARCHAR2(50) NOT NULL
)
;

CREATE TABLE  "connections"
(
	"cn_from" NUMBER(10) NOT NULL,
	"cn_to" NUMBER(10) NOT NULL,
	"cn_cost" NUMBER(15,4) NULL,
	"cn_bidir" CHAR(1) NOT NULL
)
;

CREATE TABLE  "dates"
(
	"d" DATE NULL
)
;

CREATE TABLE  "library_in_json"
(
	"lij_id" NUMBER(10) NOT NULL,
	"lij_book" NVARCHAR2(150) NOT NULL,
	"lij_author" NVARCHAR2(2000) NOT NULL,
	"lij_genre" NVARCHAR2(2000) NOT NULL
)
;

CREATE TABLE  "overflow"
(
	"x" NUMBER(10) NULL
)
;

CREATE TABLE  "rooms"
(
	"r_id" NUMBER(10) NOT NULL,
	"r_name" NVARCHAR2(50) NOT NULL,
	"r_space" NUMBER(3) NOT NULL
)
;

CREATE TABLE  "shopping"
(
	"sh_id" NUMBER(10) NOT NULL,
	"sh_transaction" NUMBER(10) NOT NULL,
	"sh_category" NVARCHAR2(150) NOT NULL
)
;

CREATE TABLE  "site_pages"
(
	"sp_id" NUMBER(10) NOT NULL,
	"sp_parent" NUMBER(10) NULL,
	"sp_name" NVARCHAR2(200) NULL
)
;

CREATE TABLE  "table_with_nulls"
(
	"x" NUMBER(10) NULL
)
;

CREATE TABLE  "test_counts"
(
	"id" NUMBER(10) NOT NULL,
	"fni" NUMBER(10) NULL,
	"fwi" NUMBER(10) NULL,
	"fni_nn" NUMBER(10) NOT NULL,
	"fwi_nn" NUMBER(10) NOT NULL
)
;

/* Create Comments, Sequences and Triggers for Autonumber Columns */

CREATE SEQUENCE "SEQ_cities_ct_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_cities_ct_id" 
	BEFORE INSERT 
	ON "cities" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_cities_ct_id".NEXTVAL 
		INTO :NEW."ct_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_computers_c_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_computers_c_id" 
	BEFORE INSERT 
	ON "computers" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_computers_c_id".NEXTVAL 
		INTO :NEW."c_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_library_in_json_lij_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_library_in_json_lij_id" 
	BEFORE INSERT 
	ON "library_in_json" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_library_in_json_lij_id".NEXTVAL 
		INTO :NEW."lij_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_rooms_r_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_rooms_r_id" 
	BEFORE INSERT 
	ON "rooms" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_rooms_r_id".NEXTVAL 
		INTO :NEW."r_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_shopping_sh_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_shopping_sh_id" 
	BEFORE INSERT 
	ON "shopping" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_shopping_sh_id".NEXTVAL 
		INTO :NEW."sh_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_site_pages_sp_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_site_pages_sp_id" 
	BEFORE INSERT 
	ON "site_pages" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_site_pages_sp_id".NEXTVAL 
		INTO :NEW."sp_id" 
		FROM DUAL; 
	END;

/


CREATE SEQUENCE "SEQ_test_counts_id" 
	INCREMENT BY 1 
	START WITH 1 
	NOMAXVALUE 
	MINVALUE  1 
	NOCYCLE 
	NOCACHE 
	NOORDER
;


CREATE OR REPLACE TRIGGER "TRG_test_counts_id" 
	BEFORE INSERT 
	ON "test_counts" 
	FOR EACH ROW 
	BEGIN 
		SELECT "SEQ_test_counts_id".NEXTVAL 
		INTO :NEW."id" 
		FROM DUAL; 
	END;

/


/* Create Primary Keys, Indexes, Uniques, Checks, Triggers */

ALTER TABLE  "cities" 
 ADD CONSTRAINT "PK_cities"
	PRIMARY KEY ("ct_id") 
 USING INDEX
;

ALTER TABLE  "computers" 
 ADD CONSTRAINT "PK_computers"
	PRIMARY KEY ("c_id") 
 USING INDEX
;

ALTER TABLE  "connections" 
 ADD CONSTRAINT "PK_connections"
	PRIMARY KEY ("cn_to","cn_from") 
 USING INDEX
;

ALTER TABLE  "connections" 
 ADD CONSTRAINT "CHK_bidir" CHECK ("cn_bidir" IN ('N','Y'))
;

CREATE INDEX "idx_d"   
 ON  "dates" ("d") 
;

ALTER TABLE  "library_in_json" 
 ADD CONSTRAINT "PK_library_in_json"
	PRIMARY KEY ("lij_id") 
 USING INDEX
;

ALTER TABLE  "library_in_json" 
 ADD CONSTRAINT "lij_author_is_JSON" CHECK ("lij_author" IS JSON)
;

ALTER TABLE  "library_in_json" 
 ADD CONSTRAINT "lij_genre_is_JSON" CHECK ("lij_genre" IS JSON)
;

ALTER TABLE  "rooms" 
 ADD CONSTRAINT "PK_rooms"
	PRIMARY KEY ("r_id") 
 USING INDEX
;

ALTER TABLE  "shopping" 
 ADD CONSTRAINT "PK_shopping"
	PRIMARY KEY ("sh_id") 
 USING INDEX
;

ALTER TABLE  "site_pages" 
 ADD CONSTRAINT "PK_site_pages"
	PRIMARY KEY ("sp_id") 
 USING INDEX
;

ALTER TABLE  "test_counts" 
 ADD CONSTRAINT "PK_test_counts"
	PRIMARY KEY ("id") 
 USING INDEX
;

CREATE INDEX "idx_fwi"   
 ON  "test_counts" ("fwi") 
;

CREATE INDEX "idx_fwi_nn"   
 ON  "test_counts" ("fwi_nn") 
;

/* Create Foreign Key Constraints */

ALTER TABLE  "computers" 
 ADD CONSTRAINT "FK_computers_rooms"
	FOREIGN KEY ("c_room") REFERENCES  "rooms" ("r_id") ON DELETE Cascade
;

ALTER TABLE  "connections" 
 ADD CONSTRAINT "FK_connections_cities1"
	FOREIGN KEY ("cn_from") REFERENCES  "cities" ("ct_id") ON DELETE Cascade
;

ALTER TABLE  "connections" 
 ADD CONSTRAINT "FK_connections_cities2"
	FOREIGN KEY ("cn_to") REFERENCES  "cities" ("ct_id") ON DELETE Cascade
;

ALTER TABLE  "site_pages" 
 ADD CONSTRAINT "FK_site_pages_site_pages"
	FOREIGN KEY ("sp_parent") REFERENCES  "site_pages" ("sp_id")
;
