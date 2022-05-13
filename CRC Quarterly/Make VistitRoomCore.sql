#######################################################################################
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
WHERE STATUS=2 
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





SET SQL_SAFE_UPDATES = 0;


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.PIPersonID=lu.PERSON
WHERE vc.ProtocolID=lu.UNIQUEFIELD
AND vc.PIPersonID IS NULL; 


ALTER TABLE ctsi_webcamp_adhoc.visitcore
ADD PI_NAME varchar(55),
ADD Title varchar(255),
ADD CRCNumber varchar(25),
ADD IRBNUMBER varchar(25),
ADD EXPSTART datetime,
ADD CRCTERM datetime,
ADD U_OCRNO varchar(20),
ADD PatientName varchar(45),
ADD VisitStart datetime,
ADD VisitEnd datetime,
ADD VisitLenMin decimal(30,2),
ADD Month Varchar(12),
ADD SFY varchar(25),
ADD Quarter varchar(12);



UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.person lu
SET vc.PI_NAME=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE vc.PIPersonID=lu.UNIQUEFIELD;


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.patient lu
SET vc.PatientName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE vc.PatientID=lu.UNIQUEFIELD;


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.Title=lu.LONGTITLE,
	vc.CRCNumber=lu.Protocol,
    vc.IRBNUMBER=lu.IRBNUMBER,
    vc.EXPSTART=lu.EXPSTART,
    vc.CRCTERM=lu.CRCTERM,
    vc.U_OCRNO=lu.U_OCRNO
WHERE vc.ProtocolID=lu.UNIQUEFIELD;




UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitStart=CONVERT(VisitStartDate, DATETIME),
	VisitEnd=CONVERT(VisitEndDate, DATETIME)
WHERE VisitStartTime is Not Null;

UPDATE ctsi_webcamp_adhoc.visitcore
SET VisitStart=CONVERT(VisitStartDate, DATETIME),
	VisitEnd=CONVERT(VisitEndDate, DATETIME)
;


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
SET MONTH=concat(Year(VisitStart),"-",lpad(month(VisitStart),2,"0")); 

UPDATE ctsi_webcamp_adhoc.visitcore vt, ctsi_webcamp_adhoc.sfy_classify lu
SET vt.SFY=lu.SFY,
	vt.Quarter=lu.Quarter
WHERE vt.Month=lu.Month;    


/*
select VisitStart,VisitEnd,TIMESTAMPDIFF(MINUTE,VisitStart,VisitEnd)
FROM ctsi_webcamp_adhoc.visitcore;

SELECT * from ctsi_webcamp_adhoc.visitcore;
desc ctsi_webcamp_adhoc.visitcore;
*/		
## DATE FILTER
## Only Completed Visits
DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStatus<>2;
## DATE FILTERS
##DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStart<str_to_date('01,01,2016','%m,%d,%Y');  
#DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStart>CURDATE();     
#Select * FROM ctsi_webcamp_adhoc.visitcore;  






DROP TABLE IF EXISTS ctsi_webcamp_adhoc.visits; 
CREATE TABLE ctsi_webcamp_adhoc.visits
SELECT 	Month,
        SFY,
        Quarter,
        VisitType,
		VisitID,
        CRCNumber,
        IRBNUMBER,
        EXPSTART,
        CRCTERM,
        U_OCRNO,
        VisitStart,
        VisitEnd,
        VisitLenMin,
        VisitStatus,
        ProtocolID,
        PIPersonID,
        BedID,
        PatientID,
        PatientName,
        PI_NAME,
        Title
FROM ctsi_webcamp_adhoc.visitcore;        
        
      


#######################################################################################
#######################################################################################
## CREATE CORE SERVICE LOOKUP Multiple Records per VISIT
#######################################################################################
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU1;
Create table  ctsi_webcamp_adhoc.CoreSvcLU1 AS
SELECT "OutPatient" AS VisitType,
	    OPVISIT AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcStartDate,
        STARTDATE as CoreSvcEndDate,
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
        STARTDATE as CoreSvcEndDate,
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
        STARTDATE as CoreSvcEndDate,
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


ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU1
ADD CoreSvcStart datetime,
ADD CoreSvcEnd datetime,
ADD CoreSvcLenDurMin decimal(30,2);




UPDATE ctsi_webcamp_adhoc.CoreSvcLU1
SET CoreSvcStart=ADDTIME(CONVERT(CoreSvcStartDate, DATETIME), CoreSvcStartTime),
	CoreSvcEnd=ADDTIME(CONVERT(CoreSvcEndDate, DATETIME), CoreSvcEndTime);

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
	cs.CoreSvcStart,
    cs.CoreSvcEnd,
    cs.CoreSvcLenDurMin,
	cs.CoreSvcQuant,
	cs.CoreSvcStatus,
    cs.CoreSvcRelatedTo,
	cs.LabID,
	cs.LabTestID,
	pp.PERSON AS ProvPersonID
from ctsi_webcamp_adhoc.CoreSvcLU1 cs 
LEFT JOIN ctsi_webcamp_pr.coreservice_personprovider pp
ON cs.CoreSvcID = pp.CORESERVICE ;



ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU
ADD VisitFacility varchar(45),
ADD Service varchar(100),
ADD SvcUnitCost float,
ADD Amount float,
ADD ProvPersonName varchar(100),
ADD ProtoSpecRate int(1);



SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.lab lu
SET cs.VisitFacility=lu.LAB
WHERE cs.LabID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.labtest lu
SET cs.Service =lu.LABTEST
WHERE cs.LabTestID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.person lu
SET cs.ProvPersonName =CONCAT(trim(LASTNAME),", ",TRIM(FIRSTNAME))
WHERE cs.ProvPersonID=lu.UNIQUEFIELD;



UPDATE 	ctsi_webcamp_adhoc.CoreSvcLU cs, 
		ctsi_webcamp_pr.labtestcost lu
SET cs.SvcUnitCost=lu.DEFAULTCOST,
    cs.AMOUNT=lu.DEFAULTCOST*cs.CoreSvcQuant
WHERE cs.LabTestID=lu.LABTEST
  AND (cs.CoreSvcStart>=lu.STARTDATE or lu.STARTDATE IS NULL)
  AND (cs.CoreSvcEnd<=lu.ENDDATE OR lu.ENDDATE IS NULL);
  

UPDATE 	ctsi_webcamp_adhoc.CoreSvcLU
SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.CoreSvcLU cs,
		ctsi_webcamp_pr.approvedresource ar
SET cs.SvcUnitCost=ar.RATESPEC,
    cs.AMOUNT=ar.RATESPEC*cs.CoreSvcQuant,
    cs.ProtoSpecRate=1
WHERE cs.CoreSvcProtocolID=ar.PROTOCOL
  AND cs.LabTestID=ar.LABTEST;

# KEEP ONLY THE COMPLETE VISITS
DELETE FROM ctsi_webcamp_adhoc.CoreSvcLU WHERE CoreSvcStatus<>2;

/*
SELECT * from ctsi_webcamp_adhoc.CoreSvcLU;
desc ctsi_webcamp_adhoc.CoreSvcLU;
*/
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
           vc.PatientName,
           vc.ProtocolID,
           vc.PIPersonID,
           vc.PI_NAME,
           vc.Title,
           vc.CRCNumber,
           vc.IRBNUMBER,
           vc.EXPSTART,
           vc.CRCTERM,
           vc.U_OCRNO,
           rl.BedID AS RoomLUID,
           rl.Bed,
           rl.RoomID,
           rl.Room
FROM ctsi_webcamp_adhoc.visits vc
	LEFT JOIN ctsi_webcamp_adhoc.RoomLookup rl
    ON vc.VisitType=rl.VisitType
    AND vc.VisitID=rl.VisitID;
    

#######################################################################################
#######################################################################################
## CREATE Final Table Visits-Room-CoreServices
#######################################################################################
####################################################################################### 

CREATE INDEX vrvi ON ctsi_webcamp_adhoc.VisitRoom (VisitID);
CREATE INDEX csvi ON ctsi_webcamp_adhoc.CoreSvcLU (VisitID);


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
           vr.PatientName,
           vr.ProtocolID,
           vr.PIPersonID,
           vr.PI_NAME,
           vr.Title,
           vr.CRCNumber,
           vr.IRBNUMBER,
           vr.U_OCRNO,
           vr.EXPSTART,
           vr.CRCTERM,
           vr.RoomID,
           vr.Room,
          cr.CoreSvcID,
          cr.CoreSvcProtocolID,
          cr.CoreSvcStart,
          cr.CoreSvcEnd,
          cr.CoreSvcLenDurMin,
          cr.CoreSvcQuant,
          cr.CoreSvcStatus,
          cr.CoreSvcRelatedTo,
          cr.LabID,
          cr.LabTestID,
          cr.ProvPersonID,
          cr.VisitFacility,
          cr.Service,
          cr.SvcUnitCost,
          cr.Amount,
          cr.ProvPersonName,
          cr.ProtoSpecRate
FROM ctsi_webcamp_adhoc.VisitRoom vr
LEFT JOIN ctsi_webcamp_adhoc.CoreSvcLU cr
ON vr.VisitType=cr.VisitType
AND vr.VisitID=cr.VisitID;

## Remove VISIT RECORDS WITH NO CORE SERVICE RECORD
DELETE FROM ctsi_webcamp_adhoc.VisitRoomCore where CoreSvcID is null;


SELECT * from ctsi_webcamp_pr.protocol pc
WHERE pc.protocol = "564";

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
select distinct PI_NAME from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "%564%";

select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564";

select count(distinct VisitID) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564";



select distinct CRCNumber  from ctsi_webcamp_adhoc.VisitRoomCore
WHERE   LIKE "%564%";


select * from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%";

create table ;
select CRCNumber,ProtocolID,VisitType,PIPersonID,count(distinct VisitID) as nVISITS 
from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%"
 group by CRCNumber,ProtocolID,VisitType,PIPersonID;


2304
#######################################################################################
#######################################################################################
## SANDRA SMITH REQUEST



/*
Protocol Number
PI Last Name
PI First Name
CRC Number
OCR Number where available
IRB Number
IRB Activation Date (if known)
IRB Expiration Date (if known)
Budget/Project Activation Date (if known)
Budget/Project Expiration Date (if known)
*/

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.SSRQST; 
CREATE TABLE ctsi_webcamp_adhoc.SSRQST AS 
SELECT ProtocolID,
       max(PI_NAME) AS PI_NAME,
       MAX(CRCNumber) AS CRCNumber,
       MAX(U_OCRNO) AS OCR_NUMBER,
       max(IRBNUMBER) AS IRBNUMBER,
       min(EXPSTART) AS EXPSTART,
       MAX(CRCTERM) AS CRCTERM,
       count(Distinct VisitID) AS nVISITS ,
       MIN(VisitStart) AS FirstVisit,
       MAX(VisitEnd) AS LastVisit,
       MAX(VisitEnd) AS LastSchedVisit ## Placeholder for update 
FROM  ctsi_webcamp_adhoc.VisitRoomCore
WHERE ProtocolID IS NOT NULL
GROUP BY ProtocolID
;
      


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.lastsched; 
CREATE TABLE ctsi_webcamp_adhoc.lastsched 
Select  PROTOCOL AS ProtocolID,
		MAX(VISITDATE) AS LastSched
 from ctsi_webcamp_pr.opvisit
WHERE STATUS in (1,6) 
AND PROTOCOL IS NOT NULL
AND VISITDATE IS NOT NULL
GROUP BY PROTOCOL
UNION ALL
Select  PROTOCOL AS ProtocolID,
        MAX(ADMITDATE) AS LastSched 	
from ctsi_webcamp_pr.admissio
WHERE STATUS in (1,6)
AND PROTOCOL IS NOT NULL
AND ADMITDATE IS NOT NULL
GROUP BY PROTOCOL 
UNION ALL
Select PROTOCOL AS ProtocolID,
       MAX(ADMITDATE) AS LastSched
from ctsi_webcamp_pr.sbadmissio
WHERE STATUS in (1,6)
AND PROTOCOL IS NOT NULL
AND ADMITDATE IS NOT NULL
GROUP BY PROTOCOL;  



UPDATE ctsi_webcamp_adhoc.SSRQST SET LastSchedVisit = NULL;

UPDATE ctsi_webcamp_adhoc.SSRQST ss,ctsi_webcamp_adhoc.lastsched lu      
SET ss.LastSchedVisit=lu.LastSched
WHERE ss. ProtocolID=lu. ProtocolID
AND lu. ProtocolID IS NOT NULL;


DELETE FROM ctsi_webcamp_adhoc.SSRQST WHERE PI_NAME IS NULL;

#################  IRB APPROVAL DATES

ALTER TABLE ctsi_webcamp_adhoc.SSRQST
	ADD IRB_Approval datetime,
	ADD IRB_Expire datetime;

UPDATE ctsi_webcamp_adhoc.SSRQST ss, ctsi_webcamp_adhoc.irb_jul_2021 lu
SET ss.IRB_Approval=lu.Date_Originally_Approved,
	ss.IRB_Expire=lu.Expiration_Date
WHERE ss.IRBNUMBER=lu.ID;    



UPDATE ctsi_webcamp_adhoc.SSRQST ss, ctsi_webcamp_adhoc.wirb20210701 lu
SET ss.IRB_Approval=lu.Approval_Date,
	ss.IRB_Expire=lu.Expiration_Date
WHERE ss.IRBNUMBER=lu.WIRBID;    




select * from ctsi_webcamp_adhoc.SSRQST;

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
DROP TABLE UTIL_BY_ROOM_MOnth;
Create table UTIL_BY_ROOM_MOnth AS
SELECT Month,
	   ROOM,
       SUM(HoursUsed) AS HoursUsed,
       SUM(CRC_Avail_Hours) HoursAvail,
       (SUM(HoursUsed)/SUM(CRC_Avail_Hours))*100 As UtilRate,
       SUM(PrsnAdjHours) as PrsnAdjHours
 FROM PR_ROOM_UTIL
 WHERE ROOM IN ('1245','1246')
 GROUP BY 	MOnth,
			ROOM;

#######################################################################################
#######################################################################################
### TABLE ANALYTICS 
#######################################################################################


### Component File Record Counts
SELECT "visits" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.visits
UNION ALL
SELECT "CoreSvcLU" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.CoreSvcLU
UNION ALL
SELECT "RoomLookup" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.RoomLookup
UNION ALL
SELECT "VisitRoom" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.VisitRoom
UNION ALL
SELECT "VisitRoomCore" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.VisitRoomCore;

### Component File Record Structure
/*
DESC ctsi_webcamp_adhoc.visitcore;
DESC ctsi_webcamp_adhoc.RoomLookup;
DESC ctsi_webcamp_adhoc.VisitRoom;
DESC ctsi_webcamp_adhoc.CoreSvcLU;
DESC ctsi_webcamp_adhoc.VisitRoomCore;

### Component File Record View
select * from ctsi_webcamp_adhoc.visitcore;
SELECT * from ctsi_webcamp_adhoc.CoreSvcLU ;
SELECT * from ctsi_webcamp_adhoc.RoomLookup;
SELECT * from ctsi_webcamp_adhoc.VisitRoomCore;

*/

### Analytic File Metrics
SELECT "Total Records" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Number of Visits" AS DescMeasure, COUNT(DISTINCT VisitID) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Number of CoreSvcVisits" AS DescMeasure, COUNT(DISTINCT CoreSvcID) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Number of Protocols" AS DescMeasure, COUNT(DISTINCT ProtocolID) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Visits with no Protocol" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE ProtocolID IS NULL
UNION ALL
SELECT "Visits with no CRCID" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE CRCNumber IS NULL
UNION ALL
SELECT "Number of PIs" AS DescMeasure, COUNT(DISTINCT PIPersonID) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "No PI" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE PIPersonID IS NULL
UNION ALL
SELECT "No Provider" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE ProvPersonID IS NULL
UNION ALL
SELECT "Visits With Provider" AS DescMeasure, COUNT(Distinct VisitID) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE ProvPersonID IS NOT NULL
UNION ALL
SELECT "No Patient" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE PatientID IS NULL
UNION ALL
SELECT "No Room" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE Room IS NULL
UNION ALL
SELECT "VisitStart <> CoreSvcStart" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE VisitStart<>CoreSvcStart;
;

##$ Analytic File Date Ranges
SELECT "First Visit Date" AS DescMeasure, min(VisitStart) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Last Visit Date" AS DescMeasure, max(VisitEnd) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "First CoreSvc Date" AS DescMeasure, min(CoreSvcStart) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL
SELECT "Last CoreSvc Date" AS DescMeasure, max(CoreSvcEnd) As Measure from ctsi_webcamp_adhoc.VisitRoomCore;
############################################################################################################################
############################################################################################################################
drop table if exists ctsi_webcamp_adhoc.ptrack;
create table ctsi_webcamp_adhoc.ptrack as
SELECT *
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart>=str_to_date('09,01,2019','%m,%d,%Y');

drop table if exists ctsi_webcamp_adhoc.MonVistProtocol;
create table ctsi_webcamp_adhoc.MonVistProtocol as
SELECT  CRCNumber,
		ProtocolID,
        PI_NAME,
        Title
from ctsi_webcamp_adhoc.ptrack
WHERE PI_NAME IS NOT NULL
GROUP BY  CRCNumber,
		ProtocolID,
        PI_NAME,
        Title  ;       

drop table if exists ctsi_webcamp_adhoc.MonProtLU;
create table ctsi_webcamp_adhoc.MonProtLU as
SELECT ProtocolID,
	   Month,
       count(distinct VisitID) as nVisits
from ctsi_webcamp_adhoc.ptrack
GROUP BY  ProtocolID,
	      Month;      
          
ALter table ctsi_webcamp_adhoc.MonVistProtocol
    ADD m_2019_09 int(6),
    ADD m_2019_10 int(6),    
    ADD m_2019_11 int(6),
    ADD m_2019_12 int(6),
    ADD m_2020_01 int(6),
    ADD m_2020_02 int(6),
    ADD m_2020_03 int(6),
    ADD m_2020_04 int(6),
    ADD m_2020_05 int(6),
    ADD m_2020_06 int(6),
    ADD m_2020_07 int(6),
    ADD m_2020_08 int(6),
    ADD m_2020_09 int(6),
    ADD m_2020_10 int(6),
    ADD m_2020_11 int(6),
    ADD m_2020_12 int(6),
    ADD m_2021_01 int(6),
    ADD m_2021_02 int(6);


UPDATE ctsi_webcamp_adhoc.MonVistProtocol
SET  m_2019_09=0,
     m_2019_10=0,
     m_2019_11=0,
     m_2019_12=0,
     m_2020_01=0,
     m_2020_02=0,
     m_2020_03=0,
     m_2020_04=0,
     m_2020_05=0,
     m_2020_06=0,
     m_2020_07=0,
     m_2020_08=0,
     m_2020_09=0,
     m_2020_10=0,
     m_2020_11=0,
     m_2020_12=0,
     m_2021_01=0,
     m_2021_02=0;
     
  

UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2019_09=lu.nVisits WHERE lu.Month='2019-09' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2019_10=lu.nVisits WHERE lu.Month='2019-10' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2019_11=lu.nVisits WHERE lu.Month='2019-11' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2019_12=lu.nVisits WHERE lu.Month='2019-12' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_01=lu.nVisits WHERE lu.Month='2020-01' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_02=lu.nVisits WHERE lu.Month='2020-02' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_03=lu.nVisits WHERE lu.Month='2020-03' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_04=lu.nVisits WHERE lu.Month='2020-04' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_05=lu.nVisits WHERE lu.Month='2020-05' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_06=lu.nVisits WHERE lu.Month='2020-06' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_07=lu.nVisits WHERE lu.Month='2020-07' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_08=lu.nVisits WHERE lu.Month='2020-08' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_09=lu.nVisits WHERE lu.Month='2020-09' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_10=lu.nVisits WHERE lu.Month='2020-10' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_11=lu.nVisits WHERE lu.Month='2020-11' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2020_12=lu.nVisits WHERE lu.Month='2020-12' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2021_01=lu.nVisits WHERE lu.Month='2021-01' and pm.ProtocolID=lu.ProtocolID;
UPDATE ctsi_webcamp_adhoc.MonVistProtocol pm, ctsi_webcamp_adhoc.MonProtLU lu SET pm.m_2021_02=lu.nVisits WHERE lu.Month='2021-02' and pm.ProtocolID=lu.ProtocolID;







         
select distinct Month from  ctsi_webcamp_adhoc.MonProtLU;         
#######################################################################################
#######################################################################################
##### Diagnostics

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRCSumm;
Create table ctsi_webcamp_adhoc.CRCSumm AS 

SELECT 	Year(VisitStart) as Year,
	    Count(distinct ProtocolID) as nProtocols,
        Count(distinct PIPersonID) as nPIs,
        Count(distinct VisitID) as nVisits,
        Count(distinct PatientID) as nPatients
from ctsi_webcamp_adhoc.visitroomcore
GROUP BY Year(VisitStart);