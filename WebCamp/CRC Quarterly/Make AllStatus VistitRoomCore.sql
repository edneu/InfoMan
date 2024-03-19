
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
ADD Title varchar(255),
ADD CRCNumber varchar(25),
ADD PatientName varchar(45),
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
SET vc.PatientName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
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
SET MONTH=concat(Year(VisitStart),"-",lpad(month(VisitStart),2,"0")); 

UPDATE ctsi_webcamp_adhoc.visitcore vt, ctsi_webcamp_adhoc.sfy_classify lu
SET vt.SFY=lu.SFY,
	vt.Quarter=lu.Quarter
WHERE vt.Month=lu.Month;    


/*
select distinct Month from ctsi_webcamp_adhoc.visitcore;
select VisitStart,VisitEnd,TIMESTAMPDIFF(MINUTE,VisitStart,VisitEnd)
FROM ctsi_webcamp_adhoc.visitcore;

SELECT * from ctsi_webcamp_adhoc.visitcore where MOnth="2021-02";
desc ctsi_webcamp_adhoc.visitcore;
		
## DATE FILTER
## Only Completed Visits
###DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStatus not in (1,2);
## DATE FILTERS
##DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStart<=str_to_date('02,01,2021','%m,%d,%Y');  
###DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStart>CURDATE();     
#Select * FROM ctsi_webcamp_adhoc.visitcore;  
*/


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
/*
# KEEP ONLY THE COMPLETE VISITS
### DELETE FROM ctsi_webcamp_adhoc.CoreSvcLU WHERE CoreSvcStatus =2;

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

Select * from ctsi_webcamp_adhoc.VisitRoomCore;
#######################################################################################
#######################################################################################
## END OF FILE CREATION
#######################################################################################
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.statuslu;
Create table ctsi_webcamp_adhoc.statuslu as
SELECT Month,
	   "Complete" as VisitCat,
       Count(DISTINCT VisitID) as nVisits,
       Count(DISTINCT PatientID) as nPatients,
       Count(DISTINCT ProtocolID) as nProtocols,
       SUM(AMOUNT) as TotAmt
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart>=str_to_date('01,01,2018','%m,%d,%Y')
AND VisitStatus in (2)
GROUP BY Month, "Complete"
UNION ALL
SELECT Month,
	   "Scheduled" as VisitCat,
       Count(DISTINCT VisitID) as nVisits,
       Count(DISTINCT PatientID) as nPatients,
       Count(DISTINCT ProtocolID) as nProtocols,
       SUM(AMOUNT) as TotAmt
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart>=str_to_date('01,01,2018','%m,%d,%Y')
AND VisitStatus in (1,6)
GROUP BY Month, "Scheduled"
UNION ALL
SELECT Month,
	   "Incomplete" as VisitCat,
       Count(DISTINCT VisitID) as nVisits,
       Count(DISTINCT PatientID) as nPatients,
       Count(DISTINCT ProtocolID) as nProtocols,
       SUM(AMOUNT) as TotAmt
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart>=str_to_date('01,01,2018','%m,%d,%Y')
AND VisitStatus in (3,8)
GROUP BY Month, "Incomplete"
UNION ALL
SELECT Month,
	   "Cancelled" as VisitCat,
       Count(DISTINCT VisitID) as nVisits,
       Count(DISTINCT PatientID) as nPatients,
       Count(DISTINCT ProtocolID) as nProtocols,
       SUM(AMOUNT) as TotAmt
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart>=str_to_date('01,01,2018','%m,%d,%Y')
AND (VisitStatus in (4,5,7) OR VisitStatus is Null)
GROUP BY Month, "Cancelled"
;

UPDATE ctsi_webcamp_adhoc.statuslu SET nVisits=0 WHERE nVisits IS NULL;
UPDATE ctsi_webcamp_adhoc.statuslu SET	nPatients=0  WHERE nPatients IS NULL;
UPDATE ctsi_webcamp_adhoc.statuslu SET nProtocols=0  WHERE nProtocols IS NULL;
UPDATE ctsi_webcamp_adhoc.statuslu SET TotAmt=0  WHERE TotAmt IS NULL;
 
 DROP TABLE IF EXISTS ctsi_webcamp_adhoc.MonStatusSumm;
 CREATE TABLE ctsi_webcamp_adhoc.MonStatusSumm AS
SELECT DISTINCT Month from ctsi_webcamp_adhoc.statuslu;


Alter table ctsi_webcamp_adhoc.MonStatusSumm
ADD Comp_nVISTS int(6),
ADD Comp_nPatients int(6),
ADD Comp_Amount decimal(65,10),

ADD Incomp_nVISTS int(6),
ADD Incomp_nPatients int(6),
ADD Incomp_Amount decimal(65,10),

ADD Sched_nVISTS int(6),
ADD Sched_nPatients int(6),
ADD Sched_Amount decimal(65,10),

ADD Cancel_nVISTS int(6),
ADD Cancel_nPatients int(6),
ADD Cancel_Amount decimal(65,10);


UPDATE ctsi_webcamp_adhoc.MonStatusSumm
SET Comp_nVISTS=0,
    Comp_nPatients=0,
    Comp_Amount=0,
    Incomp_nVISTS=0,
    Incomp_nPatients=0,
    Incomp_Amount=0,
    Sched_nVISTS=0,
    Sched_nPatients=0,
    Sched_Amount=0,
    Cancel_nVISTS=0,
    Cancel_nPatients=0,
    Cancel_Amount=0;



UPDATE ctsi_webcamp_adhoc.MonStatusSumm ms, ctsi_webcamp_adhoc.statuslu lu
SET ms.Comp_nVISTS=lu.nVisits,
	ms.Comp_nPatients=lu.nPatients,
	ms.Comp_Amount=lu.TotAmt
where ms.Month=lu.Month
AND lu.VisitCat="Complete";     

UPDATE ctsi_webcamp_adhoc.MonStatusSumm ms, ctsi_webcamp_adhoc.statuslu lu
SET ms.Incomp_nVISTS=lu.nVisits,
	ms.Incomp_nPatients=lu.nPatients,
	ms.Incomp_Amount=lu.TotAmt
where ms.Month=lu.Month
AND  VisitCat="Incomplete";

UPDATE ctsi_webcamp_adhoc.MonStatusSumm ms, ctsi_webcamp_adhoc.statuslu lu
SET ms.Sched_nVISTS=lu.nVisits,
	ms.Sched_nPatients=lu.nPatients,
	ms.Sched_Amount=lu.TotAmt
where ms.Month=lu.Month
AND VisitCat="Scheduled";







UPDATE ctsi_webcamp_adhoc.MonStatusSumm ms, ctsi_webcamp_adhoc.statuslu lu
SET ms.Cancel_nVISTS=lu.nVisits,
	ms.Cancel_nPatients=lu.nPatients,
	ms.Cancel_Amount=lu.TotAmt
where ms.Month=lu.Month
AND VisitCat="Cancelled";

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.monProtocols;
create table ctsi_webcamp_adhoc.monProtocols AS
Select Month,  SUM(nProtocols) as nProtoComp
from ctsi_webcamp_adhoc.statuslu
Where VisitCat="Complete"
group by Month
order by Month;


ALTER TABLE ctsi_webcamp_adhoc.MonStatusSumm
ADD nProtoComp integer(5);

SET SQL_SAFE_UPDATES = 0;
UPDATE ctsi_webcamp_adhoc.MonStatusSumm ms, ctsi_webcamp_adhoc.monProtocols lu
SET ms.nProtoComp=lu.nProtoComp
WHERE ms.Month=lu.Month;


select * from  ctsi_webcamp_adhoc.MonStatusSumm order by Month;

select month, sum(totamt) from ctsi_webcamp_adhoc.statuslu group by month;
select VisitStatus, sum(totamt) from ctsi_webcamp_adhoc.statuslu group by VisitStatus;




drop table if exists ctsi_webcamp_adhoc.CRC_MONEY;
create table ctsi_webcamp_adhoc.CRC_MONEY AS
select month,
    sum(Comp_Amount) as AMTCompleted,
    sum(Cancel_Amount) as AMTCancelled,
	sum(Sched_Amount) As AMTScheduled,
    sum(Incomp_Amount) as AMTIncomplete,
    SUM(Comp_Amount)+SUM(Sched_Amount)+sum(Cancel_Amount)+sum(Incomp_Amount) As AMTTotal
 from ctsi_webcamp_adhoc.MonStatusSumm
GROUP BY month
ORDER BY month;





###################################################

drop table if exists ctsi_webcamp_adhoc.CRC_GRAPH_WORK;
create table ctsi_webcamp_adhoc.CRC_GRAPH_WORK AS
SELECT 
   Month,
   Comp_nVISTS,
   0 AS MA_COMP,
   Sched_nVISTS,
   Cancel_nVISTS,
   Comp_nPatients,
   Comp_Amount,
   Sched_nVISTS AS  Sched_nVISTS2,
   Sched_nPatients,
   Sched_Amount,
   Cancel_nPatients,
   Cancel_Amount,
   Incomp_nVISTS,
   Incomp_nPatients,
   Incomp_Amount,
   0 AS MA_COMP2,
   0 AS MA_COMP_AMT,
   nProtoComp
FROM ctsi_webcamp_adhoc.MonStatusSumm
ORDER BY MONTH;   



desc ctsi_webcamp_adhoc.CRC_GRAPH_WORK;



##################################

/*

desc ctsi_webcamp_adhoc.MonStatusSumm;
Month
Completed Visits
Moving Average Completed Visits (projection)
Scheduled Visits
Cancelled Visits
Completed Visits Unduplicated Patients

Completed Amount

Scheduled Visits
Scheduled  Visits Unduplicated Patients
Scheduled Amount
Cancelled Visits  Unduplicated Patients
Cancelled Visits Patients
Cancelledd Amount
Incomp_nVISTS
Incomp_nPatients
Incomp_Amount
Moving Average Completed Visits
Moving Average Completed Visit Amount
###





*/
/*
Comp where VisitStatus in (2),
Sched where VisitStatus in (1,6)
Incomp where VisitStatus in (3,8),
Cancel where VisitStatus in (4,5,7)
*/



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
#########################################################################################
####################
## CANCELLATIONS

# 4=No-show
# 5=Request cancelled
# 7=Request denied

select * from ctsi_webcamp_adhoc.visitroomcore
WHERE VisitStatus IN (4,5,7);



#########################################################################################
DROP TABLE ctsi_webcamp_adhoc.Feb2021;
Create table ctsi_webcamp_adhoc.Feb2021 AS
SELECT Month,
       Count(distinct VisitID) as nVisits,
       Count(Distinct ProtocolID) as nProtocols,
       SUM(VisitLenMin) AS VisitMinutes,
       SUM(AMOUNT) AS AMOUNT
 FROM ctsi_webcamp_adhoc.VisitRoomCore
 WHERE Month IN ('2020-07','2020-08','2020-09','2020-10','2020-11','2020-12','2021-01','2021-02','2021-03','2021-04','2021-05','2021-06')
 GROUP BY 	MOnth;
			

select max(VISITDATE) FROM ctsi_webcamp_pr.opvisit;
#######################################################################################
###Cancelled Visits
DROP TABLE ctsi_webcamp_adhoc.Jan2021CanSum;
Create table ctsi_webcamp_adhoc.Jan2021CanSum AS
SELECT Month,
       Count(distinct VisitID) as nVisits,
       Count(Distinct ProtocolID) as nProtocols,
       SUM(VisitLenMin) AS VisitMinutes,
       SUM(AMOUNT) AS AMOUNT
 FROM ctsi_webcamp_adhoc.VisitRoomCore
  WHERE Month IN ('2020-07','2020-08','2020-09','2020-10','2020-11','2020-12','2021-01')
 GROUP BY 	Month;
 
DROP TABLE ctsi_webcamp_adhoc.Jan2021CanDTL;
Create table ctsi_webcamp_adhoc.Jan2021CanDTL AS
 SELECT	VisitID,
		CRCNumber,
        VisitStatus,
        CoreSvcStatus,
        VisitStart,
        VisitLenMin,
        PI_NAME,
        Title,
        Room,
        Service,
        SUM(Amount) AS Amount
 FROM ctsi_webcamp_adhoc.VisitRoomCore
 WHERE Month IN ('2021-01')
 GROUP BY VisitID,
		CRCNumber,
        VisitStatus,
        CoreSvcStatus,
        VisitStart,
        VisitLenMin,
        PI_NAME,
        Title,
        Room,
        Service;

#######################################################################################
USE ctsi_webcamp_adhoc

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


###########################################################################################



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

#######################################################################################
#######################################################################################
####Protcol Summary Time Series


desc ctsi_webcamp_adhoc.VisitRoomCore;

SELECT distinct sfy FROM ctsi_webcamp_adhoc.VisitRoomCore;


SELECT * FROM ctsi_webcamp_adhoc.VisitRoomCore;


use ctsi_webcamp_adhoc;

drop table If existS PROTOwORK;
CREATE TABLE PROTOwORK as
sELECT * FROM ctsi_webcamp_adhoc.VisitRoomCore
where sfy in ('SFY 2020-2021','SFY 2021-2022','SFY 2022-2022')
AND VisitStatus=2;


drop table If existS PROTOSUMMlu;
CREATE TABLE PROTOSUMMlu as
select 	PI_NAME,
		Title,
        ProtocolID,
        CRCNumber,
        Month,
        count(Distinct VisitID) as nVisits,
        count(Distinct PatientID) as nPAtients,
        sum(VisitLenMin/60) as visitdur,
        Sum(Amount) as Amount
from PROTOwORK
WHERE CRCNumber<>'0000'
GROUP BY  PI_NAME,
		Title,
        ProtocolID,
        CRCNumber,
        Month;   
        


 
drop table If existS PROTOSUMM;
CREATE TABLE PROTOSUMM as
select 	ProtocolID,
        CRCNumber,
        PI_NAME,
		Title
from PROTOwORK
WHERE CRCNumber<>'0000'
GROUP BY ProtocolID,
		 CRCNumber,
         PI_NAME,
		 Title;    
            
ALTER TABLE PROTOSUMM   
        
     ADD visits_2020_07 INT(8),
     ADD visits_2020_08 INT(8),
     ADD visits_2020_09 INT(8),
     ADD visits_2020_10 INT(8),
     ADD visits_2020_11 INT(8),
     ADD visits_2020_12 INT(8),
     ADD visits_2021_01 INT(8),
     ADD visits_2021_02 INT(8),
     ADD visits_2021_03 INT(8),
     ADD visits_2021_04 INT(8),
     ADD visits_2021_05 INT(8),
     ADD visits_2021_06 INT(8),
     ADD visits_2021_07 INT(8),
     ADD visits_2021_08 INT(8),
     ADD visits_2021_09 INT(8),
     ADD visits_2021_10 INT(8),
     ADD visits_2021_11 INT(8),
     ADD visits_2021_12 INT(8),
     ADD visits_2022_01 INT(8),
     ADD visits_2022_02 INT(8),
     ADD visits_2022_03 INT(8),
	 
     ADD visits_2022_04 INT(8),
     ADD visits_2022_05 INT(8),
     ADD visits_2022_06 INT(8),
     ADD visits_2022_07 INT(8),
     ADD visits_2022_08 INT(8),
     
     
     
     
     

     ADD patients_2020_07 INT(8),
     ADD patients_2020_08 INT(8),
     ADD patients_2020_09 INT(8),
     ADD patients_2020_10 INT(8),
     ADD patients_2020_11 INT(8),
     ADD patients_2020_12 INT(8),
     ADD patients_2021_01 INT(8),
     ADD patients_2021_02 INT(8),
     ADD patients_2021_03 INT(8),
     ADD patients_2021_04 INT(8),
     ADD patients_2021_05 INT(8),
     ADD patients_2021_06 INT(8),
     ADD patients_2021_07 INT(8),
     ADD patients_2021_08 INT(8),
     ADD patients_2021_09 INT(8),
     ADD patients_2021_10 INT(8),
     ADD patients_2021_11 INT(8),
     ADD patients_2021_12 INT(8),
     ADD patients_2022_01 INT(8),
     ADD patients_2022_02 INT(8),
     ADD patients_2022_03 INT(8),
     
     ADD patients_2022_04 INT(8),
     ADD patients_2022_05 INT(8),
     ADD patients_2022_06 INT(8),
     ADD patients_2022_07 INT(8),
     ADD patients_2022_08 INT(8),

     ADD amount_2020_07 Decimal(65,10),
     ADD amount_2020_08 Decimal(65,10),
     ADD amount_2020_09 Decimal(65,10),
     ADD amount_2020_10 Decimal(65,10),
     ADD amount_2020_11 Decimal(65,10),
     ADD amount_2020_12 Decimal(65,10),
     ADD amount_2021_01 Decimal(65,10),
     ADD amount_2021_02 Decimal(65,10),
     ADD amount_2021_03 Decimal(65,10),
     ADD amount_2021_04 Decimal(65,10),
     ADD amount_2021_05 Decimal(65,10),
     ADD amount_2021_06 Decimal(65,10),
     ADD amount_2021_07 Decimal(65,10),
     ADD amount_2021_08 Decimal(65,10),
     ADD amount_2021_09 Decimal(65,10),
     ADD amount_2021_10 Decimal(65,10),
     ADD amount_2021_11 Decimal(65,10),
     ADD amount_2021_12 Decimal(65,10),
     ADD amount_2022_01 Decimal(65,10),
     ADD amount_2022_02 Decimal(65,10),
     ADD amount_2022_03 Decimal(65,10),
     

     ADD visitdur_2020_07 Decimal(65,10),
     ADD visitdur_2020_08 Decimal(65,10),
     ADD visitdur_2020_09 Decimal(65,10),
     ADD visitdur_2020_10 Decimal(65,10),
     ADD visitdur_2020_11 Decimal(65,10),
     ADD visitdur_2020_12 Decimal(65,10),
     ADD visitdur_2021_01 Decimal(65,10),
     ADD visitdur_2021_02 Decimal(65,10),
     ADD visitdur_2021_03 Decimal(65,10),
     ADD visitdur_2021_04 Decimal(65,10),
     ADD visitdur_2021_05 Decimal(65,10),
     ADD visitdur_2021_06 Decimal(65,10),
     ADD visitdur_2021_07 Decimal(65,10),
     ADD visitdur_2021_08 Decimal(65,10),
     ADD visitdur_2021_09 Decimal(65,10),
     ADD visitdur_2021_10 Decimal(65,10),
     ADD visitdur_2021_11 Decimal(65,10),
     ADD visitdur_2021_12 Decimal(65,10),
     ADD visitdur_2022_01 Decimal(65,10),
     ADD visitdur_2022_02 Decimal(65,10),
     ADD visitdur_2022_03 Decimal(65,10),
     
     ADD visits_Q3_2020 INT(8),
     ADD visits_Q4_2020 INT(8),
     ADD visits_Q1_2021 INT(8),
     ADD visits_Q2_2021 INT(8),
     ADD visits_Q3_2021 INT(8),
     ADD visits_Q4_2021 INT(8),
     ADD visits_Q1_2022 INT(8),
     
     ADD patients_Q3_2020 INT(8),
     ADD patients_Q4_2020 INT(8),
     ADD patients_Q1_2021 INT(8),
     ADD patients_Q2_2021 INT(8),
     ADD patients_Q3_2021 INT(8),
     ADD patients_Q4_2021 INT(8),
     ADD patients_Q1_2022 INT(8),
     
     ADD amount_Q3_2020 Decimal(65,10),
     ADD amount_Q4_2020  Decimal(65,10),
     ADD amount_Q1_2021  Decimal(65,10),
     ADD amount_Q2_2021  Decimal(65,10),
     ADD amount_Q3_2021  Decimal(65,10),
     ADD amount_Q4_2021  Decimal(65,10),
     ADD amount_Q1_2022  Decimal(65,10),

     
     ADD visitdur_Q3_2020  Decimal(65,10),
     ADD visitdur_Q4_2020  Decimal(65,10),
     ADD visitdur_Q1_2021  Decimal(65,10),
     ADD visitdur_Q2_2021  Decimal(65,10),
     ADD visitdur_Q3_2021  Decimal(65,10),
     ADD visitdur_Q4_2021  Decimal(65,10),
     ADD visitdur_Q1_2022  Decimal(65,10);



     
  SELECT * from  PROTOSUMM;    
      
SET SQL_SAFE_UPDATES = 0;      
UPDATE PROTOSUMM
SET   visits_2020_07=0,  patients_2020_07=0, amount_2020_07=0, visitdur_2020_07=0,
      visits_2020_08=0,  patients_2020_08=0, amount_2020_08=0, visitdur_2020_08=0,
      visits_2020_09=0,  patients_2020_09=0, amount_2020_09=0, visitdur_2020_09=0,
      visits_2020_10=0,  patients_2020_10=0, amount_2020_10=0, visitdur_2020_10=0,
      visits_2020_11=0,  patients_2020_11=0, amount_2020_11=0, visitdur_2020_11=0,
      visits_2020_12=0,  patients_2020_12=0, amount_2020_12=0, visitdur_2020_12=0,
      visits_2021_01=0,  patients_2021_01=0, amount_2021_01=0, visitdur_2021_01=0,
      visits_2021_02=0,  patients_2021_02=0, amount_2021_02=0, visitdur_2021_02=0,
      visits_2021_03=0,  patients_2021_03=0, amount_2021_03=0, visitdur_2021_03=0,
      visits_2021_04=0,  patients_2021_04=0, amount_2021_04=0, visitdur_2021_04=0,
      visits_2021_05=0,  patients_2021_05=0, amount_2021_05=0, visitdur_2021_05=0,
      visits_2021_06=0,  patients_2021_06=0, amount_2021_06=0, visitdur_2021_06=0,
      visits_2021_07=0,  patients_2021_07=0, amount_2021_07=0, visitdur_2021_07=0,
      visits_2021_08=0,  patients_2021_08=0, amount_2021_08=0, visitdur_2021_08=0,
      visits_2021_09=0,  patients_2021_09=0, amount_2021_09=0, visitdur_2021_09=0,
      visits_2021_10=0,  patients_2021_10=0, amount_2021_10=0, visitdur_2021_10=0,
      visits_2021_11=0,  patients_2021_11=0, amount_2021_11=0, visitdur_2021_11=0,
      visits_2021_12=0,  patients_2021_12=0, amount_2021_12=0, visitdur_2021_12=0,
      visits_2022_01=0,  patients_2022_01=0, amount_2022_01=0, visitdur_2022_01=0,
      visits_2022_02=0,  patients_2022_02=0, amount_2022_02=0, visitdur_2022_02=0,
      visits_2022_03=0,  patients_2022_03=0, amount_2022_03=0, visitdur_2022_03=0,
      
      visits_Q3_2020=0,  patients_Q3_2020=0,  amount_Q3_2020=0,  visitdur_Q3_2020=0, 
	  visits_Q4_2020=0,  patients_Q4_2020=0,  amount_Q4_2020=0,  visitdur_Q4_2020=0, 
	  visits_Q1_2021=0,  patients_Q1_2021=0,  amount_Q1_2021=0,  visitdur_Q1_2021=0, 
      visits_Q2_2021=0,  patients_Q2_2021=0,  amount_Q2_2021=0,  visitdur_Q2_2021=0, 
      visits_Q3_2021=0,  patients_Q3_2021=0,  amount_Q3_2021=0,  visitdur_Q3_2021=0, 
      visits_Q4_2021=0,  patients_Q4_2021=0,  amount_Q4_2021=0,  visitdur_Q4_2021=0, 
      visits_Q1_2022=0,  patients_Q1_2022=0,  amount_Q1_2022=0,  visitdur_Q1_2022=0; 

      
      

UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_07=lu.nVisits,  ps.patients_2020_07=lu.nPatients, amount_2020_07=lu.Amount, visitdur_2020_07=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-07';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_08=lu.nVisits,  ps.patients_2020_08=lu.nPatients, amount_2020_08=lu.Amount, visitdur_2020_08=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-08';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_09=lu.nVisits,  ps.patients_2020_09=lu.nPatients, amount_2020_09=lu.Amount, visitdur_2020_09=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-09';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_10=lu.nVisits,  ps.patients_2020_10=lu.nPatients, amount_2020_10=lu.Amount, visitdur_2020_10=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-10';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_11=lu.nVisits,  ps.patients_2020_11=lu.nPatients, amount_2020_11=lu.Amount, visitdur_2020_11=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-11';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_12=lu.nVisits,  ps.patients_2020_12=lu.nPatients, amount_2020_12=lu.Amount, visitdur_2020_12=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-12';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_01=lu.nVisits,  ps.patients_2021_01=lu.nPatients, amount_2021_01=lu.Amount, visitdur_2021_01=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-01';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_02=lu.nVisits,  ps.patients_2021_02=lu.nPatients, amount_2021_02=lu.Amount, visitdur_2021_02=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-02';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_03=lu.nVisits,  ps.patients_2021_03=lu.nPatients, amount_2021_03=lu.Amount, visitdur_2021_03=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-03';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_04=lu.nVisits,  ps.patients_2021_04=lu.nPatients, amount_2021_04=lu.Amount, visitdur_2021_04=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-04';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_05=lu.nVisits,  ps.patients_2021_05=lu.nPatients, amount_2021_05=lu.Amount, visitdur_2021_05=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-05';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_06=lu.nVisits,  ps.patients_2021_06=lu.nPatients, amount_2021_06=lu.Amount, visitdur_2021_06=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-06';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_07=lu.nVisits,  ps.patients_2021_07=lu.nPatients, amount_2021_07=lu.Amount, visitdur_2021_07=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-07';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_08=lu.nVisits,  ps.patients_2021_08=lu.nPatients, amount_2021_08=lu.Amount, visitdur_2021_08=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-08';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_09=lu.nVisits,  ps.patients_2021_09=lu.nPatients, amount_2021_09=lu.Amount, visitdur_2021_09=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-09';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_10=lu.nVisits,  ps.patients_2021_10=lu.nPatients, amount_2021_10=lu.Amount, visitdur_2021_10=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-10';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_11=lu.nVisits,  ps.patients_2021_11=lu.nPatients, amount_2021_11=lu.Amount, visitdur_2021_11=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-11';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_12=lu.nVisits,  ps.patients_2021_12=lu.nPatients, amount_2021_12=lu.Amount, visitdur_2021_12=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-12';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_01=lu.nVisits,  ps.patients_2022_01=lu.nPatients, amount_2022_01=lu.Amount, visitdur_2022_01=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-01';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_02=lu.nVisits,  ps.patients_2022_02=lu.nPatients, amount_2022_02=lu.Amount, visitdur_2022_02=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-02';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_03=lu.nVisits,  ps.patients_2022_03=lu.nPatients, amount_2022_03=lu.Amount, visitdur_2022_03=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-03';


UPDATE PROTOSUMM
SET 
 visits_Q3_2020= visits_2020_07+visits_2020_08+visits_2020_09,
 visits_Q4_2020= visits_2020_10+visits_2020_11+visits_2020_12,
 visits_Q1_2021= visits_2021_01+visits_2021_02+visits_2021_03,
 visits_Q2_2021= visits_2021_04+visits_2021_05+visits_2021_06,
 visits_Q3_2021= visits_2021_07+visits_2021_08+visits_2021_09,
 visits_Q4_2021= visits_2021_10+visits_2021_11+visits_2021_12,
 visits_Q1_2022= visits_2022_01+visits_2022_02+visits_2022_03,
 patients_Q3_2020= patients_2020_07+patients_2020_08+patients_2020_09,
 patients_Q4_2020= patients_2020_10+patients_2020_11+patients_2020_12,
 patients_Q1_2021= patients_2021_01+patients_2021_02+patients_2021_03,
 patients_Q2_2021= patients_2021_04+patients_2021_05+patients_2021_06,
 patients_Q3_2021= patients_2021_07+patients_2021_08+patients_2021_09,
 patients_Q4_2021= patients_2021_10+patients_2021_11+patients_2021_12,
 patients_Q1_2022= patients_2022_01+patients_2022_02+patients_2022_03,
 amount_Q3_2020= amount_2020_07+amount_2020_08+amount_2020_09,
 amount_Q4_2020 = amount_2020_10+amount_2020_11+amount_2020_12,
 amount_Q1_2021 = amount_2021_01+amount_2021_02+amount_2021_03,
 amount_Q2_2021 = amount_2021_04+amount_2021_05+amount_2021_06,
 amount_Q3_2021 = amount_2021_07+amount_2021_08+amount_2021_09,
 amount_Q4_2021 = amount_2021_10+amount_2021_11+amount_2021_12,
 amount_Q1_2022 = amount_2022_01+amount_2022_02+amount_2022_03,
 visitdur_Q3_2020 = visitdur_2020_07+visitdur_2020_08+visitdur_2020_09,
 visitdur_Q4_2020 = visitdur_2020_10+visitdur_2020_11+visitdur_2020_12,
 visitdur_Q1_2021 = visitdur_2021_01+visitdur_2021_02+visitdur_2021_03,
 visitdur_Q2_2021 = visitdur_2021_04+visitdur_2021_05+visitdur_2021_06,
 visitdur_Q3_2021 = visitdur_2021_07+visitdur_2021_08+visitdur_2021_09,
 visitdur_Q4_2021 = visitdur_2021_10+visitdur_2021_11+visitdur_2021_12,
 visitdur_Q1_2022 = visitdur_2022_01+visitdur_2022_02+visitdur_2022_03;
 
 
drop table If existS ProtoQTRSumm;
CREATE TABLE ProtoQTRSumm as
SELECT  ProtocolID,
		CRCNumber,
        PI_NAME,
        Title,
		visits_Q3_2020,
		visits_Q4_2020,
		visits_Q1_2021,
        visits_Q2_2021,
        visits_Q3_2021,
        visits_Q4_2021,
        visits_Q1_2022,
        
        patients_Q3_2020,
        patients_Q4_2020,
        patients_Q1_2021,
        patients_Q2_2021,
        patients_Q3_2021,
        patients_Q4_2021,
        patients_Q1_2022,
        
        amount_Q3_2020,
        amount_Q4_2020,
        amount_Q1_2021,
        amount_Q2_2021,
        amount_Q3_2021,
        amount_Q4_2021,
        amount_Q1_2022,
        
        visitdur_Q3_2020,
        visitdur_Q4_2020,
        visitdur_Q1_2021,
        visitdur_Q2_2021,
        visitdur_Q3_2021,
        visitdur_Q4_2021,
        visitdur_Q1_2022     
 
 From PROTOSUMM;
 
 
 #################################################
 Select 

