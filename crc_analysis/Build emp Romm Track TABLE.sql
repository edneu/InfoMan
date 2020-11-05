#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## CREATE VISITCORE TABLE 1 Records Per Visit Outpatient, Inpatient, and Scatterbed.


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.visitcore; 
CREATE TABLE ctsi_webcamp_adhoc.visitcore 
Select 	"OutPatient" AS VisitType,
		UNIQUEFIELD AS VisitID,
        VISITDATE AS VisitDate,
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
        ADMITDATE AS VisitDate,
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
        ADMITDATE AS VisitDate,
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
ADD PatientName varchar(45);


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
		
## DATE FILTER

DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE VisitStatus<>2;
DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE Visitdate<str_to_date('01,01,2016','%m,%d,%Y')    ;
DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE Visitdate>CURDATE();     
#Select * FROM ctsi_webcamp_adhoc.visitcore;        
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## CREATE CORE SERVICE LOOKUP Multiple Records per VISIT


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU1;
Create table  ctsi_webcamp_adhoc.CoreSvcLU1 AS
SELECT "OutPatient" AS VisitType,
	    OPVISIT AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcVisitDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE OPVISIT in (SELECT VisitID FROM ctsi_webcamp_adhoc.visitcore WHERE VisitType="OutPatient")
UNION ALL
SELECT "Inpatient" AS VisitType,
		ADMISSIO AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcVisitDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE ADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visitcore WHERE VisitType="Inpatient")
UNION ALL
SELECT "ScatterBed" AS VisitType,
		SBADMISSIO AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcVisitDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        RELATED_TO AS CoreSvcRelatedTo,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE SBADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visitcore WHERE VisitType="ScatterBed");

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU;
Create table  ctsi_webcamp_adhoc.CoreSvcLU AS
SELECT cs.VisitType,
	cs.VisitID,
	cs.CoreSvcID,
	cs.CoreSvcProtocolID,
	cs.CoreSvcVisitDate,
	cs.CoreSvcQuant,
	cs.CoreSvcStartTIme,
	cs.CoreSvcEndTIme,
	cs.CoreSvcVistLen,
	cs.CoreSvcStatus,
    cs.CoreSvcRelatedTo,
	cs.LabID,
	cs.LabTestID,
	pp.PERSON AS ProvPersonID
from ctsi_webcamp_adhoc.CoreSvcLU1 cs 
LEFT JOIN ctsi_webcamp_pr.coreservice_personprovider pp
ON cs.CoreSvcID = pp.CORESERVICE;







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
  AND (cs.CoreSvcVisitDate>=lu.STARTDATE or lu.STARTDATE IS NULL)
  AND (cs.CoreSvcVisitDate<=lu.ENDDATE OR lu.ENDDATE IS NULL);
  

UPDATE 	ctsi_webcamp_adhoc.CoreSvcLU
SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.CoreSvcLU cs,
		ctsi_webcamp_pr.approvedresource ar
SET cs.SvcUnitCost=ar.RATESPEC,
    cs.AMOUNT=ar.RATESPEC*cs.CoreSvcQuant,
    cs.ProtoSpecRate=1
WHERE cs.CoreSvcProtocolID=ar.PROTOCOL
  AND cs.LabTestID=ar.LABTEST;

DELETE FROM ctsi_webcamp_adhoc.CoreSvcLU WHERE CoreSvcStatus<>2;

SELECT * from ctsi_webcamp_adhoc.CoreSvcLU;


#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
### BUILD ROOM LOOKUP
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.RoomLookup; 
CREATE TABLE ctsi_webcamp_adhoc.RoomLookup As
SELECT VisitType,
	   VisitID,
       BedID
 FROM ctsi_webcamp_adhoc.visitcore
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

SELECT * from ctsi_webcamp_adhoc.RoomLookup; 



#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################

#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################


CREATE INDEX vcvi ON ctsi_webcamp_adhoc.visitcore (VisitID);
CREATE INDEX rlvi ON ctsi_webcamp_adhoc.RoomLookup (VisitID);

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VisitRoom; 
CREATE TABLE ctsi_webcamp_adhoc.VisitRoom As
SELECT 
           vc.VisitType,
           vc.VisitID,	
           vc.VisitDate,
           vc.VisitStartTIme,
           vc.VisitEndTIme,
           vc.VisitLength,
           
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
FROM ctsi_webcamp_adhoc.visitcore vc
	LEFT JOIN ctsi_webcamp_adhoc.RoomLookup rl
    ON vc.VisitType=rl.VisitType
    AND vc.VisitID=rl.VisitID;
    
    
  
#######################################################################################

#######################################################################################
#######################################################################################   

CREATE INDEX vrvi ON ctsi_webcamp_adhoc.VisitRoom (VisitID);
CREATE INDEX csvi ON ctsi_webcamp_adhoc.CoreSvcLU (VisitID);


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VisitRoomCore; 
CREATE TABLE ctsi_webcamp_adhoc.VisitRoomCore As
SELECT 
			vr.VisitType,
			vr.VisitID,	
			vr.VisitDate,
			vr.VisitStartTIme,
			vr.VisitEndTIme,
			vr.VisitLength,
            vr.VisitStatus,
            vr.PatientID,
            vr.PatientName,
			vr.ProtocolID,
			vr.PIPersonID,
			vr.PI_NAME,
			vr.Title,
			vr.CRCNumber,
			vr.Bed,
			vr.RoomID,
			vr.Room,
			cr.CoreSvcID,
			cr.CoreSvcProtocolID,
			cr.CoreSvcVisitDate,
			cr.CoreSvcStartTIme,
			cr.CoreSvcEndTIme,
			cr.CoreSvcVistLen,
			cr.CoreSvcStatus,
            cr.CoreSvcRelatedTo,
            cr.LabID,
		    cr.LabTestID,
            cr.VisitFacility,
			cr.Service,
            cr.ProtoSpecRate,
            cr.SvcUnitCost,
            cr.CoreSvcQuant,
            cr.Amount,
			cr.ProvPersonID,
			cr.ProvPersonName
FROM ctsi_webcamp_adhoc.VisitRoom vr
LEFT JOIN ctsi_webcamp_adhoc.CoreSvcLU cr
ON vr.VisitType=cr.VisitType
AND vr.VisitID=cr.VisitID;

## 5 VISIT RECORDS WITH NO CORE SERVICE RECORD
DELETE FROM ctsi_webcamp_adhoc.VisitRoomCore where CoreSvcID is null;

SELECT "Total Records" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore
UNION ALL 
SELECT "No Provider" AS DescMeasure, COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE ProvPersonID IS NULL;


SELECT ProvPersonID,ProvPersonName, Count(*) from ctsi_webcamp_adhoc.VisitRoomCore group by ProvPersonID,ProvPersonName; 

### MISSING PERSON PROVIDERS
SELECT YEar(Visitdate), COUNT(*) As Measure from ctsi_webcamp_adhoc.VisitRoomCore WHERE ProvPersonID IS NULL group by YEar(Visitdate);

SELECT PI_NAME,COUNT(*) as nREC,SUM(case when ProvPersonID IS NULL then 1 else 0 end) as nMissProv FROM ctsi_webcamp_adhoc.VisitRoomCore group by PI_NAME;
SELECT Service,COUNT(*) as nREC,SUM(case when ProvPersonID IS NULL then 1 else 0 end) as nMissProv FROM ctsi_webcamp_adhoc.VisitRoomCore group by Service;



/*
SELECT * from ctsi_webcamp_adhoc.VisitRoomCore;
SELECT VisitType,CoreSvcRelatedTo,count(*) from ctsi_webcamp_adhoc.VisitRoomCore group by VisitType,CoreSvcRelatedTo;  


SELECT * from ctsi_webcamp_adhoc.VisitRoomCore where CoreSvcRelatedTo is null;
SELECT * from ctsi_webcamp_adhoc.VisitRoomCore where CoreSvcID is null;
*/
#######################################################################################

SELECT 
concat(YEAR(CoreSvcVisitDate),"-",LPAD(MONTH(CoreSvcVisitDate),2,"0")) AS MONTH,
COUNT(DISTINCT VISITID) As nVISIT,
COUNT(DISTINCT PatientID) nUndupPatients,
(sum(VisitLength))/60 AS VisitHours
#(sum(VisitLength)/60)/(COUNT(DISTINCT PatientID)) As HoursPerPatient,
#(sum(VisitLength)/60)/(COUNT(DISTINCT VISITID)) As HoursPerVisit

FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE YEAR(CoreSvcVisitDate) IN (2018,2019,2020)
GROUP BY concat(YEAR(CoreSvcVisitDate),"-",LPAD(MONTH(CoreSvcVisitDate),2,"0"));


SELECT VisitDate,CoreSvcVisitDate from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitDate<>CoreSvcVisitDate;



SELECT VisitDate,CoreSvcVisitDate, datediff(VisitDate,CoreSvcVisitDate) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitDate<>CoreSvcVisitDate;



#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################
## Verify
/*
select * from ctsi_webcamp_adhoc.visitcore;
SELECT * from ctsi_webcamp_adhoc.CoreSvcLU ;
SELECT * from ctsi_webcamp_adhoc.RoomLookup;
SELECT * from ctsi_webcamp_adhoc.VisitRoomCore;
 

SELECT "visitcore" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.visitcore
UNION ALL
SELECT "CoreSvcLU" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.CoreSvcLU
UNION ALL
SELECT "RoomLookup" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.RoomLookup
UNION ALL
SELECT "VisitRoom" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.VisitRoom
UNION ALL
SELECT "VisitRoomCore" AS FileName,Count(*) as nREC, COUNT(DISTINCT VisitID) AS nVisits from ctsi_webcamp_adhoc.VisitRoomCore;



DESC ctsi_webcamp_adhoc.visitcore;
DESC ctsi_webcamp_adhoc.RoomLookup;
DESC ctsi_webcamp_adhoc.VisitRoom;
DESC ctsi_webcamp_adhoc.CoreSvcLU;
DESC ctsi_webcamp_adhoc.VisitRoomCore;
*/

DROP TABLE If exists ctsi_webcamp_adhoc.VCRSummary;
CREATE TABLE ctsi_webcamp_adhoc.VCRSummary AS
SELECT Year(VisitDate) As CalYear,
       Count(*) as nRecs,
       count(distinct VisitID) as nVISITS1,
	   count(distinct concat(VisitType,VisitID)) as nVISITS,
       Count(distinct ProtocolID) as nProtocols,
       SUM(VisitLength)/60 as VisitLengthHr,
	   Count(distinct PIPersonID) as nPIs,
       Count(distinct Service) as nService,
       SUM(Amount) as TotalAmt,
       SUM( IF ( ProvPersonID is null, 1, 0 ) ) as nNULLProvID
From ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY CalYear
Order by CalYear;


#DELETE FROM ctsi_webcamp_adhoc.VisitRoomCore WHERE Visitdate<str_to_date('01,01,2017','%m,%d,%Y')    ;
#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################

SELECT VisitType
VisitID,
CoreSvcVisitDate,
CoreSvcStartTIme,
CoreSvcEndTIme,
CoreSvcVistLen,
ProvPersonName,
Service,
CoreSvcQuant,
SvcUnitCost,
Amount
From ctsi_webcamp_adhoc.VisitRoomCore
;


#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################

#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################

drop table if exists ctsi_webcamp_adhoc.temp;
Create table ctsi_webcamp_adhoc.temp AS
SELECT VISITID,COUNT(DISTINCT CoreSvcID) as nCORESVC, COUNT(*) AS n
FROM ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY VisitID;

SELECT * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VISITID IN (SELECT VISITID from ctsi_webcamp_adhoc.temp WHERE nCORESVC<>n);


SELECT * from ctsi_webcamp_adhoc.temp WHERE nCORESVC<>n;

################################

'visitcore'

drop table if exists ctsi_webcamp_adhoc.temp2;
Create table ctsi_webcamp_adhoc.temp2 AS
SELECT VISITID,COUNT(*) AS n
FROM ctsi_webcamp_adhoc.visitcore
GROUP BY VISITID;

SELECT * from ctsi_webcamp_adhoc.temp2 WHERE n>1;

SELECT * FROM ctsi_webcamp_adhoc.visitcore
WHERE VISITID IN (SELECT DISTINCT VISITID from ctsi_webcamp_adhoc.temp2 WHERE n>1);


select VisitType, count(*) from ctsi_webcamp_adhoc.visitcore group by VisitType;

######################################################


Select Year(Visitdate), Room, Count(*)
FROm ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY Year(Visitdate), Room;


Select Room, Count(*)
FROm ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY Room;

Select *
FROm ctsi_webcamp_adhoc.VisitRoomCore
WHERE Year(Visitdate)<>YEar(CoreSvcVisitDate);


3788	8	9
3926	7	8
3927	7	8

CORE SERVICE STATUS

0 or null=not entered
 1=Scheduled
 2=Completed
 3=Begun
 4=No-show
 5=Request cancelled
 6=Requested
 7=Request denied
 8=Stopped prematurely
 9=Re-scheduling requested
 9=Re-scheduling requested
 
 
 OPVISIT STATUS
0 or null=not entered
 1=Scheduled
 2=Completed
 3=Begun
 4=No-show
 5=Request cancelled
 6=Requested
 7=Request denied
 8=Stopped prematurely
 9=Re-scheduling requested
 9=Re-scheduling requested
 
 
CORESERVICE.REALTED_TO
What is this service related to (visit, admission, recognized protocol, or other)?	
1=Inpatient admission
 2=Outpatient visit
 3=Scatter bed admission
 4=Other
 5=Unknown protocol
 6=Non-CTSA or non-GCRC protocol
 7=CTSC/GCRC protocol
 
 
 
 ##############################################################################
 ###########  SUmmary from MATTS List
 DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_study_summ ;
 create table ctsi_webcamp_adhoc.crc_study_summ AS
  select	Span,
			Email,
            LastName,
            FirstName,
            CRCID,
            IRB,
            Title,
            StudyClosed
 from  ctsi_webcamp_adhoc.crc_study_covid
 WHERE StudyClosed IN ('OPEN TO ACCRUAL', 'No');
 

ALTER TABLE ctsi_webcamp_adhoc.crc_study_summ
ADD nVISITS_FY20 bigint(21),
ADD nPatients_FY20 bigint(21),
ADD Amount_FY20 Double(19,2),
ADD nVISITS_FY21 bigint(21),
ADD nPatients_FY21 bigint(21),
ADD Amount_FY21 Double(19,2);



DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_statFY20 ;
create table ctsi_webcamp_adhoc.crc_statFY20 AS
select 	CRCNumber as CRCID,
 		Count(DISTINCT VisitID) As nVISITS_FY20,
		Count(DISTINCT PatientID) as nPatients_FY20,
		ROUND(SUM(Amount),2) as Amount_FY20
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE CoreSvcVisitDate BETWEEN str_to_date('07,01,2019','%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y')
AND CRCNumber IN (SELECT DISTINCT CRCID from ctsi_webcamp_adhoc.crc_study_covid)
GROUP BY CRCNumber;

 
 
 
 
DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_statFY21 ;
create table ctsi_webcamp_adhoc.crc_statFY21 AS
select 	CRCNumber as CRCID,
 		Count(DISTINCT VisitID) As nVISITS_FY21,
		Count(DISTINCT PatientID) as nPatients_FY21,
		ROUND(SUM(Amount),2) as Amount_FY21
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE CoreSvcVisitDate BETWEEN str_to_date('07,01,2020','%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y')
AND CRCNumber IN (SELECT DISTINCT CRCID from ctsi_webcamp_adhoc.crc_study_covid)
GROUP BY CRCNumber;

desc ctsi_webcamp_adhoc.crc_statFY21;

UPDATE ctsi_webcamp_adhoc.crc_study_summ ss, ctsi_webcamp_adhoc.crc_statFY20 lu
SET ss.nVISITS_FY20=lu.nVISITS_FY20,
	ss.nPatients_FY20=lu.nPatients_FY20 ,
    ss.Amount_FY20=lu.Amount_FY20
WHERE ss.CRCID=lu.CRCID;    

UPDATE ctsi_webcamp_adhoc.crc_study_summ ss, ctsi_webcamp_adhoc.crc_statFY21 lu
SET ss.nVISITS_FY21=lu.nVISITS_FY21,
	ss.nPatients_FY21=lu.nPatients_FY21 ,
    ss.Amount_FY21=lu.Amount_FY21
WHERE ss.CRCID=lu.CRCID; 

SELECT * from ctsi_webcamp_adhoc.crc_study_summ ;


 