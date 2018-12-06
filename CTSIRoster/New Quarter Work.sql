

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