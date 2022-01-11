
DROP TABLE IF EXISTS work.kl2work;
create table work.kl2work AS
select * from work.kl2;

## Verify Name can be used as personID Key
select distinct Name from work.kl2work;
## OK



####KL2 Grants by Year

SELECT  KL2StartYr AS Year,
		count(distinct Name) as nAwd 
from work.kl2work       
GROUP by KL2StartYr
ORDER BY KL2StartYr; 


Alter table work.kl2work 
Add kl2_2009 int(1),
Add kl2_2010 int(1),
Add kl2_2011 int(1),
Add kl2_2012 int(1),
Add kl2_2013 int(1),
Add kl2_2014 int(1),
Add kl2_2015 int(1),
Add kl2_2016 int(1),
Add kl2_2017 int(1),
Add kl2_2018 int(1),
Add kl2_2019 int(1),
Add kl2_2020 int(1),
Add kl2_2021 int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.kl2work
SET
 kl2_2009=0,
 kl2_2010=0,
 kl2_2011=0,
 kl2_2012=0,
 kl2_2013=0,
 kl2_2014=0,
 kl2_2015=0,
 kl2_2016=0,
 kl2_2017=0,
 kl2_2018=0,
 kl2_2019=0,
 kl2_2020=0,
 kl2_2021=0;

 
 UPDATE work.kl2work set kl2_2009=1 WHERE Year(CareerStart)<=2009 AND Year(CareerEnd)>=2009 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2010=1 WHERE Year(CareerStart)<=2010 AND Year(CareerEnd)>=2010 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2011=1 WHERE Year(CareerStart)<=2011 AND Year(CareerEnd)>=2011 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2012=1 WHERE Year(CareerStart)<=2012 AND Year(CareerEnd)>=2012 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2013=1 WHERE Year(CareerStart)<=2013 AND Year(CareerEnd)>=2013 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2014=1 WHERE Year(CareerStart)<=2014 AND Year(CareerEnd)>=2014 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2015=1 WHERE Year(CareerStart)<=2015 AND Year(CareerEnd)>=2015 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2016=1 WHERE Year(CareerStart)<=2016 AND Year(CareerEnd)>=2016 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2017=1 WHERE Year(CareerStart)<=2017 AND Year(CareerEnd)>=2017 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2018=1 WHERE Year(CareerStart)<=2018 AND Year(CareerEnd)>=2018 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2019=1 WHERE Year(CareerStart)<=2019 AND Year(CareerEnd)>=2019 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2020=1 WHERE Year(CareerStart)<=2020 AND Year(CareerEnd)>=2020 AND CareerProject IS NOT NULL;
 UPDATE work.kl2work set kl2_2021=1 WHERE Year(CareerStart)<=2021 AND Year(CareerEnd)>=2021  AND CareerProject IS NOT NULL;

/*
 UPDATE work.kl2work set kl2_2009=1 WHERE Year(CareerStart)<=2009 AND Year(CareerEnd)>=2009;
 UPDATE work.kl2work set kl2_2010=1 WHERE Year(CareerStart)<=2010 AND Year(CareerEnd)>=2010;
 UPDATE work.kl2work set kl2_2011=1 WHERE Year(CareerStart)<=2011 AND Year(CareerEnd)>=2011;
 UPDATE work.kl2work set kl2_2012=1 WHERE Year(CareerStart)<=2012 AND Year(CareerEnd)>=2012;
 UPDATE work.kl2work set kl2_2013=1 WHERE Year(CareerStart)<=2013 AND Year(CareerEnd)>=2013;
 UPDATE work.kl2work set kl2_2014=1 WHERE Year(CareerStart)<=2014 AND Year(CareerEnd)>=2014;
 UPDATE work.kl2work set kl2_2015=1 WHERE Year(CareerStart)<=2015 AND Year(CareerEnd)>=2015;
 UPDATE work.kl2work set kl2_2016=1 WHERE Year(CareerStart)<=2016 AND Year(CareerEnd)>=2016;
 UPDATE work.kl2work set kl2_2017=1 WHERE Year(CareerStart)<=2017 AND Year(CareerEnd)>=2017;
 UPDATE work.kl2work set kl2_2018=1 WHERE Year(CareerStart)<=2018 AND Year(CareerEnd)>=2018;
 UPDATE work.kl2work set kl2_2019=1 WHERE Year(CareerStart)<=2019 AND Year(CareerEnd)>=2019;
 UPDATE work.kl2work set kl2_2020=1 WHERE Year(CareerStart)<=2020 AND Year(CareerEnd)>=2020;
 UPDATE work.kl2work set kl2_2021=1 WHERE Year(CareerStart)<=2021 AND Year(CareerEnd)>=2021;
*/


drop table if exists work.kl2personYear;
create table work.kl2personYear AS       
Select Name,
   Max(kl2_2009) as kl2_2009,
   Max(kl2_2010) as kl2_2010,   
   Max(kl2_2011) as kl2_2011,
   Max(kl2_2012) as kl2_2012,
   Max(kl2_2013) as kl2_2013,
   Max(kl2_2014) as kl2_2014,
   Max(kl2_2015) as kl2_2015,
   Max(kl2_2016) as kl2_2016,
   Max(kl2_2017) as kl2_2017,
   Max(kl2_2018) as kl2_2018,
   Max(kl2_2019) as kl2_2019,
   Max(kl2_2020) as kl2_2020, 
   Max(kl2_2021) as kl2_2021
 from work.kl2work  
 group by Name;
 


### Active KL2 Scholars by Year
select 
   Sum(kl2_2009) as kl2_2009,
   Sum(kl2_2010) as kl2_2010,   
   Sum(kl2_2011) as kl2_2011,
   Sum(kl2_2012) as kl2_2012,
   Sum(kl2_2013) as kl2_2013,
   Sum(kl2_2014) as kl2_2014,
   Sum(kl2_2015) as kl2_2015,
   Sum(kl2_2016) as kl2_2016,
   Sum(kl2_2017) as kl2_2017,
   Sum(kl2_2018) as kl2_2018,
   Sum(kl2_2019) as kl2_2019,
   Sum(kl2_2020) as kl2_2020, 
   Sum(kl2_2021) as kl2_2021
from work.kl2personYear;   
   
   
   SELECT * FROM work.kl2work;
   
   
   
  ## vverify dates
   
   drop table if exists work.temp;
   create table work.temp as
   select Name,Min(CareerStart) as CareerStart,
               max(CareerEnd) as CareeeEnd,
               min(KL2StartYr) as KL2StartYr,
               max(KL2EndYr) as KL2EndYr
    from work.kl2work
    group by Name;
   
   ######################
   SELECT KL2StartYr,count(distinct Name) from work.kl2work Group by KL2StartYr; 
   
   
   
   drop table if exists work.kl2_2015;
   create table work.kl2_2015 as 
   SELECT * from work.kl2work
   WHERE KL2StartYr>=2015;
   
   select "Total KL2 Scholars" as Measure, count(distinct Name) as Value FROM work.kl2_2015 
   UNION ALL
   select "Recieved Subq K" as Measure, count(*) as Value FROM work.kl2_2015 WHERE GrantType Like "K%" 
   UNION ALL
   select "Recieved Subq R " as Measure, count(*) as Value FROM work.kl2_2015 WHERE GrantType Like "R%" 
   UNION ALL
   select "Recieved Subq R or K" as Measure, count(*) as Value FROM work.kl2_2015 WHERE GrantType Like "R%" OR GrantType Like "K%" 
   UNION ALL
   select "Recieved Subq P U " as Measure, count(*) as Value FROM work.kl2_2015 WHERE GrantType Like "P%" OR GrantType Like "U%"
   UNION ALL
   select "SUB K/r ot other grant" as Measure, count(*) as Value FROM work.kl2_2015 WHERE GrantType IS NOT NULL;
;
  
   
   
   
   SELECT GrantType,count(*) as n from work.kl2_2015 group by GrantType;
   
   
   ### vERIFY dates
   
   drop table if exists work.temp;
   create table work.temp as
   select Name,Min(CareerStart) as CareerStart,
               max(CareerEnd) as CareeeEnd,
               min(KL2StartYr) as KL2StartYr,
               max(KL2EndYr) as KL2EndYr
    from work.kl2work
    group by Name;