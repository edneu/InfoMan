SELECT CLK_AWD_ID,
		CLK_AWD_PROJ_ID,
        CLK_AWD_PROJ_NAME,
        CLK_AWD_PI,
        CLK_AWD_PROJ_MGR,
        FUNDS_ACTIVATED,
        SPONSOR_AUTHORIZED_AMOUNT,
        REPORTING_SPONSOR_NAME,
        REPORTING_SPONSOR_AWD_ID
FROM lookup.awards_history
WHERE CLK_AWD_PROJ_NAME LIKE "%malonylation%mitochondrial%";
WHERE REPORTING_SPONSOR_AWD_ID LIKE '%1737869%';

SELECT DISTINCT REPORTING_SPONSOR_AWD_ID FROM lookup.awards_history;

#################

select * from pilots.PILOTS_MASTER
WHERE Title="Development of AAV vectors for Efficient Targeting and Elimination of Osteosarcoma Tumor-Initiating Cells";


select * from lookup.Employees
where Name like "LU%YUAN%";

select * from lookup.ufids where UF_UFID="73538221";


•	Robert Leeman, robert.leeman@ufl.edu
•	Elias Sayour, Elias.Sayour@neurosurgery.ufl.edu 
•	Sridharan Gururangan, gururangan@ufl.edu 


select UF_LAST_NM,UF_FIRST_NM,UF_EMAIL,UF_UFID from lookup.ufids 
where UF_EMAIL IN
('robert.leeman@ufl.edu'
,'Elias.Sayour@neurosurgery.ufl.edu',
'gururangan@ufl.edu');



SELECT Year,COUNT(Distinct Person_KEY)
FROM lookup.roster
WHERE STD_PROGRAM IN ('BERD')
GROUP BY YEAR;

select distinct  STD_PROGRAM  from lookup.roster;

##################################################################################
##################################################################################
##################################################################################
##################################################################################

## BERD
DROP TABLE IF EXISTS work.berdrost; 
Create TABLE work.berdrost AS
SELECT * from lookup.roster WHERE STD_PROGRAM='BERD';


ALTER TABLE work.berdrost
ADD ctsi12 int(1);


UPDATE work.berdrost SET 	ctsi12=0;
                     

UPDATE work.berdrost SET ctsi12=1 WHERE Year <=2014;
UPDATE work.berdrost SET ctsi12=2 WHERE Year >2014;



DROP TABLE IF EXISTS work.berdrost2; 
Create TABLE work.berdrost2 AS
SELECT ctsi12,FacType,Person_key,Count(distinct Year) as nYEARS
FROM work.berdrost
GROUP BY ctsi12,FacType,Person_key;

UPDATE work.berdrost2 SET nYEARS=0 WHERE nYEARS=1;
UPDATE work.berdrost2 SET nYEARS=1 WHERE nYEARS>1;

SELECT  ctsi12,
		FacType,
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.berdrost2
GROUP BY ctsi12,
		FacType;
        
        
        SELECT  ctsi12,
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.berdrost2
GROUP BY ctsi12;


####################################################################
####################################################################
## TOWN HALL MAILING


select concat(UF_LAST_NM,", ",UF_FIRST_NM) AS Name,UF_UFID,UF_EMAIL
from lookup.ufids
WHERE UF_UFID IN ("87931153");

drop table if exists work.temp;
create table work.temp as 
SELECT UF_UFID,UF_EMAIL,UF_LAST_NM,UF_FIRST_NM
FROM lookup.ufids
WHERE UF_UFID IN (select distinct UFID from work.townhall1)
ORDER BY UF_UFID;





drop table if exists work.temp2;
create table work.temp2 as 
SELECT Name,Employee_ID AS UFID,LastName,FirstName
FROM lookup.Employees
WHERE Name IN (select distinct EMPNAME from work.townhall2)
ORDER BY Name ;

ALTER TABLE work.temp2 ADD EMAIL varchar(255);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.temp2 t2, lookup.employee_email lu
SET t2.EMAIL=lu.EMAIL
WHERE t2.Name=lu.Name;




drop table if exists work.temp;
create table work.temp as 
SELECT UF_UFID,UF_EMAIL,UF_LAST_NM,UF_FIRST_NM
FROM lookup.ufids
WHERE UF_DISPLAY_NM like "%coy%";


select * from lookup.ufids where UF_UFID in ('31592929');

select * from pubs.PUB_CORE where pubmaster_id2=178;



#######################

DROP TABLE IF EXISTS work.AWD1;
CREATE TABLE work.AWD1 AS
SELECT Pilot_ID,PI_Last,PI_First,UFID,AwardLetterDate,Title from pilots.PILOTS_MASTER
WHERE Pilot_ID IN (427,316,321,51,389,306,335,317,421,430,99,385,377,54);
;


SELECT Pilot_ID,CLK_AWD_ID,CLK_AWD_PROJ_ID,FUNDS_ACTIVATED,CLK_AWD_PROJ_NAME,CLK_AWD_PI,CLK_PI_UFID,CLK_AWD_PROJ_MGR
from lookup.awards_history ah LEFT JOIN work.AWD1 awd
ON ah.CLK_PI_UFID=awd.UFID 
WHERE ah.FUNDS_ACTIVATED>=awd.AwardLetterDate
AND ah.CLK_PI_UFID<>""
ORDER BY Pilot_ID,CLK_AWD_PI,FUNDS_ACTIVATED;

DESC lookup.awards_history;


SELECT CLK_AWD_ID,CLK_AWD_PROJ_ID,FUNDS_ACTIVATED,CLK_AWD_PROJ_NAME,CLK_AWD_PI,CLK_PI_UFID,CLK_AWD_PROJ_MGR
from lookup.awards_history 
##WHERE CLK_AWD_PROJ_NAME LIKE "%ECLIPSE%";
##wHERE CLK_PI_UFID like "%46694753%"


#############################################

SELECT * from pilot.PILOTS_PUB_MASTER;

drop table if exists work.zzz;
create table work.zzz as
select * from lookup.Employees where name like "Vacca%R%";

drop table if exists work.zzz;
create table work.zzz as
SELECT * from lookup.ufids where UF_UFID='46996010';