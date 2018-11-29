

DEsc plan.pubmaster;

### MAY 2018 CTSI GRANT INCLUSION INDICATOR

ALTER TABLE plan.pubmaster ADD May18Grant INT(1);

UPDATE  plan.pubmaster SET May18Grant=0;
UPDATE  plan.pubmaster SET May18Grant=1
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online");


### Common Metrics Pilot Publication
ALTER TABLE plan.pubmaster ADD PilotPub INT(1);
UPDATE  plan.pubmaster SET PilotPub=0;


UPDATE  plan.pubmaster SET PilotPub=1
WHERE PMID in (SELECT DISTINCT PMID FROM pilots.PILOTS_PUB_MASTER WHERE PMID<>"");

## PILOT AWARD ID 
ALTER TABLE plan.pubmaster Drop PilotID;

ALTER TABLE plan.pubmaster ADD Pilot_ID INT(10);
UPDATE plan.pubmaster SET Pilot_ID=NULL;


UPDATE  plan.pubmaster pm , pilots.PILOTS_PUB_MASTER lu
SET pm.Pilot_ID=lu.Pilot_ID
WHERE pm.PMID =lu.PMID
AND pm.PMID <>"";

######################################################################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
######## CREATE A CORE TABLE FROM plan.pubmaster
######## CREATE A SUPPLEMENTAL TABLE WITH THE PROGRAM CATEGORIES

####CORE PUBLICATION TABLE
DROP TABLE IF EXISTS plan.PUB_CORE;
CREATE TABLE plan.PUB_CORE AS
select
	pubmaster_id2,
	PMID,
	PMC,
	NIHMS_Status,
	Citation,
	OnlineLink,
    May18Grant,
	PilotPub,
    Pilot_ID
FROM plan.pubmaster;


SELECT MAX(pubmaster_id2)+1 from plan.PUB_CORE;





select distinct 	NIHMS_Status from plan.PUB_CORE;;




######## TABLE WITH PROGRAM CLASSIFICATIONS
DROP TABLE IF EXISTS plan.PUB_PROGRAM_ASSIGN;
CREATE TABLE plan.PUB_PROGRAM_ASSIGN AS
SELECT 
	pubmaster_id2,
	PMID,
	PMC,
	TranslComm,
	ServiceCenter,
	Informatics,
	CommEng,
	TeamSci,
	TWD,
	KL2,
	TL1,
	Pilots,
	BERD,
	RKS,
	SpPops,
	PCI,
	Multisite,
	Recruitment,
	Metabolomics,
	NetSci,
	PMP,
	Comp_CommEng,
	Comp_Hub_Cap,
	Comp_Inform,
	Comp_NetCap,
	Comp_NetSci,
	Comp_Pilot,
	Comp_PresMed,
	Comp_RschMeth,
	Comp_SvcCtr,
	Comp_TWD,
	Comp_Trans,
	Compmask,
	Comp_HubNet,
	CatCount,
	PrimaryCat,
	OnlineLink
FROM plan.pubmaster;

######################################################################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
######################################################################################
#######################################################################################
######### SCRATCH

###PILOTS RECONCILED
select PMID,PMCID,Citation,Pilot_ID from pilots.PILOTS_PUB_MASTER where PMID not in (select distinct PMID from plan.PUB_CORE);
select count(*) from pilots.PILOTS_PUB_MASTER where PMID not in (select distinct PMID from plan.PUB_CORE);


select count(*) from pilots.PILOTS_PUB_MASTER; ##68
select count(*) from plan.PUB_CORE WHERE PilotPub=1;

select count(DISTINCT PMID) from pilots.PILOTS_PUB_MASTER; ##60
select count(DISTINCT PMID) from plan.PUB_CORE WHERE PilotPub=1;  ##60

SELECT COUNT(*) from plan.PUB_CORE WHERE May18Grant=1 AND PilotPub=1;
SELECT COUNT(*) from plan.PUB_CORE WHERE  PilotPub=1;





###############################################################################
###############################################################################
###############################################################################
###############################################################################
################ NEXT
################ ADD NEW PROGRAM PUBLICATIONS

## CREATE BACKUP
Create table work.Backup_PUB_CORE AS SELECT * from plan.PUB_CORE;

/*
DROP TABLE IF EXISTS plan.PUB_CORE;
CREATE TABLE plan.PUB_CORE AS
SELECT * FROM work.Backup_PUB_CORE;
*/

Alter table plan.PUB_CORE 
ADD ProgReptSrce varchar(80),
ADD ProgOct2018 int(1);

SET SQL_SAFE_UPDATES = 0;
UPDATE plan.PUB_CORE SET ProgOct2018=0,
						 ProgReptSrce=""; 	
SET SQL_SAFE_UPDATES = 1;        

desc plan.PUB_CORE;

SELECT DISTINCT PMID FROM plan.PUB_CORE where NIHMS_Status='Available Online';

select max(pubmaster_id2)+1 from plan.PUB_CORE;

select distinct NIHMS_Status from plan.PUB_CORE;

UPDATE plan.PUB_CORE pc, plan.progressrept_PMID lu
SET pc.ProgOct2018=1,
	pc.ProgReptSrce=lu.ProgReptSrce
WHERE pc.PMID=lu.PMID
AND pc.PMID<>"";

select count(*) from plan.PUB_CORE where ProgOct2018=1;
## RECONCILE
select count(distinct PMID) 
from plan.PUB_CORE 
WHERE PMID in (SELECT DISTINCT PMID FROM plan.progressrept_PMID);

select count(distinct PMID) 
from plan.progressrept_PMID 
WHERE PMID in (SELECT DISTINCT PMID FROM plan.PUB_CORE);



SELECT DISTINCT PMID from plan.PUB_CORE where ProgOct2018=1;
###############################################



################ NEXT
################ ADD NEW PROGRAM PUBLICATIONS

############################################################################################
############################################################################################
############################################################################################
############################################################################################
######### Test PMC MOnitor data
drop table if exists work.test;
create table work.test as
select pc.pubmaster_id2,
       pc.PMID,
       pc.PMC,
       pc.NIHMS_Status,
       pm.PMCID,
       pm.NIHMS_STATUS AS PMCStatus,
	   pm.Grant_numbers,
       pm.CTSI_GRANT,
	   pm.Publication_Date
FROM plan.PUB_CORE pc LEFT JOIN plan.PMCompMonitor pm
          ON pc.PMID=pm.PMID
WHERE  pc.NIHMS_Status<> pm.NIHMS_Status;


UPDATE plan.PUB_CORE pc, plan.PMCompMonitor pm
SET pc.PMC=pm.PMCID
WHERE pubmaster_id2 in (530,587,682,766)
AND pc.PMID=pm.PMID;



ALTER TABLE plan.PUB_CORE ADD PubDate datetime null;


UPDATE plan.PUB_CORE pc, plan.PMCompMonitor pm
SET pc.PubDate=pm.Publication_Date
WHERE pc.PMID=pm.PMID;


ALTER TABLE plan.PUB_CORE ADD PI_NAME varchar(255);


UPDATE plan.PUB_CORE pc, plan.PMCompMonitor pm
SET pc.PI_NAME=pm.PI_NAME
WHERE pc.PMID=pm.PMID;



ALTER TABLE plan.PUB_CORE DROP Grant_Numbers,
                          DROP CTSI_GRANT ;

ALTER TABLE plan.PUB_CORE ADD Grant_Numbers varchar(255),
                          ADD CTSI_GRANT int(1);


UPDATE plan.PUB_CORE pc, plan.PMCompMonitor pm
SET pc.Grant_Numbers=pm.Grant_Numbers,
		pc.CTSI_GRANT=pm.CTSI_GRANT
WHERE pc.PMID=pm.PMID;


Alter table work.getstatus3 ADD NIHMS_STATUS Varchar(255);


UPDATE work.getstatus3 gs , plan.PMCompMonitor pm
SET gs.NIHMS_STATUS=pm.NIHMS_STATUS
WHERE gs.PMID=pm.PMID;


###################################################################
###################################################################
CREATE TABLE plan.BACKUP_PLAN_PUB_CORE2 AS SELECT * FROM plan.PUB_CORE;

DROP TABLE IF EXISTS plan.PUB_CORE;
CREATE TABLE plan.PUB_CORE As SELECT * FROM plan.BACKUP_PLAN_PUB_CORE;

select max(pubmaster_id2) from plan.PUB_CORE;

desc plan.PUB_CORE;


###########################
SELECT NIHMS_STATUS,count(*) from plan.PUB_CORE group by NIHMS_STATUS;

select distinct PMC from PUB_CORE WHERE NIHMS_STATUS="Available Online";


