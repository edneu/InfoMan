
DROP TABLE IF EXISTS work.cmpilotcalc;
CREATE TABLE work.cmpilotcalc AS
Select * from lookup.pilots
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
AND ProjectStatus="Completed";

/*
### SECIM REFERENCE
select Award_Year,count(*) from lookup.pilots
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category="SECIM"
GROUP BY Award_Year;
*/

ALTER TABLE work.cmpilotcalc
ADD Pub2012 Int(5),
ADD	Pub2013 Int(5),
ADD Pub2014 Int(5),
ADD Pub2015 Int(5),
ADD Pub2016 Int(5),
ADD Grant2012 Int(5),
ADD	Grant2013 Int(5),
ADD Grant2014 Int(5),
ADD Grant2015 Int(5),
ADD Grant2016 Int(5);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.cmpilotcalc
SET Pub2012=0,
	Pub2013=0,
    Pub2014=0,
    Pub2015=0,
    Pub2016=0,
    Grant2012=0,
  	Grant2013=0,
    Grant2014=0,
    Grant2015=0,
    Grant2016=0;


UPDATE work.cmpilotcalc SET Pub2012=1 WHERE PubYear=2012;
UPDATE work.cmpilotcalc SET Pub2013=1 WHERE PubYear=2013;
UPDATE work.cmpilotcalc SET Pub2014=1 WHERE PubYear=2014;
UPDATE work.cmpilotcalc SET Pub2015=1 WHERE PubYear=2015;
UPDATE work.cmpilotcalc SET Pub2016=1 WHERE PubYear=2016;


UPDATE work.cmpilotcalc SET Grant2012=1 WHERE GrantYear=2012;
UPDATE work.cmpilotcalc SET Grant2013=1 WHERE GrantYear=2013;
UPDATE work.cmpilotcalc SET Grant2014=1 WHERE GrantYear=2014;
UPDATE work.cmpilotcalc SET Grant2015=1 WHERE GrantYear=2015;
UPDATE work.cmpilotcalc SET Grant2016=1 WHERE GrantYear=2016;





DROP TABLE IF EXISTS results.CM_PUBS;
CREATE TABLE results.CM_PUBS AS
SELECT Award_Year,
       COUNT(*) AS NumPilots,
       SUM(Pub2012) as Pub2012,
       SUM(Pub2013) as Pub2013,
       SUM(Pub2014) as Pub2014,
       SUM(Pub2015) as Pub2015,
       SUM(Pub2016) as Pub2016
FROM  work.cmpilotcalc
GROUP BY Award_Year
ORDER BY Award_Year;


DROP TABLE IF EXISTS results.CM_GRANTS;
CREATE TABLE results.CM_GRANTS AS
SELECT Award_Year,
       COUNT(*) AS NumPilots,
       SUM(Grant2012) as Grant2012,
       SUM(Grant2013) as Grant2013,
       SUM(Grant2014) as Grant2014,
       SUM(Grant2015) as Grant2015,
       SUM(Grant2016) as Grant2016
FROM  work.cmpilotcalc
GROUP BY Award_Year
ORDER BY Award_Year;
