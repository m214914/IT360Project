CREATE TABLE company (code INTEGER NOT NULL,
                      officer VARCHAR(30) NULL,
                      CONSTRAINT PK_company PRIMARY KEY (code));



CREATE TABLE mids_all (alpha INTEGER NOT NULL,
                      fname VARCHAR(30) NULL,
                      lname VARCHAR(30) NULL,
                      company INTEGER NOT NULL,
                      gender CHAR(1) NULL,
                      CONSTRAINT PK_mids PRIMARY KEY (alpha),
                      CONSTRAINT FK_company FOREIGN KEY (company)
                                  REFERENCES company (code));

CREATE TABLE auth_session (
                           alpha INTEGER NOT NULL,
                           id VARCHAR(96) NOT NULL,
                           lastvisit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           CONSTRAINT PK_auth_session PRIMARY KEY (id),
                           CONSTRAINT FK_auth_session_user FOREIGN KEY(alpha)
                            REFERENCES mids_all(alpha)
                            ON DELETE CASCADE ON UPDATE CASCADE
                          );



CREATE TABLE all_ac (alpha INTEGER NOT NULL,
                    CQPR DECIMAL NULL,
                    SQPR DECIMAL NULL,
                    MAPR_mean DECIMAL NULL,
                    MGSP CHAR(1) NULL,
                    CONSTRAINT PK_ac PRIMARY KEY (alpha),
                    CONSTRAINT FK_ac FOREIGN KEY (alpha)
                                REFERENCES mids_all (alpha));

CREATE TABLE all_maprs (alpha INTEGER NOT NULL,
                        ID INTEGER NULL,
                        score INTEGER NULL,
                        CONSTRAINT PK_maprs PRIMARY KEY (alpha),
                        CONSTRAINT FK_mapr FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));



CREATE TABLE all_moral (alpha INTEGER NOT NULL,
                        honor CHAR(1) NULL,
                        conduct INTEGER NULL,
                        ethics INTEGER NULL,
                        360_feedback INTEGER NULL,
                        MDR_avg DECIMAL NULL,
                        proknow INTEGER NULL,
                        PCA INTEGER NULL,
                        PCB INTEGER NULL,
                        pF1 DECIMAL NULL,
                        nF1 DECIMAL NULL,
                        CONSTRAINT PK_moral PRIMARY KEY (alpha),
                        CONSTRAINT FK_moral FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));

CREATE TABLE form1s (type VARCHAR(15) NOT NULL,
                      CONSTRAINT PK_form1s PRIMARY KEY (type));

CREATE TABLE all_forms (alpha INTEGER NOT NULL,
                        type VARCHAR(15) NOT NULL,
                        feedback VARCHAR(1000) NULL,
                        CONSTRAINT PK_moral PRIMARY KEY (alpha),
                        CONSTRAINT FK_forms_alpha FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha),
                        CONSTRAINT FK_forms_type FOREIGN KEY (type)
                                    REFERENCES form1s (type));





CREATE TABLE pe_sports (name VARCHAR(15) NOT NULL,
                        type VARCHAR(15) NULL,
                        CONSTRAINT PK_sports PRIMARY KEY (name));

CREATE TABLE prt (alpha INTEGER NOT NULL,
                  semester VARCHAR(15) NOT NULL,
                  year INTEGER NOT NULL,
                  score INTEGER NULL,
                  CONSTRAINT PK_alpha PRIMARY KEY (alpha, semester, year));

CREATE TABLE all_physical (alpha INTEGER NOT NULL,
                          sport VARCHAR(15) NOT NULL,
                          swim1 INTEGER NULL,
                          swim2 INTEGER NULL,
                          swim3 INTEGER NULL,
                          wrestle INTEGER NULL,
                          boxing INTEGER NULL,
                          ground INTEGER NULL,
                          standing INTEGER NULL,
                          prt_avg DECIMAL NULL,
                          prt_current INTEGER NULL,
                          CONSTRAINT PK_physical PRIMARY KEY (alpha),
                          CONSTRAINT FK_physical_sport FOREIGN KEY (sport)
                              REFERENCES pe_sports (name),
                          CONSTRAINT FK_physical FOREIGN KEY (alpha)
                              REFERENCES mids_all (alpha));



CREATE TABLE all_leadership (alpha INTEGER NOT NULL,
                             sub_eval_avg DECIMAL NULL,
                             billet_points INTEGER NULL,
                             prior CHAR(1) NULL,
                             MQPR INTEGER NULL,
                             CONSTRAINT FK_leadership FOREIGN KEY (alpha)
                                         REFERENCES mids_all (alpha));


CREATE TABLE attribute_scores (name VARCHAR(15) NOT NULL,
                               score INTEGER NULL,
                               CONSTRAINT PK_attribute PRIMARY KEY (name));
