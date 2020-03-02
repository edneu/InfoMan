

Select Year, COunt(Distinct Person_Key)
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
group by Year;

select distinct STD_PROGRAM from lookup.roster;

Select Year, COunt(Distinct Person_Key)
From lookup.roster
WHere STD_PROGRAM='HealthStreet-Gainesville'
group by Year;


Select Year, COunt(Person_Key)
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
group by Year;

Select Year, COunt(Person_Key)
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
AND ORIG_PROGRAM<>"StudyConnect"
AND Faculty="Faculty"
group by Year;

select * from 
work.neu_work_rc;


select Year,Count(distinct KeyName)
from work.neu_work_rc
group by Year;

select YEAR,ORIG_PROGRAM,COUNT(DISTINCT Person_KEY);

select year,count(*) 
from lookup.roster 
WHere STD_PROGRAM='Recruitment Center'
GROUP BY Year;

select year, ORIG_PROGRAM,count(*) 
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
GROUP BY YEAR,ORIG_PROGRAM
;


select count(*) 
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'

;

select count(Distinct Person_key) 
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'

;

select ORIG_PROGRAM, count(Distinct Person_key) 
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
GROUP BY ORIG_PROGRAM
;

select ORIG_PROGRAM, count(*) 
From lookup.roster
WHere STD_PROGRAM='Recruitment Center'
GROUP BY ORIG_PROGRAM
;

select Count(*)
from work.neu_work_rc
;

select Count(Distinct KeyName)
from work.neu_work_rc
;




Select concat(Year,"-",trim(LastName),",",trim(FirstName)) AS NameKey, COunt(*) AS NRECs
from lookup.roster 
Where  STD_PROGRAM='Recruitment Center'
group by concat(Year,"-",trim(LastName),",",trim(FirstName))
;


Select Year, ORIG_PROGRAM ,Count(Person_Key)
From lookup.roster
Where STD_PROGRAM='Recruitment Center'
group by Year, ORIG_PROGRAM;


DROP TABLE if exists work.recruit;
Create table work.recruit AS
SELECT 
rosterid,
Year,
Person_key,
UFID,
LastName,
FirstName,
email,
ORIG_PROGRAM,
concat(Year,"-",trim(LastName),",",trim(FirstName)) AS Keyname
From lookup.roster
Where STD_PROGRAM='Recruitment Center';


SET SQL_SAFE_UPDATES = 0;
Alter table work.recruit ADD onRCwb int(1);
Update work.recruit SET onRCwb =0;

UPDATE work.recruit SET  onRCwb =1
WHERE Keyname in (SELECT  Distinct concat(Year,"-",KeyName) from work.neu_work_rc);


SELECT  Distinct KeyName from work.neu_work_rc;



Select * from  work.recruit;


select Year,
	   sum(onRcwb) as onRCwb,
       sum(case when onRcwb = 0 then 1 else 0 end) as NotonRCwb
 from work.recruit group by Year;
 
 
 select 
	   sum(onRcwb) as onRCwb,
       sum(case when onRcwb = 0 then 1 else 0 end) as NotonRCwb
 from work.recruit ;
 
 
 select count(*) from lookup.awards_history;