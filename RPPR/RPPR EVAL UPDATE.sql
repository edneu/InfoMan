
## ALL Users since 2015
drop table if exists work.temp; 
create table work.temp AS
SELECT Year,COUNT(DISTINCT Person_key) as UNDUP
from lookup.roster
WHERE Year>=2015
group by Year;

Select avg(UNDUP) from work.temp;


## Faculty - All Years
drop table if exists work.fac; 
create table work.fac AS
Select Year,STD_PROGRAM,Person_key
from lookup.roster 
where Faculty="Faculty"
group by Year,STD_PROGRAM,Person_key;


## Faculty and Number of Years
drop table if exists work.facyear; 
create table work.facyear AS
select Person_key,count(distinct Year) as nYears
from work.fac
group by Person_key;


## Number of facuty 
select nYears, count(Distinct Person_key) as UNDUP 
from work.facyear
group by  nYears; 


## Number of Services in a given Year
drop table if exists work.facsvc; 
create table work.facsvc AS
select Year,Person_key,count(distinct STD_PROGRAM) as nSVC
from work.fac
group by Year,Person_key;

## Year and NSVC
SELECT Year,nSVC,count(distinct Person_key) as Undup
from work.facsvc
group by Year,nSVC;







drop table if exists work.facsvcagg; 
create table work.facsvcagg AS
Select Year,count(distinct Person_key) AS TOTAL,sum(0) as Over2Svc
from work.facsvc
GROUP BY Year
UNION ALL
Select Year,SUM(0) AS TOTAL,count(distinct Person_key) as Over2Svc
from work.facsvc
WHERE nSVC>1
GROUP BY Year;

SELECT Year,SUM(Over2Svc) as Over2Svc,Sum(Total) as Total
from work.facsvcagg
group by Year;


drop table if exists work.temp; 
drop table if exists work.fac; 
drop table if exists work.facyear; 
drop table if exists work.facsvc; 
drop table if exists work.facsvcagg; 