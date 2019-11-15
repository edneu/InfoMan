### Source : [IS_BaseData].[Base].[vwPeople]
### USE ODBC with SPSS
### UFID Load and Write ODBC.sps




drop table loaddata.ufids;
create table loaddata.ufids
(
recid Integer auto_increment primary key,
UF_UFID varchar (33) NOT NULL,
UF_DISPLAY_NM varchar (50) NOT NULL,
UF_LAST_NM varchar (50) NOT NULL,
UF_FIRST_NM varchar (50) NOT NULL,
UF_MIDDLE_NM varchar (50) NOT NULL,
UF_USER_NM varchar (50) NOT NULL,
UF_EMAIL varchar (50) NOT NULL,
UF_DEPT varchar (30) NOT NULL,
UF_DEPT_NM varchar (50) NOT NULL,
UF_PS_DEPT_ID varchar (30) NOT NULL,
UF_STATUS_FLG varchar (3) NOT NULL,
UF_PRIMARY_AFFL varchar (3) NOT NULL,
UF_WORK_TITLE varchar (50) NOT NULL,
UF_TELEPHONE varchar (50) NOT NULL,
UF_GENDER_CD varchar (3) NOT NULL,
UF_BIRTH_DT date NULL,
UF_ADDR_LINE1 varchar (50) NOT NULL,
UF_ADDR_LINE2 varchar (50) NOT NULL,
UF_ADDR_LINE3 varchar (50) NOT NULL,
UF_CITY varchar (50) NOT NULL,
UF_STATE_CD varchar (6) NOT NULL,
UF_ZIP_CD varchar (36) NOT NULL,
UF_FAX varchar (50) NOT NULL,
EMPL_STATUS varchar (9) NOT NULL,
EMPL_DESCR varchar (50) NOT NULL,
TenureDEPTID varchar (30) NOT NULL
);
commit;





load data local infile "P:\\My Documents\\My Documents\\Loaddata\\UFIDs20191029.dat" 
into table loaddata.ufids 
fields terminated by '\t'
lines terminated by '\n'
(   UF_UFID,
UF_DISPLAY_NM,
UF_LAST_NM,
UF_FIRST_NM,
UF_MIDDLE_NM,
UF_USER_NM,
UF_EMAIL,
UF_DEPT,
UF_DEPT_NM,
UF_PS_DEPT_ID,
UF_STATUS_FLG,
UF_PRIMARY_AFFL,
UF_WORK_TITLE,
UF_TELEPHONE,
UF_GENDER_CD,
UF_BIRTH_DT,
UF_ADDR_LINE1,
UF_ADDR_LINE2,
UF_ADDR_LINE3,
UF_CITY,
UF_STATE_CD,
UF_ZIP_CD,
UF_FAX,
EMPL_STATUS,
EMPL_DESCR,
TenureDEPTID
);

select min(UF_BIRTH_DT), MAX(UF_BIRTH_DT) from loaddata.ufids ;

select UF_GENDER_CD,count(*) from loaddata.ufids group by UF_GENDER_CD;

/*
select * from loaddata.ufids where UF_GENDER_CD='UF_'; 
SET SQL_SAFE_UPDATES = 0;
delete from loaddata.ufids where UF_GENDER_CD='UF_';
*/

select "New Table (loaddata.ufids):",count(*), count(distinct uf_ufid) from loaddata.ufids
UNION ALL 
select "Current Table: (lookup.ufids)",count(*), count(distinct uf_ufid) from lookup.ufids;

select * from loaddata.ufids;

select min(UF_UFID), MAX(UF_UFID) from loaddata.ufids ;





SELECT min(UF_BIRTH_DT),MAX(UF_BIRTH_DT) from loaddata.ufids;
SELECT DISTINCT UF_BIRTH_DT from loaddata.ufids;
SELECT DISTINCT UF_BIRTH_DT from lookup.ufids;


Alter table loaddata.ufids
	ADD ae_active_emp_id int(11),		
	ADD ae_Department_Code	varchar(12),			
	ADD ae_Department	varchar(45),			
	ADD ae_Employee_ID	varchar(12),			
	ADD ae_Name	varchar(45),			
	ADD ae_FTE	decimal(12,2),		
	ADD ae_Salary_Plan_Code varchar(5),				
	ADD ae_Salary_Plan	varchar(45),				
	ADD ae_Job_Code_Code varchar(12),				
	ADD ae_Job_Code	varchar(45);				


CREATE INDEX ufidtemp ON loaddata.ufids (UF_UFID);
CREATE INDEX EMPID ON lookup.Employees (Employee_ID);

SET SQL_SAFE_UPDATES = 0;
UPDATE loaddata.ufids uf, lookup.Employees lu
SET	uf.ae_active_emp_id=lu.Employee_ID,
	uf.ae_Department_Code=lu.Department_Code,
	uf.ae_Department=lu.Department,
	uf.ae_Employee_ID=lu.Employee_ID,
	uf.ae_Name=lu.Name,
	uf.ae_FTE=lu.FTE,
	uf.ae_Salary_Plan_Code=lu.Salary_Plan_Code,
	uf.ae_Salary_Plan=lu.Salary_Plan,
	uf.ae_Job_Code_Code=lu.Job_Code_Code,
	uf.ae_Job_Code=lu.Job_Code,
	uf.ae_Salary_Plan=lu.Salary_Plan,
	uf.ae_Job_Code_Code=lu.Job_Code_Code,
	uf.ae_Job_Code=lu.Job_Code
WHERE uf.UF_UFID=lu.Employee_ID;	



SET SQL_SAFE_UPDATES = 1;


desc loaddata.ufids;

/*

create table loaddata.backupufid20191029 as select * from lookup.ufids;

drop table lookup.ufids;
create table lookup.ufids AS
select * from loaddata.ufids;

CREATE INDEX ufid ON lookup.ufids (UF_UFID);
CREATE INDEX email ON lookup.ufids (UF_EMAIL);
CREATE INDEX UF_USER_NM ON lookup.ufids (UF_USER_NM);
CREATE INDEX UF_LAST_NM ON lookup.ufids (UF_LAST_NM);

select UF_BIRTH_DT from loaddata.ufids;
select min(UF_BIRTH_DT),max(UF_BIRTH_DT) from lookup.ufids;
select min(UF_BIRTH_DT),max(UF_BIRTH_DT) from loaddata.ufids;
select min(UF_UFID),max(UF_UFID) from lookup.ufids;
*/

## ufidtest SPSS LOAD
select distinct UF_LAST_NM from loaddata.ufids;


select UF_GENDER_CD,count(*) from lookup.ufids group by UF_GENDER_CD;
select UF_GENDER_CD,count(*) from loaddata.ufids group by UF_GENDER_CD;

select * from lookup.ufids where UF_LAST_NM="Neu";
select * from loaddata.ufids where UF_LAST_NM="Neu";
select * from loaddata.backupufid20191029 where UF_LAST_NM="Neu";







## ACTVIE EMPLOYEE FILE
/*
drop table if exists lookup.active_emp;
create table lookup.active_emp AS
select * from loaddata.`emp_list_9-14-2016`;

CREATE INDEX empid ON lookup.active_emp (Employee_ID);
*/

select Job_Code,count(*) from lookup.active_emp where Job_Code like "%Postd%" group by Job_Code;
