drop table if exists ctsi_webcamp_adhoc.Encounters;
CREATE TABLE ctsi_webcamp_adhoc.Encounters AS
    SELECT DISTINCT PROTOCOL
       FROM ctsi_webcamp.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
       AND Year(VISITDATE)=2016 
     UNION ALL
    SELECT PROTOCOL
      FROM ctsi_webcamp.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
       AND Year(ADMITDATE)=2016;






drop table if exists ctsi_webcamp_adhoc.pi_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.pi_tmp1 AS
SELECT  PROTOCOL,
        LASTNAME AS PI_LastName,
        FIRSTNAME AS PI_FirstName
FROM ctsi_webcamp.PERSONPROT pp, ctsi_webcamp.PERSON per
WHERE pp.PERSON=per.UNIQUEFIELD AND INVTYPE='P'
  AND PROTOCOL IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.Encounters);



drop table if exists ctsi_webcamp_adhoc.pi_2016;
CREATE TABLE ctsi_webcamp_adhoc.pi_2016 AS
SELECT 
        PI_LastName,
        PI_FirstName
from ctsi_webcamp_adhoc.pi_tmp1
GROUP BY PI_LastName, PI_FirstName
ORDER BY PI_LastName, PI_FirstName;


drop table if exists ctsi_webcamp_adhoc.Encounters;

