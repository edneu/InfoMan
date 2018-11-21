
DROP TABLE IF EXISTS work.cmpilotcalc;
CREATE TABLE work.cmpilotcalc AS
Select * from lookup.pilots
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
##AND ProjectStatus<>"Ongoing";
### AND ProjectStatus="Completed";
;
drop table if exists work.reconpilot;
create table work.reconpilot AS
Select Pilot_ID, AwardLetterDate,Title,End_Date,Begin_Date,NCE_Date
from work.cmpilotcalc;

Alter table work.reconpilot Add AprilPilotID Int(11);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.reconpilot rp, work.aprilpilot lu
set rp.AprilPilotID=lu.Pilot_ID
WHERE rp.Title=lu.Title;

UPDATE work.reconpilot SET AprilPilotID=90 WHERE Pilot_ID=90;
UPDATE work.reconpilot SET AprilPilotID=299 WHERE Pilot_ID=338;
UPDATE work.reconpilot SET AprilPilotID=305 WHERE Pilot_ID=365;
UPDATE work.reconpilot SET AprilPilotID=306 WHERE Pilot_ID=366;
UPDATE work.reconpilot SET AprilPilotID=308 WHERE Pilot_ID=369;

drop table if exists work.pilot;
create table work.pilot as 
Select * from lookup.pilots
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
##AND ProjectStatus<>"Ongoing";
### AND ProjectStatus="Completed";
;
SET SQL_SAFE_UPDATES = 0;


Alter Table work.pilot Add AprilPilotID int(11);

UPDATE work.pilot wp, work.reconpilot lu
SET wp.AprilPilotID=lu.AprilPilotID
WHERE wp.Pilot_ID=lu.Pilot_ID;

drop table if exists work.verify;
create table work.verify AS
select wp.Category,
       wp.Pilot_ID as P_Pilot_id,
	   wp.AprilPilotID AS P_AprPilotID,
       wp.Title AS P_Title,
       lu.Pilot_ID as A_Pilot_ID,
       lu.AprilPilotID as A_AprPilotID,
       lu.Title as A_Title
from work.pilot wp left join work.reconpilot lu
     ON wp.AprilPilotID=lu.AprilPilotID;



DROP TABLE IF EXISTS work.PilotRecon;
CREATE TABLE work.PilotRecon AS
Select * from work.pilot
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
##AND ProjectStatus<>"Ongoing";
### AND ProjectStatus="Completed";
;

SELECT * from work.PilotRecon WHERE AprilPilotID is Null;




select Pilot_ID,Category,Title from lookup.pilots where Pilot_ID in (select Pilot_ID from work.reconpilot where AprilPilotID is Null);
AND Category IN ("Clinical","Traditional");
##select * from work.reconpilot where AprilPilotID is Null;
;
