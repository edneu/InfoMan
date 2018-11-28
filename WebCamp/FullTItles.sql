drop table if exists ctsi_webcamp_adhoc.Encounters;
CREATE TABLE ctsi_webcamp_adhoc.Encounters AS
    SELECT VISITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "OPVisit" AS VisitType 
      FROM ctsi_webcamp.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
       AND Year(VISITDATE) IN (2014,2015,2016,2017)
     UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE) IN (2014,2015,2016,2017)
    UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "SBVisit" AS VisitType 
      FROM ctsi_webcamp.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE) IN (2014,2015,2016,2017)
;

drop table if exists ctsi_webcamp_adhoc.Proto;
CREATE TABLE ctsi_webcamp_adhoc.Proto AS
SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.Encounters;


drop table if exists ctsi_webcamp_adhoc.LongTitles;
CREATE TABLE ctsi_webcamp_adhoc.LongTitles AS
SELECT 	pr.UNIQUEFIELD AS WC_PROTOCOL,
		pr.PROTOCOL AS CRC_ID,
		pr.TITLE AS TITLE,
		pr.LONGTITLE,
		pr.IRBNUMBER AS IRB,
		pr.IRBSTATUS,
        pr.PERSON,
        ps.LASTNAME,
        ps.FIRSTNAME
from ctsi_webcamp.protocol pr, ctsi_webcamp.person ps
WHERE pr.PERSON=ps.UNIQUEFIELD
AND pr.UNIQUEFIELD IN (SELECT PROTOCOL FROM ctsi_webcamp_adhoc.Proto);
;


drop table if exists ctsi_webcamp_adhoc.LongTitles;
CREATE TABLE ctsi_webcamp_adhoc.LongTitles AS
SELECT 	pr.UNIQUEFIELD AS WC_PROTOCOL,
		pr.PROTOCOL AS CRC_ID,
		pr.TITLE AS TITLE,
		pr.LONGTITLE,
		pr.IRBNUMBER AS IRB,
        pr.PERSON
from ctsi_webcamp.protocol pr
WHERE pr.UNIQUEFIELD IN (SELECT PROTOCOL FROM ctsi_webcamp_adhoc.Proto);
;

## ADD PI
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ctsi_webcamp_adhoc.LongTitles
ADD PI_LAST varchar(45),
ADD PI_FIRST varchar(45);


drop table if EXISTS ctsi_webcamp_adhoc.pi_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.pi_tmp1 AS
SELECT  PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT pp, ctsi_webcamp.PERSON per
WHERE pp.PERSON=per.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT PROTOCOL FROM ctsi_webcamp_adhoc.Proto);



UPDATE ctsi_webcamp_adhoc.LongTitles lt, ctsi_webcamp_adhoc.pi_tmp1 ps
SET lt.PI_LAST=ps.PI_LastName,
    lt.PI_FIRST=ps.PI_FirstName
WHERE lt.WC_PROTOCOL=ps.PROTOCOL;


select * from ctsi_webcamp_adhoc.LongTitles;




##########################

U