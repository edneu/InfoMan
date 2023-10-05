DROP TABLE IF EXISTS work.ActiveEmpEmail;
create table work.ActiveEmpEmail as
select * from loaddata.active_emp_20230410;

ALTER TABLE work.ActiveEmpEmail
ADD email varchar(75);

SET SQL_SAFE_UPDATES = 0;

CREATE INDEX actemp ON work.ActiveEmpEmail (Employee_ID);
CREATE INDEX emlu ON loaddata.email_lu (UF_UFID);

UPDATE work.ActiveEmpEmail ae, loaddata.email_lu lu 
SET ae.email=lu.UF_EMAIL
WHERE ae.Employee_ID=lu.UF_UFID
AND lu.UF_EMAIL LIKE '%ufl%';

UPDATE work.ActiveEmpEmail ae, loaddata.email_lu lu 
SET ae.email=lu.UF_EMAIL
WHERE ae.Employee_ID=lu.UF_UFID
AND ae.email is NULL;

UPDATE work.ActiveEmpEmail ae, lookup.ufids lu 
SET ae.email=lu.UF_EMAIL
WHERE ae.Employee_ID=lu.UF_UFID
AND ae.email is NULL;



select count(*) from work.ActiveEmpEmail where email is Null;

select Department,count(*) from work.ActiveEmpEmail where email is Null group by Department;



