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


drop table if exists ctsi_webcamp_adhoc.AgeAtEncounter;
CREATE TABLE ctsi_webcamp_adhoc.AgeAtEncounter AS
SELECT en.PATIENT,
       YEAR(en.EncounterDate) AS EncYear,
       pt.DOB,
       truncate((datediff(en.EncounterDate,pt.DOB)/365.25)  ,0) as AgeAtEncounter
FROM ctsi_webcamp_adhoc.Encounters en 
     LEFT JOIN ctsi_webcamp.patient pt
     ON en.PATIENT=pt.UNIQUEFIELD;



select "<18 at Encounter" as Measure,
		COUNT(DISTINCT PATIENT) as MeasureValue
from ctsi_webcamp_adhoc.AgeAtEncounter
WHERE AgeAtEncounter<18
AND EncYear>=2009
UNION ALL

select ">64 at Encounter" as Measure,
		COUNT(DISTINCT PATIENT) as MeasureValue
from ctsi_webcamp_adhoc.AgeAtEncounter
WHERE AgeAtEncounter>64
AND EncYear>=2009
UNION ALL
select "18-64 at Encounter" as Measure,
		COUNT(DISTINCT PATIENT) as MeasureValue
from ctsi_webcamp_adhoc.AgeAtEncounter
WHERE AgeAtEncounter<64 AND AgeatEncounter>18
AND EncYear>=2009

UNION ALL
select "Total Patients" as Measure,
		COUNT(DISTINCT PATIENT) as MeasureValue
from ctsi_webcamp_adhoc.AgeAtEncounter
WHERE EncYear>=2009;

