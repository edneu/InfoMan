

SELECT 	UF_UFID AS UFID,
		UF_LAST_NM As LastName,
        UF_FIRST_NM AS FirstNmae,
        UF_EMAIL AS Email,
        UF_DEPT_NM AS Dept,
        UF_WORK_TITLE AS Title
FROM lookup.ufids
WHERE UF_LAST_NM IN 
('Raup-Krieger',

'Rasmussen',
'Sevier'
)
ORDER BY UF_LAST_NM,UF_FIRST_NM;


SELECT 	Employee_ID,
		Name
		FTE,
        Job_Code,
        Department
FROM lookup.Employees
WHERE Employee_ID IN 
(
'84561440',
'22121325',
'31782301',
'31745590',
'67276760',
'67276760',
'59506830',
'02220960',
'37296173',
'20684540',
'53134637',
'89453490',
'76090450');


DROP TABLE IF EXISTS work.ImpactUsers1;
Create table work.ImpactUsers1 as 
SELECT 
UFID,
STD_PROGRAM,
max(concat(LastName,", ",FirstName)) AS Name,
count(*) as nRecs,
count(distinct Year) as nYears
from lookup.roster
WHERE UFID IN 
(
'84561440',
'22121325',
'31782301',
'31745590',
'67276760',
'67276760',
'59506830',
'02220960',
'37296173',
'20684540',
'53134637',
'89453490',
'76090450')
group by
UFID,
STD_PROGRAM;


DROP TABLE IF EXISTS work.ImpactSvcUsers;
CREATE TABLE work.ImpactSvcUsers AS
select STD_PROGRAM from work.ImpactUsers1
GROUP BY STD_PROGRAM
ORDER BY STD_PROGRAM;

Alter Table work.ImpactSvcUsers
  ADD Alday int(5),
  ADD Becker int(5),
  ADD Bian int(5),
  ADD Bihorac int(5),
  ADD Cavallari int(5),
  ADD Eddleton int(5),
  ADD Gravenstein int(5),
  ADD Lauzardo int(5),
  ADD Parker int(5),
  ADD Rasmussen int(5),
  ADD Raup_Krieger int(5),
  ADD Sevier int(5);


SET SQL_SAFE_UPDATES = 0;
  
UPDATE  work.ImpactSvcUsers 
SET
   Alday=0,
   Becker=0,
   Bian=0,
   Bihorac=0,
   Cavallari=0,
   Eddleton=0,
   Gravenstein=0,
   Lauzardo=0,
   Parker=0,
   Rasmussen=0,
   Raup_Krieger=0,
   Sevier=0;




UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Alday=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Alday, William';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Becker=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Becker, Torben';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Bian=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Bian, Jiang';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Bihorac=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Bihorac, Azra';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Cavallari=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Cavallari, Larisa';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Eddleton=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Eddleton, Katherine';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Gravenstein=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Gravenstein, Nikolaus';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Lauzardo=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Lauzardo, Michael';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Parker=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Parker, Alexander';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Rasmussen=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Rasmussen, Sonja';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Raup_Krieger=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Raup-Krieger, Janice';
UPDATE work.ImpactSvcUsers iu, work.ImpactUsers1  lu SET iu.Sevier=nYears WHERE iu.STD_PROGRAM=lu.STD_PROGRAM AND lu.Name='Sevier, Brian';


  select * from work.ImpactSvcUsers;