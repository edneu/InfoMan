
##################################################################################
##################################################################################
### ID PROTOCOL AND PATIENTS WITH NO ETHNICITY ####################################
##################################################################################
DROP TABLE ctsi_webcamp_adhoc.PatNoEth;
create table ctsi_webcamp_adhoc.PatNoEth AS
select UNIQUEFIELD AS Patient,
       LASTNAME,
       FIRSTNAME,
       DOB,
       PATIENT AS PATIENT_ID
  from ctsi_webcamp.patient
WHERE NEWETH IS NULL
  AND ETHNICIT IS NULL;
 ## AND YEAR(MODIFIED)>=2012;





#########################################################################################
#### ID RELATED PROTOCOLS
########################################################################################
drop table if exists ctsi_webcamp_adhoc.Encounters;
CREATE TABLE ctsi_webcamp_adhoc.Encounters AS
    SELECT PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "OPVisit" AS VisitType 
      FROM ctsi_webcamp.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
       AND PATIENT IN (SELECT DISTINCT Patient FROM ctsi_webcamp_adhoc.PatNoEth)
    GROUP BY  PROTOCOL, PATIENT, UNIQUEFIELD, "OPVisit"  
     UNION ALL
    SELECT PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "IPVisit" AS VisitType
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND PATIENT IN (SELECT DISTINCT Patient FROM ctsi_webcamp_adhoc.PatNoEth)
    GROUP BY  PROTOCOL, PATIENT, UNIQUEFIELD, "IPVisit"  
    UNION ALL
    SELECT PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "SBVisit" AS VisitType
      FROM ctsi_webcamp.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND PATIENT IN (SELECT DISTINCT Patient FROM ctsi_webcamp_adhoc.PatNoEth)
       AND STATUS IN (2,3)
    GROUP BY  PROTOCOL, PATIENT, UNIQUEFIELD, "SBVisit"  
;




###############################
drop table if exists ctsi_webcamp_adhoc.piNoEth;
CREATE TABLE ctsi_webcamp_adhoc.piNoEth AS
SELECT  PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT pp, ctsi_webcamp.PERSON per
WHERE pp.PERSON=per.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.Encounters);



ALTER TABLE ctsi_webcamp_adhoc.piNoEth
ADD PROTOCOL_TITLE varchar(90),
ADD CRC_PROTOCOL varchar(25);

UPDATE ctsi_webcamp_adhoc.piNoEth ne, ctsi_webcamp.protocol lu
SET ne.PROTOCOL_TITLE=lu.TITLE,
    ne.CRC_PROTOCOL=lu.PROTOCOL 
WHERE ne.PROTOCOL=lu.UNIQUEFIELD;




ALTER TABLE ctsi_webcamp_adhoc.PatNoEth
ADD PROTOCOL_KEY bigint(20),
ADD PI_LastName varchar(30),
ADD PI_FirstName varchar(30),
ADD PROTOCOL_TITLE varchar(90),
ADD CRC_PROTOCOL varchar(25);

desc ctsi_webcamp_adhoc.PatNoEth;

UPDATE ctsi_webcamp_adhoc.PatNoEth pe, ctsi_webcamp_adhoc.Encounters lu
SET pe.PROTOCOL_KEY=lu.PROTOCOL
WHERE pe.PATIENT=lu.PATIENT;



UPDATE ctsi_webcamp_adhoc.PatNoEth pt, ctsi_webcamp_adhoc.piNoEth lu
SET pt.PI_LastName=lu.PI_LastName,
    pt.PI_FirstName=lu.PI_FirstName,
    pt.PROTOCOL_TITLE=lu.PROTOCOL_TITLE,
    pt.CRC_PROTOCOL=lu.CRC_PROTOCOL
WHERE pt.PROTOCOL_KEY=lu.PROTOCOL;



### OUTPUT TABLE

drop table if exists ctsi_webcamp_adhoc.detail;
create table ctsi_webcamp_adhoc.detail AS
SELECT CRC_PROTOCOL,
       PI_LastName,
       PI_FirstName,
       PROTOCOL_TITLE,
       PATIENT_ID,
       LASTNAME AS PT_LAST,
       FIRSTNAME AS PT_FIRST,
       DOB as PT_DOB
FROM ctsi_webcamp_adhoc.PatNoEth
WHERE CRC_PROTOCOL IS NOT NULL
ORDER BY CRC_PROTOCOL,PI_LastName;


create table ctsi_webcamp_adhoc.summarynoeth AS
SELECT CRC_PROTOCOL,
       PI_LastName,
       PI_FirstName,
       PROTOCOL_TITLE,
       COUNT(*) AS NumMissEth
FROM ctsi_webcamp_adhoc.PatNoEth
WHERE CRC_PROTOCOL IS NOT NULL
GROUP BY CRC_PROTOCOL,
       PI_LastName,
       PI_FirstName,
       PROTOCOL_TITLE
;




