#####CRC Demographics by Participant by Year and Overall
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################


### UNDUP PARTICPANTS
drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT YEAR(VISITDATE) AS VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp_pr.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp_pr.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp_pr.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
 ;




/*
select min(YEAR(VISITDATE)), Max(YEAR(VISITDATE)) from ctsi_webcamp_pr.OPVISIT;
select min(VisitYear), Max(VisitYear) from ctsi_webcamp_adhoc.enrollment_tmp1;

select STATUS,count(*) from ctsi_webcamp_pr.OPVISIT where YEAR(VISITDATE)=2018 group by Status;
select YEAR(VISITDATE),count(*) from ctsi_webcamp_pr.OPVISIT group by YEAR(VISITDATE);
select YEAR(ADMITDATE),count(*) from ctsi_webcamp_pr.ADMISSIO group by YEAR(ADMITDATE);
select YEAR(ADMITDATE),count(*) from ctsi_webcamp_pr.SBADMISSIO group by YEAR(ADMITDATE);
*/

### UNDUP BY YEAR
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.demogYear;
CREATE TABLE ctsi_webcamp_adhoc.demogYear AS
select VisitYear,
	   PATIENT, 
	   count(*) as Visits
from ctsi_webcamp_adhoc.enrollment_tmp1 
WHERE VisitYear>=2009    
group by VisitYear,Patient;



##################################################################################################################################
##################################################################################################################################
###### Create Demogrphic Lookup Table
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.DemogALL;
CREATE TABLE ctsi_webcamp_adhoc.DemogALL AS
SELECT 	UNIQUEFIELD AS PATIENT,
		max(0) as ETH_HISP,
        max(0) AS ETH_NONHISP,
        max(0) AS ETH_UNKN,
        max(R1) as AmerIndian,
        max(R2) as Asian,
        max(R3) as HawaiiAlaska,
        max(R4) as BlackAA,
        max(R5) as White,
        max(R6) as Morethan1Race,
        max(R7) as RaceNotReported,
        max(0) as SEX_M ,
        max(0) as SEX_F,
        Min(DOB) as DOB
from ctsi_webcamp_pr.patient
GROUP BY UNIQUEFIELD;

;
#################FIX MF and ETHNIC

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.DemogALL et, ctsi_webcamp_pr.patient lu  SET ETH_HISP=1 WHERE et.PATIENT=lu.UNIQUEFIELD and lu.NEWETH=1;
UPDATE ctsi_webcamp_adhoc.DemogALL et, ctsi_webcamp_pr.patient lu  SET ETH_NONHISP=1 WHERE et.PATIENT=lu.UNIQUEFIELD and lu.NEWETH=2;
UPDATE ctsi_webcamp_adhoc.DemogALL et, ctsi_webcamp_pr.patient lu  SET ETH_UNKN=1 WHERE et.PATIENT=lu.UNIQUEFIELD and lu.NEWETH=3;

UPDATE ctsi_webcamp_adhoc.DemogALL et, ctsi_webcamp_pr.patient lu  SET SEX_M=1 WHERE et.PATIENT=lu.UNIQUEFIELD and lu.SEX="M";
UPDATE ctsi_webcamp_adhoc.DemogALL et, ctsi_webcamp_pr.patient lu  SET SEX_F=1 WHERE et.PATIENT=lu.UNIQUEFIELD and lu.SEX="F";

############################################################################################################
############################################################################################################
############################################################################################################
### ADD DEMOGRAPHICS TO ENROLLMENT TABLE

#### ADD DEMOGRAPHICS
ALTER TABLE ctsi_webcamp_adhoc.demogYear
	ADD ETH_HISP int(1),
	ADD ETH_NONHISP int(1),
	ADD ETH_UNKN INT(1),
	ADD AmerIndian int(1),
	ADD Asian int(1),
	ADD HawaiiAlaska int(1),
	ADD BlackAA int(1),
	ADD White int(1),
	ADD Morethan1Race int(1),
	ADD RaceNotReported int(1),
	ADD SEX_M int(1),
	ADD SEX_F int(1),
    ADD Age18 int(1),
    ADD Age64 int(1)
;


CREATE INDEX demoall ON ctsi_webcamp_adhoc.demogYear (PATIENT);
CREATE INDEX demoyear ON ctsi_webcamp_adhoc.DemogALL (PATIENT);


UPDATE ctsi_webcamp_adhoc.demogYear dy, ctsi_webcamp_adhoc.DemogALL lu
SET dy.ETH_HISP=lu.ETH_HISP,
	dy.ETH_NONHISP=lu.ETH_NONHISP,
	dy.ETH_UNKN=lu.ETH_UNKN,
	dy.AmerIndian=lu.AmerIndian,
	dy.Asian=lu.Asian,
	dy.HawaiiAlaska=lu.HawaiiAlaska,
	dy.BlackAA=lu.BlackAA,
	dy.White=lu.White,
	dy.Morethan1Race=lu.Morethan1Race,
    dy.RaceNotReported=lu.RaceNotReported,
	dy.SEX_M=lu.SEX_M,	
	dy.SEX_F=lu.SEX_F
WHERE dy.PATIENT=lu.PATIENT;


UPDATE ctsi_webcamp_adhoc.demogYear
SET Age18=0,
    Age64=0;

UPDATE ctsi_webcamp_adhoc.demogYear dy, ctsi_webcamp_adhoc.DemogALL lu
SET Age18=1
WHERE VisitYear-YEAR(DOB)<=18
AND dy.PATIENT=lu.PATIENT ;

UPDATE ctsi_webcamp_adhoc.demogYear dy, ctsi_webcamp_adhoc.DemogALL lu
SET Age64=1
WHERE VisitYear-YEAR(DOB)>64
AND dy.PATIENT=lu.PATIENT ;



select * FROM ctsi_webcamp_adhoc.demogYear;

SELECT DISTINCT RaceNotReported from ctsi_webcamp_adhoc.demogYear;



#############################
####CREATE UNDUPLICATED TABLE FOR ALL YEARS
drop table if exists ctsi_webcamp_adhoc.demogallyears;
create table ctsi_webcamp_adhoc.demogallyears AS
SELECT 	"ALL" AS VisitYear,
		PATIENT,
        SUM(Visits) AS TotalVisits, 
		MAX(ETH_HISP) AS ETH_HISP,
		MAX(ETH_NONHISP) AS ETH_NONHISP,
		MAX(ETH_UNKN) AS ETH_UNKN,
		MAX(AmerIndian) AS AmerIndian,
		MAX(Asian) AS Asian,
		MAX(HawaiiAlaska) AS HawaiiAlaska,
		MAX(BlackAA) AS BlackAA,
		MAX(White) AS White,
		MAX(Morethan1Race) AS Morethan1Race,
		MAX(RaceNotReported) AS RaceNotReported,
		MAX(SEX_M) AS SEX_M,
		MAX(SEX_F) AS SEX_F,
        MAX(Age18) as Age18,
        MAX(Age64) as Age64
FROM ctsi_webcamp_adhoc.demogYear
GROUP BY "ALL", PATIENT;

################ FINAL TABLE

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRC_ALL_VISIT_DEMOG;
CREATE TABLE ctsi_webcamp_adhoc.CRC_ALL_VISIT_DEMOG AS
SELECT 	VisitYear,
		COUNT(DISTINCT PATIENT) AS TotalParticpants,
        SUM(Visits) AS TotalVisits, 
		SUM(ETH_HISP) AS ETH_HISP,
		SUM(ETH_NONHISP) AS ETH_NONHISP,
		SUM(ETH_UNKN) AS ETH_UNKN,
		SUM(AmerIndian) AS AmerIndian,
		SUM(Asian) AS Asian,
		SUM(HawaiiAlaska) AS HawaiiAlaska,
		SUM(BlackAA) AS BlackAA,
		SUM(White) AS White,
		SUM(Morethan1Race) AS Morethan1Race,
		SUM(RaceNotReported) AS RaceNotReported,
		SUM(SEX_M) AS SEX_M,
		SUM(SEX_F) AS SEX_F,
        SUM(Age18) as Age18,
        SUM(Age64) as Age64
FROM ctsi_webcamp_adhoc.demogYear
GROUP BY VisitYear
UNION ALL
SELECT 	"ALL" AS VisitYear,
		COUNT(DISTINCT PATIENT) AS TotalParticpants,
        SUM(TotalVisits) AS TotalVisits, 
		SUM(ETH_HISP) AS ETH_HISP,
		SUM(ETH_NONHISP) AS ETH_NONHISP,
		SUM(ETH_UNKN) AS ETH_UNKN,
		SUM(AmerIndian) AS AmerIndian,
		SUM(Asian) AS Asian,
		SUM(HawaiiAlaska) AS HawaiiAlaska,
		SUM(BlackAA) AS BlackAA,
		SUM(White) AS White,
		SUM(Morethan1Race) AS Morethan1Race,
		SUM(RaceNotReported) AS RaceNotReported,
		SUM(SEX_M) AS SEX_M,
		SUM(SEX_F) AS SEX_F,
        SUM(Age18) as Age18,
        SUM(Age64) as Age64
FROM ctsi_webcamp_adhoc.demogallyears
GROUP BY "ALL";

select * from ctsi_webcamp_adhoc.CRC_ALL_VISIT_DEMOG;



;

####CREATE UNDUPLICATED TABLE FOR ALL YEARS
drop table if exists ctsi_webcamp_adhoc.demogallyears;
create table ctsi_webcamp_adhoc.demogallyears AS
SELECT 	"ALL" AS VisitYear,
		PATIENT,
        SUM(Visits) AS TotalVisits, 
		MAX(ETH_HISP) AS ETH_HISP,
		MAX(ETH_NONHISP) AS ETH_NONHISP,
		MAX(ETH_UNKN) AS ETH_UNKN,
		MAX(AmerIndian) AS AmerIndian,
		MAX(Asian) AS Asian,
		MAX(HawaiiAlaska) AS HawaiiAlaska,
		MAX(BlackAA) AS BlackAA,
		MAX(White) AS White,
		MAX(Morethan1Race) AS Morethan1Race,
		MAX(RaceNotReported) AS RaceNotReported,
		MAX(SEX_M) AS SEX_M,
		MAX(SEX_F) AS SEX_F
FROM ctsi_webcamp_adhoc.demogYear
GROUP BY "ALL", PATIENT;








##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################








/*   REF
SET     tp.ETH_HISP=lu.ETH_HISP,
"		tp.ETH_NONHISP=lu.ETH_NONHISP,"
"		tp.ETH_UNKN=lu.ETH_UNKN,"
"		tp.SEX_M=lu.SEX_M,"
"		tp.SEX_F=lu.SEX_F,"
        tp.AmerIndian=lu.R1,
"		tp.Asian=lu.R2,"
"		tp.HawaiiAlaska=lu.R3,"
"		tp.BlackAA=lu.R4,"
"		tp.White=lu.R5,"
"		tp.Morethan1Race=lu.R6,"
"		tp.RaceNotReported=lu.R7,"
        tp.NumPatients=lu.NumPatients
WHERE tp.PROTOCOL=lu.PROTOCOL;








DROP TABLE IF EXISTS ctsi_webcamp_adhoc.demogYear;
CREATE TABLE ctsi_webcamp_adhoc.demogYear AS
select VisitYear,
	count(distinct PATIENT) AS UndupParticpants, 
	count(*) as Visits
from ctsi_webcamp_adhoc.enrollment_tmp1 
WHERE VisitYear>=2009    
group by VisitYear;



