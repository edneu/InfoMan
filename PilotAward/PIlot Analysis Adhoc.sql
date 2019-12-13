DROP TABLE IF EXISTS pilots.CompPilots;
create table pilots.CompPilots AS
Select Distinct Pilot_ID
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<2019
AND Status="Completed"
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
;






SELECT "Number of Grants" AS Metric,COUNT(*) AS MetricVal 
		from pilots.PILOTS_GRANT_SUMMARY
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
UNION ALL
SELECT "Number of Completed Pilot Awards with Grants" AS Metric,count(Distinct Pilot_ID) AS MetricVal 
		from pilots.PILOTS_GRANT_SUMMARY
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
UNION ALL
SELECT "Total Award Amount" AS Metric,SUM(Total) AS MetricVal 
		from pilots.PILOTS_GRANT_SUMMARY 
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
UNION ALL
SELECT "Minimum Award Amount" AS Metric,MIN(Total) AS MetricVal 
		from pilots.PILOTS_GRANT_SUMMARY 
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
        AND Total>0
UNION ALL
SELECT "Maximum Award Amount" AS Metric,Max(Total) AS MetricVal 
		from pilots.PILOTS_GRANT_SUMMARY 
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots);


### COUNT BY SPONSOR
SELECT Grant_Sponsor,COUNT(*)
from pilots.PILOTS_GRANT_SUMMARY 
GROUP BY Grant_Sponsor;


### NIH GRANT TYPES
select substr(Grant_Sponsor_ID,1,3),count(*) 
from pilots.PILOTS_GRANT_SUMMARY 
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
		AND Grant_Sponsor Like "NATL INST OF HLTH%"
GROUP BY substr(Grant_Sponsor_ID,1,3);

### Colleges of Awardees
SELECT College,COUNT(*)
from pilots.PILOTS_MASTER
WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots)
  AND Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.PILOTS_GRANT_SUMMARY)
GROUP BY College;

### PIs With Multiple Subsequent grants

drop table if exists work.Pilot_grant_count;
create table work.Pilot_grant_count As
SELECT Pilot_ID,Count(*) As numAward
from pilots.PILOTS_GRANT_SUMMARY 
		WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.CompPilots) 
GROUP BY Pilot_ID;

Alter Table work.Pilot_grant_count
Add PI_Last varchar(45),
ADD PI_First varchar(45),
ADD College varchar(45);

SET SQL_SAFE_UPDATES = 0;
UPDATE work.Pilot_grant_count pc, pilots.PILOTS_MASTER lu
SET pc.PI_Last=lu.PI_Last,
	pc.PI_First=lu.PI_First,
	pc.College=lu.College
WHERE pc.Pilot_ID=lu.Pilot_ID;
SET SQL_SAFE_UPDATES = 1;

SELECT PI_LAST, College, numAward
from work.Pilot_grant_count
WHERE  numAward>1;



