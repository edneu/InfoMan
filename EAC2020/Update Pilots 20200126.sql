

select * from pilots.PILOTS_MASTER
WHERE PI_Last like "%modave%";

select * from pilots.PILOTS_MASTER
WHERE Pilot_ID in 
(93,
97,
99,
101,
102,
385,
387,
389);


drop table if exists pilots.temp;
create table pilots.temp as
Select * from pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID in 
(93,
97,
99,
101,
102,
385,
387,
389)
ORDER BY PILOT_ID;

select max(pub_master_id)+1 from pilots.PILOTS_PUB_MASTER;


## BACKUP pilots.PILOTS_PUB_MASTER

CREATE TABLE loaddata.PubMaster_BU as select * from pilots.PILOTS_PUB_MASTER;
  ## APPEND FROM EXCEL WORK LHSPilots_FSUSeed_PubsGrants.xlsx


##############
##Grants


drop table if exists pilots.temp;
create table pilots.temp as
Select * from pilots.PILOTS_ROI_MASTERPILOTS_ROI_MASTER
WHERE Pilot_ID in 
(93,
97,
99,
101,
102,
385,
387,
389)
ORDER BY PILOT_ID;

select * from lookup.awards_history
WHERE REPORTING_SPONSOR_AWD_ID like "%R21%AG062884%";

select * from lookup.awards_history
WHERE CLK_AWD_PROJ_MGR like "%Lucero%";


select max(roi_master_id)+1 from pilots.PILOTS_ROI_MASTER;

###BAckup Pilots Awards Master
Create table loaddata.BU_ROI_MASTER as select * from pilots.PILOTS_ROI_MASTER;

SET SQL_SAFE_UPDATES = 0;
delete from pilots.PILOTS_ROI_MASTER where roi_master_id=70;
UPDATE pilots.PILOTS_ROI_MASTER set roi_master_id= 70 WHERE roi_master_id=71;

select * from pilots.PILOTS_ROI_MASTER where roi_master_id= 70;

drop table if exists pilots.temp;
create table pilots.temp as


SELECT 
CLK_AWD_ID,
CLK_AWD_PROJ_ID,
" " AS PilotPI,
" " AS PilotPI_UFID,
Year(FUNDS_ACTIVATED) AS Year_Activiated,
FUNDS_ACTIVATED AS FUNDS_ACTIVATED,
CLK_AWD_PI,
CLK_PI_UFID,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_AWD_ID,
CLK_AWD_PROJ_NAME,
" " AS AwardLetterDate,
"  " AS SponsorType,
"  " AS AwardType,
"  " AS SUMMCAT
 FROM lookup.awards_history 
 where CLK_AWD_PI  like "%Salloum%"
 AND REPORTING_SPONSOR_NAME = 'FL DEPT OF HLTH BIOMED RES PGM/J&E KING';
 
 
 AND REPORTING_SPONSOR_NAME like "PATIENT-CENTERED%";
 
 
 SELECT Pilot_ID, 
		concat(PI_Last,", ",PI_First) as Pilot_PI,
		UFID As Pilot_PI_UFID,
        AwardLetterDate
FROM pilots.PILOTS_MASTER
WHERE Pilot_ID = 102;        
        
 
select SponsorType,AwardType,SUMMCAT from pilots.PILOTS_ROI_MASTER group by SponsorType,AwardType,SUMMCAT;

