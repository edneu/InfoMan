############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
########### SQL FOR UPLOADING DATA FROM PILOT SURVEY
############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
#####
######## PUBS TO pilots.PILOTS_PUB_MASTER

### CREATE FORMAT REFERNCE TABLE


DROP TABLE IF EXISTS work.pilot_pub_ref;
CREATE TABLE work.pilot_pub_ref as
SELECT * from pilots.PILOTS_PUB_MASTER 
WHERE PMCID<>""
LIMIT 10;

;

DROP TABLE IF EXISTS work.PubCore_FMT;
CREATE TABLE work.PubCore_FMT as
SELECT * from pubs. PUB_CORE
WHERE PMC<>""
LIMIT 10;

;
SELECT max(Pub_master_ID)+1 from pilots.PILOTS_PUB_MASTER ;


SELECT max(pubmaster_id2)+1 from pubs.PUB_CORE ;


SELECT DISTINCT NIHMS_Status from pubs.PUB_CORE ;

select * from pubs.PUB_CORE;
SELECT max(pubmaster_id2)+1 from pubs.PUB_CORE;

SELECT PMID,PMC,PilotPub,Pilot_ID FROM pubs.PUB_CORE 
WHERE PMID IN 
(
'28049858',
'28431199',
'28794210',
'29478354',
'29494332',
'29495524',
'29637442',
'29641284',
'29932867',
'30001422',
'30049487',
'30165855',
'30366088',
'30427124',
'30429830',
'30563001',
'30563937',
'30579226',
'30637373',
'30652513',
'30724739',
'30947282',
'30949556');



SET SQL_SAFE_UPDATES = 0;


UPDATE pubs.PUB_CORE SET PilotPub=1, Pilot_ID=313 WHERE PMID='28794210';
UPDATE pubs.PUB_CORE SET PilotPub=1, Pilot_ID=338 WHERE PMID='29494332';
UPDATE pubs.PUB_CORE SET PilotPub=1, Pilot_ID=369 WHERE PMID='30165855';
UPDATE pubs.PUB_CORE SET PilotPub=1, Pilot_ID=97 WHERE PMID='30427124';
UPDATE pubs.PUB_CORE SET PilotPub=1, Pilot_ID=102 WHERE PMID='30563001';

SET SQL_SAFE_UPDATES = 1;

###########################
DROP TABLE IF EXISTS work.pilot_grnt_ref;
CREATE TABLE work.pilot_grnt_ref as
SELECT * from pilots.PILOTS_ROI_MASTER
LIMIT 10;



###############

SELECT 	Pilot_ID,
		concat(PI_Last,", ",PI_First) AS Pi_NAME,
        UFID,
        AwardLetterDate
from pilots.PILOTS_MASTER

WHERE Pilot_ID IN
(330,
89,
333,
429,
390,
365,
431,
339,
338,
383,
97,
305,
122,
329,
121,
335,
51,
54,
99,
306,
316,
317,
321,
377,
385,
389,
421,
427,
430
);

#######################

SELECT 	CLK_AWD_ID,
		MIN(Year(FUNDS_ACTIVATED)) as Year_Activated,
		MIN(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
        MIN(CLK_AWD_PI) AS CLK_AWD_PI,
        MIN(CLK_PI_UFID) AS CLK_PI_UFID,
        MIN(CLK_AWD_PROJ_MGR) AS CLK_AWD_PROJ_MGR,
        MIN(CLK_AWD_PROJ_MGR_UFID) AS CLK_AWD_PROJ_MGR_UFID,
        MIN(REPORTING_SPONSOR_NAME) AS REPORTING_SPONSOR_NAME,
        MIN(REPORTING_SPONSOR_AWD_ID) AS REPORTING_SPONSOR_AWD_ID,
        MIN(CLK_AWD_FULL_TITLE)  AS CLK_AWD_FULL_TITLE
FROM lookup.awards_history
WHERE CLK_AWD_ID IN ('AWD05859');

('00094107',
'AWD05640',
'AWD04331',
'AWD02503',
'AWD01497',
'AWD04271',
'00087340',
'00097432',
'00098872',
'AWD04455',
'AWD03880',
'AWD01456',
'AWD05539',
'AWD00350',
'00099133',
'AWD02822')
GROUP BY CLK_AWD_ID
ORDER BY CLK_AWD_ID ;


select   CLK_AWD_ID,CLK_AWD_PROJ_ID,FUNDS_ACTIVATED,CLK_AWD_PROJ_NAME,CLK_AWD_PROJ_MGR,CLK_AWD_PI
FROM lookup.awards_history
WHERE CLK_AWD_ID IN ('00087340');


SELECT 	
		CLK_AWD_PROJ_ID,
		MIN(Year(FUNDS_ACTIVATED)) as Year_Activated,
		MIN(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
        MIN(CLK_AWD_PI) AS CLK_AWD_PI,
        MIN(CLK_PI_UFID) AS CLK_PI_UFID,
        MIN(CLK_AWD_PROJ_MGR) AS CLK_AWD_PROJ_MGR,
        MIN(CLK_AWD_PROJ_MGR_UFID) AS CLK_AWD_PROJ_MGR_UFID,
        MIN(REPORTING_SPONSOR_NAME) AS REPORTING_SPONSOR_NAME,
        MIN(REPORTING_SPONSOR_AWD_ID) AS REPORTING_SPONSOR_AWD_ID,
        MIN(CLK_AWD_FULL_TITLE)  AS CLK_AWD_FULL_TITLE
FROM lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN ('00122588')
GROUP BY CLK_AWD_PROJ_ID;


######## ADD PILOT SURVEY STATUS TO PILOTS_MASTER
ALTER TABLE pilots.PILOTS_MASTER ADD Survey2019 varchar(45);

UPDATE pilots.PILOTS_MASTER pm, pilots.suvery2019status lu
SET pm.Survey2019="Not Included";

UPDATE pilots.PILOTS_MASTER pm, pilots.suvery2019status lu
SET pm.Survey2019=lu.Survey2019
WHERE pm.Pilot_ID=lu.Pilot_ID;

SELECT Survey2019,count(*) from pilots.PILOTS_MASTER group by Survey2019;
############################
############################


select Survey2019,COUNT(Distinct Pilot_ID) from pilots.PILOTS_MASTER
WHERE Survey2019 NOT IN ('Not Included')
AND Category="SECIM"
GROUP BY Survey2019;


SELECT PIlot_ID, CItation
FROM pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID in (422,306,301,307,429,312,299,430);



SELECT * from pilots.PILOTS_ROI_MASTER;

select Max(roi_master_id)+1 from pilots.PILOTS_ROI_MASTER;


SELECT * FROM lookup.awards_history where REPORTING_SPONSOR_AWD_ID like "%R%21%62884%";

create table work.pitemp as 
select roi_master_id,CLK_AWD_PI from pilots.PILOTS_ROI_MASTER;


ALTER TABLE pilots.PILOTS_ROI_MASTER  MODIFY CLK_AWD_PI varchar(45);
ALTER TABLE pilots.PILOTS_ROI_MASTER MODIFY CLK_AWD_PROJ_ID varchar(12) null;

create table pilots.temp as 
select * from pilots.PILOTS_ROI_MASTER where roi_master_id>=53;

desc pilots.PILOTS_ROI_MASTER;


UPDATE pilots.PILOTS_ROI_MASTER
SET CLK_AWD_PROJ_MGR_UFID= LPAD(CLK_AWD_PROJ_MGR_UFID,8,"0"),
	PilotPI_UFID=LPAD(PilotPI_UFID,8,"0"),
    CLK_PI_UFID=LPAD(CLK_PI_UFID,8,"0");

###############################################

SELECT Category,Pilot_ID,AwardeePositionAtApp   ,AwardeeCareerStage, UFID, PI_Last,PI_First ,Award_Year,Awarded   
      FROM pilots.PILOTS_MASTER
      WHERE  Pilot_ID IN (SELECT DISTINCT PILOT_ID FROM pilots.PILOTS_SUMMARY)
      AND (AwardeeCareerStage IS NULL or AwardeeCareerStage="N/A")
      AND Awarded="Awarded"
      AND Category<>"SECIM"
      AND Award_Year>=2012;
      

DROP TABLE IF EXISTS work.fixstage;
CREATE TABLE work.fixstage AS
SELECT Pilot_ID,UFID 
      FROM pilots.PILOTS_MASTER
      WHERE  Pilot_ID IN (SELECT DISTINCT PILOT_ID FROM pilots.PILOTS_SUMMARY)
      AND (AwardeeCareerStage IS NULL or AwardeeCareerStage="N/A")
      AND Awarded="Awarded"
      AND Category<>"SECIM"
      AND Award_Year>=2012;
      
ALTER TABLE  work.fixstage 	ADD Job_Code varchar(45),
							ADD Salary_Plan varchar(255),
							ADD FacType varchar(25);
                            
UPDATE work.fixstage fs, lookup.Employees lu
SET fs.Job_Code=lu.Job_Code,
	fs.Salary_Plan=lu.Salary_Plan,
    fs.FacType=lu.FacType
WHERE fs.UFID=lu.Employee_ID;
    ;
                            
SELECT * from work.fixstage;

SELECT DISTINCT  AwardeeCareerStage from pilots.PILOTS_MASTER;
UPDATE pilots.PILOTS_MASTER SET AwardeeCareerStage='Junior Faculty' WHERE AwardeeCareerStage='Junior';
UPDATE pilots.PILOTS_MASTER SET AwardeeCareerStage='Mid Career Faculty' WHERE AwardeeCareerStage='Mid-Career';
UPDATE pilots.PILOTS_MASTER SET AwardeeCareerStage='Senior Faculty' WHERE AwardeeCareerStage='Senior';

SELECT DISTINCT FacType from lookup.Employees;  
     
     
ALTER TABLE work.fixstage ADD AwardeeCareerStage varchar(45);

UPDATE work.fixstage SET AwardeeCareerStage='Junior Faculty' WHERE FacType='Assistant Professor';
UPDATE work.fixstage SET AwardeeCareerStage='Mid Career Faculty' WHERE FacType='Associate Professor';
UPDATE work.fixstage SET AwardeeCareerStage='Senior Faculty' WHERE FacType='Professor';
UPDATE work.fixstage SET AwardeeCareerStage='Senior Faculty' WHERE FacType='Professor';
UPDATE work.fixstage SET AwardeeCareerStage='Trainee' WHERE FacType='Trainee';


SELECT * from work.fixstage;

UPDATE pilots.PILOTS_MASTER pm, work.fixstage lu
SET pm.AwardeeCareerStage=lu.AwardeeCareerStage
WHERE pm.Pilot_ID=lu.Pilot_ID;

###############################################
SELECT * from pilots.PILOTS_SUMMARY WHERE PI_GENDER is Null
AND  Award_Year>=2012 AND Award_Year<2019
AND Awarded="Awarded"
AND ProjectStatus<>"Ongoing"
AND Category NOT IN ("SECIM");

UPDATE pilots.PILOTS_MASTER SET PI_GENDER="F" WHERE Pilot_ID=400;

###############################################
SELECT Pilot_ID,Category,AwardType,PI_Last,Title from pilots.PILOTS_SUMMARY WHERE Award_HummanSubjectResearch is Null
AND  Award_Year>=2012 AND Award_Year<2019
AND Awarded="Awarded"
AND ProjectStatus<>"Ongoing"
AND Category NOT IN ("SECIM");

UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=1 WHERE Pilot_ID=400;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=418;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=442;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=443;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=444;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=445;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=446;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=1 WHERE Pilot_ID=447;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=448;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=1 WHERE Pilot_ID=449;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=450;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=451;
UPDATE pilots.PILOTS_MASTER SET Award_HummanSubjectResearch=0 WHERE Pilot_ID=452;




###############################################      
	
## Per Angela

UPDATE pilots.PILOTS_MASTER
SET  ProjectStatus='Completed'
 WHERE Pilot_ID IN
 (121,122,118,120,114,115,390,380,381,391,392,400,338,339,340,341,351,352,365,366,368,369,103,389,385,418 );
 
 
 UPDATE pilots.PILOTS_MASTER
SET  Status='Completed'
 WHERE Pilot_ID IN
 (121,122,118,120,114,115,390,380,381,391,392,400,338,339,340,341,351,352,365,366,368,369,103,389,385,418 );






UPDATE pilots.PILOTS_MASTER SET College='Journalism and Communications' WHERE Pilot_ID=382;
UPDATE pilots.PILOTS_MASTER SET College='Journalism and Communications' WHERE Pilot_ID=387;
UPDATE pilots.PILOTS_MASTER SET College='Journalism and Communications' WHERE Pilot_ID=386;
UPDATE pilots.PILOTS_MASTER SET College='Health and Human Performance' WHERE Pilot_ID=385;
UPDATE pilots.PILOTS_MASTER SET College='Health and Human Performance' WHERE Pilot_ID=380;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=388;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=383;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=381;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=384;
UPDATE pilots.PILOTS_MASTER SET College='Nursing' WHERE Pilot_ID=389;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=399;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=400;
UPDATE pilots.PILOTS_MASTER SET College='Medicine Jacksonville' WHERE Pilot_ID=401;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=402;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=403;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=404;
UPDATE pilots.PILOTS_MASTER SET College='Health and Human Performance' WHERE Pilot_ID=405;
UPDATE pilots.PILOTS_MASTER SET College='PHHP-COM' WHERE Pilot_ID=406;
UPDATE pilots.PILOTS_MASTER SET College='Engineering' WHERE Pilot_ID=407;
UPDATE pilots.PILOTS_MASTER SET College='Engineering' WHERE Pilot_ID=408;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=409;
UPDATE pilots.PILOTS_MASTER SET College='Engineering' WHERE Pilot_ID=410;
UPDATE pilots.PILOTS_MASTER SET College='Pharmacy' WHERE Pilot_ID=411;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=412;
UPDATE pilots.PILOTS_MASTER SET College='Medicine' WHERE Pilot_ID=413;



##################################
select * from pilots.PILOTS_MASTER WHERE Award_Year=2017
AND Pilot_ID in (SELECT DISTINCT Pilot_ID from pilots.PILOTS_ROI_MASTER)
AND Category NOT IN ("SECIM");

SELECT * FROM pilots.PILOTS_ROI_MASTER WHERE Pilot_ID=389;


#############################
SELECT *  FROM pilots.PILOTS_SUMMARY Where ROIRelatedGrant=1 AND ProjectStatus<>"Completed";
