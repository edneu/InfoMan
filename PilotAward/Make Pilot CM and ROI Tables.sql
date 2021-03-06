### CM AND ROI TABLES
SET SQL_SAFE_UPDATES = 0;

########################################################################################VERIFY TABLES


######################################################################
#ALTER TABLE pilots.PILOTS_SUMMARY
	#ADD TotalAMT decimal(11,2),
	#ADD RelatedPub int(1),
	#ADD RelatedGrant int(1);
 ALTER TABLE pilots.PILOTS_SUMMARY   
   	ADD ROIRelatedPub int(1),
    ADD ROIRelatedGrant int(1);

UPDATE pilots.PILOTS_SUMMARY
SET TotalAMT=Total,
RelatedPub=0,
RelatedGrant=0;


UPDATE pilots.PILOTS_SUMMARY
SET ROIRelatedPub=0,
ROIRelatedGrant=0;
	

UPDATE pilots.PILOTS_SUMMARY SET RelatedPub=1 WHERE PubYear>0 AND PubYear<=2020;
UPDATE pilots.PILOTS_SUMMARY SET RelatedGrant=1 WHERE GrantYear>0 AND GrantYear<=2020;  

UPDATE pilots.PILOTS_SUMMARY SET ROIRelatedPub=1 WHERE PubYear>0 ;
UPDATE pilots.PILOTS_SUMMARY SET ROIRelatedGrant=1 WHERE GrantYear>0 ;  


SELECT * FROM pilots.PILOTS_SUMMARY WHERE ROIRelatedGrant=1 AND RelatedGrant=0;

##################### START TABLES

DROP TABLE IF EXISTS work.cmpilotcalc;
CREATE TABLE work.cmpilotcalc AS
Select * from pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
;

drop table if exists work.temp;
create table work.temp AS
Select Pilot_ID, AwardLetterDate,Title,End_Date,Begin_Date
from work.cmpilotcalc;



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
ADD Pub2013 int(5),
ADD Pub2014 Int(5),
ADD Pub2015 Int(5),
ADD Pub2016 Int(5),
ADD Pub2017 Int(5),
ADD Pub2018 Int(5),
ADD Pub2019 Int(5),
ADD Pub2020 int(5),
ADD Grant2012 Int(5),
ADD Grant2013 int(5),
ADD Grant2014 Int(5),
ADD Grant2015 Int(5),
ADD Grant2016 Int(5),
ADD Grant2017 Int(5),
ADD Grant2018 Int(5),
ADD Grant2019 Int(5),
ADD Grant2020 int(5);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.cmpilotcalc
SET Pub2012=0,
    Pub2013=0,
    Pub2014=0,
    Pub2015=0,
    Pub2016=0,
    Pub2017=0,
    Pub2018=0,
	Pub2019=0,
    Pub2020=0,
    Grant2012=0,
    Grant2013=0,
    Grant2014=0,
    Grant2015=0,
    Grant2016=0,
    Grant2017=0,
    Grant2018=0,
	Grant2019=0,
    Grant2020=0;
    
SELECT "Number of Pilots with Pubs" as Measure, count(*) as nPilots from work.cmpilotcalc WHERE PubYear>=2012 AND PubYear<=2019    
UNION ALL
SELECT "Number of Pilots with Grants" as Measure, count(*) as nPilots from work.cmpilotcalc WHERE GrantYear>=2012 AND GrantYear<=2019;    


### select distinct PubYear,count(*) from work.cmpilotcalc group by PubYear ;
#### select distinct GrantYear, count(*) from work.cmpilotcalc group by GrantYear ;



UPDATE work.cmpilotcalc SET Pub2012=1 WHERE PubYear=2012;
UPDATE work.cmpilotcalc SET Pub2013=1 WHERE PubYear=2013;
UPDATE work.cmpilotcalc SET Pub2014=1 WHERE PubYear=2014;
UPDATE work.cmpilotcalc SET Pub2015=1 WHERE PubYear=2015;
UPDATE work.cmpilotcalc SET Pub2016=1 WHERE PubYear=2016;
UPDATE work.cmpilotcalc SET Pub2017=1 WHERE PubYear=2017;
UPDATE work.cmpilotcalc SET Pub2018=1 WHERE PubYear=2018;
UPDATE work.cmpilotcalc SET Pub2019=1 WHERE PubYear=2019;
UPDATE work.cmpilotcalc SET Pub2020=1 WHERE PubYear=2020;
;

UPDATE work.cmpilotcalc SET Grant2012=1 WHERE GrantYear=2012;
UPDATE work.cmpilotcalc SET Grant2013=1 WHERE GrantYear=2013;
UPDATE work.cmpilotcalc SET Grant2014=1 WHERE GrantYear=2014;
UPDATE work.cmpilotcalc SET Grant2015=1 WHERE GrantYear=2015;
UPDATE work.cmpilotcalc SET Grant2016=1 WHERE GrantYear=2016;
UPDATE work.cmpilotcalc SET Grant2017=1 WHERE GrantYear=2017;
UPDATE work.cmpilotcalc SET Grant2018=1 WHERE GrantYear=2018;
UPDATE work.cmpilotcalc SET Grant2019=1 WHERE GrantYear=2019;
UPDATE work.cmpilotcalc SET Grant2020=1 WHERE GrantYear=2020;



DROP TABLE IF EXISTS results.CM_PUBS;
CREATE TABLE results.CM_PUBS AS
SELECT Award_Year,
       COUNT(*) AS NumPilots,
       SUM(Pub2012) as Pub2012,
       SUM(Pub2013) as Pub2013,
       SUM(Pub2014) as Pub2014,
       SUM(Pub2015) as Pub2015,
       SUM(Pub2016) as Pub2016,
       SUM(Pub2017) as Pub2017,
       SUM(Pub2018) as Pub2018,
	   SUM(Pub2019) as Pub2019,
       SUM(Pub2020) as Pub2020
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
       SUM(Grant2016) as Grant2016,
       SUM(Grant2017) as Grant2017,
       SUM(Grant2018) as Grant2018,
	   SUM(Grant2019) as Grant2019,
       SUM(Grant2020) as Grant2020
FROM  work.cmpilotcalc
GROUP BY Award_Year
ORDER BY Award_Year;

###################################
###################################
###################################
###################################
###################################
###################################
####################################
## ROI TABLES
####################################

####### INCLUDE ALL GRANTS IN ROI CALCULATION

select * from pilots.PILOTS_SUMMARY ;



select distinct GrantYear from pilots.PILOTS_SUMMARY;


Select Award_Year, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
GROUP BY Award_Year;
;




Select Category, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
GROUP BY Category;
;


#########
## COMPLETED PROJECTS
##########


##


 select distinct ProjectStatus from pilots.PILOTS_SUMMARY;
 
 select * from pilots.PILOTS_SUMMARY where ProjectStatus='' AND Awarded="Awarded" ;

Select Award_Year, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND ProjectStatus="Closed"
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
GROUP BY Award_Year;
;



Select Category, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY Category;
;




## TRAD BY TYPE
###################
Select AwardType, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category IN ("Traditional")
GROUP BY AwardType;
;



###################################
### AWRD BY COLLEGE
###################################

SELECT College,
       COUNT(*) as NumProjects,
       Sum(Award_Amt) AS PilotAmt,
       Sum(TotalAmt) AS GrantAmt,
       Sum(ROIRelatedPub) AS HasPub,
       Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY College
ORDER BY GrantAmt DESC ;


###################################
### AWRD BY CAREER STAGE
###################################

Select AwardeeCareerStage, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY AwardeeCareerStage;
;

select distinct AwardeeCareerStage from pilots.pilots_summary;
select Award_Year,Category,AwardeeCareerStage,Pilot_id,AwardType,Pi_last,PI_First, UFID from pilots.pilots_summary where AwardeeCareerStage is null and Awarded="Awarded";
###################################
### AWD BY GENDER
###################################
Select PI_GENDER, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(RelatedPub) AS HasPub, Sum(RelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY PI_GENDER ;
;


###################################
### AWD BY AWD SIZE
#################################
SELECT Award_Amt from pilots.PILOTS_SUMMARY WHERE Awarded="Awarded";

ALTER TABLE pilots.PILOTS_SUMMARY
ADD  AWD_AMT_CAT varchar(20);

UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="<$9,999" WHERE Award_Amt<10000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$10,000-$19,999" WHERE Award_Amt>=10000 AND Award_Amt<20000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$20,000-$29,999" WHERE  Award_Amt>=20000 AND Award_Amt<30000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$30,000-$39,999" WHERE  Award_Amt>=30000 AND Award_Amt<40000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$30,000-$39,999" WHERE  Award_Amt>=30000 AND Award_Amt<40000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$40,000-$49,999" WHERE  Award_Amt>=40000 AND Award_Amt<50000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$50,000-$59,999" WHERE  Award_Amt>=50000 AND Award_Amt<60000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$60,000-$69,999" WHERE  Award_Amt>=60000 AND Award_Amt<70000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$70,000-$79,999" WHERE  Award_Amt>=70000 AND Award_Amt<80000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT="$80,000-$89,999" WHERE  Award_Amt>=80000 AND Award_Amt<90000;
UPDATE pilots.PILOTS_SUMMARY SET AWD_AMT_CAT=">$90,000" WHERE  Award_Amt>=90000;

select AWD_AMT_CAT,count(*) from pilots.PILOTS_SUMMARY WHERE Awarded="Awarded" GROUP BY AWD_AMT_CAT; 

select * from pilots.PILOTS_SUMMARY WHERE Awarded="Awarded" AND AWD_AMT_CAT IS NULL ; 

## BY AWARD SIZE  ALL AWARDED PILOTS
Select AWD_AMT_CAT, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(RelatedPub) AS HasPub, Sum(RelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
#AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY AWD_AMT_CAT;
;

## BY AWARD SIZE   CLOSED PILOTS
Select AWD_AMT_CAT, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(RelatedPub) AS HasPub, Sum(RelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus="Closed"
AND Category NOT IN ("SECIM")
GROUP BY AWD_AMT_CAT;
;


## BY AWARD SIZE   COVID PILOTS


Select AWD_AMT_CAT, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(RelatedPub) AS HasPub, Sum(RelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Category LIKE ("%COVID%")
GROUP BY AWD_AMT_CAT;
;

###################################
### AWD BY HUMAN SUBJECT
#################################
Select Award_HummanSubjectResearch, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus<>"Ongoing"
AND Category NOT IN ("SECIM")
GROUP BY Award_HummanSubjectResearch ;
;

## NUMBER OF  AWARDS (Cell Q45)
select count(DISTINCT PILOT_ID) from pilots.PILOTS_ROI_MASTER WHERE Pilot_ID in 
(select DISTINCT PILOT_ID FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2020
AND Awarded="Awarded"
AND ProjectStatus<>"Ongoing"
AND Category NOT IN ("SECIM"));
;
/*
SELECT PIlot_ID, Category, TITLE, PI_LAST,PI_FIRST from lookup.pilots 
where Award_HummanSubjectResearch IS NULL
AND Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
;
select distinct Award_HummanSubjectResearch from lookup.pilots;
*/

###  CHARTS 
######################################################################
SELECT Award_Year,  COUNT(*) as NumProjects, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
GROUP BY Award_Year;


SELECT Category,  COUNT(*) as NumProjects, SSum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")
GROUP BY Category;




Select AwardType, COUNT(*) as NumProjects, Sum(Award_Amt) AS PilotAmt,Sum(TotalAmt) AS GrantAmt, Sum(ROIRelatedPub) AS HasPub, Sum(ROIRelatedGrant) AS HasGrant
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND ProjectStatus<>"Ongoing"
AND Category IN ("Traditional")
GROUP BY AwardType;
;



#######################################
###
#######################################
/*
##DROP TABLE loaddata.PilotsBackup;
CREATE TABLE loaddata.PilotsBackup AS
SELECT * from lookup.pilots;




ALTER TABLE lookup.pilots
ADD RelatedPub int(1),
ADD RelatedGrant int(1);


UPDATE lookup.pilots
SET RelatedPub=0,
    RelatedGrant=0;

ALTER TABLE lookup.pilots
ADD ORGINAL_AWARD decimal (20.2);

UPDATE lookup.pilots SET ORGINAL_AWARD=0;
UPDATE lookup.pilots SET ORGINAL_AWARD=Award_Amt;




select *   from lookup.pilots
WHERE ProjectStatus in ('Closed-Low Enrollment','Not Started');



UPDATE lookup.pilots SET Award_Amt=3353.6 , Return_Amt=16646.4 ,ProjectStatus='Closed-Low Enrollment ' WHERE PILOT_ID=83;
UPDATE lookup.pilots SET Award_Amt=6549.71 , Return_Amt=3130.29 ,ProjectStatus='Closed-Low Enrollment ' WHERE PILOT_ID=87;
UPDATE lookup.pilots SET Award_Amt=12657 , Return_Amt=0 ,ProjectStatus='Ongoing ' WHERE PILOT_ID=89;
UPDATE lookup.pilots SET Award_Amt=22745 , Return_Amt=0 ,ProjectStatus='Not Started ' WHERE PILOT_ID=104;
UPDATE lookup.pilots SET Award_Amt=25639 , Return_Amt=0 ,ProjectStatus='Closed-Low Enrollment ' WHERE PILOT_ID=105;
UPDATE lookup.pilots SET Award_Amt=9045.5 , Return_Amt=7629.5 ,ProjectStatus='Closed-Low Enrollment ' WHERE PILOT_ID=111;

*/
##EATE TABLE results.APilotAwardExtract_SATURDAY AS
##LECT * from work.APIlotAwardExtract;
/*
drop table if exists work.temp;
create table work.temp AS
select * from lookup.pilots
WHERE Award_Year>=2012
AND Awarded="Awarded"
AND Category NOT IN ("SECIM");
*/
DROP TABLE IF EXISTS work.APIlotAwardExtract;
CREATE TABLE work.APIlotAwardExtract AS
Select 

        AwardLetterDate;

Select 	COUNT(*) as NumProjects, 
        Sum(Award_Amt) AS PilotAmt,
        Sum(TotalAmt) AS GrantAmt,
        Sum(ROIRelatedPub) AS HasPub,
        Sum(ROIRelatedGrant) AS HasGrant,
        Min(Award_Amt) AS MINAWD,
        MAx(Award_Amt) AS MAXAWD
FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2019
AND ProjectStatus="Closed"
AND Awarded="Awarded"
AND Category NOT IN ("SECIM")

;


############   Closed Pilots, Number of Publicaitons

SELECT Count(distinct pilot_ID),COUNT(Distinct PMID) as nPUBS from pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID IN 
(select Distinct Pilot_ID FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2019
AND ProjectStatus="Closed"
AND Awarded="Awarded"
AND Category NOT IN ("SECIM"));


############   Closed Pilots, Number of Awards

SELECT COunt(distinct pilot_ID), SUM(nAWARDS_UD) as nAwards from pilots.ROI_AWARD_AGG
WHERE Pilot_ID IN 
(select Distinct Pilot_ID FROM pilots.PILOTS_SUMMARY
WHERE Award_Year>=2012 AND Award_Year<=2019
AND ProjectStatus="Closed"
AND Awarded="Awarded"
AND Category NOT IN ("SECIM"));



