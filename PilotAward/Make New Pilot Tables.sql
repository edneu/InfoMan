##################
### EXTRACT AWARDS FOR Appending to pilots.roi_awards_master
### This file contains a base record at with the Project or Award Level.
### These Data are used to query the Awards Data to update the pilot realted award amounts

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
 FROM lookup.awards_history where CLK_AWD_ID  like "AWD03282";
;

###Aggregate the Amounts
select sum(DIRECT_AMOUNT), Sum(INDIRECT_AMOUNT),sum(SPONSOR_AUTHORIZED_AMOUNT)  FROM lookup.awards_history where CLK_AWD_ID  like "AWD03666";
############### SZCRATCH
select * from pilots.roi_awards_master;

CREATE TABLE pilots.PILOTS_ROI_MASTER AS
SELECT * from pilots.roi_awards_master;



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
###############################################################################################################
###############################################################################################################
###############################################################################################################
##  pilots.PILOTS_ROI_MASTER is the table identifying awards or project associated with a Pilot (PilotID)
## ##  pilots.ROIAward_detail contains the Award History Records for the Awards or Projects identified in pilots.pilots.roi_awards
##
##
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

SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.ROIAward_detail_work;
##
## ADD Pilot Award Information to Award Data
##
ALTER TABLE pilots.ROIAward_detail_work
	ADD Pilot_ID int(11),
	ADD	PilotPI varchar(25),
	ADD	PilotPI_UFID varchar(12),
    ADD AwardLetterDate datetime null,
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

UPDATE pilots.ROIAward_detail_work pd, pilots.PILOTS_ROI_MASTER lu
SET pd.Pilot_ID=lu.Pilot_ID,
	pd.PilotPI=lu.PilotPI,
    pd.PilotPI_UFID=lu.PilotPI_UFID,
    pd.AwardLetterDate=lu.AwardLetterDate,
	pd.Year_Activiated=lu.Year_Activiated,
    pd.Grant_Title=lu.CLK_AWD_PROJ_NAME
WHERE pd.CLK_AWD_PROJ_ID=lu.CLK_AWD_PROJ_ID
  AND pd.AggLevel="Project";	

###Remove any projects which started before the pilot
SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.ROIAward_detail_work;

SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.ROIAward_detail_work WHERE AwardLetterDate>FUNDS_ACTIVATED;

SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.ROIAward_detail_work WHERE Pilot_ID is Null;



DELETE FROM  pilots.ROIAward_detail_work WHERE AwardLetterDate>FUNDS_ACTIVATED;
SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.ROIAward_detail_work;


SET SQL_SAFE_UPDATES = 0;


DROP TABLE IF EXISTS pilots.PILOTS_ROI_DETAIL;
Create table pilots.PILOTS_ROI_DETAIL AS
SELECT 
	@ROI_Detail_id := @ROI_Detail_id + 1 n,
	Pilot_ID,
	AggLevel,
	CLK_AWD_ID,
	CLK_AWD_PROJ_ID,
	PilotPI,
	PilotPI_UFID,
	Year_Activiated,
	FUNDS_ACTIVATED,
    AwardLetterDate,
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

SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from pilots.PILOTS_ROI_DETAIL;
### DROP TABLE pilots.ROIAward_detail_work

DROP TABLE IF EXISTS pilots.ROI_AWARD_AGG;
CREATE TABLE pilots.ROI_AWARD_AGG AS
	SELECT 	Pilot_ID,
			Concat("AwdID: ",CLK_AWD_ID) AS GrantID ,
			MIN(Grant_Title) AS Grant_Title,
			MIN(Year_Activiated) AS Year_Activiated,
			MIN(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
			MIN(CLK_AWD_PI) AS Grant_PI,
			MIN(CLK_PI_UFID) AS Grant_PI_UFID,
			MIN(REPORTING_SPONSOR_NAME) AS Grant_Sponsor,
			MIN(REPORTING_SPONSOR_AWD_ID) AS Grant_Sponsor_ID,
			SUM(DIRECT_AMOUNT) As Direct,
			SUM(INDIRECT_AMOUNT) As Indirect,
			SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total,
            FORMAT(SUM(SPONSOR_AUTHORIZED_AMOUNT),0) AS Fmt_total
FROM pilots.PILOTS_ROI_DETAIL
WHERE AggLevel="Award"
Group by Pilot_ID, Concat("AwdID: ",CLK_AWD_ID)
UNION ALL
	SELECT 	Pilot_ID,
			Concat("ProjID: ",CLK_AWD_PROJ_ID) AS GrantID ,
			MIN(Grant_Title) AS Grant_Title,
			MIN(Year_Activiated) AS Year_Activiated,
			MIN(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
			MIN(CLK_AWD_PROJ_MGR) AS Grant_PI,
			MIN(CLK_AWD_PROJ_MGR_UFID) AS Grant_PI_UFID,
			MIN(REPORTING_SPONSOR_NAME) AS Grant_Sponsor,
			MIN(REPORTING_SPONSOR_AWD_ID) AS Grant_Sponsor_ID,
			SUM(DIRECT_AMOUNT) As Direct,
			SUM(INDIRECT_AMOUNT) As Indirect,
			SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total,
            FORMAT(SUM(SPONSOR_AUTHORIZED_AMOUNT),0) AS Fmt_total
FROM pilots.PILOTS_ROI_DETAIL
WHERE AggLevel="Project"
Group by Pilot_ID, Concat("ProjID: ",CLK_AWD_PROJ_ID) ;

drop table if exists pilots.PILOTS_GRANT_SUMMARY;
create table pilots.PILOTS_GRANT_SUMMARY as 
SELECT Pilot_ID,
       Grant_Title,
       min(Year_Activiated) as Year_Activiated,
       min(Grant_Sponsor) As Grant_Sponsor,
       min(Grant_Sponsor_ID) AS Grant_Sponsor_ID,
		sum(Direct) AS Direct,
		sum(Indirect) AS Indirect,
		sum(Total) As Total,
       FORMAT(SUM(Total),0) AS Fmt_total
from pilots.ROI_AWARD_AGG
group by Pilot_ID,Grant_Title;



#### This table is for the grants summary for the single Pilot View
DROP TABLE IF EXISTS pilots.ROI_PILOTID_AGG;
CREATE TABLE pilots.ROI_PILOTID_AGG AS
	SELECT 	Pilot_ID,
            Min(Year_Activiated) AS GrantYear,
            GROUP_CONCAT(CONCAT(Grant_Title," (",Year_Activiated,") ",Grant_Sponsor," (",Grant_Sponsor_ID,") $",Fmt_Total)," | ") AS Grant_Summary,
			sum(Direct) AS Direct,
			sum(Indirect) AS Indirect,
			sum(Total) As Total
##FROM pilots.ROI_AWARD_AGG
from pilots.PILOTS_GRANT_SUMMARY
GROUP BY Pilot_ID;

select sum(Total) from pilots.ROI_PILOTID_AGG;
#### This table is for the publication summary for the single Pilot View
DROP TABLE IF EXISTS pilots.PUB_PILOTID_AGG;
CREATE TABLE pilots.PUB_PILOTID_AGG AS
SELECT	Pilot_ID,
		Min(PubYear) AS PubYear,
        Min(PubDate) AS FirstPubDate,
		GROUP_CONCAT(Concat(Citation) ," | ") AS PubSummary
FROM pilots.PILOTS_PUB_MASTER
GROUP BY Pilot_ID;


### pilots.PILOTS_MASTER IS THE ROOT
####### pilots.ROI_PILOTID_AGG are the Grants
####### pilots.PUB_PILOTID_AGG are the publications
SET sql_mode = '';


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

select sum(Total) from pilots.PILOTS_SUMMARY;
## Cleanup
/*
DROP TABLE IF EXISTS pilots.ROIAward_detail_work;
DROP TABLE IF EXISTS pilots.ROI_AWARD_AGG;
DROP TABLE IF EXISTS pilots.PUB_PILOTID_AGG;
DROP TABLE IF EXISTS pilots.ROI_PILOTID_AGG;



*/
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################

#




