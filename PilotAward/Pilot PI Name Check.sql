
### Check and Fix  Aprils revesrsed Names

drop table if Exists work.fixnames ;
create table work.fixnames AS
Select UF_UFID As UFID,
       UF_LAST_NM As LastName,
	   UF_FIRST_NM AS FirstName
from lookup.ufids
WHERE UF_UFID IN (SELECT DISTINCT UFID from pilots.PILOTS_MASTER);

DROP TABLE IF EXISTS work.pilotnames;
CREATE TABLE work.pilotnames AS
SELECT UFID,PI_First,PI_LAST
from pilots.PILOTS_MASTER
GROUP BY UFID,PI_First,PI_LAST;

ALTER TABLE work.pilotnames
ADD FirstName varchar(45),
ADD LastName varchar(45);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.pilotnames pm, work.fixnames lu
SET pm.FirstName=lu.FirstName,
	pm.LastName=lu.LastName
WHERE pm.UFID=lu.UFID;


SELECT * from work.pilotnames
WHERE PI_LAST<>LastName;

UPDATE pilots.PILOTS_MASTER SET PI_Last='Allen', PI_FIRST='Josephine' WHERE UFID='03583016';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Mathews', PI_FIRST='Anne' WHERE UFID='26780377';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Wallet', PI_FIRST='Mark' WHERE UFID='35324036';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Raup-Krieger', PI_FIRST='Janice' WHERE UFID='37296173';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Singh Ospina', PI_FIRST='Naykky' WHERE UFID='43796129';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Bernier', PI_FIRST='Angelina' WHERE UFID='45268160';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Whisler', PI_FIRST='Yan' WHERE UFID='58753640';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Sommerfield', PI_FIRST='Linda' WHERE UFID='74115193';
UPDATE pilots.PILOTS_MASTER SET PI_Last='McNamara', PI_FIRST='Joseph' WHERE UFID='74388730';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Dulany', PI_FIRST='Krista' WHERE UFID='78481531';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Shechtman', PI_FIRST='Orit' WHERE UFID='79200500';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Canales', PI_FIRST='Muna' WHERE UFID='85840109';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Todd', PI_FIRST='Adrian' WHERE UFID='94577553';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Ding', PI_FIRST='Mingzhou' WHERE UFID='99488871';

UPDATE pilots.PILOTS_MASTER SET PI_Last='da Silva', PI_FIRST='Robin' WHERE UFID='73679381';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Fernandez', PI_FIRST='Rosemarie' WHERE UFID='36048093';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Fisher', PI_FIRST='Carla' WHERE UFID='43602181';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Flood-Grady', PI_FIRST='Elizabeth' WHERE UFID='41939294';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Goins', PI_FIRST='Allison' WHERE UFID='19711096';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Guirgis', PI_FIRST='Faheem' WHERE UFID='05568930';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Heldermon', PI_FIRST='Coy' WHERE UFID='55933356';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Reddy', PI_FIRST='Raju' WHERE UFID='31613263';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Zhao', PI_FIRST='Jinying' WHERE UFID='59951019';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Lynne', PI_FIRST='Sarah' WHERE UFID='42708620';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Penza', PI_FIRST='Charles' WHERE UFID='57296270';
UPDATE pilots.PILOTS_MASTER SET PI_Last='Domenico', PI_FIRST='Lisa' WHERE UFID='69834353';

SET SQL_SAFE_UPDATES = 1;

#############################################################
