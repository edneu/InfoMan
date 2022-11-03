

drop table if exists work.ss_rqst1;
create table work.ss_rqst1 as
SELECT Employee_ID,
Department_Code,
Department,
Job_Code,
FTE
from lookup.active_emp;
###WHERE Employee_ID IN (SELECT DISTINCT UFID from finance.assistbudgetyr8);



Alter table work.ss_rqst1
ADD Email varchar(125),
Add College varchar(45),
Add LastName varchar(50),
Add FirstName varchar(50)
;

SET SQL_SAFE_UPDATES = 0;

/*
CREATE INDEX ufid ON lookup.ufids (UF_UFID);
CREATE INDEX ufid_ss1 ON work.ss_rqst1 (Employee_ID);
*/


UPDATE work.ss_rqst1 ss, lookup.ufids lu
SET ss.Email=lu.UF_EMAIL,
	ss.LastName=lu.UF_LAST_NM,
    ss.FirstName=lu.UF_FIRST_NM
WHERE  ss.Employee_ID=lu.UF_UFID;



UPDATE work.ss_rqst1 ss, lookup.dept_coll lu
SET ss.College=lu.College
WHERE ss.Department_Code=lu.DepartmentID;

UPDATE work.ss_rqst1 ss, lookup.email lu
SET ss.Email=lu.UF_EMAIL
WHERE ss.Employee_ID=lu.UF_UFID;



UPDATE work.ss_rqst1 ss, lookup.dept_coll_supp lu
SET ss.College=lu.College
WHERE ss.Department_Code=lu.DeptID;



SELECT Department_Code, Department from work.ss_rqst1 where College is Null group by Department_Code, Department;

drop table if exists work.temp;
create table work.temp as
select Employee_ID as UFID,
Email,
Department_Code,
Department,
Job_Code,
Employee_ID
from work.ss_rqst1
WHERE Employee_ID in (select Distinct UFID from work.staffufid);


Empl Dept Code	Empl Dept Descr	Employee ID	Employee Name	EmplRec#	Salary Admin Plan	Empl Job Title

Drop table if Exists work.crcood;
create table work.crcood as
Select 	Employee_ID,
		Name,
        Department_Code,
        Department,
        Job_Code
		from loaddata.activeemp20221031
WHERE Job_Code LIKE "CL%RES%COO%";

Alter table work.crcood ADD email varchar(75);

SET SQL_SAFE_UPDATES = 0;
UPDATE work.crcood cr, lookup.email lu
SET cr.email=lu.UF_EMAIL
WHERE cr.Employee_ID=lu.UF_UFID;

UPDATE work.crcood cr, lookup.ufids lu
SET cr.email=lu.UF_EMAIL
WHERE cr.Employee_ID=lu.UF_UFID
AND cr.EMAIL is NULL;

UPDATE work.crcood 
SET email='dana.brooks@ufl.edu'
WHERE email is null 
and Employee_ID='50173785';

Select * from work.crcood where email is null;
