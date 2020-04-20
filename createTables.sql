CREATE TABLE all_companies (code INTEGER NOT NULL,
                      officer VARCHAR(30) NULL,
                      CONSTRAINT PK_companies PRIMARY KEY (code));



CREATE TABLE mids_all (alpha INTEGER NOT NULL,
                      fname VARCHAR(30) NULL,
                      lname VARCHAR(30) NULL,
                      company INTEGER NOT NULL,
                      gender CHAR(1) NULL,
                      hash VARCHAR(250) NULL,
                      session TEXT NULL,
                      lastlogin TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      CONSTRAINT PK_mids PRIMARY KEY (alpha),
                      CONSTRAINT FK_company FOREIGN KEY (company)
                                  REFERENCES all_companies (code));

CREATE TABLE auth_session (
                           alpha INTEGER NOT NULL,
                           id VARCHAR(96) NOT NULL,
                           lastvisit TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           CONSTRAINT PK_auth_session PRIMARY KEY (id),
                           CONSTRAINT FK_auth_session_user FOREIGN KEY(alpha)
                            REFERENCES mids_all(alpha)
                            ON DELETE CASCADE ON UPDATE CASCADE
                          );


-- --------------ACADEMICS --------------------------
-- List of academic attributes for each midshipmen [alpha] - attributes
CREATE TABLE academic_attributes (alpha INTEGER NOT NULL,
                    CQPR DECIMAL NULL,
                    SQPR DECIMAL NULL,
                    MAPR_count DECIMAL NULL, -- **TRIGGER** upon updating all_maprs for this alpha, update the count
                    MGSP INTEGER NULL,
                    CONSTRAINT PK_academic PRIMARY KEY (alpha),
                    CONSTRAINT FK_academic FOREIGN KEY (alpha)
                                REFERENCES mids_all (alpha));
-- List of all maprs [alpha] - ID - period
-- alphas can have multiple maprs in the same period so they have a surrogate key (ID)
CREATE TABLE all_maprs (alpha INTEGER NOT NULL,
                        ID INTEGER NOT NULL AUTO_INCREMENT,
                        period VARCHAR(30) NULL,
                        CONSTRAINT PK_maprs PRIMARY KEY (ID),
                        CONSTRAINT FK_maprs FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));

-- ---------MORAL ----------------
-- List of moral attributes [ALPHA] -
CREATE TABLE moral_attributes (alpha INTEGER NOT NULL,
                        honor INTEGER NULL, -- honor grade 0-70 is negative, 70-100 is positve
                        conduct INTEGER NULL, -- conduct grade 0-80 is negative, 80-100 is positive
                        ethics INTEGER NULL,
                        MDR DECIMAL NULL, -- this will be the most recent, just score one
                        proknow INTEGER NULL,
                        PCA INTEGER NULL,
                        PCB INTEGER NULL,
                        pF1_count INTEGER NULL, -- **TRIGGER** upon updating the form1s(below) table for this alpha, update the count of positves
                        nF1_count INTEGER NULL, -- **TRIGGER** upon updating the form1s(below) table for this alpha, update the count of negatives
                        CONSTRAINT PK_moral PRIMARY KEY (alpha),
                        CONSTRAINT FK_moral FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha));
-- List of all form1 types (positive and negative) forgeign key for all_forms
CREATE TABLE form1s (type VARCHAR(15) NOT NULL,
                      CONSTRAINT PK_form1s PRIMARY KEY (type));
-- List of all form1s submitted [alpha] - type
CREATE TABLE all_forms (alpha INTEGER NOT NULL,
                        formID INTEGER NOT NULL AUTO_INCREMENT,
                        type VARCHAR(15) NOT NULL,
                        CONSTRAINT PK_forms PRIMARY KEY (formID),
                        CONSTRAINT FK_forms_alpha FOREIGN KEY (alpha)
                                    REFERENCES mids_all (alpha),
                        CONSTRAINT FK_forms_type FOREIGN KEY (type)
                                    REFERENCES form1s (type));

-- --------PHYSICAL ------------
-- List of sports with how much they are worth (scale) [name] - type (intra,club A/B,var)) - scale
CREATE TABLE sports_list (sport_name VARCHAR(15) NOT NULL,
                        type VARCHAR(15) NOT NULL,
                        scale INTEGER NOT NULL,
                        CONSTRAINT PK_sports PRIMARY KEY (sport_name));
-- Store all the PRTs [ALPHA]- date (for easy comparison) - score(out of 100)
CREATE TABLE all_prt (alpha INTEGER NOT NULL,
                      date_taken DATE NOT NULL,
                      score INTEGER NOT NULL,
                      CONSTRAINT PK_prt PRIMARY KEY (alpha, date_taken),
                      CONSTRAINT FK_prt FOREIGN KEY (alpha)
                          REFERENCES mids_all (alpha));
-- List of physical attributes [ALPHA] -
-- its okay if a mid doesn't have them all
CREATE TABLE physical_attributes (alpha INTEGER NOT NULL,
                          sport_name VARCHAR(15) NOT NULL,
                          swim1 INTEGER NULL,
                          swim2 INTEGER NULL,
                          swim3 INTEGER NULL,
                          wrestle INTEGER NULL,
                          boxing INTEGER NULL,
                          ground INTEGER NULL,
                          standing INTEGER NULL,
                          prt_avg DECIMAL NULL, -- **TRIGGER** upon insertion of a new PRT into prt^^ for this alpha, update the average for this alpha
                          prt_current INTEGER NULL, -- **TRIGGER** upon insertion of a new PRT into prt^^ check for the most recent (by date) and update this
                          CONSTRAINT PK_physical PRIMARY KEY (alpha),
                          CONSTRAINT FK_physical_sport FOREIGN KEY (sport_name)
                              REFERENCES sports_list (sport_name),
                          CONSTRAINT FK_physical FOREIGN KEY (alpha)
                              REFERENCES mids_all (alpha));

-- ------------LEADERSHIP-------------------------
-- List of possible BILLETS (to be foreign keys for all_billets)
CREATE TABLE billets_list (billet_name VARCHAR(30) NOT NULL, -- **TRIGGER** when a billet that isnt in this table is inserted into all_billets, add it to the table with a scale of 10 (can be updated later)
                          scale INTEGER,
                          CONSTRAINT PK_billet_list PRIMARY KEY (billet_name));

-- List of billets [ALPHA] - BILLET - RATING
CREATE TABLE all_billets (alpha INTEGER NOT NULL,
                          billet_name VARCHAR(30) NOT NULL,
                          score INTEGER NOT NULL,
                          CONSTRAINT PK_all_billets PRIMARY KEY (alpha),
                          CONSTRAINT FK_all_billets FOREIGN KEY (alpha)
                                      REFERENCES mids_all (alpha),
                          CONSTRAINT FK_billets FOREIGN KEY (billet_name)
                                      REFERENCES billets_list (billet_name));
-- Leadership attributes (excluding billets) [ALPHA] -
CREATE TABLE leadership_attributes (alpha INTEGER NOT NULL,
                             prior INTEGER NULL, -- 1 or 0
                             MQPR INTEGER NULL,
                             CONSTRAINT PK_leadership PRIMARY KEY (alpha),
                             CONSTRAINT FK_leadership FOREIGN KEY (alpha)
                                         REFERENCES mids_all (alpha));

-- Maximum points to be awarded to each attribute (excluding billets AND sports)
-- Attributes are the names of each field above^^
-- maximum scale = 60
-- minimum scale = 10
CREATE TABLE attribute_scores (attribute_name VARCHAR(15) NOT NULL,
                              out_of INTEGER NULL,
                               scale INTEGER NULL,
                               CONSTRAINT PK_attribute PRIMARY KEY (attribute_name));
