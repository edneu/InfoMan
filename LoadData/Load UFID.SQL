### Source : [IS_BaseData].[Base].[vwPeople]
### UFID Load and Write ODBC.sps




drop table loaddata.ufids;
create table loaddata.ufids
(
recid Integer auto_increment primary key,
UF_UFID varchar (11) NOT NULL,
UF_DISPLAY_NM varchar (400) NULL,
UF_LAST_NM varchar (55) NULL,
UF_FIRST_NM varchar (55) NULL,
UF_MIDDLE_NM varchar (55) NULL,
UF_USER_NM varchar (70)  NULL,
UF_EMAIL varchar (254)  NULL,
UF_DEPT varchar (10)  NULL,
UF_DEPT_NM varchar (50)  NULL,
UF_PS_DEPT_ID varchar (30)  NULL,
UF_STATUS_FLG varchar (3)  NULL,
UF_PRIMARY_AFFL varchar (29)  NULL,
UF_WORK_TITLE varchar (250)  NULL,
UF_TELEPHONE varchar (40)  NULL,
UF_GENDER_CD varchar (4)  NULL,
UF_BIRTH_DT_RAW varchar(26) NULL,
UF_ADDR_LINE1 varchar (100) NULL,
UF_ADDR_LINE2 varchar (100) NULL,
UF_ADDR_LINE3 varchar (100) NULL,
UF_CITY varchar (50) NULL,
UF_STATE_CD varchar (12)  NULL,
UF_ZIP_CD varchar (12) NULL,
UF_FAX varchar (22) NULL,
EMPL_STATUS varchar (5) NULL,
EMPL_DESCR varchar (50) NULL,
TenureDEPTID varchar (10) NULL
);
commit;

##select * from loaddata.ufids;



load data local infile "P:\\My Documents\\My Documents\\Loaddata\\ufid20240124.dat" 
into table loaddata.ufids 
fields terminated by '|'
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
UF_BIRTH_DT_RAW,
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

SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.ufids SET UF_DISPLAY_NM=NULL WHERE UF_DISPLAY_NM='NULL';
UPDATE loaddata.ufids SET UF_LAST_NM=NULL WHERE UF_LAST_NM='NULL';
UPDATE loaddata.ufids SET UF_FIRST_NM=NULL WHERE UF_FIRST_NM='NULL';
UPDATE loaddata.ufids SET UF_MIDDLE_NM=NULL WHERE UF_MIDDLE_NM='NULL';
UPDATE loaddata.ufids SET UF_USER_NM=NULL WHERE UF_USER_NM='NULL';
UPDATE loaddata.ufids SET UF_EMAIL=NULL WHERE UF_EMAIL='NULL';
UPDATE loaddata.ufids SET UF_DEPT=NULL WHERE UF_DEPT='NULL';
UPDATE loaddata.ufids SET UF_DEPT_NM=NULL WHERE UF_DEPT_NM='NULL';
UPDATE loaddata.ufids SET UF_PS_DEPT_ID=NULL WHERE UF_PS_DEPT_ID='NULL';
UPDATE loaddata.ufids SET UF_STATUS_FLG=NULL WHERE UF_STATUS_FLG='NULL';
UPDATE loaddata.ufids SET UF_PRIMARY_AFFL=NULL WHERE UF_PRIMARY_AFFL='NULL';
UPDATE loaddata.ufids SET UF_WORK_TITLE=NULL WHERE UF_WORK_TITLE='NULL';
UPDATE loaddata.ufids SET UF_TELEPHONE=NULL WHERE UF_TELEPHONE='NULL';
UPDATE loaddata.ufids SET UF_GENDER_CD=NULL WHERE UF_GENDER_CD='NULL';
UPDATE loaddata.ufids SET UF_BIRTH_DT_RAW=NULL WHERE UF_BIRTH_DT_RAW='NULL';
UPDATE loaddata.ufids SET UF_ADDR_LINE1=NULL WHERE UF_ADDR_LINE1='NULL';
UPDATE loaddata.ufids SET UF_ADDR_LINE2=NULL WHERE UF_ADDR_LINE2='NULL';
UPDATE loaddata.ufids SET UF_ADDR_LINE3=NULL WHERE UF_ADDR_LINE3='NULL';
UPDATE loaddata.ufids SET UF_CITY=NULL WHERE UF_CITY='NULL';
UPDATE loaddata.ufids SET UF_STATE_CD=NULL WHERE UF_STATE_CD='NULL';
UPDATE loaddata.ufids SET UF_ZIP_CD=NULL WHERE UF_ZIP_CD='NULL';
UPDATE loaddata.ufids SET UF_FAX=NULL WHERE UF_FAX='NULL';
UPDATE loaddata.ufids SET EMPL_STATUS=NULL WHERE EMPL_STATUS='NULL';
UPDATE loaddata.ufids SET EMPL_DESCR=NULL WHERE EMPL_DESCR='NULL';
UPDATE loaddata.ufids SET TenureDEPTID=NULL WHERE TenureDEPTID='NULL';


Delete from loaddata.ufids
WHERE UF_BIRTH_DT_RAW IN ('F','M',' Health Outcomes and Biome');


Alter Table loaddata.ufids ADD UF_BIRTH_DT date;
UPDATE loaddata.ufids
			SET UF_BIRTH_DT=str_to_date(CONCAT(SUBSTR(UF_BIRTH_DT_RAW,1,2),",",SUBSTR(UF_BIRTH_DT_RAW,4,2),",",SUBSTR(UF_BIRTH_DT_RAW,7,4)),'%m,%d,%Y') ;

Select UF_BIRTH_DT_RAW, UF_BIRTH_DT,count(*) from loaddata.ufids group by UF_BIRTH_DT_RAW, UF_BIRTH_DT;



Drop table if exists work.ufidtemp;
CREATE TABLE work.ufidtemp AS
SELECT * from loaddata.ufids;

DROP TABLE IF EXISTS loaddata.ufids;
CREATE TABLE loaddata.ufids AS
SELECT 
UF_UFID,
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
FROM work.ufidtemp  ;







SELECT DISTINCT UF_BIRTH_DT from loaddata.ufids;

select UF_GENDER_CD,count(*) from loaddata.ufids group by UF_GENDER_CD;

/*
select * from loaddata.ufids where UF_GENDER_CD LIKE 'UF%'; 
SET SQL_SAFE_UPDATES = 0;
delete from loaddata.ufids where UF_GENDER_CD LIKE 'UF%';
*/

select "New Table (loaddata.ufids):",count(*), count(distinct uf_ufid) from loaddata.ufids
UNION ALL 
select "Current Table: (lookup.ufids)",count(*), count(distinct uf_ufid) from lookup.ufids;

select * from loaddata.ufids limit 1000;

##delete from loaddata.ufids where recid=1;

select min(UF_UFID), MAX(UF_UFID) from loaddata.ufids ;





SELECT min(UF_BIRTH_DT),MAX(UF_BIRTH_DT) from loaddata.ufids;
SELECT DISTINCT UF_BIRTH_DT from loaddata.ufids;
SELECT DISTINCT UF_BIRTH_DT from lookup.ufids;


Alter table loaddata.ufids
	ADD ae_active_emp_id int(11),		
	ADD ae_Department_Code	varchar(12),			
	ADD ae_Department	varchar(45),			
	ADD ae_Employee_ID	varchar(12),			
	ADD ae_Name	varchar(255),			
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


00000550


/*

create table loaddata.backupufid20220429 as select * from lookup.ufids;
SET sql_mode = '';
drop table if exists lookup.ufids;
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




select * from lookup.ufids where UF_LAST_NM="fischbach";


