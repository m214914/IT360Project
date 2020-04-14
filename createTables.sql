-- use m216762;

DROP TABLE IF EXISTS attribute_scores;
DROP TABLE IF EXISTS all_leadership;
DROP TABLE IF EXISTS all_physical;
DROP TABLE IF EXISTS prt;
DROP TABLE IF EXISTS pe_sports;
DROP TABLE IF EXISTS all_forms;
DROP TABLE IF EXISTS form1s;
DROP TABLE IF EXISTS all_moral;
DROP TABLE IF EXISTS all_maprs;
DROP TABLE IF EXISTS all_ac;
DROP TABLE IF EXISTS mids_all;
DROP TABLE IF EXISTS company;



CREATE TABLE company (code INTEGER,
                      officer VARCHAR(30),
                      CONSTRAINT PK_company PRIMARY KEY (code));



CREATE TABLE mids_all (alpha INTEGER,
                      fname VARCHAR(30),
                      lname VARCHAR(30),
                      company INTEGER,
                      gender CHAR(1),
                      CONSTRAINT PK_mids PRIMARY KEY (alpha),
                      CONSTRAINT FK_company FOREIGN KEY (company)
                                  REFERENCES company (code));



CREATE TABLE all_ac (alpha INTEGER,
                    CQPR DECIMAL,
                    SQPR DECIMAL,
                    MAPR_mean DECIMAL,
                    MGSP CHAR(1),
                    CONSTRAINT PK_ac PRIMARY KEY (alpha),
                    CONSTRAINT FK_ac FOREIGN KEY (alpha)
                                REFERENCES mids_all (alpha));

CREATE TABLE all_maprs (alpha INTEGER,
                        ID INTEGER,
                        score INTEGER,
                        CONSTRAINT PK_maprs PRIMARY KEY (alpha),
                        CONSTRAINT FK_mapr FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));



CREATE TABLE all_moral (alpha INTEGER,
                        honor CHAR(1),
                        conduct INTEGER,
                        ethics INTEGER,
                        360_feedback INTEGER,
                        MDR_avg DECIMAL,
                        proknow INTEGER,
                        PCA INTEGER,
                        PCB INTEGER,
                        pF1 DECIMAL,
                        nF1 DECIMAL,
                        CONSTRAINT PK_moral PRIMARY KEY (alpha),
                        CONSTRAINT FK_moral FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));

CREATE TABLE form1s (type VARCHAR(15),
                      CONSTRAINT PK_form1s PRIMARY KEY (type));

CREATE TABLE all_forms (alpha INTEGER,
                        type VARCHAR(15),
                        feedback VARCHAR(1000),
                        CONSTRAINT PK_moral PRIMARY KEY (alpha),
                        CONSTRAINT FK_forms_alpha FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha),
                        CONSTRAINT FK_forms_type FOREIGN KEY (type)
                                    REFERENCES form1s (type));





CREATE TABLE pe_sports (name VARCHAR(15),
                        type VARCHAR(15),
                        CONSTRAINT PK_sports PRIMARY KEY (name));

CREATE TABLE prt (alpha INTEGER,
                  semester VARCHAR(15),
                  year INTEGER,
                  score INTEGER,
                  CONSTRAINT PK_alpha PRIMARY KEY (alpha, semester, year));

CREATE TABLE all_physical (alpha INTEGER,
                          sport VARCHAR(15),
                          swim1 INTEGER,
                          swim2 INTEGER,
                          swim3 INTEGER,
                          wrestle INTEGER,
                          boxing INTEGER,
                          ground INTEGER,
                          standing INTEGER,
                          prt_avg DECIMAL,
                          prt_current INTEGER,
                          CONSTRAINT PK_physical PRIMARY KEY (alpha),
                          CONSTRAINT FK_physical_sport FOREIGN KEY (sport)
                              REFERENCES pe_sports (name),
                          CONSTRAINT FK_physical FOREIGN KEY (alpha)
                              REFERENCES mids_all (alpha));



CREATE TABLE all_leadership (alpha INTEGER,
                             sub_eval_avg DECIMAL,
                             billet_points INTEGER,
                             prior CHAR(1),
                             MQPR INTEGER,
                             CONSTRAINT FK_leadership FOREIGN KEY (alpha)
                                         REFERENCES mids_all (alpha));


CREATE TABLE attribute_scores (name VARCHAR(15),
                               score INTEGER,
                               CONSTRAINT PK_attribute PRIMARY KEY (name));
