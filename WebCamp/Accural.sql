


#######################################################################################
#######   CREATE ACCRUAL INDEX TABLE                                  #################
#######################################################################################
### CREATE TABLE OF PROTOCOLS AND PIs



drop table if exists ctsi_webcamp_adhoc.pi_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.pi_tmp1 AS
SELECT  PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT, ctsi_webcamp.PERSON
WHERE PERSONPROT.PERSON=PERSON.UNIQUEFIELD AND INVTYPE='P';  # AND INACTIVE=0;



##########################################
### FIRST ENROLLMENT DATE
##########################################
drop table if exists ctsi_webcamp_adhoc.visitdates_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.visitdates_tmp1 AS
    SELECT VISITDATE AS First,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
     UNION ALL
    SELECT ADMITDATE AS First,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
    UNION ALL
    SELECT ADMITDATE AS First,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
;

drop table if exists ctsi_webcamp_adhoc.firstvisit_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.firstvisit_tmp1 AS 
SELECT PROTOCOL,
       MIN(First) AS FirstEncounterDate 
FROM ctsi_webcamp_adhoc.visitdates_tmp1
group by PROTOCOL;


##########################################
### ENROLLMENT BY PROTOCOL
##########################################
drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
 ;

drop table if exists ctsi_webcamp_adhoc.currenrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.currenrollment_tmp1 AS
SELECT PROTOCOL,COUNT(DISTINCT PATIENT) AS CurrentEnrollment
  FROM ctsi_webcamp_adhoc.enrollment_tmp1
  GROUP BY PROTOCOL;

##########################################################
####  BUILD FINAL TABLE
##########################################################

drop table if exists ctsi_webcamp_adhoc.AccuralIndexTmp;
CREATE TABLE ctsi_webcamp_adhoc.AccuralIndexTmp AS    
SELECT UNIQUEFIELD AS PROTOCOL,
       PROTOCOL AS CRC_PROTOCOL,
       IRBNUMBER,
       TITLE,
       EXPNUMPATS,
       PROJDUR,
       DATECLOSEDTOACCRUAL
FROM  ctsi_webcamp.protocol;
### WHERE DATECLOSEDTOACCRUAL IS NULL;


SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ctsi_webcamp_adhoc.AccuralIndexTmp
ADD FirstEncounterDate datetime,
ADD CurrentEnrollment bigint(21),
ADD PI_LastName varchar(30),
ADD PI_FIrstName varchar(30),
ADD ElapsedMonths decimal(10,4),
ADD TotalMonths decimal(10,4),
ADD AccuralProgress decimal(10,4),
ADD AccuralElapsed decimal(10,4),
ADD AccuralIndex decimal(10,4),
ADD OpenToAccural varchar(12);

 

UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp ai, ctsi_webcamp_adhoc.firstvisit_tmp1 lu
SET ai.FirstEncounterDate=lu.FirstEncounterDate
WHERE ai.PROTOCOL=lu.PROTOCOL;

UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp ai, ctsi_webcamp_adhoc.currenrollment_tmp1 lu
SET ai.CurrentEnrollment=lu.CurrentEnrollment
WHERE ai.PROTOCOL=lu.PROTOCOL;

UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp ai, ctsi_webcamp_adhoc.pi_tmp1 lu
SET  ai.PI_LastName=lu.PI_LastName,
     ai. PI_FirstName=lu.PI_FirstName
WHERE ai.PROTOCOL=lu.PROTOCOL;


UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp
SET ElapsedMonths=(DATEDIFF(Now(),FirstEncounterDate))/30 ,
	TotalMonths=PROJDUR*12 ,
	AccuralProgress=(CurrentEnrollment/EXPNUMPATS) ,
	AccuralElapsed=((DATEDIFF(Now(),FirstEncounterDate))/30)/(PROJDUR*12) 
;

UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp
SET OpenToAccural="OPEN";

UPDATE ctsi_webcamp_adhoc.AccuralIndexTmp
SET OpenToAccural="CLOSED"
WHERE DATECLOSEDTOACCRUAL<CURDATE()
AND DATECLOSEDTOACCRUAL IS NOT NULL;


select distinct DATECLOSEDTOACCRUAL from ctsi_webcamp_adhoc.AccuralIndexTmp;
#############################################################
####  CREATE FINAL VERSION OF TABLE
############################################################

drop table if exists ctsi_webcamp_adhoc.AccuralIndex;
CREATE TABLE ctsi_webcamp_adhoc.AccuralIndex AS   
SELECT 	PROTOCOL,
        CRC_PROTOCOL, 
        IRBNUMBER,
		PI_FIrstName,
        PI_LastName,
        TITLE,
		PROJDUR,
		DATECLOSEDTOACCRUAL,
        EXPNUMPATS,
		CurrentEnrollment,
		FirstEncounterDate,
        ElapsedMonths,
        TotalMonths,
        AccuralProgress,
        AccuralElapsed,
        AccuralProgress/AccuralElapsed AS AccuralIndex,
        1 AS IdealAccural
from ctsi_webcamp_adhoc.AccuralIndexTmp
WHERE OpenToAccural="OPEN" 
ORDER BY AccuralProgress/AccuralElapsed DESC;

########### AUDIT






ALTER TABLE ctsi_webcamp_adhoc.AccuralIndex
ADD MissList varchar(255);

UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList="";
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=concat(MissList," FirstEncounterDate") WHERE FirstEncounterDate IS NULL;
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=concat(MissList," PROJDUR") WHERE PROJDUR IS NULL;
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=concat(MissList," CurrentEnrollment") WHERE CurrentEnrollment IS NULL;
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=concat(MissList," EXPNUMPATS") WHERE EXPNUMPATS IS NULL;
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=TRIM(MissList);
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList=Replace(MissList," ",", ");
UPDATE ctsi_webcamp_adhoc.AccuralIndex SET MissList="OK" WHERE MissList="";

select MissList,count(*) from ctsi_webcamp_adhoc.AccuralIndex group by MissList;






select * from ctsi_webcamp_adhoc.AccuralIndex Order BY AccuralIndex DESC ;
select MissList,count(*) from ctsi_webcamp_adhoc.accuralindex group by MissList;
############################################################
###  CLEAN UP TEMPORARY TABLES
############################################################

 drop table if exists ctsi_webcamp_adhoc.pi_tmp1;
 drop table if exists ctsi_webcamp_adhoc.visitdates_tmp1;
 drop table if exists ctsi_webcamp_adhoc.firstvisit_tmp1;
 drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
 drop table if exists ctsi_webcamp_adhoc.currenrollment_tmp1;
 drop table if exists ctsi_webcamp_adhoc.AccuralIndexTmp; 

################################################################
########       FIN
################################################################


################################################################



select * from ctsi_webcamp.protocol where longtitle like "%Haitians%";







