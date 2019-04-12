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
AND Award_Year<=2016
AND Award_Amt>=20000;



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









 ;

