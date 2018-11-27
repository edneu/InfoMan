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
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
/*  File Administration Code
DELETE FROM pilots.roi_awards
WHERE roi_awards_id2 IN (40);

select max(roi_awards_id2)+1 from pilots.roi_awards;



create table pilots.roi_awards_master as Select * from pilots.roi_awards;
ALTER TABLE pilots.roi_awards_master CHANGE COLUMN `pilots.roi_awards_master` `roi_awards_master_id` int(11);
*/


###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
### ADMIN CODE TO CREATE pilot_award_master
/*
DROP TABLE IF EXISTS pilots.pilot_award_master;
Create table pilots.pilot_award_master As
SELECT     Pilot_ID,
           Award_Year,
           Category,
           AwardType,
           Cohort,
           Awarded,
           AwardLetterDate,
           Award_Amt,
           Status,
           UFID,
           Email,
           PI_First,
           PI_Last,
           Title,
           Remain_Amt,
           Return_Amt,
           Role,
           Institution,
           NumCollab,
           Begin_Date,
           End_Date,
           NCE_Date,
           PI_DEPT,
           PI_DEPTID,
           PI_DEPTNM,
           Orig_Award_Year,
           ProjectStatus,
		   CiteGrant,
           ORGINAL_AWARD,
           College,
           PI_GENDER,
           PI_DOB,
           AwardeePositionAtApp,
           AwardeeCareerStage,
           Award_HummanSubjectResearch,
           CancerScore,
           AprilPilotID
from lookup.pilots;
*/
select CiteGrant,count(*) from lookup.pilots group by CiteGrant;
select GrantProjectID,count(*) from lookup.pilots group by GrantProjectID;
select GrantNote,count(*) from lookup.pilots group by GrantNote;

select GrantStartNote,count(*) from lookup.pilots group by GrantStartNote;

select VerifiedPub_CitesCTSI,count(*) from lookup.pilots group by VerifiedPub_CitesCTSI;
select VerifiedPub_CitesCTSI_Notes,count(*) from lookup.pilots group by VerifiedPub_CitesCTSI_Notes;

##############  Pilot Pub Admin

;

create table pilots.pilot_pub_master AS
select * from pilots.pilot_pubs;
USE pilots;
 
select count(*) from pilot_pub_master;
select count(distinct Pilot_ID) from pilot_pub_master;

select pilot_id, count(*) from pilots.pilot_pub_master group by Pilot_id;

Alter Table pilots.pilot_pub_master;

UPDATE pilots.pilot_pub_master SET Citation='Samant, S., Jiang, X., Horenstein, R. B., Shuldiner, A. R., Yerges-Armstrong, L. M., Zheng, S., ... & Schmidt, S. (2014). A Semi-physiological Population Pharmacokinetic/Pharmacodynamic Model For The Development Of A Bedside-ready Dosing Algorithm For Clopidogrel.: oiii-3. Clinical Pharmacology & Therapeutics, 95(1), S102.' WHERE pilot_pubs_id2=6;
UPDATE pilots.pilot_pub_master SET  PMID='22689992', PMCID='PMC3387103' WHERE pilot_pubs_id2=13;
UPDATE pilots.pilot_pub_master SET  PMID='26919068', PMCID='' WHERE pilot_pubs_id2=64;
UPDATE pilots.pilot_pub_master SET  PMID='26820234', PMCID='PMC6052867' WHERE pilot_pubs_id2=63;


 
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
WHERE CLK_AWD_ID IN (SELECT DISTINCT CLK_AWD_ID from pilots.roi_awards_master WHERE AggLevel="Award")
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
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT CLK_AWD_PROJ_ID from pilots.roi_awards_master WHERE AggLevel="Project");
##
## ADD Pilot Award Information to Award Data
##
ALTER TABLE pilots.ROIAward_detail_work
	ADD Pilot_ID int(11),
	ADD	PilotPI varchar(25),
	ADD	PilotPI_UFID varchar(12),
	ADD	Year_Activiated int(11),
    ADD Grant_Title varchar(255);

SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.ROIAward_detail_work pd, pilots.roi_awards_master lu
SET pd.Pilot_ID=lu.Pilot_ID,
	pd.PilotPI=lu.PilotPI,
    pd.PilotPI_UFID=lu.PilotPI_UFID,
	pd.Year_Activiated=lu.Year_Activiated,
    pd.Grant_Title=lu.CLK_AWD_PROJ_NAME
WHERE pd.CLK_AWD_ID=lu.CLK_AWD_ID
  AND pd.AggLevel="Award";	

UPDATE pilots.ROIAward_detail_work pd, pilots.roi_awards_master lu
SET pd.Pilot_ID=lu.Pilot_ID,
	pd.PilotPI=lu.PilotPI,
    pd.PilotPI_UFID=lu.PilotPI_UFID,
	pd.Year_Activiated=lu.Year_Activiated,
    pd.Grant_Title=lu.CLK_AWD_PROJ_NAME
WHERE pd.CLK_AWD_PROJ_ID=lu.CLK_AWD_PROJ_ID
  AND pd.AggLevel="Project";	

SET SQL_SAFE_UPDATES = 0;


DROP TABLE IF EXISTS pilots.ROI_Detail;
Create table pilots.ROI_Detail AS
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
FROM pilots.ROI_Detail
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
FROM pilots.ROI_Detail
WHERE AggLevel="Project"
Group by Pilot_ID, Concat("ProjID: ",CLK_AWD_PROJ_ID) ;

#### This table is for the grants summary for the single Pilot View
DROP TABLE IF EXISTS pilots.ROI_PILOTID_AGG;
CREATE TABLE pilots.ROI_PILOTID_AGG AS
	SELECT 	Pilot_ID,
            Min(Year_Activiated) AS GrantYear,
            GROUP_CONCAT(CONCAT(Grant_Title," (",Year_Activiated,") ",Grant_Sponsor," (",Grant_Sponsor_ID,") $",Fmt_Total)," | ") AS Grant_Summary,
			sum(Direct) AS Direct,
			sum(Indirect) AS Indirect,
			sum(Total) As Total
FROM pilots.ROI_AWARD_AGG
GROUP BY Pilot_ID;


#### This table is for the publication summary for the single Pilot View
DROP TABLE IF EXISTS pilots.PUB_PILOTID_AGG;
CREATE TABLE pilots.PUB_PILOTID_AGG AS
SELECT	Pilot_ID,
		Min(PubYear) AS PubYear,
		GROUP_CONCAT(Concat(Citation) ," | ") AS PubSummary
FROM pilots.pilot_pub_master
GROUP BY Pilot_ID;


### pilots.pilot_award_master IS THE ROOT
####### pilots.ROI_PILOTID_AGG are the Grants
####### pilots.PUB_PILOTID_AGG are the publications

drop table if exists pilots.pilots_summary;
CREATE TABLE pilots.pilots_summary AS
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
FROM pilots.pilot_award_master pi 
     LEFT JOIN pilots.ROI_PILOTID_AGG gr ON pi.Pilot_ID=gr.Pilot_ID
     LEFT JOIN pilots.PUB_PILOTID_AGG pb ON pi.Pilot_ID=pb.Pilot_ID;





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
drop table if exists pilots.lu_pilots;
create table pilots.lu_pilots AS
select * from lookup.pilots;

desc pilots.lu_pilots;


drop table if exists pilots.lu_pilots;
create table pilots.lu_pilots AS
select * from lookup.pilots;

desc pilots.pilot_pubs;

desc pilots.roi_awards;



