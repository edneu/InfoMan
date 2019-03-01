
SELECT COUNT(*) 
FROM ctsi_webcamp_pr.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")
AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp_pr.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
AND YEAR(VISITDATE)=2018;

SELECT COUNT(*) 
FROM ctsi_webcamp_pr.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")
AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp_pr.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
AND YEAR(VISITDATE)=2017;



## PArticpant 2018

drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(VISITDATE)=2018
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  AND YEAR(ADMITDATE)=2018
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(ADMITDATE)=2018
 ;
select count(distinct PATIENT) from ctsi_webcamp_adhoc.enrollment_tmp1;

## Particpants 2017
drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(VISITDATE)=2017
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  AND YEAR(ADMITDATE)=2017
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp_pr.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(ADMITDATE)=2017
 ;



select count(distinct PATIENT) from ctsi_webcamp_adhoc.enrollment_tmp1;
select count(*) from ctsi_webcamp_adhoc.enrollment_tmp1;

### PROTOCOLS

drop table if exists ctsi_webcamp_adhoc.protocolTMP;
CREATE TABLE ctsi_webcamp_adhoc.protocolTMP AS
    SELECT Year(VISITDATE) AS ActYear,
           PROTOCOL,
            "OPVisit" AS VisitType 
      FROM ctsi_webcamp_pr.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
     UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp_pr.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
    UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
          "SBVisit" AS VisitType 
      FROM ctsi_webcamp_pr.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
;
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
