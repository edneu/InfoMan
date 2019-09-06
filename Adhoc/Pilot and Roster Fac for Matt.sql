
DROP TABLE IF EXISTS work.pilotfac;
create table work.pilotfac as
select PI_Last,PI_First,Email,UFID,AwardLetterDate,Category,AwardType,Award_Amt,AwardeePositionAtApp,PI_DEPT
from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Category <> "SECIM"
AND AwardType NOT IN ("Graduate student","Trainee")
AND AwardeePositionAtApp NOT IN ('Fellow',
								 'PhD Student',
                                 'Resident',
                                 'Postdoc Fellow',
                                 'Postdoc Associate',
                                 'Biological Scientist IV',
                                 'Postdoctoral Fellow',
                                 'Postdoctoral Associate',
                                 'POSTDOC ASO',
                                 'ADJ AST SCTST',
                                 'OPS-Spons Prjs Non-Clerical')
ORDER BY PI_Last,PI_First;

select distinct AwardeePositionAtApp from pilots.PILOTS_MASTER;


create table work.facroster201719
SELECT UFID,
       Max(LastName) AS LastName,
       Max(FirstName) AS FirstName,
       Max(Department) AS Department,
      count(distinct STD_PROGRAM) AS NumSvcs
from lookup.roster
WHERE Faculty='Faculty'
AND UFID<>""
AND YEAR IN (2017,2018,2019)
GROUP BY UFID
ORDER BY LastName,FirstName;




DROP TABLE IF EXISTS work.bondfac;
CREATE TABLE work.bondfac as
Select Person_ID,Person_Name from space.salary2019
GROUP BY Person_ID,Person_Name;

ALTER TABLE work.bondfac ADD Salary_Plan varchar(45);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.bondfac bf, lookup.Employees lu
SET bf.Salary_Plan=lu.Salary_Plan
WHERE bf.Person_ID=lu.Employee_ID;

SELECT Salary_Plan,count(*) from work.bondfac group by Salary_Plan;

ALTER TABLE work.bondfac ADD Faculty int(1);

DELETE from work.bondfac where Salary_Plan is null;

UPDATE work.bondfac SET Faculty=0;

UPDATE work.bondfac SET Faculty=1 WHERE Salary_Plan LIKE "%Faculty%";

select * from work.bondfac;