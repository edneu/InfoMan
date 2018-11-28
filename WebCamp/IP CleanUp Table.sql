
drop table if exists ctsi_webcamp_adhoc.IPEncounters;
CREATE TABLE ctsi_webcamp_adhoc.IPEncounters AS
    SELECT ADMITDATE AS VisitDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE)=2016
;

drop table if exists ctsi_webcamp_adhoc.IP_PI;
CREATE TABLE ctsi_webcamp_adhoc.IP_PI AS
SELECT  p.UNIQUEFIELD,
        PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT PP, ctsi_webcamp.PERSON P
WHERE PP.PERSON=P.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL from ctsi_webcamp_adhoc.IPEncounters);  



drop table if exists ctsi_webcamp_adhoc.IP_PROTO;
CREATE TABLE ctsi_webcamp_adhoc.IP_PROTO AS
SELECT PROTOCOL AS CRCNumber,
       UNIQUEFIELD AS PROTOCOL_ID,
       TITLE as Title
FROM ctsi_webcamp.protocol
WHERE UNIQUEFIELD IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.IPEncounters);  
       

drop table if exists ctsi_webcamp_adhoc.IPP_2016;
CREATE TABLE ctsi_webcamp_adhoc.IPP_2016 AS
SELECT 
pr.CRCNumber,
pi.PI_LastName,
pi.PI_FirstName,
pr.Title,
pr.PROTOCOL_ID
FROM ctsi_webcamp_adhoc.IP_PROTO pr LEFT JOIN ctsi_webcamp_adhoc.IP_PI pi ON pr.PROTOCOL_ID=pi.PROTOCOL;


drop table if exists ctsi_webcamp_adhoc.IP_VISITS_2016;
CREATE TABLE ctsi_webcamp_adhoc.IP_VISITS_2016 AS
SELECT 
pr.CRCNumber,
pr.PI_LastName,
pr.PI_FirstName,
pr.Title,
dt.VisitDate,
dt.PATIENT AS PatientID,
pr.PROTOCOL_ID
from ctsi_webcamp_adhoc.IPP_2016 pr left join ctsi_webcamp_adhoc.IPEncounters dt
on dt.PROTOCOL=pr.PROTOCOL_ID;


ALTER TABLE ctsi_webcamp_adhoc.IP_VISITS_2016
ADD Patient_Last varchar(30),
ADD Patient_First varchar(30);


UPDATE ctsi_webcamp_adhoc.IP_VISITS_2016 ip, ctsi_webcamp.patient lu
SET ip.Patient_Last=lu.LASTNAME,
    ip.Patient_First=lu.FIRSTNAME
WHERE ip.PatientID=lu.UNIQUEFIELD;

select * from ctsi_webcamp_adhoc.IP_VISITS_2016;






drop table if exists ctsi_webcamp_adhoc.IPEncounters;
drop table if exists ctsi_webcamp_adhoc.IP_PI;
drop table if exists ctsi_webcamp_adhoc.IP_PROTO;
drop table if exists ctsi_webcamp_adhoc.IPP_2016;