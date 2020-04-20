--Upon updating all_maprs for this alpha, update the count
DROP TRIGGER IF EXISTS updateMAPR;
DELIMITER $$
CREATE TRIGGER updateMAPR
AFTER INSERT ON all_maprs
FOR EACH ROW
BEGIN
  UPDATE academic_attributes SET MAPR_count=MAPR_count+1 WHERE alpha=NEW.alpha;
END $$
DELIMITER ;

-- update the pF1 and nF1 count for moral_attributes when AFTER a row is inserted into all_forms
DROP TRIGGER IF EXISTS updatePositiveF1;
DELIMITER $$
CREATE TRIGGER updatePositiveF1
AFTER INSERT ON all_forms
FOR EACH ROW
BEGIN
IF (NEW.type = 'Positive') THEN
  UPDATE moral_attributes SET pF1_count=pF1_count+1 WHERE alpha=NEW.alpha;
END IF;
IF (NEW.type = 'Negative') THEN
  UPDATE moral_attributes SET nF1_count=nF1_count+1 WHERE alpha=NEW.alpha;
END IF;
END $$
DELIMITER ;

-- update the prt_avg for physical_attributes AFTER a new row is inserted into all_prt
DROP TRIGGER IF EXISTS updatePrtAvg;
DELIMITER $$
CREATE TRIGGER updatePrtAvg
AFTER INSERT ON all_prt
FOR EACH ROW
BEGIN
  DECLARE temp3 DECIMAL;
  SET temp3= SELECT AVG(score) FROM all_prt WHERE alpha= NEW.alpha
  UPDATE physical_attributes SET prt_avg=temp3 WHERE alpha=NEW.alpha;
END $$
DELIMITER ;

-- update the prt_current for physical_attributes AFTER a new row is inserted into all_prt
DROP TRIGGER IF EXISTS updatePrtDate;
DELIMITER $$
CREATE TRIGGER updatePrtDate
AFTER INSERT ON all_prt
FOR EACH ROW
BEGIN
  IF(NEW.date_taken >= (SELECT MAX(date_taken) FROM all_prt WHERE alpha= NEW.alpha)) THEN
  UPDATE physical_attributes SET prt_current=NEW.score WHERE alpha=NEW.alpha;
  END IF;
END $$
DELIMITER ;

--when a billet that isnt in this table is inserted into all_billets, add it to the table with a scale of 10 (can be updated later)
DROP TRIGGER IF EXISTS createBillet;
DELIMITER $$
CREATE TRIGGER createBillet
AFTER INSERT ON all_billets
FOR EACH ROW
BEGIN
  DECLARE temp VARCHAR(30);
  SET temp = (SELECT billet_name FROM billets_list WHERE billet_name=NEW.billet_name);
  IF(temp!= NEW.billet_name) THEN
  INSERT INTO billets_list VALUES(NEW.billet_name,10);
  END IF;
END $$
DELIMITER ;
