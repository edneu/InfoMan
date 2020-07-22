##  Add results from Survey TO BondMaster
/*
This Process add the QualtricsSurvey Results to the space.bondmaster table
The Investigators supply a value for the CTRB_PCT variable in the space.bondmaster table

Required Tables for this process :  space.bondmaster
									space.redsurveyresults Results table uploaded from Qualtrics

drop table if exists space.redsurveyresults2018;
*/



drop table if exists space.redsurveyresults;
create table space.redsurveyresults AS
SELECT * FROM space.redsurveyresults2020;

##ADJUST FOR BOUNCED EMAIL



###############################################################      AFTER SURVEY IS COMPLETE
drop table if exists space.redsurveydata;
create table space.redsurveydata AS
SELECT RecipientEmail AS EMAIL, 1 as Span, span01 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 2 as Span, span02 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 3 as Span, span03 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 4 as Span, span04 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 5 as Span, span05 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 6 as Span, span06 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 7 as Span, span07 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 8 as Span, span08 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 9 as Span, span09 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 10 as Span, span10 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 11 as Span, span11 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 12 as Span, span12 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 13 as Span, span13 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 14 as Span, span14 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 15 as Span, span15 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 16 as Span, span16 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 17 as Span, span17 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 18 as Span, span18 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 19 as Span, span19 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 20 as Span, span20 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 21 as Span, span21 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 22 as Span, span22 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 23 as Span, span23 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 24 as Span, span24 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 25 as Span, span25 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 26 as Span, span26 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 27 as Span, span27 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 28 as Span, span28 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 29 as Span, span29 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 30 as Span, span30 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 31 as Span, span31 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 32 as Span, span32 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 33 as Span, span33 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 34 as Span, span34 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 35 as Span, span35 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 36 as Span, span36 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 37 as Span, span37 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 38 as Span, span38 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 39 as Span, span39 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 40 as Span, span40 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 41 as Span, span41 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 42 as Span, span42 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 43 as Span, span43 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 44 as Span, span44 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 45 as Span, span45 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 46 as Span, span46 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 47 as Span, span47 as CTRB_PCT FROM space.redsurveyresults  UNION ALL
SELECT RecipientEmail AS EMAIL, 48 as Span, span48 as CTRB_PCT FROM space.redsurveyresults ;	

DROP TABLE IF EXISTS space.maxspan;
create table space.maxspan AS
select EMAIL,max(Span) AS Span from space.bondmaster group by EMAIL;										

SET SQL_SAFE_UPDATES = 0;

UPDATE space.redsurveydata rs, space.maxspan ms
SET CTRB_PCT=NULL
WHERE rs.EMAIL=ms.EMAIL
AND rs.SPAN>ms.SPAN;

SELECT * from space.redsurveydata;

DELETE FROM space.redsurveydata WHERE CTRB_PCT IS NULL;


select CTRB_PCT, CTRB_PCT*.01 from  space.redsurveydata;


## VERIFY
select EMAIL from space.redsurveydata where EMAIL not in (select distinct EMAIL from space.bondmaster);

select distinct EMAIL from space.bondmaster where EMAIL not in (select distinct EMAIL from space.redsurveydata);



SET SQL_SAFE_UPDATES = 0;

## UPDATE space.bondmaster with survey results
#drop table if exists loaddata.backupbondmaster2020;
#create table loaddata.backupbondmaster2020 as select * from space.bondmaster;




UPDATE space.bondmaster bm, space.redsurveydata sd
SET bm.CTRB_PCT=sd.CTRB_PCT
WHERE bm.Span=sd.Span
  AND bm.EMAIL=sd.EMAIL  ;


## Add Previously Collected Values for records with No Survey Data.
/*
UPDATE space.bondmaster bm, work.redsurveydata sd
SET bm.CTRB_PCT=CTRB_PCT_PREV
WHERE bm.CTRB_PCT IS NULL
  AND bm.CTRB_PCT_PREV IS NOT NULL;
*/
select count(distinct EMAIL) from space.bondmaster where CTRB_PCT IS NULL And CTRB_PCT_PREV IS NOT NULL;
select count(DISTINCT EMAIL) from space.bondmaster where CTRB_PCT IS NULL And CTRB_PCT_PREV IS NULL;


UPDATE space.bondmaster SET Research_Revenue=Include_Award*Total_Award;
UPDATE space.bondmaster SET CTRB_Research_Revenue=Research_Revenue*(CTRB_PCT*.01);
UPDATE space.bondmaster SET Good_Research_Revenue=CTRB_Research_Revenue WHERE IP_USAGE="Good";
UPDATE space.bondmaster SET Bad_Research_Revenue=CTRB_Research_Revenue WHERE IP_USAGE="Bad";




##
##  CREATE CONTACT LIST FOR NON-RESPONDERS

DROP TABLE IF EXISTS space.notdone;
CREATE TABLE space.notdone AS
SELECT concat(bm.LastName,", ",bm.FirstName) AS PI_NAME,
       bm.EMAIL AS PI_EMAIL,
       bm.PI_PHONE,
       eh.Link,
       SUM(bm.Total_Award) as TotalAwarded,
       MAX(Span) as NumAwards
FROM space.bondmaster bm 
     LEFT JOIN space.email_hist eh
     ON bm.email=eh.email
WHERE eh.Status<>"Finished Survey"
GROUP BY concat(bm.LastName,", ",bm.FirstName),
         bm.EMAIL,
         bm.PI_PHONE,
         eh.Link
ORDER BY concat(bm.LastName,", ",bm.FirstName);
;




##################  ADD ADDITIONAL STUDIES FROM SURVEY

DROP TABLE IF EXISTS work.Extra_studies;
Create table work.Extra_studies AS
SELECT    email, 
          Add1_Title AS Title,	
          Add1 AS CTRB_PCT,	
          Add1_Fed AS Federal,	
          Add1_IP AS GiveUpIP,	
          Add1_nonmon AS NonMon	
          FROM space.redsurveyresults	
          WHERE More1=1	
          UNION ALL	
SELECT    email,
    	  Add2_Title AS Title,	
          Add2 AS CTRB_PCT,	
          Add2_Fed AS Federal,	
          Add2_IP AS GiveUpIP,	
          Add2_nonmon AS NonMon	
          FROM space.redsurveyresults	
          WHERE More2=1	
          UNION ALL	
SELECT    email, 
	      Add3_Title AS Title,	
          Add3 AS CTRB_PCT,	
          Add3_Fed AS Federal,	
          Add3_IP AS GiveUpIP,	
          Add3_nonmon AS NonMon	
          FROM space.redsurveyresults	
          WHERE More3=1	
          UNION ALL	
SELECT    email, 
          Add4_Title AS Title,	
          Add4 AS CTRB_PCT,	
          Add4_Fed AS Federal,	
          Add4_IP AS GiveUpIP,	
          Add4_nonmon AS NonMon	
          FROM space.redsurveyresults	
          WHERE More4=1	
          UNION ALL	
SELECT    email, 
          Add5_Title AS Title,	
          Add5 AS CTRB_PCT,	
          Add5_Fed AS Federal,	
          Add5_IP AS GiveUpIP,	
          Add5_nonmon AS NonMon	
          FROM space.redsurveyresults	
          WHERE More5=1	;


drop table space.measures;
Create table space.measures as
Select "Number of ProjectIDs from Space File" AS MetricDesc,
count(ProjectID) AS Metric
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
#WHERE Include_Award=1
UNION ALL
Select "Number of unique PIs" AS MetricDesc,
count(distinct AWARD_INV_UFID) AS Metric
from space.bondmaster
#WHERE Include_Award=1
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
;
## select * from space.measures;




DROP TABLE work.contract_class;
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



DROP TABLE if exists space.contract_class;
Create table space.contract_class AS
SELECT	 Prime_Sponsor_Type AS SponsorType,
		SUM(GOOD) AS Good,
		SUM(BAD) AS Bad,
		SUM(GOOD+BAD) AS Total
FROM work.contract_class
GROUP BY Prime_Sponsor_Type;

DROP TABLE if exists space.other_sources;
Create table space.other_sources AS
SELECT	SponsorName,
		Count(*) as NumAwards,
		SUM(Total_Award) AS TotalAward
FROM space.bondmaster
WHERE Prime_Sponsor_Type="ALL OTHER SOURCES"
GROUP BY SponsorName
;


########### CHECK THIS


DROP TABLE work.red_research_revenue;
Create table work.red_research_revenue AS
SELECT 	Prime_Sponsor_Type,
		Sum(Total_Award) AS Good_Research_Revenue,
        Sum(0) AS Bad_Research_Revenue,
        Sum(0) AS Total_Research_Revenue
FROM space.bondmaster
WHERE IP_USAGE="GOOD"
    AND Include_Award=1
GROUP BY Prime_Sponsor_Type
UNION ALL
SELECT 	Prime_Sponsor_Type,
		Sum(0) AS Good_Research_Revenue,
        Sum(Total_Award) AS Bad_Research_Revenue,
        Sum(0) as Total_Research_Revenue
FROM space.bondmaster
WHERE IP_USAGE="BAD"
  AND Include_Award=1
GROUP BY Prime_Sponsor_Type
UNION ALL
SELECT 	Prime_Sponsor_Type,
		Sum(0) AS Good_Research_Revenue,
        Sum(0) AS Bad_Research_Revenue,
        Sum(Total_Award) AS Total_Research_Revenue
FROM space.bondmaster
WHERE Include_Award=1
GROUP BY Prime_Sponsor_Type;


DROP TABLE space.red_research_revenue;
Create table space.red_research_revenue AS
SELECT  Prime_Sponsor_Type,
		Sum(Good_Research_Revenue) AS Good_Research_Revenue,
        Sum(Bad_Research_Revenue) AS Bad_Research_Revenue,
        Sum(Total_Research_Revenue) AS Total_Research_Revenue
FROM work.red_research_revenue
GROUP BY Prime_Sponsor_Type;



DROP TABLE if exists space.SpaceSummary;
Create table space.SpaceSummary AS
SELECT concat(trim(LastName),", ",trim(FirstName)) as PI,
       count(*) as NumberofAwards,
       SUM(CTRB_Research_Revenue) AS CTRB_AMT,
       SUM(Good_Research_Revenue) AS GOOD,
       SUM(Bad_Research_Revenue) AS BAD  
from space.bondmaster
group by concat(trim(LastName),", ",trim(FirstName))
order by concat(trim(LastName),", ",trim(FirstName));


DROP TABLE IF EXISTS space.bondmaster2016;
CREATE TABLE space.bondmaster2016 AS
SELECT * FROM space.bondmaster;



select * from space.measures;


/*
## Clean Up

DROP TABLE work.spacelist;
DROP TABLE work.SRMWORK;

DROP TABLE work.AwardID;
DROP TABLE work.bondmaster;
Drop table work.SpaceRank;
*/




select * from space.Extra_studies;

#############
##  LOOKUP EXTRA STUDIES
###############

Select CLK_AWD_PI,
       REPORTING_SPONSOR_NAME,
       CLK_AWD_PROJ_NAME, 
       CLK_AWD_ID,
       REPORTING_SPONSOR_AWD_ID,
       FY_DATE_ACTIVATED AS FY,
       SUM(SPONSOR_AUTHORIZED_AMOUNT)
FROM lookup.awards_history
#WHERE  CLK_AWD_PI like "%haller, m%"
#WHERE CLK_AWD_ID LIKE "%00099358%"
WHERE CLK_AWD_PROJ_NAME LIKE "%TARGET-NASH%"
AND FY_DATE_ACTIVATED=2017
GROUP BY CLK_AWD_PI,
       REPORTING_SPONSOR_NAME,
       CLK_AWD_PROJ_NAME, 
       CLK_AWD_ID,
       REPORTING_SPONSOR_AWD_ID,
       FY_DATE_ACTIVATED;

UPDATE space.bondmaster 
SET CTRB_PCT=0 where CTRB_PCT IS NULL;


SELECT * from space.bondmaster
WHERE LastName="Muller";


UPDATE space.bondmaster SET CTRB_PCT=50 WHERE LastName="Muller" AND Span=1;
UPDATE space.bondmaster SET CTRB_PCT=75 WHERE LastName="Muller" AND Span=2;
UPDATE space.bondmaster SET CTRB_PCT=50 WHERE LastName="Muller" AND Span=3;





