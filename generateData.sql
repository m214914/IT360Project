INSERT INTO all_companies VALUES(3, "LT LEE");

INSERT INTO mids_all(alpha,fname,lname,company,gender) VALUES(210000,'Eric','Smith',3,'M');
-- INSERT INTO auth_session(alpha,id) VALUES(210000,123);

INSERT INTO academic_attributes VALUES(210000, 3, 3, 0, 1);
-- INSERT INTO all_maprs VALUES();

INSERT INTO moral_attributes VALUES(210000,100,100,100,3,100,100,100,1,3);
INSERT INTO form1s VALUES("Positive");
INSERT INTO form1s VALUES("Negative");
INSERT INTO all_forms(alpha,type) VALUES(210000,"Positive");

INSERT INTO sports_list VALUES('Volleyball', 'Intramural',10);
INSERT INTO all_prt VALUES(210000, '2020-04-17', 90);
INSERT INTO physical_attributes VALUES(210000,'Volleyball',100,100,100,100,100,100,100,95,90);

INSERT INTO billets_list VALUES("Training Sergeant", 50);
INSERT INTO all_billets VALUES(210000,"Training Sergeant", 5);
INSERT INTO leadership_attributes VALUES(210000,1,4);

-- NEW ---------------------------------------------------
INSERT INTO all_companies VALUES(30, "LT KEEGAN");

INSERT INTO mids_all(alpha,fname,lname,company,gender) VALUES(219999,'John','Jones',30,'M');
-- INSERT INTO auth_session(alpha,id) VALUES(210000,123);

INSERT INTO academic_attributes VALUES(219999, 2.4, 2.2, 3, 0);
INSERT INTO all_maprs(alpha,period) VALUES(219999,"6 Week");
INSERT INTO all_maprs(alpha,period) VALUES(219999,"6 Week");
INSERT INTO all_maprs(alpha,period) VALUES(219999,"12 Week");

INSERT INTO moral_attributes VALUES(219999,80,60,100,2,85,85,85,1,3);
-- INSERT INTO form1s VALUES("Positive");
-- INSERT INTO form1s VALUES("Negative");
INSERT INTO all_forms(alpha,type) VALUES(219999,"Positive");
INSERT INTO all_forms(alpha,type) VALUES(219999,"Negative");
INSERT INTO all_forms(alpha,type) VALUES(219999,"Negative");
INSERT INTO all_forms(alpha,type) VALUES(219999,"Negative");

INSERT INTO sports_list VALUES('Soccer','Club A', 20);
INSERT INTO all_prt VALUES(219999, '2020-04-17', 80);
INSERT INTO physical_attributes VALUES(219999,'Soccer',80,80,80,80,80,80,80,75,80);

INSERT INTO billets_list VALUES("Academics Sergeant", 10);
INSERT INTO all_billets VALUES(219999,"Academics Sergeant", 4);
INSERT INTO leadership_attributes VALUES(219999,0,4);
-- INSERT INTO attribute_scores VALUES('swim', 1);
