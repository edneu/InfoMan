






DROP TABLE IF EXISTS loaddata.email_master;
CREATE TABLE loaddata.email_master 
( 
   
`email_master_id` Integer auto_increment primary key,    
`UF_UFID`	varchar(12) null,
`UF_TYPE_CD`	int(11) null,
`UF_TYPE`	varchar(255) null,
`UF_SEQUENCE_NO`	int(11) null,
`UF_PUBLISH_FLG`	varchar(3) null,
`UF_PRIMARY_FLG`	varchar(3) null,
`UF_ACTIVE_FLG`	varchar(3) null,
`UF_EMAIL`	varchar(255) null 
);

load data local infile "P:\\My Documents\\My Documents\\LoadData\\email master 20200914.csv" 
into table loaddata.email_master 
fields terminated by ','
lines terminated by '\n'
IGNORE 1 LINES
(
UF_UFID,
UF_TYPE_CD,
UF_TYPE,
UF_SEQUENCE_NO,
UF_PUBLISH_FLG,
UF_PRIMARY_FLG,
UF_ACTIVE_FLG,
UF_EMAIL
);


select * from loaddata.email_master;

select UF_TYPE_CD,UF_TYPE from loaddata.email_master group by UF_TYPE_CD,UF_TYPE;

select em.UF_UFID, lu.UF_LAST_NM, lu.UF_FIRST_NM, em.UF_EMAIL, em.UF_ACTIVE_FLG 
from loaddata.email_master em left join lookup.ufids lu on em.UF_UFID=lu.UF_UFID 
where lu.UF_LAST_NM like "Fischbach";
where em.uf_email like "%neu@%";

create table lookup.email_master AS
select * from loaddata.email_master;


CREATE INDEX EmailmaterUFID ON lookup.email_master (UF_UFID);
CREATE INDEX EmailmaterEMAIL ON lookup.email_master (UF_EMAIL);


ALTER TABLE lookup.email_master
	ADD Lastname varchar(50),
	ADD FirstName varchar(50),
	ADD Salary_Plan varchar(45),
	ADD JobTitle varchar(255),
	ADD DeptID varchar(12),
	ADD DeptName varchar(55);

SET SQL_SAFE_UPDATES = 0;

UPDATE lookup.email_master em, lookup.ufids lu
SET em.Lastname=lu.UF_LAST_NM,
	em.FirstName=lu.UF_FIRST_NM
WHERE em.UF_UFID=lu.UF_UFID   ; 


UPDATE lookup.email_master em, lookup.Employees lu
SET em.Salary_Plan=lu.Salary_Plan,
    em.JobTitle=lu.Job_Code,
    em.DeptID=lu.Department_Code,
    em.DeptName=lu.Department
WHERE em.UF_UFID=lu.Employee_ID  ; 

select *
from lookup.email_master 
where LastName like "%crizaldo%";


UPDATE lookup.email_master em, lookup.ufids lu
SET em.JobTitle=lu.UF_WORK_TITLE 
WHERE em.UF_UFID=lu.UF_UFID 
AND em.JobTitle IS NULL ; 

UPDATE lookup.email_master em, lookup.ufids lu
SET em.DeptID=lu.UF_DEPT,
    em.DeptName=lu.UF_USER_NM
WHERE em.UF_UFID=lu.UF_UFID
AND em.DeptID IS NULL ; 



