drop table if exists work.leadstemp;
create table work.leadstemp as
SELECT Person_key,
		Year,
		Max(LastName) As LastName,
		Max(FirstName) AS FIrstName,
        Count(distinct STD_PROGRAM) as nDiff_srvs
from lookup.roster
WHERE Person_key NOT IN ('')
GROUP BY 	Person_key,
			Year;



drop table if exists  work.rosterleads;
Create table work.rosterleads as
Select 	Person_key,
		Max(LastName) AS LastName, 
        MAx(FirstName) AS FirstName
FROM work.leadstemp
GROUP BY  Person_key;

Alter Table work.rosterleads
ADD CY2009 int(5),
ADD CY2010 int(5),
ADD CY2011 int(5),
ADD CY2012 int(5),
ADD CY2013 int(5),
ADD CY2014 int(5),
ADD CY2015 int(5),
ADD CY2016 int(5),
ADD CY2017 int(5),
ADD CY2018 int(5),
ADD CY2019 int(5),
ADD CY2020 int(5),
ADD CY2021 int(5),
ADD CY2022 int(5);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.rosterleads
SET CY2009=0,
 CY2010=0,
 CY2011=0,
 CY2012=0,
 CY2013=0,
 CY2014=0,
 CY2015=0,
 CY2016=0,
 CY2017=0,
 CY2018=0,
 CY2019=0,
 CY2020=0,
 CY2021=0,
 CY2022=0;


UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2009=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2009;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2010=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2010;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2011=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2011;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2012=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2012;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2013=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2013;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2014=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2014;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2015=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2015;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2016=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2016;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2017=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2017;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2018=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2018;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2019=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2019;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2020=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2020;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2021=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2021;
UPDATE work.rosterleads rl, work.leadstemp lu SET rl.CY2022=lu.nDiff_srvs WHERE rl.Person_key=lu.Person_key AND lu.Year=2022;



select * from work.rosterleads;

Alter Table work.rosterleads
ADD WGT_UTIL int(10);

UPDATE work.rosterleads SET WGT_UTIL=CY2009+CY2010+CY2011+CY2012+CY2013+CY2014+CY2015+CY2016+CY2017+CY2018+CY2019+CY2020+CY2021+CY2022;

DROP TABLE IF EXISTS work.rosterleadsout;
create table work.rosterleadsout
SELECT *
FROM work.rosterleads
ORDER BY WGT_UTIL DESC;