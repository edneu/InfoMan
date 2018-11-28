## OUTPATIENT VISITS by YEAR


SELECT YEAR(VISITDATE),COUNT(*) AS N_OP_VISITS
FROM ctsi_webcamp.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")
AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
GROUP BY YEAR(VISITDATE);


##########  PROTCOLS BY YEAR

drop table if exists ctsi_webcamp_adhoc.protocolTMP;
CREATE TABLE ctsi_webcamp_adhoc.protocolTMP AS
    SELECT Year(VISITDATE) AS ActYear,
           PROTOCOL,
            "OPVisit" AS VisitType 
      FROM ctsi_webcamp.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
     UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
    UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
          "SBVisit" AS VisitType 
      FROM ctsi_webcamp.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
;


## UNIQUE PROTOCOL LIST
drop table if exists ctsi_webcamp_adhoc.UprotoTMP;
CREATE TABLE ctsi_webcamp_adhoc.UprotoTMP AS
    SELECT ActYear,
           PROTOCOL
FROM ctsi_webcamp_adhoc.protocolTMP
GROUP BY ActYear,
         PROTOCOL
;


select ActYear,
       COUNT(DISTINCT PROTOCOL) AS NumProtocol
FROM ctsi_webcamp_adhoc.protocolTMP
group by ActYear;


###########################################################################################
########## NUMBER OF PIs
###########################################################################################

## ADD PI TO UNIQUE PROTOCOL LIST




drop table if exists ctsi_webcamp_adhoc.pi_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.pi_tmp1 AS
SELECT  PROTOCOL,
        pp.PERSON,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT pp, ctsi_webcamp.PERSON per
WHERE pp.PERSON=per.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.UprotoTMP);


ALTER TABLE ctsi_webcamp_adhoc.UprotoTMP
ADD PI_PERSON int(20),
ADD PI_LastName varchar(30),
ADD PI_FirstName varchar(30);


SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.UprotoTMP pc,  ctsi_webcamp_adhoc.pi_tmp1 lu
SET pc.PI_PERSON=lu.PERSON,
	pc.PI_LastName=lu.PI_LastName,
	pc.PI_FirstName=lu.PI_FirstName
WHERE pc.PROTOCOL=lu.PROTOCOL;

ALTER TABLE ctsi_webcamp_adhoc.UprotoTMP
ADD CRC_Number varchar(25);

UPDATE ctsi_webcamp_adhoc.UprotoTMP pc, ctsi_webcamp.protocol lu
SET pc.CRC_Number=lu.PROTOCOL
WHERE pc.PROTOCOL=lu.UNIQUEFIELD;



select ActYear,
       COUNT(DISTINCT PI_PERSON) AS NumProtocol
FROM ctsi_webcamp_adhoc.UprotoTMP
group by ActYear;

DROP TABLE if exists tsi_webcamp_adhoc.Active2017;
CREATE TABLE ctsi_webcamp_adhoc.Active2017 AS
SELECT ActYear,
       CRC_Number,
       PI_LastName,
       PI_FirstName,
       PROTOCOL
from ctsi_webcamp_adhoc.UprotoTMP
WHERE ActYear=2017
order by CRC_Number;




SELECT * from ctsi_webcamp_adhoc.UprotoTMP;
select * from ctsi_webcamp_adhoc.pi_tmp1;


####################### TOTAL PATIENTS

drop table if exists ctsi_webcamp_adhoc.ptcount1;
CREATE TABLE ctsi_webcamp_adhoc.ptcount1 AS
     SELECT Year(VISITDATE) AS ActYear,
            PATIENT,
            PROTOCOL
     FROM ctsi_webcamp.OPVISIT
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT Year(ADMITDATE) as ActYear,
            PATIENT,
            PROTOCOL
     FROM ctsi_webcamp.ADMISSIO
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT Year(ADMITDATE) as ActYear,
            PATIENT,
            PROTOCOL
     FROM ctsi_webcamp.SBADMISSIO
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
;


select ActYear,
       COUNT(DISTINCT PATIENT) AS NumPatients
FROM ctsi_webcamp_adhoc.ptcount1
group by ActYear;


/* 
######################Cleanuo
drop table if exists ctsi_webcamp_adhoc.protocolTMP;

drop table if exists ctsi_webcamp_adhoc.pi_tmp1;
drop table if exists ctsi_webcamp_adhoc.ptcount1