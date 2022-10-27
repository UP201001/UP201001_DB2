
--DROP TABLE IF ALREADY EXIST
DROP TABLE STAR_BILLINGS;
DROP TABLE ACTORS;
DROP TABLE RENTAL_HISTORY;
DROP TABLE MEDIA;
DROP TABLE MOVIES;
DROP TABLE CUSTOMERS;



--CREATE OF TABLES
CREATE TABLE CUSTOMERS ("CUSTOMER_ID" NUMBER(10),
                        "LAST_NAME" VARCHAR2(25) CONSTRAINT "CUS_LAST_NAME_NN" NOT NULL ENABLE,
                        "FIRST_NAME" VARCHAR2(25) CONSTRAINT "CUS_FIRST_NAME_NN" NOT NULL ENABLE,
                        "HOME_PHONE" VARCHAR2(12) CONSTRAINT "HOM_PHONE_NN" NOT NULL ENABLE,
                        "ADDRESS" VARCHAR2(100) CONSTRAINT "ADDRESS_NN" NOT NULL ENABLE,
                        "CITY" VARCHAR2(30) CONSTRAINT "CITY_NN" NOT NULL ENABLE,
                        "STATE" VARCHAR2(2) CONSTRAINT "STATE_NN" NOT NULL ENABLE,
                        "EMAIL" VARCHAR2(25),
                        "CELL_PHONE" VARCHAR2(12),
                        CONSTRAINT "CUS_ID_PK" PRIMARY KEY ("CUSTOMER_ID") USING INDEX ENABLE);
                       
CREATE TABLE MOVIES ("TITLE_ID" NUMBER(10),
                     "TITLE" VARCHAR2(60) CONSTRAINT "TITLE_NN" NOT NULL ENABLE,
                     "DESCRIPTION" VARCHAR2(400) CONSTRAINT "DESC_NN" NOT NULL ENABLE,
                     "RATING" VARCHAR2(4) CONSTRAINT "RATING_ALLOWED" CHECK ("RATING" IN ('G','PG','PG13','E','R')),
                     "CATEGORY" VARCHAR2(20) CONSTRAINT "CAT_ALLOWED" CHECK ("CATEGORY" IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTRY')),
                     "RELEASE_DATE" DATE CONSTRAINT "REL_DATE_NN" NOT NULL ENABLE,
                     CONSTRAINT "TIT_ID_PK" PRIMARY KEY ("TITLE_ID") USING INDEX ENABLE);
                     
CREATE TABLE MEDIA ("MEDIA_ID" NUMBER(10),
                    "FORMAT" VARCHAR2(3) CONSTRAINT "FORMAT_NN" NOT NULL ENABLE,
                    "TITLE_ID" NUMBER(10) CONSTRAINT "MED_TIT_NN" NOT NULL ENABLE,
                    CONSTRAINT "MED_ID_PK" PRIMARY KEY ("MEDIA_ID") USING INDEX ENABLE,
                    CONSTRAINT "MED_TIT_FK" FOREIGN KEY (TITLE_ID) REFERENCES MOVIES (TITLE_ID));                     

CREATE TABLE RENTAL_HISTORY ("MEDIA_ID" NUMBER(10),
                             "RENTAL_DATE" DATE DEFAULT SYSDATE CONSTRAINT "RENT_DATE_NN" NOT NULL ENABLE,
                             "CUSTOMER_ID" NUMBER(10) CONSTRAINT "RENT_HIST_CUST_ID_NN" NOT NULL ENABLE,
                             "RETURN_DATE" DATE,
                             CONSTRAINT "RENT_HIST_PK" PRIMARY KEY ("MEDIA_ID", "RENTAL_DATE") USING INDEX ENABLE,
                             CONSTRAINT "RENT_HIST_MEDIA_ID_FK" FOREIGN KEY ("MEDIA_ID") REFERENCES MEDIA ("MEDIA_ID"),
                             CONSTRAINT "RENT_HIST_CUST_ID_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES CUSTOMERS ("CUSTOMER_ID"));
                             
create table "ACTORS" (actor_id NUMBER(10),
                       stage_name VARCHAR2(25) CONSTRAINT stage_name_nn NOT NULL ENABLE,
                       first_name VARCHAR2(25) CONSTRAINT first_name_nn NOT NULL ENABLE,
                       last_name VARCHAR2(25) CONSTRAINT last_name_nn NOT NULL ENABLE,
                       birth_date DATE CONSTRAINT birth_date_nn NOT NULL ENABLE,
                       CONSTRAINT actors_pk PRIMARY KEY (actor_id) USING INDEX ENABLE);   

create table "STAR_BILLINGS" (actor_id NUMBER(10) CONSTRAINT actor_id_fk NOT NULL REFERENCES actors(actor_id),
                               title_id NUMBER(10) CONSTRAINT title_id_fk NOT NULL REFERENCES movies(title_id),
                               comments VARCHAR2(40),
                               CONSTRAINT star_billings_pk PRIMARY KEY (actor_id, title_id) USING INDEX ENABLE);


--DESCRIBE TABLES
DESC CUSTOMERS;
DESC RENTAL_HISTORY;
DESC MOVIES;
DESC MEDIA;
DESC ACTORS;
DESC STAR_BILLINGS;

--CREATE SEQUENCES
CREATE SEQUENCE customers_id_seq
start with 101
increment by 1
cache 50;

CREATE SEQUENCE movie_id_seq
start with 1
increment by 1
cache 50;

CREATE SEQUENCE media_id_seq
start with 92
increment by 1
cache 50;

CREATE SEQUENCE actors_id_seq
start with 1001
increment by 1
cache 50;


--CREATE INDEX FOR CUSTOMER'S LAST NAME 
CREATE INDEX customers_last_name_i
ON CUSTOMERS(last_name);

--CREATE VIEW TITLE_UNAVAIL
CREATE VIEW TITLE_UNAVAIL AS
SELECT m.title, f.media_id, r.rental_date, r.return_date
FROM movies m, media f, rental_history r
WHERE m.title_id = f.title_id AND f.media_id = r.media_id
                              AND r.return_date IS NULL
ORDER BY RENTAL_DATE
WITH READ ONLY;


--CREATE SYNONYM TU
CREATE SYNONYM TU FOR TITLE_UNAVAIL;

--select * FROM USER_SYS_PRIVS; 

