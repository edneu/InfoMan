

DROP TABLE IF EXISTS loaddata.awards_history;
CREATE TABLE loaddata.awards_history 
(
	`awards_history_id` Integer auto_increment primary key,
	`CLK_AWD_ID` Varchar(12) not null,
	`CLK_AWD_STATE` Varchar(25) not null,
	`CLK_AWD_PI` Varchar(45) not null,
	`CLK_PI_UFID` Varchar(12) not null,
	`REPORTING_SPONSOR_NAME` Varchar(45) not null,
	`REPORTING_SPONSOR_CUSTID` Varchar(25) not null,
	`REPORTING_SPONSOR_CAT` Varchar(45) not null,
	`REPORTING_SPONSOR_AWD_ID` Varchar(25) not null,
	`DIRECT_AMOUNT` Decimal(65, 10) not null,
	`INDIRECT_AMOUNT` Decimal(65, 10) not null,
	`SPONSOR_AUTHORIZED_AMOUNT` Decimal(65, 10) not null,
	`FUNDS_ACTIVATED` Datetime not null,
	`CLK_AWD_PI_DEPTID` Varchar(25) not null,
	`CLK_AWD_PI_DEPT` Varchar(255) not null,
	`CLK_AWD_PI_COLLEGE` Varchar(255) not null,
	`CLK_AWD_DEPT` Varchar(45) not null,
	`CLK_AWD_COLLEGE` Varchar(255) not null,
	`CLK_AWD_DEPTID` Varchar(25) not null,
	`CLK_AWD_SPONSOR_NAME` Varchar(45) not null,
	`CLK_AWD_SPONSOR_CUSTID` Varchar(12) not null,
	`CLK_AWD_SPONSOR_CAT` Varchar(45) not null,
	`CLK_AWD_SPONSOR_AWD_ID` Varchar(25) not null,
	`CLK_AWD_PRIME_SPONSOR_NAME` Varchar(255) not null,
	`CLK_AWD_PRIME_SPONSOR_CUSTID` Varchar(255) not null,
	`CLK_AWD_PRIME_SPONSOR_CAT` Varchar(255) not null,
	`CLK_AWD_PRIME_SPONSOR_AWD_ID` Varchar(255) not null,
	`CLK_AWD_OVERALL_START_DATE` Datetime not null,
	`CLK_AWD_OVERALL_END_DATE` Datetime not null,
	`CLK_AWD_COST_SHARE` Varchar(12) not null,
	`CLK_AWD_HUMAN_SUBJ` Varchar(5) not null,
	`CLK_AWD_LAB_ANMLS` Varchar(5) not null,
	`CLK_AWD_PROJ_ID` Varchar(12) not null,
	`CLK_AWD_PROJ_NAME` Varchar(255) not null,
	`CLK_AWD_PROJ_MGR` Varchar(45) not null,
	`CLK_AWD_PROJ_MGR_UFID` Varchar(12) not null,
	`CLK_AWD_PROJ_DEPT` Varchar(255) not null,
	`CLK_AWD_PROJ_DEPTID` Varchar(25) not null,
	`CLK_AWD_PROJ_COLLEGE` Varchar(255) not null,
	`CLK_AWD_PROJ_COLLEGEID` Varchar(45) not null,
	`CLK_AWD_ALLOC_IDC_RATE` Decimal(12, 2) not null,
	`CLK_AWD_ALLOC_RATE_TYPE` Varchar(45) not null,
	`CLK_AWD_ALLOC_RATE_BASE` Varchar(12) not null,
	`CLK_AWD_PURPOSE` Varchar(25) not null,
	`CLK_AWD_PROJ_TYPE` Varchar(25) not null,
	`CLK_AWD_PRJ_START_DT` Datetime not null,
	`CLK_AWD_PRJ_END_DT` Datetime null,
	`CLK_AWD_ALLOC_STRT_DT` Datetime not null,
	`CLK_AWD_ALLOC_END_DT` Datetime not null,
	`CLK_AWD_PS_FUND_CODE_ID` Varchar(5) not null,
	`CLK_AWD_PROJ_ACTIVE` Varchar(12) not null,
	`CLK_AWD_PROJ_CLOSED` Varchar(5) not null,
	`SRC` Varchar(12) not null,
	`MOD_PAY_ID` Varchar(45) not null,
	`ALLOCATION_ID` Varchar(12) not null,
	`SID_DATE_ACTVTD` Varchar(25) not null,
	`DAY_NUM_DATE_ACTIVATED` Integer not null,
	`LEAP_YEAR` Integer not null,
	`FD_DATE_ACTIVATED` Integer not null,
	`MONTH_DATE_ACTIVATED` Varchar(12) not null,
	`FM_DATE_ACTIVATED` Integer not null,
	`FQ_DATE_ACTIVATED` Integer not null,
	`FY_DATE_ACTIVATED` Integer not null,
	`CLK_AWD_FULL_TITLE` Varchar(255) not null,
	`EXCEPTION` Varchar(255) not null,
	`INTERNAL_REPORTING_SPONSOR` Varchar(45) not null,
	`TRANSFER` Varchar(255) not null,
	`AWD_PI_PREEM` Varchar(25) not null,
	`PRJ_MGR_PREEM` Varchar(25) not null,
	`UNIVERSITY_REPORTABLE` varchar(12) not null,
	`TEMPORARY_IND` varchar(12) not null,
	`CARRYOVER` varchar(12) not null,
	`CORE_OFFICE_CORRECTION` varchar(12) not null,
	`INTERNAL_FUNDS` varchar(12) not null,
	`LASTUPD_EW_DTTM` Datetime not null,
## Following Were Added August 3 2017 to accomdate changes in Structure of view
`CLK_AWD_PROJ_MGR_DEPTID` varchar(25) not null,
`CLK_AWD_PROJ_MGR_DEPT` varchar(255) not null,
`CLK_AWD_PROJ_MGR_COLLEGEID` varchar(25) not null,
`CLK_AWD_PROJ_MGR_COLLEGE` varchar(255) not null,
`CLK_MOD_SPON_AWD_ID` varchar(25) null,
`CLK_AWD_PURPOSE_NAME` varchar(255) null,
`CLK_AWD_PURPOSE_GROUP` varchar(255)  null,
`ORGNL_FUNDS_ACTIVATED` Datetime null

);

SET GLOBAL local_infile = 1;



load data local infile "P:\\My Documents\\My Documents\\LoadData\\AwardsHistory20201110.csv" 
into table loaddata.awards_history 
fields terminated by '|'
lines terminated by '\n'
IGNORE 1 LINES
(
CLK_AWD_ID,
CLK_AWD_STATE,
CLK_AWD_PI,
CLK_PI_UFID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_CUSTID,
REPORTING_SPONSOR_CAT,
REPORTING_SPONSOR_AWD_ID,
DIRECT_AMOUNT,
INDIRECT_AMOUNT,
SPONSOR_AUTHORIZED_AMOUNT,
FUNDS_ACTIVATED,
CLK_AWD_PI_DEPTID,
CLK_AWD_PI_DEPT,
CLK_AWD_PI_COLLEGE,
CLK_AWD_DEPT,
CLK_AWD_COLLEGE,
CLK_AWD_DEPTID,
CLK_AWD_SPONSOR_NAME,
CLK_AWD_SPONSOR_CUSTID,
CLK_AWD_SPONSOR_CAT,
CLK_AWD_SPONSOR_AWD_ID,
CLK_AWD_PRIME_SPONSOR_NAME,
CLK_AWD_PRIME_SPONSOR_CUSTID,
CLK_AWD_PRIME_SPONSOR_CAT,
CLK_AWD_PRIME_SPONSOR_AWD_ID,
CLK_AWD_OVERALL_START_DATE,
CLK_AWD_OVERALL_END_DATE,
CLK_AWD_COST_SHARE,
CLK_AWD_HUMAN_SUBJ,
CLK_AWD_LAB_ANMLS,
CLK_AWD_PROJ_ID,
CLK_AWD_PROJ_NAME,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
CLK_AWD_PROJ_DEPT,
CLK_AWD_PROJ_DEPTID,
CLK_AWD_PROJ_COLLEGE,
CLK_AWD_PROJ_COLLEGEID,
CLK_AWD_ALLOC_IDC_RATE,
CLK_AWD_ALLOC_RATE_TYPE,
CLK_AWD_ALLOC_RATE_BASE,
CLK_AWD_PURPOSE,
CLK_AWD_PROJ_TYPE,
CLK_AWD_PRJ_START_DT,
CLK_AWD_PRJ_END_DT,
CLK_AWD_ALLOC_STRT_DT,
CLK_AWD_ALLOC_END_DT,
CLK_AWD_PS_FUND_CODE_ID,
CLK_AWD_PROJ_ACTIVE,
CLK_AWD_PROJ_CLOSED,
SRC,
MOD_PAY_ID,
ALLOCATION_ID,
SID_DATE_ACTVTD,
DAY_NUM_DATE_ACTIVATED,
LEAP_YEAR,
FD_DATE_ACTIVATED,
MONTH_DATE_ACTIVATED,
FM_DATE_ACTIVATED,
FQ_DATE_ACTIVATED,
FY_DATE_ACTIVATED,
CLK_AWD_FULL_TITLE,
EXCEPTION,
INTERNAL_REPORTING_SPONSOR,
TRANSFER,
AWD_PI_PREEM,
PRJ_MGR_PREEM,
UNIVERSITY_REPORTABLE,
TEMPORARY_IND,
CARRYOVER,
CORE_OFFICE_CORRECTION,
INTERNAL_FUNDS,
LASTUPD_EW_DTTM,
## ADDED 8/3/2017 to accomodate changes in strucure of view
CLK_AWD_PROJ_MGR_DEPTID,
CLK_AWD_PROJ_MGR_DEPT,
CLK_AWD_PROJ_MGR_COLLEGEID,
CLK_AWD_PROJ_MGR_COLLEGE,
CLK_MOD_SPON_AWD_ID,
## Following Added December 12 2017
CLK_AWD_PURPOSE_NAME,
CLK_AWD_PURPOSE_GROUP,
ORGNL_FUNDS_ACTIVATED
);




SET SQL_SAFE_UPDATES = 0;




## select * from loaddata.awards_history;


###delete from loaddata.awards_history    where awards_history_id=1;

Select "Old File" AS Measure, Count(*) AS Reccount from lookup.awards_history
UNION ALL
Select "New File" AS Measure, Count(*) AS Reccount from loaddata.awards_history;




Select "FUNDS_ACTIVATED" as Measure ,Min(FUNDS_ACTIVATED), Max(FUNDS_ACTIVATED) from loaddata.awards_history
UNION ALL
Select "LASTUPD_EW_DTTM" as Measure, Min(LASTUPD_EW_DTTM), Max(LASTUPD_EW_DTTM) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_PRJ_START_DT" as Measure,min(CLK_AWD_PRJ_START_DT), MAX(CLK_AWD_PRJ_START_DT) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_PRJ_END_DT" as Measure,min(CLK_AWD_PRJ_END_DT), MAX(CLK_AWD_PRJ_END_DT) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_ALLOC_STRT_DT",min(CLK_AWD_ALLOC_STRT_DT), MAX(CLK_AWD_ALLOC_STRT_DT) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_ALLOC_END_DT"as Measure,min(CLK_AWD_ALLOC_END_DT), MAX(CLK_AWD_PRJ_END_DT) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_OVERALL_START_DATE"as Measure,min(CLK_AWD_OVERALL_START_DATE), MAX(CLK_AWD_OVERALL_START_DATE) from loaddata.awards_history
UNION ALL
Select "CLK_AWD_OVERALL_END_DATE"as Measure,min(CLK_AWD_OVERALL_START_DATE), MAX(CLK_AWD_OVERALL_END_DATE) from loaddata.awards_history
;


select "Direct" as Measure, min(DIRECT_AMOUNT) as Minimum, max(DIRECT_AMOUNT) as Maximum, sum(DIRECT_AMOUNT) AS Total, Avg(DIRECT_AMOUNT) as Average from loaddata.awards_history
UNION ALL
select "Indirect" as Measure, min(INDIRECT_AMOUNT) as Minimum, max(INDIRECT_AMOUNT) as Maximum, sum(INDIRECT_AMOUNT) AS Total, Avg(INDIRECT_AMOUNT) as Average from loaddata.awards_history
UNION ALL
select "AuthAmt" as Measure, min(SPONSOR_AUTHORIZED_AMOUNT) as Minimum, max(SPONSOR_AUTHORIZED_AMOUNT) as Maximum, sum(SPONSOR_AUTHORIZED_AMOUNT) AS Total, Avg(SPONSOR_AUTHORIZED_AMOUNT) as Average from loaddata.awards_history
;



select * from loaddata.awards_history;

#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################


ALTER TABLE loaddata.awards_history
ADD AcademicUnit varchar(45);

SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.awards_history ah, lookup.academic_units lu
       SET ah.AcademicUnit=lu.AcademicUnit
       WHERE ah.CLK_AWD_PI_COLLEGE=lu.College;


##select distinct CLK_AWD_PI_COLLEGE from loaddata.awards_history where AcademicUnit IS NULL;
##select AcademicUnit,count(*) from loaddata.awards_history group by AcademicUnit;

## ADD ROSTER FIELDS
ALTER TABLE loaddata.awards_history
ADD Roster2008 integer(1),
ADD Roster2009 integer(1),
ADD Roster2010 integer(1),
ADD Roster2011 integer(1),
ADD Roster2012 integer(1),
ADD Roster2013 integer(1),
ADD Roster2014 integer(1),
ADD Roster2015 integer(1),
ADD Roster2016 integer(1),
ADD Roster2017 integer(1),
ADD Roster2018 integer(1),
ADD Roster2019 integer(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.awards_history
SET Roster2008=0,
    Roster2009=0,
	Roster2010=0,
	Roster2011=0,
	Roster2012=0,
	Roster2013=0,
	Roster2014=0,
	Roster2015=0,
	Roster2016=0,
	Roster2017=0,
	Roster2018=0,
	Roster2019=0;


#########

SET SQL_SAFE_UPDATES = 0;

CREATE INDEX rosterufid ON lookup.roster (UFID);
CREATE INDEX rosteryear ON lookup.roster (Year);


UPDATE loaddata.awards_history ah SET Roster2008=1 Where Year(FUNDS_ACTIVATED)=2008 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2009 and Roster=1);  ## USE 2009 roster for 2008 (AT)
UPDATE loaddata.awards_history ah SET Roster2009=1 Where Year(FUNDS_ACTIVATED)=2009 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2009 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2010=1 Where Year(FUNDS_ACTIVATED)=2010 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2010 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2011=1 Where Year(FUNDS_ACTIVATED)=2011 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2011 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2012=1 Where Year(FUNDS_ACTIVATED)=2012 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2012 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2013=1 Where Year(FUNDS_ACTIVATED)=2013 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2013 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2014=1 Where Year(FUNDS_ACTIVATED)=2014 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2014 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2015=1 Where Year(FUNDS_ACTIVATED)=2015 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2015 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2016=1 Where Year(FUNDS_ACTIVATED)=2016 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2016 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2017=1 Where Year(FUNDS_ACTIVATED)=2017 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2017 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2018=1 Where Year(FUNDS_ACTIVATED)=2018 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2018 and Roster=1);
UPDATE loaddata.awards_history ah SET Roster2019=1 Where Year(FUNDS_ACTIVATED)=2019 AND ah.CLK_PI_UFID IN (SELECT DISTINCT UFID from lookup.roster Where Year=2019 and Roster=1);

##select  sum(Roster2009), sum(Roster2010),sum(Roster2011),sum(Roster2012),sum(Roster2013),sum(Roster2014),sum(Roster2015),sum(Roster2016),sum(Roster2017),sum(Roster2018) from loaddata.awards_history;




#############################################################################################
#############################################################################################
#############################################################################################
##################################################################################




SET sql_mode = '';
SET SQL_SAFE_UPDATES = 0;
create table loaddata.backupAwardsHistory20201110 AS SELECT * from lookup.awards_history;


select distinct (CLK_AWD_PRJ_END_DT) from loaddata.awards_history;
select distinct CLK_AWD_OVERALL_END_DATE from loaddata.awards_history;
Select distinct EXCEPTION,count(*)  FROM loaddata.awards_history group by Exception;



DELETE FROM loaddata.awards_history
WHERE EXCEPTION IN (

 ' ""Heterogeneity and Impact of Rotavirus Vaccination in Asia"""',
 ' Master Services Agreement and Statement of Work ' ,
 ' US Alpha-1 	Medical Advisory Board ',
'2019'	,
'Best Managment Practices Program and Research',
'2020','EXCLUDE-BYPASS',
'EXCLUDE-CARRYOVER',
'EXCLUDE-CORE',
'EXCLUDE-NOT AUTH',
'EXCLUDE-REBUDGET',
'EXCLUDE-TEMP',
'EXCLUDE-UF',
'EXCLUDE-UFRF');
;


select * from loaddata.awards_history;
select count(*)  from loaddata.awards_history;

select * from loaddata.awards_history  Where CLK_AWD_PRJ_END_DT='Research Developmental'
OR 'CLK_AWD_ALLOC_END_DT'='Research Developmental' ;

select distinct CLK_AWD_OVERALL_END_DATE from loaddata.awards_history;

Select distinct EXCEPTION FROM loaddata.awards_history;


/*
drop table if exists lookup.awards_history;
create table lookup.awards_history AS
select * from loaddata.awards_history;

select * from lookup.awards_history where CLK_AWD_PRJ_END_DT LIKE "CLK_AWD%";


select min(CLK_AWD_PRJ_END_DT) from lookup.awards_history;

Select * from loaddata.awards_history where CLK_AWD_PRJ_END_DT IN (SELECT MAX(CLK_AWD_PRJ_END_DT) from loaddata.awards_history)  ;

*/

SELECT Year,Roster,COunt(*) from lookup.roster group by Year,Roster;