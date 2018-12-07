

####  CLEAN SCRIPT FOR ALL ROSTER TASKS
## roster_id
## Faculty, factype, FacultyType
## ERA COMMONS
## Roster
## Person Key
## Roster Key


select max(rosterid)+1 from lookup.roster;



select max(rosterid)+1 from work.roster2018q1q2;

select count(*) from brian.roster2018q1q2;
select * from brian.roster2018q1q2;

select count(*) from work.roster2018q1q2;

select  count(*)
from work.roster2018q1q2
WHERE UFID IN (""," ","0")
  AND Affiliation="" ;


select * from work.roster2018q1q2 where roster2018q1q2_id=3388;


26016, 


SET SQL_SAFE_UPDATES = 0;
SELECT @i:=26016;
UPDATE work.roster2018q1q2 SET rosterid = @i:=@i+1;
SET SQL_SAFE_UPDATES = 1;


26017,29920
select min(rosterid), max(rosterid) from work.roster2018q1q2;



UPDATE work.roster2018q1q2
SET Year=2018;


### Roster_key
UPDATE work.roster2018q1q2
SET Roster_Key=CONCAT(Year,"-",UFID)
WHERE UFID<>"";

UPDATE work.roster2018q1q2
SET Roster_Key=CONCAT(Year,"-",LastName)
WHERE UFID="";


### Person Key
UPDATE work.roster2018q1q2
SET Person_Key=UFID
WHERE UFID<>"";

UPDATE work.roster2018q1q2
SET Person_Key=(LastName)
WHERE UFID="";


### ERA COMMONS
UPDATE work.roster2018q1q2 r, lookup.ERACommons era
SET r.EraCommons=era.ERACommons
WHERE r.email=era.Email
AND r.email<>""
AND era.email<>"";

## ERACommon Cleanup placeholders
UPDATE work.roster2018q1q2
SET EraCommons = ''
WHERE EraCommons="AS Don't Need";


select Roster from work.roster2018q1q2;
select distinct Roster from work.roster2018q1q2;
select Roster,count(*) from work.roster2018q1q2 group by Roster;

select * from work.roster2018q1q2 where Roster='';

UPDATE work.roster2018q1q2 r, lookup.Employees lu
SET r.Roster=1
WHERE r.UFID=lu.Employee_ID
##AND r.Roster=""
AND lu.Salary_Plan LIKE "%Faculty%";

select Salary_Plan_Code,Salary_Plan,count(*) from lookup.Employees group by Salary_Plan_Code,Salary_Plan;


select rosterid,Title,Roster from work.roster2018q1q2 r where Roster='';


select * from work.roster2018q1q2 ;

select distinct FacultyType from lookup.roster;

select distinct Faculty from lookup.roster;





UPDATE work.roster2018q1q2 r
SET r.Roster=0
WHERE Title=' '
AND Roster=''; ;

select * from lookup.faculty_lookup;


ALTER TABLE work.roster2018q1q2
ADD FacType varchar(25),
ADD Faculty varchar(25);

UPDATE work.roster2018q1q2 SET FacType = Null;

UPDATE work.roster2018q1q2 r, lookup.roster_faculty_type lu
SET r.FacType=lu.FacType
WHERE r.Title=lu.Title
AND r.Title<>' '
;
select distinct FacType from work.roster2018q1q2;

select distinct FacType from lookup.roster_faculty_type;

select * from work.roster2018q1q2 where FacType is Null;

select distinct Title from work.roster2018q1q2 where FacType is Null;
##################### Factype
desc lookup.roster_faculty_type;

select max(roster_faculty_type_id2)+1 from lookup.roster_faculty_type;



####################
UPDATE work.roster2018q1q2 r, lookup.Employees lu
SET r.Title=lu.Job_Code
WHERE r.UFID=lu.Employee_ID
and r.Title=""
;

select distinct Job_code from lookup.Employees;




UPDATE work.roster2018q1q2 r, lookup.Employees lu
SET r.Roster=1
WHERE r.Title=lu.Job_Code
AND Roster=0
AND lu.Salary_Plan LIKE "%Faculty%";


UPDATE work.roster2018q1q2 r, lookup.faculty_classify lu
SET r.Faculty=lu.Faculty
WHERE r.FacType=lu.FacType;

;
SELECT Distinct FacultyType from lookup.faculty_type;
SELECT Distinct FacType from work.roster2018q1q2 ;

select Faculty, FacType from lookup.FacType group by Faculty, FacType;

drop table if exists lookup.faculty_classify2;
Create table lookup.faculty_classify2 as
SELECT fl.Title,
       fl.Faculty,
       fl.FacType
from lookup.faculty_classify fl
UNION ALL
SELECT Title,
       " " AS Faculty,
       FacType as FacType
FROM roster_faculty_type 
WHERE Title NOT IN (SELECT DISTINCT Title from lookup.faculty_classify) ;



select Faculty, FacType from lookup.faculty_classify group by Faculty, FacType;

select Faculty,FacType,count(Title),Count(distinct Title) from lookup.faculty_classify group by Faculty,FacType;

select * from lookup.faculty_classify where Faculty=" ";
delete from lookup.faculty_classify where Faculty=" ";

select * from lookup.faculty_classify ;

drop table lookup.FacType;
drop table lookup.faculty_lookup;

DROP TABLE IF EXISTS work.roster_faculty_classify;
CREATE TABLE work.roster_faculty_classify AS
SELECT Title,Faculty,FacType from lookup.roster group by Title,Faculty,FacType
UNION ALL
SELECT Title,Faculty,FacType from work.roster2018q1q2
WHERE Title NOT IN (SELECT DISTINCT Title from lookup.roster)
GROUP BY Title,Faculty,FacType
UNION ALL
SELECT Title,"" AS Faculty,FacType from lookup.roster_faculty_type
WHERE Title NOT IN (SELECT DISTINCT Title from lookup.roster)
  AND Title NOT IN (SELECT DISTINCT Title from work.roster2018q1q2);

select Distinct FacultyType from lookup.roster;



Alter Table work.roster_faculty_classify ADD FacultyType varchar(12);


UPDATE work.roster_faculty_classify SET Faculty='Faculty' WHERE FacType in ('Assistant Professor');
UPDATE work.roster_faculty_classify SET FacultyType='Senior' WHERE Factype in ("Professor");
UPDATE work.roster_faculty_classify SET FacultyType='Junior' WHERE Factype in ('Assistant Professor');
UPDATE work.roster_faculty_classify SET FacultyType='Mid-Career' WHERE Factype in ('Associate Professor');
UPDATE work.roster_faculty_classify SET Faculty='Non-Faculty' WHERE Faculty in ('Not Faculty');
UPDATE work.roster_faculty_classify SET FacultyType='N/A' WHERE Faculty in ("Non-Faculty"," ");
UPDATE work.roster_faculty_classify SET FacultyType='Junior', Faculty='Faculty' WHERE FacType in ('Other Faculty');


select FacultyType,Faculty,FacType,count(Title),Count(distinct Title) from work.roster_faculty_classify group by FacultyType,Faculty,FacType;

select distinct Title from work.roster_faculty_classify where Faculty='Non-Faculty' and FacType='Other Faculty'

DROP TABLE lookup.faculty_classify;

CREATE TABLE lookup.roster_faculty_classify AS
select * from work.roster_faculty_classify;





SELECT rs.Title,rs.FacType,lu.FacType,rs.Faculty,lu.Faculty,rs.FacultyType,lu.FacultyType
FROM work.roster2018q1q2 rs 
     left join  lookup.roster_faculty_classify lu
     ON rs.Title=lu.Title
WHERE (rs.FacType<>lu.FacType OR
      rs.Faculty<>lu.Faculty OR
      rs.FacultyType<>lu.FacultyType)
AND rs.TITLE<>" ";

SELECT rs.Title,rs.FacType,lu.FacType,rs.Faculty,lu.Faculty,rs.FacultyType,lu.FacultyType
FROM lookup.roster rs 
     left join  lookup.roster_faculty_classify lu
     ON rs.Title=lu.Title
WHERE (rs.FacType<>lu.FacType OR
      rs.Faculty<>lu.Faculty OR
      rs.FacultyType<>lu.FacultyType)
AND rs.TITLE<>" ";





create table loaddata.roster_backup20181206 as select * from lookup.roster;

UPDATE lookup.roster rs, lookup.roster_faculty_classify lu
SET rs.FacultyType=lu.FacultyType,
    rs.FacType=lu.FacType,
    rs.Faculty=lu.Faculty
WHERE rs.Title=lu.Title
AND rs.Title<>" ";

UPDATE work.roster2018q1q2 rs, lookup.roster_faculty_classify lu
SET rs.FacultyType=lu.FacultyType,
    rs.FacType=lu.FacType,
    rs.Faculty=lu.Faculty
WHERE rs.Title=lu.Title
AND rs.Title<>" ";

SELECT rs.Title,rs.FacType,lu.FacType,rs.Faculty,lu.Faculty,rs.FacultyType,lu.FacultyType
FROM work.roster2018q1q2 rs 
     left join  lookup.roster_faculty_classify lu
     ON rs.Title=lu.Title
WHERE (rs.FacType<>lu.FacType OR
      rs.Faculty<>lu.Faculty OR
      rs.FacultyType<>lu.FacultyType)
AND rs.TITLE<>" ";

SELECT rs.Title,rs.FacType,lu.FacType,rs.Faculty,lu.Faculty,rs.FacultyType,lu.FacultyType
FROM lookup.roster rs 
     left join  lookup.roster_faculty_classify lu
     ON rs.Title=lu.Title
WHERE (rs.FacType<>lu.FacType OR
      rs.Faculty<>lu.Faculty OR
      rs.FacultyType<>lu.FacultyType)
AND rs.TITLE<>" ";


UPDATE work.roster2018q1q2 SET Roster=1 WHERE Faculty='Faculty';

select year,count(distinct Person_key) as invest from lookup.roster where Roster=1 Group by Year
UNION ALL
select year,count(distinct Person_key) as invest from  work.roster2018q1q2  where Roster=1 group by Year;

