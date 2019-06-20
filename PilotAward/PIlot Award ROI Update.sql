##################
### EXTRACT AWARDS FOR Appending to pilots.roi_awards_master
### This file contains a base record at with the Project or Award Level.
### These Data are used to query the Awards Data to update the pilot realted award amounts
##### DATA CLEANING CODE

drop table if exists pilots.temp;
create table pilots.temp as
SELECT 
CLK_AWD_ID,
CLK_AWD_PROJ_ID,
Year(FUNDS_ACTIVATED) AS Year_Activiated,
FUNDS_ACTIVATED AS FUNDS_ACTIVATED,
CLK_AWD_PI,
CLK_PI_UFID,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_AWD_ID,
CLK_AWD_PROJ_NAME AS Grant_Title,
DIRECT_AMOUNT,
INDIRECT_AMOUNT,
SPONSOR_AUTHORIZED_AMOUNT
 FROM lookup.awards_history where CLK_AWD_PROJ_NAME  like "%Iatrogenic%";
;


################
SELECT Award_Year,ProjectStatus,count(*) from pilots.PILOTS_MASTER WHERE AWARDED="Awarded" GROUP BY Award_Year,ProjectStatus;
SELECT DISTINCT ProjectStatus from pilots.PILOTS_MASTER;

drop table if exists work.projstatus;
create table work.projstatus as
SELECT Pilot_ID,Category,Award_Year,AwardLetterDate,ProjectStatus,PI_Last,PI_First,Title from pilots.PILOTS_MASTER WHERE ProjectStatus NOT IN ('Completed','Active','Closed-Low Enrollment')
AND AWARDED="Awarded" AND Award_Year<=2018;

UPDATE pilots.PILOTS_MASTER SET ProjectStatus="Completed" WHERE Category="SECIM";
UPDATE pilots.PILOTS_MASTER SET ProjectStatus="Completed" WHERE ProjectStatus="" and Award_Year=2011 AND AWARDED="Awarded"; 
UPDATE pilots.PILOTS_MASTER SET ProjectStatus="" WHERE Award_Year=2011 AND AWARDED<>"Awarded";
UPDATE pilots.PILOTS_MASTER SET ProjectStatus="Completed" WHERE Pilot_ID IN (382,383,384);
UPDATE pilots.PILOTS_MASTER SET ProjectStatus="Ongoing" 
      WHERE Pilot_ID IN  (399,400,401,402,403,404,405,406,407,408,409,410,411,412,413);


; 

select Category,count(*) from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Award_Year<=2016
GROUP BY Category;




Completed
Closed-Low Enrollment 
Ongoing
Active





###Aggregate the Amounts
select sum(DIRECT_AMOUNT), Sum(INDIRECT_AMOUNT),sum(SPONSOR_AUTHORIZED_AMOUNT)  FROM lookup.awards_history where CLK_AWD_ID  like "AWD05859";

###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
### ADMIN CODE TO CREATE pilot_award_master

#####################################################
#####################################################
#####################################################
##  pilots.roi_awards is the table identifying awards or project associated with a Pilot (PilotID)
## 
##  pilots.ROIAward_detail contains the Award History Records for the Awards or Projects identified in pilots.pilots.roi_awards
##
##
####ALTER TABLE pilots.roi_awards CHANGE COLUMN `PilotID` `Pilot_ID` int(11);
##############################################################################
##  CREATE DETAIL AWARDS TABLE FOR UPDATES ###################################
##############################################################################

DROP TABLE IF EXISTS pilots.ROIAward_detail_work;
Create table pilots.ROIAward_detail_work AS
SELECT
	"Award" As AggLevel, 
	CLK_AWD_ID,
	CLK_AWD_PROJ_ID,
	FUNDS_ACTIVATED,
	CLK_AWD_PI,
	CLK_PI_UFID,
	CLK_AWD_PROJ_MGR,
	CLK_AWD_PROJ_MGR_UFID,
	REPORTING_SPONSOR_NAME,
	REPORTING_SPONSOR_AWD_ID,
	CLK_AWD_PROJ_NAME,
	DIRECT_AMOUNT,
	INDIRECT_AMOUNT,
	SPONSOR_AUTHORIZED_AMOUNT
from lookup.awards_history
WHERE CLK_AWD_ID IN (SELECT DISTINCT CLK_AWD_ID from pilots.PILOTS_ROI_MASTER WHERE AggLevel="Award")
UNION ALL 
SELECT
	"Project" As AggLevel, 
	CLK_AWD_ID,
	CLK_AWD_PROJ_ID,
	FUNDS_ACTIVATED,
	CLK_AWD_PI,
	CLK_PI_UFID,
	CLK_AWD_PROJ_MGR,
	CLK_AWD_PROJ_MGR_UFID,
	REPORTING_SPONSOR_NAME,
	REPORTING_SPONSOR_AWD_ID,
	CLK_AWD_PROJ_NAME,
	DIRECT_AMOUNT,
	INDIRECT_AMOUNT,
	SPONSOR_AUTHORIZED_AMOUNT
from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT CLK_AWD_PROJ_ID from pilots.PILOTS_ROI_MASTER WHERE AggLevel="Project");
##
## ADD Pilot Award Information to Award Data
##



ALTER TABLE pilots.ROIAward_detail_work
	ADD Pilot_ID int(11),
	ADD	PilotPI varchar(25),
	ADD	PilotPI_UFID varchar(12),
    ADD AwardLetterDate datetime,
	ADD	Year_Activiated int(11),
    ADD Grant_Title varchar(255);

SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.ROIAward_detail_work pd, pilots.PILOTS_ROI_MASTER lu
SET pd.Pilot_ID=lu.Pilot_ID,
	pd.PilotPI=lu.PilotPI,
    pd.PilotPI_UFID=lu.PilotPI_UFID,
    pd.AwardLetterDate=lu.AwardLetterDate,
	pd.Year_Activiated=lu.Year_Activiated,
    pd.Grant_Title=lu.CLK_AWD_PROJ_NAME
WHERE pd.CLK_AWD_ID=lu.CLK_AWD_ID
  AND pd.AggLevel="Award";	

UPDATE pilots.ROIAward_detail_work pd, pilots.PILOTS_ROI_MASTER  lu
SET pd.Pilot_ID=lu.Pilot_ID,
	pd.PilotPI=lu.PilotPI,
    pd.PilotPI_UFID=lu.PilotPI_UFID,
        pd.AwardLetterDate=lu.AwardLetterDate,
	pd.Year_Activiated=lu.Year_Activiated,
    pd.Grant_Title=lu.CLK_AWD_PROJ_NAME
WHERE pd.CLK_AWD_PROJ_ID=lu.CLK_AWD_PROJ_ID
  AND pd.AggLevel="Project";	

SET SQL_SAFE_UPDATES = 0;

DELETE from pilots.ROIAward_detail_work
       WHERE FUNDS_ACTIVATED<AwardLetterDate ;


SET SQL_SAFE_UPDATES = 1;


### DELETE PROJECT RECORDS PRIOR TO Pilot Award Letter
select FUNDS_ACTIVATED,AwardLetterDate from pilots.ROIAward_detail_work
WHERE FUNDS_ACTIVATED<AwardLetterDate ;




DROP TABLE IF EXISTS pilots.ROI_Detail;
Create table pilots.ROI_Detail AS
SELECT 
	@ROI_Detail_id := @ROI_Detail_id + 1 n,
	Pilot_ID,
	AggLevel,
    AwardLetterDate AS Pilot_Award_Date,
	CLK_AWD_ID,
	CLK_AWD_PROJ_ID,
	PilotPI,
	PilotPI_UFID,
	Year_Activiated,
	FUNDS_ACTIVATED,
	CLK_AWD_PI,
	CLK_PI_UFID,
	CLK_AWD_PROJ_MGR,
	CLK_AWD_PROJ_MGR_UFID,
	REPORTING_SPONSOR_NAME,
	REPORTING_SPONSOR_AWD_ID,
	Grant_Title,
	DIRECT_AMOUNT,
	INDIRECT_AMOUNT,
	SPONSOR_AUTHORIZED_AMOUNT
from pilots.ROIAward_detail_work, (SELECT @ROI_Detail_id := 0) n
ORDER BY Pilot_ID;

### DROP TABLE pilots.ROIAward_detail_work

DROP TABLE IF EXISTS pilots.ROI_AWARD_AGG;
CREATE TABLE pilots.ROI_AWARD_AGG AS
	SELECT 	Pilot_ID,
            Concat("AwdID: ",CLK_AWD_ID) AS GrantID ,
            MAX(Pilot_Award_Date) AS Pilot_Award_Date,
			MIN(Grant_Title) AS Grant_Title,
			MIN(Year_Activiated) AS GrantYear,
			MIN(FUNDS_ACTIVATED) AS Year_Activiated,
			MIN(CLK_AWD_PI) AS Grant_PI,
			MIN(CLK_PI_UFID) AS Grant_PI_UFID,
			MIN(REPORTING_SPONSOR_NAME) AS Grant_Sponsor,
			MIN(REPORTING_SPONSOR_AWD_ID) AS Grant_Sponsor_ID,
			SUM(DIRECT_AMOUNT) As Direct,
			SUM(INDIRECT_AMOUNT) As Indirect,
			SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total,
            FORMAT(SUM(SPONSOR_AUTHORIZED_AMOUNT),0) AS Fmt_total
FROM pilots.ROI_Detail
WHERE AggLevel="Award"
Group by Pilot_ID, Concat("AwdID: ",CLK_AWD_ID)
UNION ALL
	SELECT 	Pilot_ID,
           	Concat("ProjID: ",CLK_AWD_PROJ_ID) AS GrantID ,
            MAX(Pilot_Award_Date) AS Pilot_Award_Date,
			MIN(Grant_Title) AS Grant_Title,
			MIN(Year_Activiated) AS GrantYear,
			MIN(FUNDS_ACTIVATED) AS Year_Activiated,
			MIN(CLK_AWD_PROJ_MGR) AS Grant_PI,
			MIN(CLK_AWD_PROJ_MGR_UFID) AS Grant_PI_UFID,
			MIN(REPORTING_SPONSOR_NAME) AS Grant_Sponsor,
			MIN(REPORTING_SPONSOR_AWD_ID) AS Grant_Sponsor_ID,
			SUM(DIRECT_AMOUNT) As Direct,
			SUM(INDIRECT_AMOUNT) As Indirect,
			SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total,
            FORMAT(SUM(SPONSOR_AUTHORIZED_AMOUNT),0) AS Fmt_total
FROM pilots.ROI_Detail
WHERE AggLevel="Project"
Group by Pilot_ID, Concat("ProjID: ",CLK_AWD_PROJ_ID) ;

#### This table is for the grants summary for the single Pilot View
DROP TABLE IF EXISTS pilots.ROI_PILOTID_AGG;
CREATE TABLE pilots.ROI_PILOTID_AGG AS
	SELECT 	Pilot_ID,
            MIN(Pilot_Award_Date) AS Pilot_Award_Date,
            Min(YEAR(Year_Activiated)) AS GrantYear,
            GROUP_CONCAT(CONCAT(Grant_Title," (",Year_Activiated,") ",Grant_Sponsor," (",Grant_Sponsor_ID,") $",Fmt_Total)," | ") AS Grant_Summary,
			sum(Direct) AS Direct,
			sum(Indirect) AS Indirect,
			sum(Total) As Total
FROM pilots.ROI_AWARD_AGG
GROUP BY Pilot_ID;

SELECT SUM(TOTAL) from pilots.ROI_PILOTID_AGG;


#### This table is for the publication summary for the single Pilot View
DROP TABLE IF EXISTS pilots.PUB_PILOTID_AGG;
CREATE TABLE pilots.PUB_PILOTID_AGG AS
SELECT	Pilot_ID,
		Min(PubYear) AS PubYear,
		GROUP_CONCAT(Concat(Citation) ," | ") AS PubSummary
FROM pilots.PILOTS_PUB_MASTER
GROUP BY Pilot_ID;


### pilots.pilot_award_master IS THE ROOT
####### pilots.ROI_PILOTID_AGG are the Grants
####### pilots.PUB_PILOTID_AGG are the publications

drop table if exists pilots.PILOTS_SUMMARY;
CREATE TABLE pilots.PILOTS_SUMMARY AS
SELECT    pi.Pilot_ID,
          pi.Award_Year,
          pi.Category,
          pi.AwardType,
          pi.Cohort,
          pi.Awarded,
          pi.AwardLetterDate,
          pi.Award_Amt,
          pi.Status,
          pi.UFID,
          pi.Email,
          pi.PI_First,
          pi.PI_Last,
          pi.Title,
          pi.Remain_Amt,
          pi.Return_Amt,
          pi.Role,
          pi.Institution,
          pi.NumCollab,
          pi.Begin_Date,
          pi.End_Date,
          pi.NCE_Date,
          pi.PI_DEPT,
          pi.PI_DEPTID,
          pi.PI_DEPTNM,
          pi.Orig_Award_Year,
          pi.ProjectStatus,
          gr.GrantYear,
          gr.Grant_Summary,
          gr.Direct,
          gr.Indirect,
          gr.Total,
          pb.PubYear,
          pb.PubSummary,
          pi.ORGINAL_AWARD,
          pi.College,
          pi.PI_GENDER,
          pi.PI_DOB,
          pi.AwardeePositionAtApp,
          pi.AwardeeCareerStage,
          pi.Award_HummanSubjectResearch,
          pi.CancerScore,
          pi.AprilPilotID
FROM pilots.PILOTS_MASTER pi
     LEFT JOIN pilots.ROI_PILOTID_AGG gr ON pi.Pilot_ID=gr.Pilot_ID
     LEFT JOIN pilots.PUB_PILOTID_AGG pb ON pi.Pilot_ID=pb.Pilot_ID;
     
     
     
ALTER TABLE pilots.PILOTS_SUMMARY
	ADD TotalAMT decimal(11,2),
	ADD RelatedPub int(1),
	ADD RelatedGrant int(1);

SET SQL_SAFE_UPDATES = 0;	

UPDATE pilots.PILOTS_SUMMARY
SET TotalAMT=Total,
RelatedPub=0,
RelatedGrant=0;



UPDATE pilots.PILOTS_SUMMARY SET RelatedPub=1 WHERE PubYear>0 AND PubYear<=2018;
UPDATE pilots.PILOTS_SUMMARY SET RelatedGrant=1 WHERE GrantYear>0 AND GrantYear<=2018;       

SET SQL_SAFE_UPDATES = 1;	
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################

 




select sum(TOTAL) from pilots.PILOTS_SUMMARY;


select distinct PubYear, GrantYear from pilots.pilots_summary;


select distinct AggLevel from pilots.ROI_Detail;


drop table if exists  pilots.roiSRM;
create table pilots.roiSRM as
select Pilot_ID,SUM(SPONSOR_AUTHORIZED_AMOUNT) as TOTAL
from pilots.ROI_Detail
group BY Pilot_ID
order by Pilot_ID;


drop table if exists  pilots.roiAPP;
create table pilots.roiAPP as
select Pilot_ID ,
       SUM(TotalAmt) as TOTAL
from pilots.grants_app
group BY Pilot_ID
order by Pilot_ID;

Alter Table pilots.roiAPP
ADD SRM_total decimal(12,2);

UPDATE pilots.roiAPP ap, pilots.roiSRM lu
SET ap.SRM_total=lu.TOTAL
WHERE ap.Pilot_ID=lu.Pilot_ID;

#################
### CHECK ###

select sum(TOTAL),sum(SRM_total),sum(TOTAL)-sum(SRM_total) from pilots.roiAPP;

select * from pilots.roiAPP where Total>SRM_Total;
select * from pilots.roiAPP where Total<SRM_Total;
select * from pilots.roiAPP where Total<>SRM_Total;
select * from pilots.roiAPP ;




select 	Pilot_ID,
		Award_Year,
		Category,
		PI_Last,
		PI_First,
		GrantYear,
		VerifiedGrant,
		TotalAmt
 from lookup.pilots where Pilot_id in (select distinct Pilotid from pilots.roiAPP where Total<SRM_Total);










select * from lookup.ufids where UF_EMAIL="cmtucker@ufl.edu";

select * from lookup.pilots where Pilot_ID=379;

select * from lookup.awards_history where CLK_PI_UFID="89917290";



select * from pilots.roi_awards where PilotID=379;

##################################################################
##################################################################


