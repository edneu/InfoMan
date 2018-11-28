##################  OP VISIT LENGTH

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




## OUTPATIENT VISITS FOR 2017
SELECT COUNT(*) 
FROM ctsi_webcamp.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")
AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
AND YEAR(VISITDATE)=2017;

## Unduplicated Particpants for 2016
select * from ctsi_webcamp.location;

### UNDUP PARTICPANTS
drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(VISITDATE)=2016
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  AND YEAR(ADMITDATE)=2016
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(ADMITDATE)=2016
 ;

drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(VISITDATE)=2015
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  AND YEAR(ADMITDATE)=2015
         UNION ALL
     SELECT PATIENT,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) AND YEAR(ADMITDATE)=2015
 ;



select count(distinct PATIENT) from ctsi_webcamp_adhoc.enrollment_tmp1;
select count(*) from ctsi_webcamp_adhoc.enrollment_tmp1;



### UNDUP PARTICPANTS
drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT YEAR(VISITDATE) AS VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
 ;

create table ctsi_webcamp_adhoc.temp
select VisitYear,count(distinct PATIENT) AS UndupParticpants, count(*) as Visits from ctsi_webcamp_adhoc.enrollment_tmp1 group by VisitYear;

select count(distinct PATIENT) AS UndupParticpants, count(*) as Visits 
from ctsi_webcamp_adhoc.enrollment_tmp1
Where VisitYear in (2012,2013,2014,2015,2016,2017);

select count(distinct PATIENT) AS UndupParticpants, count(*) as Visits 
from ctsi_webcamp_adhoc.enrollment_tmp1
Where VisitYear in (2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017);

select count(distinct PATIENT) AS UndupParticpants, count(*) as Visits 
from ctsi_webcamp_adhoc.enrollment_tmp1
Where VisitYear in (2009,2010,2011,2012,2013,2014,2015,2016,2017);

############# TEST




drop table if exists ctsi_webcamp_adhoc.enrollment_tmp1;
CREATE TABLE ctsi_webcamp_adhoc.enrollment_tmp1 AS
     SELECT YEAR(VISITDATE) AS VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.OPVISIT WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.ADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3)  
         UNION ALL
     SELECT YEAR(ADMITDATE) as VisitYear,PATIENT,PROTOCOL FROM ctsi_webcamp.SBADMISSIO WHERE PROTOCOL IS NOT NULL AND STATUS IN (2,3) 
 ;

create table ctsi_webcamp_adhoc.temp
select VisitYear,count(distinct PATIENT) AS UndupParticpants, count(*) as Visits from ctsi_webcamp_adhoc.enrollment_tmp1 group by VisitYear;

drop table if exists ctsi_webcamp_adhoc.visit2016_23;
create table ctsi_webcamp_adhoc.visit2016_23 as
SELECT * FROM ctsi_webcamp_adhoc.enrollment_tmp1 WHERE VisitYear=2016;

########################

drop table if exists ctsi_webcamp_adhoc.Statusnot23;
CREATE TABLE ctsi_webcamp_adhoc.Statusnot23 AS
     SELECT YEAR(VISITDATE) AS VisitYear,PATIENT,PROTOCOL,STATUS FROM ctsi_webcamp.OPVISIT 
     WHERE concat(PROTOCOL,"-",PATIENT) NOT IN (SELECT DISTINCT concat(PROTOCOL,"-",PATIENT) from ctsi_webcamp_adhoc.visit2016_23)
       AND YEAR(VISITDATE)=2016
       AND PROTOCOL IS NOT NULL
       AND STATUS NOT IN (2,3);

Alter table ctsi_webcamp_adhoc.Statusnot23
ADD FIRSTNAME varchar(30),
ADD LASTNAME varchar(30),
ADD PATIENT_ID varchar(15);


SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.Statusnot23 st, ctsi_webcamp.PATIENT lu
SET st.FIRSTNAME=lu.FIRSTNAME,
    st.LASTNAME=lu.LASTNAME,
    st.PATIENT_ID=lu.PATIENT
WHERE st.PATIENT=lu.UNIQUEFIELD;

 
create table ctsi_webcamp_adhoc.temp
select VisitYear,count(distinct PATIENT) AS UndupParticpants, count(*) as Visits from ctsi_webcamp_adhoc.enrollment_tmp1 group by VisitYear;


##############################################################
##############################################################
##############################################################
##############################################################
##############################################################



SELECT YEAR(VISITDATE),
       COUNT(*) AS OpVisits
FROM ctsi_webcamp.OPVISIT
WHERE PROTOCOL IS NOT NULL 
AND STATUS IN (2,3)
AND LAB IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.lab WHERE LAB="CRC")#AND LOCATION IN (SELECT UNIQUEFIELD FROM ctsi_webcamp.location WHERE location IN ("GCRC","JCAHO (non-GCRC)"))
GROUP BY YEAR(VISITDATE);


select * from ctsi_webcamp.protocol where LONGTITLE LIKE "%Auditory Hyper-Reactivity%" ;

