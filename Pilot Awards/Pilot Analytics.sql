############## PILOT ANALYTICS
############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
#################### ADD ICITE DATA TO PubMaster;
/*
Alter table  pilots.PILOTS_PUB_MASTER
							ADD Total_Citations int(11),
							ADD Citations_per_Year decimal(65,30),
							ADD Expected_Citations_per_Year decimal(65,30),
                            ADD Field_Citation_Rate decimal(65,30),		
							ADD Relative_Citation_Ratio decimal(65,30),	
							ADD NIH_Percentile decimal(12,2);	



SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.PILOTS_PUB_MASTER pp, pilots.PILOT_PUBS_iCite lu
SET            pp.Total_Citations=lu.Total_Citations,
               pp.Citations_per_Year=lu.Citations_per_Year,
               pp.Expected_Citations_per_Year=lu.Expected_Citations_per_Year,
               pp.Field_Citation_Rate=lu.Field_Citation_Rate,
               pp.Relative_Citation_Ratio=lu.Relative_Citation_Ratio,
               pp.NIH_Percentile=lu.NIH_Percentile
WHERE pp.PMID=lu.PubMed_ID;

select * from work.pilotspub;
*/
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
### A publication based file with pilot attributes

DROP table if exists pilots.pilotpub1;
CREATE TABLE pilots.pilotpub1 as SELECT * from
    pilots.PILOTS_PUB_MASTER;


ALTER TABLE pilots.pilotpub1
ADD Pilot_Award_Date datetime null,
ADD Pilot_Close_Date datetime null,
ADD Category varchar(25),
ADD AwardType varchar(125),
ADD Awarded varchar(12),
ADD Award_Amt decimal(12,2),
ADD CRC_STUDY int(1),
ADD College varchar(45),
ADD Pilot_PI varchar(120),
ADD Pilot_Title varchar(255),
ADD Award_HummanSubjectResearch int(11),
ADD IRB_Num varchar(16),
ADD IRB_Approval_Date datetime null,
ADD IRB_Close_Date datetime null;

UPDATE pilots.pilotpub1 pp,
    pilots.PILOTS_MASTER lu 
SET 
    pp.Pilot_Award_Date = lu.AwardLetterDate,
    pp.Pilot_Close_Date = lu.End_Date,
    pp.Category = lu.Category,
    pp.AwardType = lu.AwardType,
    pp.Awarded = lu.Awarded,
    pp.Award_Amt = lu.Award_Amt,
    pp.CRC_STUDY = lu.CRC_STUDY,
    pp.College = lu.College,
    pp.Award_HummanSubjectResearch = lu.Award_HummanSubjectResearch,
    pp.Pilot_PI = concat(trim(PI_Last), ', ', Trim(PI_First)),
    pp.Pilot_Title = lu.Title,
    pp.IRB_Num = lu.IRB_Num,
    pp.IRB_Approval_Date = lu.IRB_Approval_Date,
    pp.IRB_Close_Date = lu.IRB_Close_Date
WHERE
    pp.Pilot_ID = lu.Pilot_ID;






UPDATE pilots.pilotpub1 pp,
    pilots.PILOTS_MASTER lu 
SET 
    pp.Pilot_Close_Date = lu.NCE_Date
WHERE
    pp.Pilot_ID = lu.Pilot_ID
        AND lu.NCE_DATE > pp.Pilot_Close_Date
        AND lu.NCE_DATE IS NOT NULL;

DROP table if exists pilots.pilotpub2;
CREATE TABLE pilots.pilotpub2 as SELECT * from
    pilots.pilotpub1
WHERE
    YEAR(Pilot_Award_Date) >= 2012
        AND Awarded = 'Awarded'
        AND Category NOT IN ('SECIM');


## CREATE TABLE FOR SPSS
DROP TABLE IF EXISTS lookup.pilotpubanalytic;
create table lookup.pilotpubanalytic AS select * from
    pilots.pilotpub2;

select     Category, count(*) from lookup.pilotpubanalytic group by Category;
select     Category, count(DISTINCT Pilot_ID) from lookup.pilotpubanalytic group by Category;

select 
    Category, SUM(Total_Citations)
from
    lookup.pilotpubanalytic
group by Category;

select 
    Category, PMID
from
    lookup.pilotpubanalytic
group by Category , PMID
ORDER by Category;
select 
    AwardType, PMID
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Traditional'
group by AwardType , PMID
ORDER by AwardType;

select 
    AwardType, count(*)
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Traditional'
group by AwardType;

SELECT 
    Category, count(*)
from
    pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category NOT IN ('SECIM')
GROUP BY Category;

SELECT 
    AwardType, count(*)
from
    pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category = 'Traditional'
GROUP BY AwardType;

select 
    AwardType, count(*)
from
    lookup.pilotpubanalytic
where
    Category = 'Traditional'
group by AwardType;
select 
    AwardType, count(DISTINCT Pilot_ID)
from
    lookup.pilotpubanalytic
where
    Category = 'Traditional'
group by AwardType;
select 
    AwardType, SUM(Total_Citations)
from
    lookup.pilotpubanalytic
where
    Category = 'Traditional'
group by AwardType;

########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
######### BUILD GRANT BASED ANALYTIC FILE
Drop table if Exists work.PilotGrant;
CREATE TABLE work.PilotGrant AS SELECT * from
    pilots.PILOTS_ROI_MASTER;




ALTER TABLE work.PilotGrant
ADD Direct decimal(65,20),
ADD Indirect decimal(65,20),
ADD Total_Award decimal(65,20),
ADD nAwards int(5),
ADD Pilot_Award_Date datetime null,
ADD Pilot_Close_Date datetime null,
ADD Fund_Date datetime null,
ADD Category varchar(25),
ADD AwardType varchar(125),
ADD Awarded varchar(12),
ADD Award_Amt decimal(12,2),
ADD CRC_STUDY int(1),
ADD College varchar(45),
ADD Pilot_PI varchar(120),
ADD Pilot_Title varchar(255),
ADD Award_HummanSubjectResearch int(11),
ADD IRB_Num varchar(16),
ADD IRB_Approval_Date datetime null,
ADD IRB_Close_Date datetime null;


UPDATE work.PilotGrant pp,
    pilots.PILOTS_MASTER lu 
SET 
    pp.Pilot_Award_Date = lu.AwardLetterDate,
    pp.Pilot_Close_Date = lu.End_Date,
    pp.Category = lu.Category,
    pp.AwardType = lu.AwardType,
    pp.Awarded = lu.Awarded,
    pp.Award_Amt = lu.Award_Amt,
    pp.CRC_STUDY = lu.CRC_STUDY,
    pp.College = lu.College,
    pp.Award_HummanSubjectResearch = lu.Award_HummanSubjectResearch,
    pp.Pilot_PI = concat(trim(PI_Last), ', ', Trim(PI_First)),
    pp.Pilot_Title = lu.Title,
    pp.IRB_Num = lu.IRB_Num,
    pp.IRB_Approval_Date = lu.IRB_Approval_Date,
    pp.IRB_Close_Date = lu.IRB_Close_Date
WHERE
    pp.Pilot_ID = lu.Pilot_ID;






drop table if Exists work.pilot_tot_awd;
create table work.pilot_tot_awd AS SELECT CLK_AWD_ID,
    Max(1) AS nAwards,
    Min(FUNDS_ACTIVATED) as Fund_Date,
    SUM(DIRECT_AMOUNT) AS Direct,
    SUM(INDIRECT_AMOUNT) As Indirect,
    SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total_Award FROM
    pilots.PILOTS_ROI_DETAIL
WHERE
    AggLevel = 'Award'
GROUP BY CLK_AWD_ID;

select 
    sum(Total_Award)
from
    work.pilot_tot_awd;


drop table if Exists work.pilot_tot_proj;
create table work.pilot_tot_proj AS SELECT CLK_AWD_PROJ_ID,
    Max(1) AS nAwards,
    Min(FUNDS_ACTIVATED) as Fund_Date,
    SUM(DIRECT_AMOUNT) AS Direct,
    SUM(INDIRECT_AMOUNT) As Indirect,
    SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total_Award FROM
    pilots.PILOTS_ROI_DETAIL
WHERE
    AggLevel = 'Project'
GROUP BY CLK_AWD_PROJ_ID;

select 
    sum(Total_Award)
from
    work.pilot_tot_proj;

UPDATE work.PilotGrant pp,
    work.pilot_tot_awd lu 
SET 
    pp.Direct = lu.Direct,
    pp.Indirect = lu.Indirect,
    pp.Total_Award = lu.Total_Award,
    pp.Fund_Date = lu.Fund_Date,
    pp.nAwards = lu.nAwards
WHERE
    pp.CLK_AWD_ID = lu.CLK_AWD_ID
        AND pp.AggLevel = 'Award';

UPDATE work.PilotGrant pp,
    work.pilot_tot_proj lu 
SET 
    pp.Direct = lu.Direct,
    pp.Indirect = lu.Indirect,
    pp.Total_Award = lu.Total_Award,
    pp.Fund_Date = lu.Fund_Date,
    pp.nAwards = lu.nAwards
WHERE
    pp.CLK_AWD_PROJ_ID = lu.CLK_AWD_PROJ_ID
        AND pp.AggLevel = 'Project';

select 
    sum(Total_Award)
from
    work.PilotGrant;

select 
    roi_master_id,
    Pilot_ID,
    AwardLetterDate,
    FUNDS_ACTIVATED,
    Fund_Date,
    Year_Activiated
from
    work.PilotGrant
where
    AwardLetterDate > Funds_Activated;




select 
    Category, count(DISTINCT Pilot_ID)
from
    work.PilotGrant
group by Category;
select 
    Category, Sum(nAwards)
from
    work.PilotGrant
group by Category;
select 
    Category, Sum(Total_Award)
from
    work.PilotGrant
group by Category;


select 
    Category, COUNT(*), Sum(Award_Amt)
from
    pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category NOT IN ('SECIM')
GROUP BY Category;



select 
    AwardType, COUNT(*), Sum(Award_Amt)
from
    pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category IN ('Traditional')
GROUP BY AwardType;

select 
    AwardType, count(DISTINCT Pilot_ID)
from
    work.PilotGrant
WHERE
    Category IN ('Traditional')
group by AwardType;
select 
    AwardType, Sum(nAwards)
from
    work.PilotGrant
WHERE
    Category IN ('Traditional')
group by AwardType;
select 
    AwardType, Sum(Total_Award)
from
    work.PilotGrant
WHERE
    Category IN ('Traditional')
group by AwardType;




select 
    CRC_STUDY, COUNT(*), Sum(Award_Amt)
from
    pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category IN ('Clinical')
GROUP BY CRC_STUDY;

select 
    CRC_STUDY, count(DISTINCT Pilot_ID)
from
    work.PilotGrant
WHERE
    CRC_STUDY
group by CRC_STUDY;
select 
    CRC_STUDY, Sum(nAwards)
from
    work.PilotGrant
WHERE
    Category IN ('Clinical')
group by CRC_STUDY;
select 
    CRC_STUDY, Sum(Total_Award)
from
    work.PilotGrant
WHERE
    Category IN ('Clinical')
group by CRC_STUDY;




select 
    CRC_STUDY, PMID
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Clinical'
group by CRC_STUDY , PMID
ORDER by CRC_STUDY;
select 
    CRC_STUDY, SUM(Total_Citations)
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Clinical'
group by CRC_STUDY;


select 
    CRC_STUDY, count(*)
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Clinical'
group by CRC_STUDY;
select 
    CRC_STUDY, count(DISTINCT Pilot_ID)
from
    lookup.pilotpubanalytic
WHERE
    Category = 'Clinical'
group by CRC_STUDY;


########## ADD Closed Indicatot
## Pubs

UPDATE pilots.pilotpub2 pp, pilots.PILOTS_MASTER lu
SET pp.Pilot_Close_Date=lu.End_Date
WHERE pp.Pilot_ID=lu.Pilot_ID;


SET SQL_SAFE_UPDATES = 0;

ALTER TABLE pilots.pilotpub2 ADD ClosedPilot int(1);
UPDATE pilots.pilotpub2 
SET     ClosedPilot = 0;

UPDATE pilots.pilotpub2 
SET     ClosedPilot = 1
WHERE     Pilot_Close_Date < CURDATE();

SELECT * from 

## GRANTS
UPDATE work.PilotGrant pp, pilots.PILOTS_MASTER lu
SET pp.Pilot_Close_Date=lu.End_Date
WHERE pp.Pilot_ID=lu.Pilot_ID;


ALTER TABLE work.PilotGrant ADD ClosedPilot int(1);
UPDATE work.PilotGrant SET  ClosedPilot = 0;

UPDATE work.PilotGrant SET    ClosedPilot = 1
WHERE  Pilot_Close_Date < CURDATE();

SET SQL_SAFE_UPDATES = 1;
####################################################


DROP TABLE IF Exists pilots.pilot_master_analysis;
Create table pilots.pilot_master_analysis as 
SELECT * from  pilots.PILOTS_MASTER
WHERE
    YEAR(AwardLetterDate) >= 2012
        AND Awarded = 'Awarded'
        AND Category NOT IN ('SECIM');

ALTER TABLE pilots.pilot_master_analysis
ADD PubDate datetime NULL,
ADD GrantDate datetime NULL;

drop table if exists work.pubtemp;
create table work.pubtemp as
select Pilot_ID,
       MIN(PubDate) As PubDate
from pilots.PubAnalysis
GROUP BY Pilot_ID;

UPDATE pilots.pilot_master_analysis ma, work.pubtemp lu
SET ma.PubDate=lu.PubDate
WHERE ma.Pilot_ID=lu.Pilot_ID;

drop table if exists work.granttemp;
create table work.granttemp as
select Pilot_ID,
       MIN(FUNDS_ACTIVATED) As GrantDate
from pilots.ROIAnalysis
GROUP BY Pilot_ID;

UPDATE pilots.pilot_master_analysis ma,  work.granttemp lu
SET ma.GrantDate=lu.GrantDate
WHERE ma.Pilot_ID=lu.Pilot_ID;






ALTER TABLE pilots.pilot_master_analysis ADD ClosedPilot int(1);
UPDATE pilots.pilot_master_analysis SET     ClosedPilot = 0;

UPDATE  pilots.pilot_master_analysis SET ClosedPilot = 1
WHERE End_Date < CURDATE()
AND END_DATE is not Null;

select * from pilots.pilot_master_analysis where ClosedPilot = 0;

UPDATE pilots.PILOTS_MASTER SET Awarded="Withdrew" where Pilot_ID=96;


ALTER TABLE pilots.pilot_master_analysis ADD DaysSinceClosed int(11);
UPDATE pilots.pilot_master_analysis 
SET DaysSinceClosed=ROUND(DATEDIFF(CURDATE(),End_Date),0);

select End_Date,CURDATE(),DaysSinceClosed from pilots.pilot_master_analysis;

ALTER TABLE pilots.pilot_master_analysis ADD HasPub int(1),
                                         ADD HasGrant int(1);

update pilots.pilot_master_analysis SET HasPub=0, HasGrant=0;

update pilots.pilot_master_analysis SET HasPub=1 WHERE PubDate IS NOT NULL;
update pilots.pilot_master_analysis SET HasGrant=1 WHERE GrantDate IS NOT NULL;


SELECT * from pilots.pilot_master_analysis where DaysSinceClosed<0;

ALTER TABLE pilots.pilot_master_analysis 
ADD pubin12mon Int(1),
ADD Awdin12Mon INT(1);



SET SQL_SAFE_UPDATES = 0;

UPDATE pilots.pilot_master_analysis
SET pubin12mon=0 ,
    Awdin12Mon=0;


## CREATE COMPOSITE CATEGORIES
ALTER TABLE pilots.pilot_master_analysis 
	ADD CompCat varchar(40);

UPDATE pilots.pilot_master_analysis
   
SELECT  cATEGORY, aWARDtYPE,CRC_STUDY,COUNT(*) FROM pilots.pilot_master_analysis GROUP BY cATEGORY, aWARDTYPE,CRC_STUDY;

UPDATE pilots.pilot_master_analysis SET CompCat='Clinical - Non-CRC Study' WHERE Category='Clinical' AND AwardType='' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Clinical - CRC Study' WHERE Category='Clinical' AND AwardType='' AND CRC_STUDY=1;
UPDATE pilots.pilot_master_analysis SET CompCat='Communications' WHERE Category='Communication' AND AwardType='' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Communications' WHERE Category='Communication' AND AwardType='Faculty' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Communications' WHERE Category='Communication' AND AwardType='Trainee' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Pipeline' WHERE Category='Pipeline' AND AwardType='Pipeline' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='PRICE' WHERE Category='PRICE' AND AwardType='' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Trad-Junior Faculty' WHERE Category='Traditional' AND AwardType='Junior Faculty' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Trad-Network' WHERE Category='Traditional' AND AwardType='Network' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Trad-Novel Methods' WHERE Category='Traditional' AND AwardType='Novel Methods' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Trad-Trainee' WHERE Category='Traditional' AND AwardType='Trainee' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 1' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=0;
UPDATE pilots.pilot_master_analysis SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=1;
UPDATE pilots.pilot_master_analysis SET CompCat='UFII-CTSI' WHERE Category='UFII-CTSI' AND AwardType='' AND CRC_STUDY=0;

SELECT DISTINCT CompCat from pilots.pilot_master_analysis;


ALTER TABLE pilots.pilot_master_analysis 
ADD Pubdate datetime null,
ADD GrantDate datetime null;




############## CREATE FILE FOR SPSS USE
Drop table if exists pilots.PubAnalysis;
Create table pilots.PubAnalysis AS SELECT * From
    pilots.pilotpub2;


Alter table pilots.PubAnalysis Add Publag decimal (65,20);
UPDATE pilots.PubAnalysis 
SET Publag=ROUND(DATEDIFF(PubDate,Pilot_Award_Date)/(365.25/12),0);


Alter table pilots.PubAnalysis Add PublagEnd decimal (65,20);
UPDATE pilots.PubAnalysis 
SET PublagEnd=ROUND(DATEDIFF(PubDate,Pilot_Close_Date)/(365.25/12),0);

select * from pilots.PubAnalysis WHERE ClosedPilot = 0;

Drop table if exists pilots.ROIAnalysis;
Create table pilots.ROIAnalysis AS SELECT * From
    work.PilotGrant;


select * from pilots.pilot_master_analysis where Category="PRICE";

Alter table pilots.ROIAnalysis Add Grantlag decimal (65,20);
UPDATE pilots.ROIAnalysis
SET Grantlag=ROUND(DATEDIFF(FUNDS_ACTIVATED,AwardLetterDate)/(365.25/12),0);



Alter table pilots.ROIAnalysis Add GrantlagEnd decimal (65,20);
UPDATE pilots.ROIAnalysis
SET GrantlagEnd=ROUND(DATEDIFF(FUNDS_ACTIVATED,Pilot_Close_Date)/(365.25/12),0);




ALTER TABLE pilots.pilot_master_analysis
ADD GrantAmt decimal(65,20),
ADD Citations int(20),
ADD NIHPct decimal(12,2),
ADD RCR decimal(65,20);

DROP TABLE  IF EXISTS work.grantsumm;
CREATE TABLE work.grantsumm As
SELECT Pilot_ID,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalGrantAMT
FROM pilots.PILOTS_ROI_DETAIL
GROUP BY  Pilot_ID;


DROP TABLE  IF EXISTS work.pubsumm1;
CREATE TABLE work.pubsumm1 As
SELECT Pilot_ID,
       MAX(Total_Citations) as nCitations,
       MAX(Relative_Citation_Ratio) as RCR,
       MAX(NIH_Percentile) as NIHPct	
FROM pilots.PILOTS_PUB_MASTER 
GROUP BY Pilot_ID;


UPDATE pilots.pilot_master_analysis ma, work.grantsumm lu
SET ma.GrantAmt=lu.TotalGrantAMT
WHERE ma.Pilot_ID=lu.Pilot_ID;
## Master is pilots.pilot_master_analysis;

UPDATE pilots.pilot_master_analysis ma, work.pubsumm1 lu
SET ma.Citations=lu.nCitations,
	ma.NIHPct=lu.NIHPct,
	ma.RCR=lu.RCR
WHERE ma.Pilot_ID=lu.Pilot_ID;


########### CLOSED AWARD COUNTS

SELECT Category,COUNT(*) from pilots.pilot_master_analysis group by Category;

## Closed by Cateogry
SELECT Category,COUNT(*) from pilots.pilot_master_analysis WHERE ClosedPilot = 1 group by Category;

## Closed by TRANDITONAL AWARD TYPE
SELECT AwardType,COUNT(*) from pilots.pilot_master_analysis WHERE ClosedPilot = 1 AND Category='Traditional' group by AwardType;


## Closed by TRANDITONAL AWARD TYPE
SELECT CRC_STUDY,COUNT(*) from pilots.pilot_master_analysis WHERE ClosedPilot = 1 AND Category='Clinical' group by CRC_STUDY;

select * from pilots.pilot_master_analysis WHERE ClosedPilot = 0 AND Category='Clinical';

###################################
SELECT CompCat,SUM(Award_Amt),SUM(GrantAmt) from pilots.pilot_master_analysis group by CompCat;

SELECT CompCat,AVG(RCR),AVG(NIHPct) from pilots.pilot_master_analysis group by CompCat;

