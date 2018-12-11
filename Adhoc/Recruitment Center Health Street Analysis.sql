
drop table if Exists work.rec_center;
create table work.rec_center AS
select 	Year,
        UFID,
        STD_PROGRAM,
		LastName AS LastName,
		FirstName AS FirstName,
		DepartmentID AS DeptID,
		Department AS Dept,
		Title AS Title
from lookup.roster
WHERE Year in (2016,2017)
AND STD_PROGRAM ="Recruitment Center"
UNION ALL
select 	Year,
        UFID,
        STD_PROGRAM,
		LastName AS LastName,
		FirstName AS FirstName,
		DepartmentID AS DeptID,
		Department AS Dept,
		Title AS Title
from work.rechs_2018
WHERE Year in (2018)
AND STD_PROGRAM ="Recruitment Center"
;

drop table if Exists work.hstreet;
create table work.hstreet AS
select 	Year,
        UFID,
        STD_PROGRAM,
		LastName AS LastName,
		FirstName AS FirstName,
		DepartmentID AS DeptID,
		Department AS Dept,
		Title AS Title
from lookup.roster
WHERE Year in (2016,2017)
AND STD_PROGRAM IN ("HealthStreet-Gainesville","HealthStreet-Jacksonville")
UNION ALL
select 	Year,
        UFID,
        STD_PROGRAM,
		LastName AS LastName,
		FirstName AS FirstName,
		DepartmentID AS DeptID,
		Department AS Dept,
		Title AS Title
from work.rechs_2018
WHERE Year in (2018)
AND STD_PROGRAM  IN ("HealthStreet-Gainesville","HealthStreet-Jacksonville")
;





;


drop table if exists Adhoc.RecruitHStreet;
create table Adhoc.RecruitHStreet AS
Select Year,
       UFID,
       Max(LastName) AS LastName,
       MAx(FirstName) AS FirstName,
       MAx(DeptID) AS DeptID,
       MAX(Dept) AS Dept,
       MAX(Title) AS Title
from work.rec_center
group by Year, UFID;

Alter Table Adhoc.RecruitHStreet
ADD HlthStreet int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE Adhoc.RecruitHStreet SET HlthStreet=0;

select * from Adhoc.RecruitHStreet;


UPDATE Adhoc.RecruitHStreet rh, work.hstreet hs
SET rh.HlthStreet=1
WHERE rh.UFID=hs.UFID
  AND rh.UFID<>""
  AND rh.Year<=hs.Year;



select Year,Count(*) from Adhoc.RecruitHStreet group by Year;


select Year,Count(DISTINCT UFID) from work.hstreet group by Year;


select Year,Count(*) from Adhoc.RecruitHStreet WHERE HlthStreet=1 group by Year;


