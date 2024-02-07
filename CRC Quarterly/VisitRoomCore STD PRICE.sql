
### MakeAllStatus VisitRoomCore

#######################################################################################
# 0 or null=not entered
# 1=Scheduled
# 2=Completed
# 3=Begun
# 4=No-show
# 5=Request cancelled
# 6=Requested
# 7=Request denied
# 8=Stopped prematurely
# 9=Re-scheduling requested



#######################################################################################
#######################################################################################
#######################################################################################
## CREATE VISITCORE TABLE 1 Records Per Visit Outpatient, Inpatient, and Scatterbed.
#######################################################################################
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.visitcore; 
CREATE TABLE ctsi_webcamp_adhoc.visitcore 
Select 	"OutPatient" AS VisitType,
		UNIQUEFIELD AS VisitID,
        VISITDATE AS VisitStartDate,
        VISITDATE AS VisitEndDate,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS VisitStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS VisitEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        PERSON as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID
from ctsi_webcamp_pr.opvisit
## WHERE STATUS in (2) 
UNION ALL
Select 	"Inpatient" AS VisitType,
		UNIQUEFIELD AS VisitID,
        ADMITDATE AS VisitStartDate,
        DISCHDATE AS VisitEndDate,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS VisitStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS VisitEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        PERSON as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID
from ctsi_webcamp_pr.admissio
## WHERE STATUS in (2) 
UNION ALL
Select 	"ScatterBed" AS VisitType,
		UNIQUEFIELD AS VisitID,
        ADMITDATE AS VisitStartDate,
        DISCHDATE AS VisitEndDate,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS VisitStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS VisitEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        trim(PERSON) as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID
from ctsi_webcamp_pr.sbadmissio;
## WHERE STATUS in (2);


SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.PIPersonID=lu.PERSON
WHERE vc.ProtocolID=lu.UNIQUEFIELD
AND vc.PIPersonID IS NULL; 


ALTER TABLE ctsi_webcamp_adhoc.visitcore
ADD PI_NAME varchar(55),
ADD Title varchar(255),  ## maxLength=641
ADD CRCNumber varchar(25),
ADD PatientName varchar(125),
ADD ParticipantID varchar(15),
ADD VisitStart datetime,
ADD VisitEnd datetime,
ADD VisitLenMin decimal(30,2),
ADD Month Varchar(12),
ADD SFY varchar(25),
ADD Quarter varchar(25);


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.person lu
SET vc.PI_NAME=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE vc.PIPersonID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.patient lu
SET vc.PatientName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME),
    vc.ParticipantID=lu.PATIENT
WHERE vc.PatientID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.Title=lu.LONGTITLE,
	vc.CRCNumber=lu.Protocol
WHERE vc.ProtocolID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitStart=CONVERT(VisitStartDate, DATETIME),
	VisitEnd=CONVERT(VisitEndDate, DATETIME)
WHERE VisitStartTime is Not Null;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitStart=CONVERT(VisitStartDate, DATETIME),
	VisitEnd=CONVERT(VisitEndDate, DATETIME);

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitStart=ADDTIME(CONVERT(VisitStartDate, DATETIME), VisitStartTIme)
WHERE VisitStartTime is Not Null;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitEnd=ADDTIME(CONVERT(VisitEndDate, DATETIME), VisitEndTIme)
WHERE VisitEndTIme IS NOT NULL;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitLenMin=TIMESTAMPDIFF(MINUTE,VisitStart,VisitEnd);
   
UPDATE ctsi_webcamp_adhoc.visitcore 
   SET VisitEnd=DATE_ADD(VisitEnd, INTERVAL 1 DAY)
WHERE VisitLenMin<0;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitLenMin=TIMESTAMPDIFF(MINUTE,VisitStart,VisitEnd);

UPDATE ctsi_webcamp_adhoc.visitcore
SET MONTH=concat(Year(VisitEnd),"-",lpad(month(VisitEnd),2,"0"));   ## Changed to VisitEnd May 3, 2023

UPDATE ctsi_webcamp_adhoc.visitcore vt, ctsi_webcamp_adhoc.sfy_classify lu
SET vt.SFY=lu.SFY,
	vt.Quarter=lu.Quarter
WHERE vt.Month=lu.Month;    


#### CREATE VISITS CONSOLIDATED TABLE
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.visits; 
CREATE TABLE ctsi_webcamp_adhoc.visits
SELECT 	Month,
        SFY,
        Quarter,
        VisitType,
		VisitID,
        CRCNumber,
        VisitStart,
        VisitEnd,
        VisitLenMin,
        VisitStatus,
        ProtocolID,
        PIPersonID,
        BedID,
        PatientID,
        ParticipantID,
        PatientName,
        PI_NAME,
        Title
FROM ctsi_webcamp_adhoc.visitcore;        

#######################################################################################
#######################################################################################
## CREATE CORE SERVICE LOOKUP Multiple Records per VISIT
#######################################################################################
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU2;
Create table  ctsi_webcamp_adhoc.CoreSvcLU2 AS
SELECT "OutPatient" AS VisitType,
	    OPVISIT AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcStartDate,
        ENDDATE as CoreSvcEndDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE OPVISIT in (SELECT VisitID FROM ctsi_webcamp_adhoc.visits WHERE VisitType="OutPatient")
UNION ALL
SELECT "Inpatient" AS VisitType,
		ADMISSIO AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcStartDate,
        ENDDATE as CoreSvcEndDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE ADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visits WHERE VisitType="Inpatient")
UNION ALL
SELECT "ScatterBed" AS VisitType,
		SBADMISSIO AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcStartDate,
        ENDDATE as CoreSvcEndDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE SBADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visits WHERE VisitType="ScatterBed");


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcNoVIsit;
Create table  ctsi_webcamp_adhoc.CoreSvcNoVIsit AS
SELECT "No Visit" AS VisitType,
		0 AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS ProtocolID,
        STARTDATE as CoreSvcStartDate,
        ENDDATE as CoreSvcEndDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
from ctsi_webcamp_pr.coreservice
WHERE UNIQUEFIELD NOT IN (SELECT DISTINCT CoreSvcID from ctsi_webcamp_adhoc.CoreSvcLU2);


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU1;
Create table  ctsi_webcamp_adhoc.CoreSvcLU1 AS
SELECT * from ctsi_webcamp_adhoc.CoreSvcLU2
UNION ALL 
SELECT * from ctsi_webcamp_adhoc.CoreSvcNoVIsit;


##### ADD Attributes to CORESERVICE Lookup

ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU1
ADD CoreSvcStart datetime,
ADD CoreSvcEnd datetime,
ADD CoreSvcLenDurMin decimal(30,2);


UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET CoreSvcStart=ADDTIME(CONVERT(CoreSvcStartDate, DATETIME), CoreSvcStartTime)
WHERE CoreSvcStartTime IS NOT NULL;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET	CoreSvcEnd=ADDTIME(CONVERT(CoreSvcEndDate, DATETIME), CoreSvcEndTime)
WHERE CoreSvcEndTime IS NOT NULL    
;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET CoreSvcStart=CoreSvcStartDate,
	CoreSvcEnd=CoreSvcEndDate
WHERE CoreSvcStartTime IS NULL OR CoreSvcEndTime IS NULL;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET CoreSvcLenDurMin=TIMESTAMPDIFF(MINUTE,CoreSvcStart,CoreSvcEnd);

UPDATE ctsi_webcamp_adhoc.CoreSvcLU1 
   SET CoreSvcEnd=DATE_ADD(CoreSvcEnd, INTERVAL 1 DAY)
WHERE CoreSvcLenDurMin<0;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET CoreSvcLenDurMin=TIMESTAMPDIFF(MINUTE,CoreSvcStart,CoreSvcEnd);


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU;
Create table  ctsi_webcamp_adhoc.CoreSvcLU AS
SELECT cs.VisitType,
	cs.VisitID,
	cs.CoreSvcID,
	cs.CoreSvcProtocolID,
	MIN(cs.CoreSvcStart) AS CoreSvcStart,
    MAX(cs.CoreSvcEnd) AS CoreSvcEnd,
    MAX(cs.CoreSvcLenDurMin) AS CoreSvcLenDurMin,
	MAX(cs.CoreSvcQuant) as CoreSvcQuant,
	MAX(cs.CoreSvcStatus) as CoreSvcStatus,
    MAX(cs.CoreSvcRelatedTo) AS CoreSvcRelatedTo,
	MAX(cs.LabID) AS LabID,
	MAX(cs.LabTestID) AS LabTestID,
	MAX(pp.PERSON) AS ProvPersonID
from ctsi_webcamp_adhoc.CoreSvcLU1 cs 
LEFT JOIN ctsi_webcamp_pr.coreservice_personprovider pp
ON cs.CoreSvcID = pp.CORESERVICE 
GROUP BY cs.VisitType,
	     cs.VisitID,
	     cs.CoreSvcID,
         cs.CoreSvcProtocolID;

## select * from ctsi_webcamp_adhoc.CoreSvcLU1 where CoreSvcID=338283;


ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU
ADD VisitFacility varchar(45),
ADD Service varchar(100),
ADD ProvPersonName varchar(100),
ADD ProtoSpecRate int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.lab lu
SET cs.VisitFacility=lu.LAB
WHERE cs.LabID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.labtest lu
SET cs.Service=lu.LABTEST
WHERE cs.LabTestID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.coreservice_personprovider lu
SET cs.ProvPersonID=PERSON
WHERE cs.CoreSvcID=lu.CORESERVICE;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.person lu
SET cs.ProvPersonName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE cs.ProvPersonID=lu.UNIQUEFIELD;



######################################################################################
#########################################################################################################################
################### CREATE VISITROOM FILE FOR NO VISIT Records (i.e. CORESERVICE but no visit, ADMIN, SETUP, etc.)
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.NoVisitProtocollu; 
CREATE TABLE ctsi_webcamp_adhoc.NoVisitProtocollu As
SELECT  pt.UNIQUEFIELD AS ProtocolID,
		pt.Protocol AS CRCNumber,
	    pt.PERSON   AS PIPersonID,
        CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME) AS PI_NAME,
        pt.LONGTITLE AS Title
FROM ctsi_webcamp_pr.protocol pt LEFT JOIN ctsi_webcamp_pr.PERSON lu ON pt.PERSON=lu.UNIQUEFIELD
WHERE pt.UNIQUEFIELD IN (SELECT DISTINCT ProtocolID from ctsi_webcamp_adhoc.coresvcnovisit);

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.NoVisitVist1; 
CREATE TABLE ctsi_webcamp_adhoc.NoVisitVist1 As
Select 	CoreSvcProtocolID as ProtocolID,
		"No Visit" as VisitType,
		CoreSvcStart AS VisitStart,
        CoreSvcEnd AS VisitEnd,
        CoreSvcStatus AS VisitStatus
from ctsi_webcamp_adhoc.coresvclu
WHERE VisitType="No Visit" ;


ALTER TABLE ctsi_webcamp_adhoc.NoVisitVist1 
	ADD MONTH varchar(12),
	ADD SFY varchar(25),
	ADD Quarter varchar(25),
    ADD VisitID int(20),
    ADD CRCNumber varchar(25),
    ADD VisitLenMin decimal(30,2),
    ADD PIPersonID varchar(20),
    ADD BedID int(20),
    ADD PatientID int(20),
    ADD ParticipantID varchar(15),
    ADD PatientName varchar(125),
    ADD PI_NAME varchar(55),
    ADD Title varchar(255),
    ADD RoomLUID int(20),
    ADD Bed varchar(15),
    ADD RoomID int(20),
    ADD Room varchar(12);
 

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.NoVisitVist1
SET VisitID = 0,
	BedID = NULL,
	PatientID = NULL,
    ParticipantID = NULL,
    PatientName = NULL,
    Bed = Null,
    RoomID = NULL,
    Room = NULL;
    
UPDATE ctsi_webcamp_adhoc.NoVisitVist1 nv,  ctsi_webcamp_adhoc.NoVisitProtocollu lu
SET nv.CRCNumber=lu.CRCNumber,
	nv.PIPersonID=lu.PIPersonID,
	nv.PI_NAME=lu.PI_NAME,
	nv.Title=lu.Title
WHERE nv.ProtocolID=lu.ProtocolID;    

UPDATE ctsi_webcamp_adhoc.NoVisitVist1
SET MONTH=concat(Year(VisitEnd),"-",lpad(month(VisitEnd),2,"0")); 

UPDATE ctsi_webcamp_adhoc.NoVisitVist1 vt, ctsi_webcamp_adhoc.sfy_classify lu
SET vt.SFY=lu.SFY,
	vt.Quarter=lu.Quarter
WHERE vt.Month=lu.Month; 

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.NoVisitVist; 
CREATE TABLE ctsi_webcamp_adhoc.NoVisitVist AS
SELECT 	Month,
        SFY,
        Quarter,
        VisitType,
		VisitID,
        VisitStart,
        VisitEnd,
        VisitLenMin,
        VisitStatus,
        PatientID,
        ParticipantID,
        PatientName,
        ProtocolID,
        PIPersonID,
        PI_NAME,
        Title,
        CRCNumber,
        RoomLUID,
        Bed,
        RoomID,
        Room
FROM ctsi_webcamp_adhoc.NoVisitVist1;        


#######################################################################################
#######################################################################################
### BUILD ROOM LOOKUP
#######################################################################################
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.RoomLookup; 
CREATE TABLE ctsi_webcamp_adhoc.RoomLookup As
SELECT VisitType,
	   VisitID,
       BedID
 FROM ctsi_webcamp_adhoc.visits
GROUP BY VisitType,
	     VisitID,
         BedID;
  
ALTER TABLE ctsi_webcamp_adhoc.RoomLookup
ADD Bed VARCHAR(15),
ADD RoomID bigint(20),
ADD Room varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.RoomLookup rl, ctsi_webcamp_pr.bed lu
SET rl.RoomID=lu.room,
    rl.Bed=lu.bed
WHERE rl.BedID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.RoomLookup rl, ctsi_webcamp_pr.room lu
SET rl.Room=lu.room
WHERE rl.RoomID=lu.UNIQUEFIELD;

/*
SELECT * from ctsi_webcamp_adhoc.RoomLookup; 
*/


#######################################################################################
#######################################################################################
## CREATE Intermediate table of VISITS and Room 
#######################################################################################
#######################################################################################

### DROP INDEX vcvi ON ctsi_webcamp_adhoc.visits;
### DROP INDEX rlvi ON ctsi_webcamp_adhoc.RoomLookup;

CREATE INDEX vcvi ON ctsi_webcamp_adhoc.visits (VisitID);
CREATE INDEX rlvi ON ctsi_webcamp_adhoc.RoomLookup (VisitID);

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VisitRoom; 
CREATE TABLE ctsi_webcamp_adhoc.VisitRoom As
SELECT     vc.Month,
           vc.SFY, 
           vc.Quarter, 
           vc.VisitType,
           vc.VisitID,	
           vc.VisitStart,
		   vc.VisitEnd,
		   vc.VisitLenMin,
           vc.VisitStatus,
           vc.PatientID,
           vc.ParticipantID,
           vc.PatientName,
           vc.ProtocolID,
           vc.PIPersonID,
           vc.PI_NAME,
           vc.Title,
           vc.CRCNumber,
           rl.BedID AS RoomLUID,
           rl.Bed,
           rl.RoomID,
           rl.Room
FROM ctsi_webcamp_adhoc.visits vc
	LEFT JOIN ctsi_webcamp_adhoc.RoomLookup rl
    ON vc.VisitType=rl.VisitType
    AND vc.VisitID=rl.VisitID
UNION ALL
SELECT * from ctsi_webcamp_adhoc.NoVisitVist;
 

#######################################################################################
#######################################################################################
## CREATE Final Table Visits-Room-CoreServices
#######################################################################################
####################################################################################### 
/*
ALTER TABLE ctsi_webcamp_adhoc.VisitRoom ADD MergeKey varchar(130);
ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU ADD MergeKey varchar(130);


select concat(trim(VisitType),"*",trim(VisitID),"*",trim(ProtocolID)) from ctsi_webcamp_adhoc.VisitRoom WHERE VisitID is null ; 
*/


CREATE INDEX vrvi ON ctsi_webcamp_adhoc.VisitRoom (VisitID);
CREATE INDEX csvi ON ctsi_webcamp_adhoc.CoreSvcLU (VisitID);
CREATE INDEX vrvip ON ctsi_webcamp_adhoc.VisitRoom (ProtocolID);
CREATE INDEX vrvip ON ctsi_webcamp_adhoc.CoreSvcLU (CoreSvcProtocolID);

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VisitRoomCore; 
CREATE TABLE ctsi_webcamp_adhoc.VisitRoomCore As
SELECT 
	       vr.VisitType,
           vr.VisitID,
           vr.Month,
           vr.SFY,
           vr.Quarter,
           vr.VisitStart,
		   vr.VisitEnd,
		   vr.VisitLenMin,
           vr.VisitStatus,
           vr.PatientID,
           vr.ParticipantID,
           vr.PatientName,
           vr.ProtocolID,
           vr.PIPersonID,
           vr.PI_NAME,
           vr.Title,
           vr.CRCNumber,
           vr.RoomID,
           vr.Room,
          cr.CoreSvcID,
          cr.CoreSvcProtocolID,
          cr.CoreSvcStart,
          cr.CoreSvcEnd,
          cr.CoreSvcLenDurMin,
          cr.CoreSvcQuant,
          ##cr.UnitOfService,
          cr.CoreSvcStatus,
          cr.CoreSvcRelatedTo,
          cr.LabID,
          cr.LabTestID,
          cr.ProvPersonID,
          cr.VisitFacility,
          cr.Service,
          ## cr.SvcUnitCost,
          ## cr.BillingUnitSrvc,
          ##cr.Amount,
          cr.ProvPersonName,
          cr.ProtoSpecRate
FROM ctsi_webcamp_adhoc.VisitRoom vr
LEFT JOIN ctsi_webcamp_adhoc.CoreSvcLU cr
ON vr.VisitType=cr.VisitType
AND vr.VisitID=cr.VisitID
AND vr.ProtocolID=cr.CoreSvcProtocolID;

## Remove VISIT RECORDS WITH NO CORE SERVICE RECORD
DELETE FROM ctsi_webcamp_adhoc.VisitRoomCore where CoreSvcID is null;

Select * from ctsi_webcamp_adhoc.VisitRoomCore;
DESC ctsi_webcamp_adhoc.VisitRoomCore;

ALTER TABLE ctsi_webcamp_adhoc.VisitRoomCore
ADD PatientDOB datetime,
ADD AgeAtDOS decimal(65,10);

UPDATE ctsi_webcamp_adhoc.VisitRoomCore vrc, ctsi_webcamp_pr.patient lu
SET vrc.PatientDOB=lu.DOB
WHERE vrc.PatientID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.VisitRoomCore 
SET AgeAtDOS=TRUNCATE(ABS(DATEDIFF(PatientDOB,VisitStart))/365.25,0);


SELECT PatientDOB, VisitStart, AgeAtDOS from ctsi_webcamp_adhoc.VisitRoomCore;

select PatientDOB,count(*) from ctsi_webcamp_adhoc.VisitRoomCore group by PatientDOB;

#######################################################################################

######################################################################################
######################################################################################
######################################################################################
######################################################################################
#######################################################################################
###PRICING
######################################################################################
######################################################################################
######## STD PRICE

drop table if exists ctsi_webcamp_adhoc.STD_PRICE;
create table ctsi_webcamp_adhoc.STD_PRICE AS
SELECT LabTestID,Service
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE LabTestID is not NULL
GROUP BY LabTestID,Service;

Alter Table ctsi_webcamp_adhoc.STD_PRICE
ADD QUANTITYTYPE int(5),
ADD Quantitylabel varchar(20),
ADD BillingUnit varchar(20),
ADD UnitCost decimal(65,10),
ADD StdBillAmt decimal(65,10);

## CREATE SINGLECOST TABLE
drop table if exists ctsi_webcamp_adhoc.singlecost;
Create table ctsi_webcamp_adhoc.singlecost as
SELECT 	Labtest,
        max(DEFAULTCOST) as maxcost 
from ctsi_webcamp_pr.labtestcost
where DEFAULTCOST is NOT NULL
group by Labtest;

SET SQL_SAFE_UPDATES = 0;

Update ctsi_webcamp_adhoc.STD_PRICE sp, ctsi_webcamp_adhoc.singlecost lu
SET sp.UnitCost=lu.maxcost 
WHERE sp.LabTestID=lu.labtest;

UPDATE ctsi_webcamp_adhoc.STD_PRICE sp, ctsi_webcamp_pr.labtest lu
SET sp.QUANTITYTYPE=lu.QUANTITYTYPE,
	sp.Quantitylabel=lu.QUANTITYLABEL
WHERE sp.labtestid=lu.UNIQUEFIELD;

Update ctsi_webcamp_adhoc.STD_PRICE sp, ctsi_webcamp_adhoc.singlecost lu
SET sp.UnitCost=lu.maxcost 
WHERE sp.LabTestID=lu.labtest;

### FILL IN Missing  WITH PROTOCOL RATES
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.protorate;
CREATE TABLE ctsi_webcamp_adhoc.protorate AS
SELECT LABTEST,max(RATESPEC) as maxcost
from ctsi_webcamp_pr.approvedresource
GROUP BY LABTEST; 


Update ctsi_webcamp_adhoc.STD_PRICE sp, ctsi_webcamp_adhoc.protorate lu
SET sp.UnitCost=lu.maxcost 
WHERE sp.LabTestID=lu.LABTEST
AND sp.UnitCost is NULL;

## SANDRA RATES
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.invoicecost;
CREATE TABLE ctsi_webcamp_adhoc.invoicecost as
SELECT Service, Max(UnitCost) as ssUnitCost
FROM ctsi_webcamp_adhoc.sandracost
GROUP BY Service;

UPDATE ctsi_webcamp_adhoc.STD_PRICE sp, ctsi_webcamp_adhoc.invoicecost lu
SET sp.UnitCost=lu.ssUnitCost
WHERE sp.Service=lu.Service;



################  DOCUMENT SERVICES WITH NO UNIT RATES

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.NoUnitRates;
create TABLE ctsi_webcamp_adhoc.NoUnitRates as
select * from ctsi_webcamp_adhoc.STD_PRICE where UNITCOST is NULL;
################




UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit=NULL WHERE QuantityType IN (0,NULL);
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Minutes' WHERE QuantityType=1;
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE QuantityType=2;  ##
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Days' WHERE QuantityType=3;   ## 
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance' WHERE QuantityType=4; ##
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit= 'Other Specify' WHERE QuantityType=5;   ## Appears to Be Units
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Weeks' WHERE QuantityType=6; 
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Months' WHERE QuantityType=7; ##
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Years' WHERE QuantityType=8; 
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Dollars' WHERE QuantityType=9; 
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Participants' WHERE QuantityType=10; 

UPDATE ctsi_webcamp_adhoc.STD_PRICE Set BillingUnit='Instance' WHERE Service='CTRB: Outpatient Visit (Instance)';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='CTRB:  Outpatient visit (budgeted)';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='CTRB:  Outpatient visit (budgeted)';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='' WHERE Service='CTRB: IOA';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='CTRB: Specimen drop off only';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='DIET: Controlled diet (foods weighed)';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='DIET: Regular meal';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='EQS: ECG machine';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='LAB: Specimen Processing - Hourly';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='LAB: Specimen processing - Instance';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='LAB: Specimen shipping';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='NUR: IP Medication administration';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='NUR: Nurse performed ECG';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service='NUR: Nursing Service (Instance)';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='NUR: Scheduled nursing services';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Hours' WHERE Service='NUR: Specimen collection /Blood draw';
UPDATE ctsi_webcamp_adhoc.STD_PRICE SET BillingUnit='Instance ' WHERE Service LIKE ('%Instance%') AND BillingUnit='Other Specify';

ALTER TABLE ctsi_webcamp_adhoc.VisitRoomCore
		ADD UnitCost decimal(65,10),
		ADD QuantityType int(5),
		ADD BillingUnit varchar(20),
        ADD BillingAmt decimal(65,10);

UPDATE ctsi_webcamp_adhoc.VisitRoomCore vrc, ctsi_webcamp_adhoc.STD_PRICE lu
SET vrc.UnitCost=lu.UnitCost,
	vrc.QuantityType=lu.QUANTITYTYPE,
    vrc.BillingUnit=lu.BillingUnit
WHERE vrc.LabtestID=lu.LabTestID;    
########################################
## USE SANDRA's INVOICE COSTS


#############################################

UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=0;
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=CoreSvcLenDurMin*UnitCost WHERE BillingUnit='Minutes' ;
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/60)*UnitCost WHERE BillingUnit='Hours'; #### 2
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/(60*24))*UnitCost WHERE BillingUnit='Days'; ##### 3
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=1*UnitCost WHERE BillingUnit='Instance' ; ##### 4  Should units be 1 (default unit?)
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=CoreSvcQuant*UnitCost WHERE BillingUnit='Each' ; ## NEW
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=CoreSvcQuant*UnitCost WHERE BillingUnit='Other Specify' ;  #### 5 IS THIS CORRECT?
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/(60*24*7))*UnitCost WHERE BillingUnit='Weeks'; 
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/(60*24*7*30.25))*UnitCost WHERE BillingUnit='Months'; ###### 7
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/(60*24*7*30.25*12))*UnitCost WHERE BillingUnit='Months';
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/(60*24*7*30.25*12))*UnitCost WHERE BillingUnit='Years';
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=CoreSvcQuant*UnitCost WHERE  BillingUnit='Dollars';
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=CoreSvcQuant*UnitCost WHERE  BillingUnit='Participants';
UPDATE ctsi_webcamp_adhoc.VisitRoomCore SET BillingAmt=(CoreSvcLenDurMin/60)*UnitCost WHERE BillingUnit='Total Time';


######################################################################################
select * from ctsi_webcamp_adhoc.VisitRoomCore;

#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## END OF FILE CREATION
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
###  Monthly
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.MonthSummary;
CREATE TABLE ctsi_webcamp_adhoc.MonthSummary As
SELECT 	Month,
		COUNT(distinct VisitID) as nVisits,
        COUNT(distinct ProtocolID) as nProtocols,
        COUNT(Distinct PatientID) as nPatients,
        COUNT(distinct LabTestID) as nServiceTypes,
        COUNT(distinct ProvPersonID) as nPIs,
        SUM(BillingAmt) as BillingAmt
        FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE CoreSvcStatus=2
AND VisitStatus=2
AND YEAR(VisitEnd)>=2018
GROUP BY MONTH
ORDER BY MONTH;


        
ALTER TABLE ctsi_webcamp_adhoc.MonthSummary
ADD AdjustedAmt decimal(65,10);

UPDATE ctsi_webcamp_adhoc.MonthSummary
SET AdjustedAmt=BillingAmt/6.44477;

SELECT * from ctsi_webcamp_adhoc.MonthSummary;



########################################################################################


DESC ctsi_webcamp_adhoc.VisitRoomCore;

Select  VisitType,
		VisitStart,
        VisitEnd,
        VisitLenMin,
        VisitStatus,
        CRCNumber,
        ProtocolID,
        PI_NAME,
        Title,
        Service,
        PatientName,
        CoreSvcQuant
        
 from ctsi_webcamp_adhoc.VisitRoomCore
 where CoreSvcStart=str_to_date('08,21,2023','%m,%d,%Y') or  coreSvcEND=str_to_date('08,21,2023','%m,%d,%Y');

 
 
 
 WHERE VisitsTART=str_to_date('08,21,2023','%m,%d,%Y');
 
 select 
 
 from ctsi_webcamp_pr.coreservice where ENDDATE=str_to_date('08,21,2023','%m,%d,%Y') OR STARTDATE=str_to_date('08,21,2023','%m,%d,%Y');


        
        
        




08/21/2023 
