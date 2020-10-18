#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## CREATE VISITCORE TABLE 1 Records Per Visit Outpatient, Inpatient, and Swingbed.


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
        BED as BedID
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
        BED as BedID
from ctsi_webcamp_pr.admissio
UNION ALL
Select 	"SwingBed" AS VisitType,
		UNIQUEFIELD AS VisitID,
        ADMITDATE AS VisitDate,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS VisitStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS VisitEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        trim(PERSON) as PIPersonID, 
        BED as BedID
from ctsi_webcamp_pr.admissio;


SET SQL_SAFE_UPDATES = 0;


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.PIPersonID=lu.PERSON
WHERE vc.ProtocolID=lu.UNIQUEFIELD
AND vc.PIPersonID IS NULL; 


ALTER TABLE ctsi_webcamp_adhoc.visitcore
ADD PI_NAME varchar(55),
ADD Title varchar(255),
ADD CRCNumber varchar(25);


UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.person lu
SET vc.PI_NAME=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE vc.PIPersonID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.visitcore vc, ctsi_webcamp_pr.protocol lu
SET vc.Title=lu.LONGTITLE,
	vc.CRCNumber=lu.Protocol
WHERE vc.ProtocolID=lu.UNIQUEFIELD;
		
## DATE FILTER
DELETE FROM ctsi_webcamp_adhoc.visitcore  WHERE Visitdate<=str_to_date('07,01,2017','%m,%d,%Y')    ;
    
#Select * FROM ctsi_webcamp_adhoc.visitcore;        
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## CREATE CORE SERVICE LOOKUP Multiple Records per VISIT


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreSvcLU;
Create table  ctsi_webcamp_adhoc.CoreSvcLU AS
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
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE ADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visitcore WHERE VisitType="Inpatient")
UNION ALL
SELECT "SwingBed" AS VisitType,
		SBADMISSIO AS VisitID,
        UNIQUEFIELD AS CoreSvcID,
        PROTOCOL AS CoreSvcProtocolID,
        STARTDATE as CoreSvcVisitDate,
        QUANTITY_OF_SERVICE AS CoreSvcQuant,
        STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p') AS CoreSvcStartTIme,
        STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p') AS CoreSvcEndTIme,
        TIME_TO_SEC(TimeDiff(STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')))/60 AS CoreSvcVistLen,
        STATUS AS CoreSvcStatus,
        LAB AS LabID,
        LABTEST AS LabTestID
FROM ctsi_webcamp_pr.coreservice
WHERE SBADMISSIO in (SELECT VisitID FROM ctsi_webcamp_adhoc.visitcore WHERE VisitType="SwingBed");


ALTER TABLE ctsi_webcamp_adhoc.CoreSvcLU
ADD VisitFacility varchar(45),
ADD Service varchar(100),
ADD SvcUnitCost float,
ADD Amount float,
ADD ProvPersonID bigint(20),
ADD ProvPersonName varchar(100),
ADD ProtoSpecRate int(1);



SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.lab lu
SET cs.VisitFacility=lu.LAB
WHERE cs.LabID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.labtest lu
SET cs.Service =lu.LABTEST
WHERE cs.LabTestID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.coreservice_personprovider lu
SET cs.ProvPersonID =lu.PERSON
WHERE cs.CoreSvcID=lu.CORESERVICE;

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



SELECT * from ctsi_webcamp_adhoc.VisitRoomCore;


#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################
## Verify

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


DROP TABLE If exists ctsi_webcamp_adhoc.VCRSummary;
CREATE TABLE ctsi_webcamp_adhoc.VCRSummary AS
SELECT Year(VisitDate) As CalYear,
	   count(distinct VisitID) as nVISITS,
       Count(distinct ProtocolID) as nProtocols,
       SUM(VisitLength)/60 as VisitLengthHr,
	   Count(distinct PIPersonID) as nPIs,
       Count(distinct Service) as nService,
       SUM(Amount) as TotalAmt
From ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY CalYear
Order by CalYear;

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

#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################




######################################################
######################################################
######### ADD COSTS  SCRATCH

/*
######### ADD NON-PROTOCL SPECIFIC COST DATA 
UPDATE 	ctsi_webcamp_adhoc.OPVCS op, 
		ctsi_webcamp_pr.labtestcost lu
SET op.Amount=lu.DEFAULTCOST
WHERE op.LABTEST=lu.LABTEST
  AND (op.VISITDATE>=lu.STARTDATE or lu.STARTDATE IS NULL)
  AND (op.VISITDATE<=lu.ENDDATE OR lu.ENDDATE IS NULL);

######### UPDATE PROTOCOL SPECIFIC Service Costs
UPDATE 	ctsi_webcamp_adhoc.OPVCS op
SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.OPVCS op,
		ctsi_webcamp_pr.approvedresource ar
SET op.AMOUNT=ar.RATESPEC,
    op.ProtoSpecRate=1
WHERE op.ProtoID=ar.PROTOCOL
  AND op.LABTEST=ar.LABTEST;
  #AND op.AMOUNT IS NULL;   

######### PRICE ZERO COST SERVICES NOT FOUND IN LABTEST COST
UPDATE ctsi_webcamp_adhoc.OPVCS
       SET Amount=0
WHERE LABTEST IN (154, 220, 143);
 
######### UPDATE ALL TOTAL AMOUNT
UPDATE ctsi_webcamp_adhoc.OPVCS op
SET op.TotAmt=op.AMOUNT*op.SvcQuant;

select LabTestID, Service, count(*) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE LabTestID NOT IN (SELECT DISTINCT LABTEST from ctsi_webcamp_pr.labtestcost)
GROUP BY LabTestID, Service;


select * from ctsi_webcamp_adhoc.OPVCS;
*/