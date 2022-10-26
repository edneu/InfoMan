

drop table if exists work.ss_rqst;
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


CREATE INDEX ufid ON lookup.ufids (UF_UFID);
CREATE INDEX ufid_ss1 ON work.ss_rqst1 (Employee_ID);



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

CREATE INDEX ufid ON lookup.ufids (UF_UFID);
CREATE INDEX ufid_ss1 ON work.ss_rqst1 (Employee_ID);

UPDATE work.ss_rqst1 ss, lookup.dept_coll_supp lu
SET ss.College=lu.College
WHERE ss.Department_Code=lu.DeptID;



SELECT Department_Code, Department from work.ss_rqst1 where College is Null group by Department_Code, Department;

