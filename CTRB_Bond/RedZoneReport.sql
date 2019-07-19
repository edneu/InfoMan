## MAKE FILE FOR DSP DETERMINATION
/*

drop table space.SafeHarbor2019;
create table space.SafeHarbor20109 AS
select Award_ID_Number AS PS_CONTRACT, 
       space(20) AS DSP_Determine,
       concat(LastName,", ",FirstName) AS PI_NAME,
       AWARD_INV_UFID AS PI_UFID,
       SponsorName,
       SponsorID,
       Title,
       Total_Award
from space.bondmaster
Where IP_USAGE IS NULL;
*/
################################################################
/*
## Spacelist for reference
DROP TABLE if exists work.spacelist;
CREATE TABLE work.spacelist AS
Select BLDG AS Building,
         FL AS Floor,
         ROOM as Room,
         PRJNUM AS ProjectID 
FROM space.ctrb_projects_2019;

select * from space.spacelist;
*/

select distinct IP_USAGE from space.bondmaster;

UPDATE space.bondmaster SET Research_Revenue=0,
							CTRB_Research_Revenue=0,
                            Good_Research_Revenue=0,
                            Bad_Research_Revenue=0;

UPDATE space.bondmaster SET Research_Revenue=Include_Award*Total_Award;
UPDATE space.bondmaster SET CTRB_Research_Revenue=Research_Revenue*(CTRB_PCT*.01);
UPDATE space.bondmaster SET Good_Research_Revenue=CTRB_Research_Revenue WHERE IP_USAGE="Good";
UPDATE space.bondmaster SET Bad_Research_Revenue=CTRB_Research_Revenue WHERE IP_USAGE="Bad";



## REPORT RED ZONE


drop table  if exists space.measures;
Create table space.measures as
Select "Number of ProjectIDs from Space File" AS MetricDesc,
count(ProjectID) AS MetricSpace
from work.spacelist
UNION ALL
Select "Number of unique Projects from Space File" AS MetricDesc,
count(distinct ProjectID) AS Metric
from work.spacelist
UNION ALL
Select "Number of Unique Project IDs with no match" AS MetricDesc,
 count(distinct ProjectID) as Metric
from space.Project_Not_found
UNION ALL
Select "Number of Contracts" AS MetricDesc,
count(distinct Award_Id) AS Metric
from space.bondmaster
WHERE Include_Award=1
UNION ALL
Select "Number of unique PIs" AS MetricDesc,
count(distinct AWARD_INV_UFID) AS Metric
from space.bondmaster
WHERE Include_Award=1
UNION ALL
Select "Maximum Contracts Per Investigator" AS MetricDesc,
max(Span) as Metric
from space.bondmaster
UNION ALL
Select "Total Research Revenue" AS MetricDesc,
sum(Research_Revenue) as Metric
from space.bondmaster
UNION ALL
Select "CTRB Research Revenue" AS MetricDesc,
sum(CTRB_Research_Revenue) as Metric
from space.bondmaster
UNION ALL
Select "GOOD CTRB Research Revenue" AS MetricDesc,
sum(Good_Research_Revenue) as Metric
from space.bondmaster
UNION ALL
Select "BAD CTRB Research Revenue" AS MetricDesc,
sum(Bad_Research_Revenue) as Metric
from space.bondmaster
UNION ALL
Select "Percentage Good CTRB Research Revenue" AS MetricDesc,
sum(Good_Research_Revenue)/sum(CTRB_Research_Revenue) as Metric
from space.bondmaster
UNION ALL
Select "Missing CTRB Percentage Good Research Revenue" AS MetricDesc,
sum(Research_Revenue) as Metric
from space.bondmaster
WHERE IP_USAGE="Good"
AND CTRB_PCT IS NULL
UNION ALL
Select "Missing CTRB Percentage Bad Research Revenue" AS MetricDesc,
sum(Research_Revenue) as Metric
from space.bondmaster
WHERE IP_USAGE="Bad"
AND CTRB_PCT IS NULL
;

;


select * from space.bondmaster where (Good_Research_Revenue+Bad_Research_Revenue)<>CTRB_Research_Revenue;

##################################


SELECT "2015" as CertYear,
       SUM(Research_Revenue) as ResearchRev,
       SUM(CTRB_Research_Revenue) AS CTRBRev,
       SUM(Good_Research_Revenue) as GoodRev,
       SUM(Bad_Research_Revenue) AS BadRev
FROM space.bondmaster2015
UNION ALL
SELECT "2016" as CertYear,
       SUM(Research_Revenue) as ResearchRev,
       SUM(CTRB_Research_Revenue) AS CTRBRev,
       SUM(Good_Research_Revenue) as GoodRev,
       SUM(Bad_Research_Revenue) AS BadRev
FROM space.bondmaster2016
UNION ALL
SELECT "2017" as CertYear,
       SUM(Research_Revenue) as ResearchRev,
       SUM(CTRB_Research_Revenue) AS CTRBRev,
       SUM(Good_Research_Revenue) as GoodRev,
       SUM(Bad_Research_Revenue) AS BadRev
FROM space.bondmaster2017
UNION ALL
SELECT "2018" as CertYear,
       SUM(Research_Revenue) as ResearchRev,
       SUM(CTRB_Research_Revenue) AS CTRBRev,
       SUM(Good_Research_Revenue) as GoodRev,
       SUM(Bad_Research_Revenue) AS BadRev
FROM space.bondmaster2018
UNION ALL
SELECT "2019" as CertYear,
       SUM(Research_Revenue) as ResearchRev,
       SUM(CTRB_Research_Revenue) AS CTRBRev,
       SUM(Good_Research_Revenue) as GoodRev,
       SUM(Bad_Research_Revenue) AS BadRev
FROM space.bondmaster       ;
       





###################################




select * from space.measures;

DROP TABLE if exists work.contract_class;
Create table work.contract_class AS
SELECT 	Prime_Sponsor_Type,
		COUNT(DISTINCT AWARD_ID) AS Good,
        0 AS BAD
FROM space.bondmaster
WHERE IP_USAGE="GOOD"
    AND Include_Award=1
GROUP BY Prime_Sponsor_Type
UNION ALL
SELECT 	Prime_Sponsor_Type,
		0 AS GOOD,
        COUNT(DISTINCT AWARD_ID) AS BAD
FROM space.bondmaster
WHERE IP_USAGE="BAD"
  AND Include_Award=1
GROUP BY Prime_Sponsor_Type;

select * from work.contract_class;

DROP TABLE if exists space.contract_class;
Create table space.contract_class AS
SELECT	 Prime_Sponsor_Type AS SponsorType,
		SUM(GOOD) AS Good,
		SUM(BAD) AS Bad,
		SUM(GOOD+BAD) AS Total
FROM work.contract_class
GROUP BY Prime_Sponsor_Type;







DROP TABLE work.award_class;
Create table work.award_class AS
SELECT 	Prime_Sponsor_Type,
		SUM(Total_Award) AS Good,
        0 AS BAD
FROM space.bondmaster
WHERE IP_USAGE="GOOD"
  AND Include_Award=1
GROUP BY Prime_Sponsor_Type
UNION ALL
SELECT 	Prime_Sponsor_Type,
		0 AS GOOD,
        SUM(Total_Award) AS BAD
FROM space.bondmaster
WHERE IP_USAGE="BAD"
  AND Include_Award=1
GROUP BY Prime_Sponsor_Type;

drop table space.red_research_revenue;
create table space.red_research_revenue
SELECT Prime_Sponsor_Type,
       SUM(Total_Award) AS Total_Research_Revenue,
       SUM(CTRB_Research_Revenue) As CTRB_Research_Revenue,
       SUM(Good_Research_Revenue) AS Good_Research_Revenue,
       SUM(Bad_Research_Revenue) AS Bad_Research_Revenue
from space.bondmaster
group by Prime_Sponsor_Type
ORDER BY Total_Research_Revenue DESC;


DROP TABLE if exists space.other_sponsors;
Create table space.other_sponsors AS
Select 	SponsorName,
        Count(*) AS NumAward, 
		SUM(Total_Award) AS Award
FROM space.bondmaster       
Where Prime_Sponsor_Type="Miscellaneous"
GROUP BY SponsorName
ORDER BY SponsorName;



DROP TABLE IF EXISTS space.SurveySumm;
CREATE TABLE space.SurveySumm AS
SELECT concat(trim(LastName),", ",trim(FirstName)) AS PI,
       MAX(SPAN) AS NumAwards,
       SUM(CTRB_Research_Revenue) AS CTRB_Amt,
       SUM(Good_Research_Revenue) AS Good,
       SUM(Bad_Research_Revenue) AS BAD_AMT 
FROM space.bondmaster
group by concat(trim(LastName),", ",trim(FirstName)) 
order by concat(trim(LastName),", ",trim(FirstName)) ;

select * from space.SurveySumm where PI like "%Muller%";

select sum(CTRB_Amt),sum(Good), Sum(BAD_AMT) from space.SurveySumm;