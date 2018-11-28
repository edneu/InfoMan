

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
       AND Year(VISITDATE) >=2012
     UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE) >=2012
    UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "SBVisit" AS VisitType 
      FROM ctsi_webcamp.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE) >=2012
;





drop table if exists ctsi_webcamp_adhoc.EncounterType;
CREATE TABLE ctsi_webcamp_adhoc.EncounterType AS
SELECT PROTOCOL,
       COUNT(*) AS OPEncounters, 
       COUNT(DISTINCT PATIENT) AS OPUndup, 
       SUM(0) AS IPEncounters,
       SUM(0) AS IPUndup, 
       SUM(0) AS SBEncounters,
       SUM(0) AS SBIPUndup,
       MIN(EncounterDate) AS EarliestVisit,
       MAX(EncounterDate) AS LatestVisit 
   from ctsi_webcamp_adhoc.Encounters
   WHERE VisitType="OPVISIT"
   GROUP BY PROTOCOL
UNION ALL
SELECT PROTOCOL,
       SUM(0) AS OPEncounters,
       SUM(0) AS OPUndup, 
       COUNT(*) AS IPEncounters,
       COUNT(DISTINCT PATIENT) AS IPUndup,
       SUM(0) AS SBEncounters,
       SUM(0) AS SBIPUndup,
       MIN(EncounterDate) AS EarliestVisit,
       MAX(EncounterDate) AS LatestVisit  
  from ctsi_webcamp_adhoc.Encounters 
  WHERE VisitType="IPVISIT"
  GROUP BY PROTOCOL
UNION ALL
SELECT PROTOCOL,
       SUM(0) AS OPEncounters,
       SUM(0) AS OPUndup, 
       SUM(0) AS IPEncounters,
       SUM(0) AS IPUndup, 
       COUNT(*) AS SBEncounters,
       COUNT(DISTINCT PATIENT) AS SBUndup,
       MIN(EncounterDate) AS EarliestVisit,
       MAX(EncounterDate) AS LatestVisit 
  from ctsi_webcamp_adhoc.Encounters
  WHERE VisitType="SBVISIT"
  GROUP BY PROTOCOL;



### MOVE ALL BUT LOCANAO AND ZORI TO OP
SET SQL_SAFE_UPDATES = 0;
UPDATE ctsi_webcamp_adhoc.EncounterType 
SET OPEncounters=OPEncounters+IPEncounters,
    OPUndup=OPUndup+IPUndup
WHERE PROTOCOL NOT IN (553,494);

UPDATE ctsi_webcamp_adhoc.EncounterType 
SET IPEncounters=0,
    IPUndup=0
WHERE PROTOCOL NOT IN (553,494);


drop table if exists ctsi_webcamp_adhoc.NumEncounters;
CREATE TABLE ctsi_webcamp_adhoc.NumEncounters AS
SELECT PROTOCOL,
       SUM(OPEncounters) AS OPEncounters,
       SUM(OPUndup) AS OPUndup, 
       SUM(IPEncounters) AS IPEncounters,
       SUM(IPUndup) AS IPUndup, 
       SUM(SBEncounters) AS SBEncounters,
       SUM(SBIPUndup) AS SBUndup, 
       MIN(EarliestVisit) AS EarliestVisit,
       MAX(LatestVisit) AS LatestVisit 
from ctsi_webcamp_adhoc.EncounterType
GROUP BY PROTOCOL;


drop table if exists ctsi_webcamp_adhoc.ProtocolPI;
CREATE TABLE ctsi_webcamp_adhoc.ProtocolPI AS
SELECT  p.UNIQUEFIELD,
        PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT PP, ctsi_webcamp.PERSON P
WHERE PP.PERSON=P.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL from ctsi_webcamp_adhoc.NumEncounters);  




drop table if exists ctsi_webcamp_adhoc.ActiveProtocol;
CREATE TABLE ctsi_webcamp_adhoc.ActiveProtocol AS
SELECT	PROTOCOL AS CRCNumber,
        UNIQUEFIELD AS PROTOKEY,
        Title
FROM ctsi_webcamp.protocol       
WHERE UNIQUEFIELD IN (SELECT DISTINCT PROTOCOL from ctsi_webcamp_adhoc.NumEncounters);





ALTER TABLE ctsi_webcamp_adhoc.ActiveProtocol
      ADD PI_LastName varchar(45),
      ADD PI_FirstName varchar(45),
      ADD OPEncounters integer(20),
      ADD IPEncounters integer(20),
      ADD SBEncounters integer(20),
      ADD OPUndup integer(20),
      ADD IPUndup integer(20),
      ADD SBUndup integer(20),
      ADD EarliestVisit datetime,
      ADD LatestVisit datetime;


SET SQL_SAFE_UPDATES = 0;

## ADD NUMBER OF ENCOUNTERS (VISITS)
UPDATE ctsi_webcamp_adhoc.ActiveProtocol ap, ctsi_webcamp_adhoc.NumEncounters lu
SET ap.OPEncounters=lu.OPEncounters,
    ap.OPUndup=lu.OPUndup,
    ap.IPEncounters=lu.IPEncounters,
    ap.IPUndup=lu.IPUndup,
    ap.SBEncounters=lu.SBEncounters,
    ap.SBUndup=lu.SBUndup,
    ap.EarliestVisit=lu.EarliestVisit,
    ap.LatestVisit=lu.LatestVisit
WHERE ap.PROTOKEY=lu.PROTOCOL;



## PROTOCOL PI NAMES
UPDATE ctsi_webcamp_adhoc.ActiveProtocol ap, ctsi_webcamp_adhoc.ProtocolPI lu
SET ap.PI_LastName=lu.PI_LastName,
    ap.PI_FirstName=lu.PI_FirstName
WHERE ap.PROTOKEY=lu.PROTOCOL;

select * from ctsi_webcamp_adhoc.ActiveProtocol;

## FORMATTED TABLE
drop table if exists ctsi_webcamp_adhoc.ActiveProtocol20122017;
CREATE TABLE ctsi_webcamp_adhoc.ActiveProtocol20122017 AS
SELECT CRCNumber,
       PI_LastName,
	   PI_FirstName,
       Title,
       EarliestVisit,
       LatestVisit,
       OPEncounters,
       OPUndup,
       IPEncounters,
       IPUndup,
       SBEncounters,
       SBUndup,
       PROTOKEY
FROM ctsi_webcamp_adhoc.ActiveProtocol
WHERE CRCNumber<>"0000"
ORDER BY PI_LastName, PI_FirstName, CRCNumber;


select * from ctsi_webcamp_adhoc.ActiveProtocol20122017;

select count(distinct CRCNumber) from ctsi_webcamp_adhoc.ActiveProtocol20152017;



drop table if exists ctsi_webcamp_adhoc.Encounters;
drop table if exists ctsi_webcamp_adhoc.EncounterType;
drop table if exists ctsi_webcamp_adhoc.NumEncounters;
drop table if exists ctsi_webcamp_adhoc.ProtocolPI;


