#### ACTIVE PROTOCOLS

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

SELECT YEAR(EncounterDate),
       COUNT(DISTINCT PROTOCOL) AS NumProtocol
FROM ctsi_webcamp_adhoc.Encounters
GROUP BY YEAR(EncounterDate);



########### OPVISITS AND HOURS

drop table if exists ctsi_webcamp_adhoc.OPTIME1;
CREATE TABLE ctsi_webcamp_adhoc.OPTIME1 AS
    SELECT YEAR(VISITDATE) AS OpYear,
           COUNT(*) AS NumVisits,
           SUM(VISITLEN) AS TotalVisitMinutes,
           (SUM(VISITLEN))/60 AS TotalVisitHours
      FROM ctsi_webcamp.OPVISIT
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
GROUP BY YEAR(VISITDATE)
;




########### INPATIENT DAYS 

drop table if exists ctsi_webcamp_adhoc.IPDAY;
CREATE TABLE ctsi_webcamp_adhoc.IPDAY AS
SELECT
    	YEAR(ADMITDATE) AS IPYear,
		DISCHDATE,
        ADMITDATE,
        #(DISCHDATE-ADMITDATE)/1000000 AS LOS
        datediff(DISCHDATE,ADMITDATE) AS LOS
      FROM ctsi_webcamp.admissio
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
;





SELECT IPYear,
       SUM(LOS) AS IPDAYS
FROM ctsi_webcamp_adhoc.IPDAY
GROUP BY IPYear;

#######################################################
#######################################################


