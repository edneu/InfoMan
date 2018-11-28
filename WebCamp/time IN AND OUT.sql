## OF VISITS BY TIM EOF DAY

drop table if exists ctsi_webcamp_adhoc.OPVISITS;
CREATE TABLE ctsi_webcamp_adhoc.OPVISITS AS
    SELECT VISITDATE AS EncounterDate,
           TIMEIN AS TIMEIN,
           TIMEOUT AS TIMEOUT,
           VISITLEN,
           PROTOCOL,
           PATIENT,
           UNIQUEFIELD AS UF, 
           "OPVisit" AS VisitType 
      FROM ctsi_webcamp.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
       AND VISITDATE>=str_to_date('07,01,2017','%m,%d,%Y')
;

select avg(VISITLEN) from ctsi_webcamp_adhoc.OPVISITS;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ctsi_webcamp_adhoc.OPVISITS
ADD TIMEINSTR varchar(12),
ADD TIMEOUTSTR varchar(12),
ADD StartTime DATETIME,
ADD EndTime DATETIME;





UPDATE ctsi_webcamp_adhoc.OPVISITS
SET TIMEINSTR=TRIM(CONCAT(SUBSTR( TIMEIN,1,length(trim(TIMEIN ))-1)," ",UPPER(substr(TIMEIN,LENGTH(trim(TIMEIN)),1)  ) ,"M" )),
    TIMEOUTSTR=TRIM(CONCAT(SUBSTR(TIMEOUT,1,length(trim(TIMEOUT))-1)," ",UPPER(substr(TIMEOUT,LENGTH(trim(TIMEOUT)),1)  ) ,"M" ));


UPDATE ctsi_webcamp_adhoc.OPVISITS
SET StartTime=STR_TO_DATE(TIMEINSTR, '%h:%i %p') ,
	  EndTime=STR_TO_DATE(TIMEOUTSTR, '%h:%i %p') ;



alter table ctsi_webcamp_adhoc.OPVISITS
DROP timein, 
DROP timeout,
DROP timeinstr,
DROP timeoutstr;

alter table ctsi_webcamp_adhoc.OPVISITS
ADD DOW int(1);

update ctsi_webcamp_adhoc.OPVISITS
set DOW=DAYOFWEEK(ENCOUNTERdATE);

select * from ctsi_webcamp_adhoc.OPVISITS;

drop table ctsi_webcamp_adhoc.DOW;
CREATE TABLE ctsi_webcamp_adhoc.DOW AS
SELECT dow,STARTTIME,ENDTIME,COUNT(*)
FROM ctsi_webcamp_adhoc.OPVISITS
GROUP BY dow,STARTTIME,ENDTIME;


desc ctsi_webcamp_adhoc.OPVISITS;


UPDATE ctsi_webcamp_adhoc.OPVISITS
SET NewTi



SELECT STR_TO_DATE(TIMEIN, '%h:%i%p') 
FROM ctsi_webcamp_adhoc.OPVISITS;


SELECT EncounterDate,SUM(VISITLEN)/60 AS Duration
FROM ctsi_webcamp_adhoc.OPVISITS
group by EncounterDate;