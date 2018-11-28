

drop table if exists ctsi_webcamp_adhoc.SBIP;
CREATE TABLE ctsi_webcamp_adhoc.SBIP AS
     SELECT Year(ADMITDATE),
            PATIENT,
            DISCHDATE,
            ADMITDATE ,
            DATEDIFF( DISCHDATE,ADMITDATE) AS DAYS,
            PROTOCOL FROM ctsi_webcamp_pr.SBADMISSIO 
WHERE PROTOCOL IS NOT NULL
AND STATUS IN (2,3)
AND VISITTYPE <> 1
UNION ALL
     SELECT Year(ADMITDATE),
            PATIENT,
            DISCHDATE,
            ADMITDATE ,
            DATEDIFF( DISCHDATE,ADMITDATE) AS DAYS,
            PROTOCOL FROM ctsi_webcamp_PR.ADMISSIO
WHERE PROTOCOL IS NOT NULL
AND STATUS IN (2,3)
AND VISITTYPE <> 1
;

     SELECT Year(ADMITDATE),
            PATIENT,
            DISCHDATE,
            ADMITDATE ,
            DATEDIFF( DISCHDATE,ADMITDATE) AS DAYS,
            PROTOCOL FROM ctsi_webcamp_PR.ADMISSIO
WHERE PROTOCOL IS NOT NULL
AND STATUS IN (2,3)
AND VISITTYPE <> 1
;

select distinct CATEGORY from ctsi_webcamp_PR.ADMISSIO;



SELECT YEAR(ADMITDATE) AS CalYear,
	Count(*) As Admissions,
	COUNT(DISTINCT PATIENT) AS Patients,
	SUM(DAYS) AS PatientDays
from ctsi_webcamp_adhoc.SBIP
GROUP BY YEAR(ADMITDATE)
ORDER BY YEAR(ADMITDATE);

####################################### CRC OVERNIGHT
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND VISITTYPE <> 1
         UNION ALL

      SELECT Year(ADMITDATE),
            PATIENT,
            DISCHDATE,
            ADMITDATE ,
            DATEDIFF( DISCHDATE,ADMITDATE) AS DAYS,
            PROTOCOL FROM ctsi_webcamp_pr.OPVISIT      