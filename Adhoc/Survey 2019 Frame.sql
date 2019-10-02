
alter table work.townemail add UFID varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.townemail te, lookup.Employees  lu
SET te.UFID=lu.Employee_ID
WHERE te.Email=lu.EMAIL;


UPDATE work.townemail te, lookup.ufids  lu
SET te.UFID=lu.UF_UFID
WHERE te.Email=lu.UF_EMAIL
AND te.UFID IS NULL ;

select * from work.townemail WHERE UFID IS NULL;


select * from work.prmail;

UPDATE work.prmail pr, lookup.ufids lu
SET pr.EMAIL=lu.UF_EMAIL
WHERE pr.UFID=lu.UF_UFID;

select * from lookup.ufids where UF_UFID="89369195";

select * from lookup.Employees where 
 Employee_ID in ('79048216', '69763049');



###
###   Complete Record
select * from work.s19ufid;

ALTER TABLE  work.s19ufid
DROP Title, DROP Department_Code, DROP Department, DROP Salary_Plan , DROP Factype , DROP Faculty ;


ALTER TABLE  work.s19ufid
ADD Title varchar(255),
ADD Department_Code varchar(12),
ADD Department varchar(45),
ADD Salary_Plan varchar(255),
ADD Factype varchar(25),
ADD Faculty varchar(12);


UPDATE work.s19ufid uf, lookup.Employees lu
SET uf.Title=lu.Job_Code, 
uf.Department_Code=lu.Department_Code ,
uf.Department=lu.Department,
uf.Salary_Plan=lu.Salary_Plan, 
uf.Factype=lu.Factype, 
uf.Faculty=lu.Faculty
WHERE uf.UFID=lu.Employee_ID;


drop table if exists work.s19out;
CREATE TABLE work.s19out as
select UFID,
       min(Title) As Title,
       min(Department_Code) As Department_Code,
       min(Department) as Department,
       max(Salary_Plan) as Salary_Plan,
       min(Factype) as Factype,
       min(Faculty) as Faculty
from work.s19ufid
group by UFID
ORDER BY UFID;

SELECT LastName,FirstName,Title
from lookup.roster 
WHERE Affiliation="FSU"
group by LastName,FirstName,Title;


select * from work.survey2019raw;

Alter table work.survey2019raw
ADD TownHall int(1),
ADD Payroll int(1),
ADD FSU int(1);


UPDATE work.survey2019raw
SET TownHall=0,
	Payroll=0,
    FSU=0;
    
 SELECT DISTINCT Source from   work.survey2019raw; 
    
UPDATE work.survey2019raw SET TownHall=1 WHERE Source='TownHall';   
UPDATE work.survey2019raw SET Payroll=1 WHERE Source='Payroll';   
UPDATE work.survey2019raw SET FSU=1 WHERE Source='FSU';  


drop table if exists ctsi_survey.ctsi_2019_panel;
Create table ctsi_survey.ctsi_2019_panel AS
SELECT Email,
       min(Last_Name) as Last_Name,
       min(First_Name) as First_Name,
       min(Factype) as Factype,
       min(Faculty) as Faculty,
       min(Title) as Title,
       max(TownHall) as TownHall,
       max(Payroll) as Payroll,
       max(FSU) as FSU,
       min(UFID) AS UFID,
       min(Department_Code) AS DeptID,
       min(Department) as Department,
       min(Salary_Plan) as Salary_Plan
from work.survey2019raw
group by Email;    
    

SELECT 	Faculty,
		SUM(TownHall) as TownHall,
        SUM(Payroll) as Payroll,
        SUM(FSU) as FSU,
        COUNT(DISTINCT Email) as UNDUP
FROM ctsi_survey.ctsi_2019_panel
group by Faculty;


SELECT 	
        COUNT(DISTINCT Email) as UNDUP
FROM ctsi_survey.ctsi_2019_panel;





