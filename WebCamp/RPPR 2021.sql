### CRC PERFOMRANCE MEASURES TABLE

#### ACTIVE PROTOCOLS BY YEAR
drop table if exists ctsi_webcamp_adhoc.protocolTMP;
CREATE TABLE ctsi_webcamp_adhoc.protocolTMP AS
    SELECT  PROTOCOL,
            "OPVisit" AS VisitType ,
            Count(DISTINCT VISITID) as nVISITS
      FROM ctsi_webcamp_pr.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
            AND VISITDATE >= str_to_date('03,1,2020','%m,%d,%Y')
            AND VISITDATE <= str_to_date ('02,28,2021','%m,%d,%Y')
            AND STATUS IN (2,3)
       GROUP BY Protocol, VisitType
     UNION ALL
    SELECT  PROTOCOL,
           "IPVisit" AS VisitType,
           Count(DISTINCT VISITID) as nVISITS
      FROM ctsi_webcamp_pr.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
      AND ADMITDATE >= str_to_date('03,1,2020','%m,%d,%Y')
      AND ADMITDATE <= str_to_date ('02,28,2021','%m,%d,%Y')
       AND STATUS IN (2,3) 
          GROUP BY "IPVisit", VisitType 
    UNION ALL
    SELECT PROTOCOL,
           "SBVisit" AS VisitType ,
            Count(DISTINCT VISITID) as nVISITS
      FROM ctsi_webcamp_pr.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
      AND ADMITDATE >= str_to_date('03,1,2020','%m,%d,%Y')
      AND ADMITDATE <= str_to_date ('02,28,2021','%m,%d,%Y')
       AND STATUS IN (2,3)
        GROUP BY "SBVisit", VisitType
;

select ActYear,
       COUNT(DISTINCT PROTOCOL) AS NumProtocol
FROM ctsi_webcamp_adhoc.protocolTMP
WHERE ActYear>=2012
group by ActYear;



#### PArticpants Enrolled
drop table if exists ctsi_webcamp_adhoc.ptcount1;
CREATE TABLE ctsi_webcamp_adhoc.ptcount1 AS
     SELECT Year(VISITDATE) AS ActYear,
            PATIENT
            FROM ctsi_webcamp_pr.OPVISIT
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT Year(ADMITDATE) as ActYear,
            PATIENT
            FROM ctsi_webcamp_pr.ADMISSIO
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL
     SELECT Year(ADMITDATE) as ActYear,
            PATIENT
            FROM ctsi_webcamp_pr.SBADMISSIO
     WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
;
select ActYear,
       COUNT(DISTINCT PATIENT) AS NumPatients
FROM ctsi_webcamp_adhoc.ptcount1
WHERE ActYear>=2012
group by ActYear;


########## OUTPATIENT VISITS

SELECT YEAR(VISITDATE) AS ActDate,COUNT(*) AS N_OP_VISITS
FROM ctsi_webcamp_pr.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")
AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
AND YEAR(VISITDATE)>=2012
GROUP BY YEAR(VISITDATE);


########## IP SCATTERBED VISITS

drop table if exists ctsi_webcamp_adhoc.inp;
CREATE TABLE ctsi_webcamp_adhoc.inp AS
    SELECT Year(ADMITDATE) as AdmYear,
		   1 as Admit,
		   datediff(DISCHDATE,ADMITDATE) as days
      FROM ctsi_webcamp_pr.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
    UNION ALL
    SELECT Year(ADMITDATE) as AdmYear,
           1 as Admit, 
           datediff(DISCHDATE,ADMITDATE) as days
     FROM ctsi_webcamp_pr.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
;





;


SELECT AdmYear,Sum(Admit) as IPSBAdmit,sum(days) as IPSBdays
FROM  ctsi_webcamp_adhoc.inp
WHERE AdmYear>=2012
GROUP BY AdmYear;



select ADMITDATE,DISCHDATE from ctsi_webcamp_pr.ADMISSIO ;


select ADMITDATE,DISCHDATE, datediff(ADMITDATE,DISCHDATE) AS Days from ctsi_webcamp_pr.ADMISSIO 
WHERE datediff(ADMITDATE,DISCHDATE)>0;