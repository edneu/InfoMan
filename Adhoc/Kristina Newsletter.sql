
Drop table if Exists work.newsletter;
create table work.newsletter as
select * from work.kristina_emails;

Alter table work.newsletter
ADD alt_email varchar(60),
ADD UFID varchar(12),
ADD DeptID varchar(12),
ADD Department varchar(60),
ADD Gender Varchar(3),
ADD Title varchar(50);

SET SQL_SAFE_UPDATES = 0;

#CREATE INDEX emp_email ON lookup.email (UF_UFID);
CREATE INDEX nl1 ON work.newsletter (email);
CREATE INDEX nl2 ON work.newsletter (alt_email);


UPDATE work.newsletter nl, lookup.email lu
SET nl.UFID=lu.UF_UFID
WHERE nl.email=lu.UF_EMAIL;


UPDATE work.newsletter nl, lookup.ufids lu
SET nl.UFID=lu.UF_UFID
WHERE nl.email=lu.UF_EMAIL
AND nl.ufid is Null;

UPDATE work.newsletter
SET alt_email=concat(trim(SUBSTRING_INDEX(email,'@',1)),"@ufl.edu");



SELECT DISTINCT alt_email from work.newsletter WHERE ufid is Null;

UPDATE work.newsletter nl, lookup.email lu
SET nl.UFID=lu.UF_UFID
WHERE nl.alt_email=lu.UF_EMAIL
AND nl.ufid is Null;


UPDATE work.newsletter nl, lookup.ufids lu
SET nl.UFID=lu.UF_UFID
WHERE nl.alt_email=lu.UF_EMAIL
AND nl.ufid is Null;

UPDATE work.newsletter nl, lookup.ufids lu
SET nl.Gender=lu.UF_GENDER_CD
WHERE nl.UFID=lu.UF_UFID;

UPDATE work.newsletter nl, lookup.active_emp lu
SET nl.DeptID=lu.Department_Code,
    nl.Department=lu.Department,
    nl.Title=lu.Job_Code
WHERE nl.UFID=lu.Employee_ID
AND FTE>0;

UPDATE work.newsletter nl, lookup.Employees lu
SET nl.DeptID=lu.Department_Code,
    nl.Department=lu.Department,
    nl.Title=lu.Job_Code
WHERE nl.UFID=lu.Employee_ID
AND nl.DeptID is Null;

UPDATE work.newsletter nl, lookup.ufids lu
SET nl.DeptID=lu.UF_DEPT,
    nl.Department=lu.UF_DEPT_NM,
    nl.Title=lu.UF_WORK_TITLE
WHERE nl.UFID=lu.UF_UFID
AND nl.DeptID is Null;

select * from work.newsletter;

