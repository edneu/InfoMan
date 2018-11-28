
## ALL CRC PATIENTS SEEN

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
     UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "IPVisit" AS VisitType
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
    UNION ALL
    SELECT ADMITDATE AS EncounterDate,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "SBVisit" AS VisitType
      FROM ctsi_webcamp.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
;


######################


drop table if exists ctsi_webcamp_adhoc.EncDemo;
CREATE TABLE ctsi_webcamp_adhoc.EncDemo AS 
SELECT en.PATIENT,
       YEAR(en.EncounterDate) AS EncYear,
       pt.DOB,
       pt.ETHNICIT,
	   pt.SEX,
       pt.MODIFIED AS ModDate	
FROM ctsi_webcamp_adhoc.Encounters en 
     LEFT JOIN ctsi_webcamp.patient pt
     ON en.PATIENT=pt.UNIQUEFIELD;

drop table if exists ctsi_webcamp_adhoc.EncDemo;
CREATE TABLE ctsi_webcamp_adhoc.EncDemo AS 
SELECT en.PATIENT,
       concat(YEAR(en.EncounterDate),"-",lpad(month(en.EncounterDate),2,"0")) AS EncMon,
       pt.DOB,
       pt.ETHNICIT,
	   pt.SEX,
       concat(YEAR(pt.MODIFIED),"-",lpad(month(pt.MODIFIED),2,"0")) AS ModMonth
FROM ctsi_webcamp_adhoc.Encounters en 
     LEFT JOIN ctsi_webcamp.patient pt
     ON en.PATIENT=pt.UNIQUEFIELD;

desc ctsi_webcamp.patient;

select "Missing DOB" AS Demo, EncYear,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE DOB IS NULL group by "Missing DOB", EncYear
UNION ALL
select "Missing ETH" AS Demo, EncYear,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NULL group by "Missing ETH", EncYear 
UNION ALL
select "Missing Sex" AS Demo, EncYear, count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE SEX IS NULL GROUP BY "Missing Sex", EncYear ;


select "Has DOB" AS Demo, EncYear,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE DOB IS NOT NULL group by "Missing DOB", EncYear
UNION ALL
select "Has ETH" AS Demo, EncYear,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NOT NULL group by "Missing ETH", EncYear 
UNION ALL
select "Has Sex" AS Demo, EncYear, count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE SEX IS NOT NULL GROUP BY "Missing Sex", EncYear ;

select distinct ETHNICIT from ctsi_webcamp.patient;



##################################################################################################
############  ENCOUNTER MONTH
#############################################################################################
drop table if exists ctsi_webcamp_adhoc.EncDemo;
CREATE TABLE ctsi_webcamp_adhoc.EncDemo AS 
SELECT en.PATIENT,
       concat(YEAR(en.EncounterDate),"-",lpad(month(en.EncounterDate),2,"0")) AS EncMon,
       pt.DOB,
       pt.ETHNICIT AS OLDETH,
	   pt.SEX,
       concat(YEAR(pt.MODIFIED),"-",lpad(month(pt.MODIFIED),2,"0")) AS ModMonth	
FROM ctsi_webcamp_adhoc.Encounters en 
     LEFT JOIN ctsi_webcamp.patient pt
     ON en.PATIENT=pt.UNIQUEFIELD;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ctsi_webcamp_adhoc.EncDemo
ADD ETHNULL INT(10),
ADD DOBNULL INT(10);

UPDATE ctsi_webcamp_adhoc.EncDemo SET ETHNULL=1;
UPDATE ctsi_webcamp_adhoc.EncDemo SET DOBNULL=1;

UPDATE ctsi_webcamp_adhoc.EncDemo SET ETHNULL=0 WHERE ETHNICIT IS NOT NULL;
UPDATE ctsi_webcamp_adhoc.EncDemo SET DOBNULL=0 WHERE DOB IS NOT NULL;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.EncMonDemoNull;
create table ctsi_webcamp_adhoc.EncMonDemoNull AS
SELECT EncMon, 
       PATIENT,
       MIN(ETHNULL) AS ETHNULL,
       MIN(DOBNULL) AS DOBNULL
FROM ctsi_webcamp_adhoc.EncDemo
GROUP BY EncMon, 
       PATIENT;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ModMonDemoNull;
create table ctsi_webcamp_adhoc.ModMonDemoNull AS
SELECT Modmonth, 
       PATIENT,
       MIN(ETHNULL) AS ETHNULL,
       MIN(DOBNULL) AS DOBNULL
FROM ctsi_webcamp_adhoc.EncDemo
GROUP BY ModMonth, 
       PATIENT;






DROP TABLE IF EXISTS ctsi_webcamp_adhoc.EncMonMissETH;
create table ctsi_webcamp_adhoc.EncMonMissETH AS
SELECT EncMon,
       COUNT(DISTINCT PATIENT) AS PATIENTS,
       SUM(ETHNULL) AS MissingEth,
       SUM(ETHNULL)/COUNT(*) AS PctMissEth,
       SUM(DOBNULL) AS MissingDOB,
       SUM(DOBNULL)/COUNT(*) AS PctMissDOB
FROM ctsi_webcamp_adhoc.EncMonDemoNull
GROUP BY EncMon;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ModMonMissETH;
create table ctsi_webcamp_adhoc.ModMonMissETH AS
SELECT ModMonth,
       COUNT(DISTINCT PATIENT) AS PATIENTS,
       SUM(ETHNULL) AS MissingEth,
       SUM(ETHNULL)/COUNT(*) AS PctMissEth,
       SUM(DOBNULL) AS MissingDOB,
       SUM(DOBNULL)/COUNT(*) AS PctMissDOB
FROM ctsi_webcamp_adhoc.ModMonDemoNull
GROUP BY ModMonth;

############ NEW ETHNICITY TEST

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ModMonMissETH;
create table ctsi_webcamp_adhoc.ModMonMissETH AS
Select concat(YEAR(pt.MODIFIED),"-",lpad(month(pt.MODIFIED),2,"0")) AS ModMonth,
       SUM(IF (NEWETH IS NULL AND ETHNICIT IS NULL, 1, 0)) AS NumMissingEth,
       COUNT(*) AS NumModRecs
FROM ctsi_webcamp.patient pt
WHERE YEAR(pt.MODIFIED)>=2012
GROUP BY concat(YEAR(pt.MODIFIED),"-",lpad(month(pt.MODIFIED),2,"0"));


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
  AND ETHNICIT IS NULL
  AND YEAR(MODIFIED)>=2012;

ALTER TABLE ctsi_webcamp_adhoc.PatNoEth
ADD PROTOCOL_NUM bigint(20),
ADD CRC_PROTOCOL char(25)
;

##########################

SELECT  pp.PROTOCOL
FROM ctsi_webcamp.PERSONPROT pp
WHERE pp.PERSON IN (SELECT DISTINCT PERSON FROM ctsi_webcamp.PERSON);
######################################################################################################
######################################################################################################
######################################################################################################
######################################################################################################


    SELECT PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF,
           "OPVisit" AS VisitType 
      FROM ctsi_webcamp.OPVISIT 



Select MODIFIER,
       SUM(IF (ETHNICIT IS NULL , 1, 0)) AS NumMissingEth,
       COUNT(*) AS NumModRecs
FROM ctsi_webcamp.patient pt
WHERE YEAR(pt.MODIFIED)>=2012
GROUP BY ;

#############################################################################################
## Identify Protocols without Ethnicity
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProtoNoEth;
CREATE TABLE ctsi_webcamp_adhoc.ProtoNoEth AS
SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.Encounters
WHERE PATIENT IN (SELECT DISTINCT PATIENT from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NULL)
;




ALTER TABLE ctsi_webcamp_adhoc.Encounters
ADD HAS_ETH integer,
ADD TOTAL_PAT integer;



















UPDATE ctsi_webcamp_adhoc.Encounters
SET HAS_ETH=0,
TOTAL_PAT=1;


SET SQL_SAFE_UPDATES = 0;

CREATE INDEX endemo ON ctsi_webcamp_adhoc.EncDemo (PATIENT);

UPDATE ctsi_webcamp_adhoc.Encounters
SET HAS_ETH=1
WHERE PATIENT IN (SELECT DISTINCT PATIENT from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NOT NULL);

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PCTETH;
CREATE TABLE ctsi_webcamp_adhoc.PCTETH AS
SELECT PROTOCOL,
       SUM(HAS_ETH) AS HAS_ETHNIC,
       SUM(TOTAL_PAT) AS TOTALPATENC,
       SUM(HAS_ETH)/SUM(TOTAL_PAT) AS PCTETH
FROM ctsi_webcamp_adhoc.Encounters
GROUP BY PROTOCOL;

drop table if exists ctsi_webcamp_adhoc.piNoEth;
CREATE TABLE ctsi_webcamp_adhoc.piNoEth AS
SELECT  PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT pp, ctsi_webcamp.PERSON per
WHERE pp.PERSON=per.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.PCTETH);


ALTER TABLE ctsi_webcamp_adhoc.piNoEth
      ADD CRCNumber varchar(25),
      ADD TITLE varchar(90),
      ADD CRCApprDATE datetime,
      ADD HAS_ETHNIC integer,
      ADD TOTALPATENC integer,
      ADD PCTETH decimal(65,12);


select * from ctsi_webcamp_adhoc.piNoEth;

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.piNoEth ne, ctsi_webcamp.protocol pr
SET ne.CRCNumber=pr.PROTOCOL,
    ne.TITLE=pr.TITLE,
    ne.CRCApprDATE=pr.CRCAPPROV
WHERE ne.PROTOCOL=pr.UNIQUEFIELD;


UPDATE ctsi_webcamp_adhoc.piNoEth ne, ctsi_webcamp_adhoc.PCTETH pe
SET ne.HAS_ETHNIC=pe.HAS_ETHNIC,
    ne.TOTALPATENC=pe.TOTALPATENC,
    ne.PCTETH=pe.PCTETH
WHERE ne.PROTOCOL=pe.PROTOCOL;





DROP TABLE ctsi_webcamp_adhoc.NoETHProtocol;
Create table ctsi_webcamp_adhoc.NoETHProtocol AS
SELECT * from ctsi_webcamp_adhoc.piNoEth WHERE PCTETH<.90
AND CRCApprDATE>str_to_date('01,01,2016','%m,%d,%Y');


##
drop table if exists ctsi_webcamp_adhoc.ActiveProtocol;
CREATE TABLE ctsi_webcamp_adhoc.ActiveProtocol AS
SELECT	PROTOCOL AS CRCNumber,
        UNIQUEFIELD AS PROTOKEY,
        Title
FROM ctsi_webcamp.protocol       
WHERE UNIQUEFIELD IN (SELECT DISTINCT PROTOCOL from ctsi_webcamp_adhoc.NumEncounters);
##





Select * from ctsi_webcamp.patient where LASTNAME="Aaron_" and FIRSTNAME="Boy";


select distinct NEWETH from ctsi_webcamp.patient;

select distinct R2 from ctsi_webcamp.patient;



################################################
select "Missing DOB" AS Demo, EncMon,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE DOB IS NULL group by "Missing DOB", EncMon
UNION ALL
select "Missing ETH" AS Demo, EncMon,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NULL group by "Missing ETH", EncMon 
UNION ALL
select "Missing Sex" AS Demo, EncMon, count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE SEX IS NULL GROUP BY "Missing Sex", EncMon ;


select "Has DOB" AS Demo, EncMon,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE DOB IS NOT NULL group by "Missing DOB", EncMon
UNION ALL
select "Has ETH" AS Demo, EncMon,count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE ETHNICIT IS NOT NULL group by "Missing ETH", EncMon 
UNION ALL
select "Has Sex" AS Demo, EncMon, count(*)  AS NumPat from ctsi_webcamp_adhoc.EncDemo WHERE SEX IS NOT NULL GROUP BY "Missing Sex", EncMon ;

select distinct ETHNICIT from ctsi_webcamp.patient;

















### UNDUPLICATED PATIENTS

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.UndupPat;
CREATE TABLE ctsi_webcamp_adhoc.UndupPat AS
SELECT PATIENT, 
max(Year(EncounterDate)) AS LastEncYear 
FROM ctsi_webcamp_adhoc.Encounters
GROUP BY PATIENT;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRCDemog;
CREATE TABLE ctsi_webcamp_adhoc.CRCDemog AS
SELECT UNIQUEFIELD as PATIENT,
       DOB,
       ETHNICIT,
	   SEX	
from ctsi_webcamp.patient
WHERE UNIQUEFIELD IN (SELECT DISTINCT PATIENT FROM ctsi_webcamp_adhoc.UndupPat);

###############






















##### MISSING SUMMARY
select "Missing DOB" AS Demo, count(*) AS NumPat from ctsi_webcamp_adhoc.CRCDemog WHERE DOB IS NULL
UNION ALL
select "Missing ETH" AS Demo, count(*) AS NumPat from ctsi_webcamp_adhoc.CRCDemog WHERE ETHNICIT IS NULL 
UNION ALL
select "Missing Sex" AS Demo, count(*) AS NumPat from ctsi_webcamp_adhoc.CRCDemog WHERE SEX IS NULL ;


## 58 Missig Sex
## 1570 Missing Ethnicity
## 58 Missing DOB

######################################################################################
#####
######################################################################################

drop table if exists ctsi_webcamp_adhoc.EncounterType;
CREATE TABLE ctsi_webcamp_adhoc.EncounterType AS
SELECT PROTOCOL,
       COUNT(*) AS OPEncounters, 
       COUNT(DISTINCT PATIENT) AS OPUndup, 
       SUM(0) AS IPEncounters,
       SUM(0) AS IPUndup, 
       SUM(0) AS SBEncounters,
       SUM(0) AS SBIPUndup 
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
       SUM(0) AS SBIPUndup 
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
       COUNT(DISTINCT PATIENT) AS SBUndup
  from ctsi_webcamp_adhoc.Encounters
  WHERE VisitType="SBVISIT"
  GROUP BY PROTOCOL;



### MOVE ALL BUT LOCANAO AND ZORI TO OP

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
       SUM(SBIPUndup) AS SBUndup        
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
      ADD SBUndup integer(20);


SET SQL_SAFE_UPDATES = 0;

## ADD NUMBER OF ENCOUNTERS (VISITS)
UPDATE ctsi_webcamp_adhoc.ActiveProtocol ap, ctsi_webcamp_adhoc.NumEncounters lu
SET ap.OPEncounters=lu.OPEncounters,
    ap.OPUndup=lu.OPUndup,
    ap.IPEncounters=lu.IPEncounters,
    ap.IPUndup=lu.IPUndup,
    ap.SBEncounters=lu.SBEncounters,
    ap.SBUndup=lu.SBUndup
WHERE ap.PROTOKEY=lu.PROTOCOL;



## PROTOCOL PI NAMES
UPDATE ctsi_webcamp_adhoc.ActiveProtocol ap, ctsi_webcamp_adhoc.ProtocolPI lu
SET ap.PI_LastName=lu.PI_LastName,
    ap.PI_FirstName=lu.PI_FirstName
WHERE ap.PROTOKEY=lu.PROTOCOL;

select * from ctsi_webcamp_adhoc.ActiveProtocol;

## FORMATTED TABLE
drop table if exists ctsi_webcamp_adhoc.ActiveProtocol2016;
CREATE TABLE ctsi_webcamp_adhoc.ActiveProtocol2016 AS
SELECT CRCNumber,
       PI_LastName,
	   PI_FirstName,
       Title,
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


select * from ctsi_webcamp_adhoc.ActiveProtocol2016;

select count(distinct CRCNumber) from ctsi_webcamp_adhoc.ActiveProtocol2016;



drop table if exists ctsi_webcamp_adhoc.Encounters;
drop table if exists ctsi_webcamp_adhoc.EncounterType;
drop table if exists ctsi_webcamp_adhoc.NumEncounters;
drop table if exists ctsi_webcamp_adhoc.ProtocolPI;

SELECT ETHNICIT,year(MODIFIED),count(*) from ctsi_oldwebcamp.patient group by ETHNICIT,year(MODIFIED);


select min(MODIFIED),max(MODIFIED) from ctsi_oldwebcamp.patient;
select min(MODIFIED),max(MODIFIED) from ctsi_webcamp.patient;
