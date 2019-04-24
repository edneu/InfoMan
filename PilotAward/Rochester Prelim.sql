drop table if exists work.pilotaward;
create table work.pilotaward as
Select *
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


select count(*) from work.pilotaward;

select count(*) from work.pilotaward WHERE Category not in ("SECIM");

Select min(AwardLetterDate), max(AwardLetterDate)
from work.pilotaward;
 
SELECT Award_Amt,count(*) from work.pilotaward group by Award_Amt  ORDER by Award_Amt DESC;

select count(*) from work.pilotaward WHERE Award_Amt>=50000;
select count(*) from work.pilotaward WHERE Category not in ("SECIM") AND Award_Amt>=50000;

SELECT Award_Amt,count(*) from work.pilotaward where Category="Translational" group by Award_Amt ;



CREATE TABLE work.allpilots as
SELECT distinct Category As Category
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


drop table if exists work.pilotfitered;
create table work.pilotfitered as
SELECT * from pilots.PILOTS_MASTER
WHERE Awarded='Awarded'
AND Award_Year<=2012
AND Award_Amt>=50000;



select 	CONCAT(category," ",AwardType) AS AwardType,
		COUNT(*) AS NumAwards,
		Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
        SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE  Category NOT IN ('SECIM',"Communication")
AND CONCAT(category," ",AwardType) NOT IN ("Traditional Unkown","Traditional Cohort Applicant")
GROUP BY CONCAT(category," ",AwardType)
UNION ALL
select distinct 
		category AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE Category='SECIM'
GROUP BY Category
UNION ALL
select distinct 
		"Traditional Other" AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE CONCAT(category," ",AwardType) IN ("Traditional Unkown","Traditional Cohort Applicant")
GROUP BY "Traditional Other"
UNION ALL
select distinct 
		Category AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE Category IN ('Communication')
GROUP BY Category;



################  PULL PRe 2012 Pilots

DROP TABLE IF EXISTS pilots.EarlyCompPilots;
create table pilots.EarlyCompPilots AS
Select  *
FROM pilots.PILOTS_MASTER
WHERE Award_Year<2012 
AND ProjectStatus="Completed"
AND Awarded="Awarded"
;

  select Award_Year,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by Award_Year;
  select count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots ;

  select Category,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by Category;

  select AwardType,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by AwardType;
 ;

DROP TABLE IF Exists pilots.EarlyExtract ;
CREATE TABLE pilots.EarlyExtract AS
SELECT 	Pilot_ID,
		Award_Year,
        Category,
        AwardType,
        Awarded,
        AwardLetterDate,
        Award_Amt,
        PI_Last,
        PI_First,
        Email AS PI_EMAIL,
        UFID AS PI_UFID,
        PI_DEPT,
        College
FROM pilots.EarlyCompPilots
ORDER BY Pilot_ID;