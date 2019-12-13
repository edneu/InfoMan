

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


