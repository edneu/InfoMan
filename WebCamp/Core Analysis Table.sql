
/*
ctsi_webcamp_pr.
ctsi_webcamp_adhoc.

DESC ctsi_webcamp_adhoc.visitroomcore;
*/
#################################################################################################### 
#################################################################################################### 
############# CREATE CORESERVICES ROOT TABLE
#############
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreRoot;
Create table ctsi_webcamp_adhoc.CoreRoot as
SELECT 
	UNIQUEFIELD AS CoreSvcID,
    STARTDATE AS CoreSvcStart,
    ENDDATE AS CoreSvcEnd,
    TIMEIN AS CoreSvcTimeIn,
    TIMEOUT AS CoreSvcTimeOut,
    P
    QUANTITY_OF_SERVICE,
    PROTOCOL AS ProtocolID,
    STATUS as CoreSvcStatus,
    ### RELATED_TO AS CoreSvcRelatedTo,
    LABTEST AS LabTestID,
    LAB AS LabID,
    OPVISIT,
    ADMISSIO,
    SBADMISSIO,
    DONOTBILL
From ctsi_webcamp_pr.coreservice
WHERE STARTDATE>=str_to_date('07,01,2009','%m,%d,%Y');

/*
    STARTDATE, STR_TO_DATE(concat(trim(TIMEIN),"m"), '%h:%i %p')) AS CoreSvcStart,
    ENDDATE, STR_TO_DATE(concat(trim(TIMEOUT),"m"), '%h:%i %p')) AS CoreSvcEnd,
*/

Alter Table ctsi_webcamp_adhoc.CoreRoot
	ADD SERVICE varchar(100),
    ADD CoreSvcSFY Varchar(25),
    ADD CoreSvcQuarter varchar(25),
	ADD CoreSvcMonth varchar(8),
    ADD QuantityType INT(5),
    ADD QUANTITYUNITS varchar(30),
    ADD BillingUnitSrvc varchar(25),
    ADD ProvPersonID INT(20),
    ADD ProviderPersonName VARCHAR(100),
    ADD VisitFacility varchar(45),
    #### ADD DefaultSvcUnitCost decimal(65,10),
    ADD ProtoSvcUnitCost decimal(65,10),
    ADD SvcUnitCost float,
    ADD Amount decimal(65,10),
    ADD ProtoSpecRate int(1),
    ADD OMIT int(1),
    ADD CoreSvcDTStart Datetime,
    ADD CoreSvcDTEnd Datetime,
    ADD CoreServiceDTDur decimal(65,10);
    
    
SET SQL_SAFE_UPDATES = 0;

##########################
UPDATE ctsi_webcamp_adhoc.CoreRoot
SET CoreSvcDTStart=ADDTIME(CoreSvcStart, STR_TO_DATE(concat(trim(CoreSvcTimeIn),"m"), '%h:%i %p')) ,
    CoreSvcDTEnd=ADDTIME(CoreSvcEnd, STR_TO_DATE(concat(trim(CoreSvcTimeOut),"m"), '%h:%i %p')),
    CoreServiceDTDur=TIME_TO_SEC(TimeDiff(ADDTIME(CoreSvcEnd, STR_TO_DATE(concat(trim(CoreSvcTimeOut),"m"), '%h:%i %p')),ADDTIME(CoreSvcStart, STR_TO_DATE(concat(trim(CoreSvcTimeIn),"m"), '%h:%i %p'))))/60
WHERE CoreSvcTimeOut IS NOT NULL 
  AND CoreSvcTimeIn IS NOT NULL    ; 

UPDATE ctsi_webcamp_adhoc.CoreRoot
SET CoreSvcTotTime=CoreServiceDTDur
WHERE CoreServiceDTDur IS NOT NULL;
##########################

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.labtest lu
SET cr.Service=lu.LABTEST,
	cr.QuantityType=lu.QUANTITYTYPE,
    cr.QUANTITYUNITS=lu.QUANTITYUNITS,
    cr.BillingUnitSrvc=lu.QUANTITYLABEL
where cr.LabTestID=lu.UNIQUEFIELD;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.Labtestcost_t1;
Create table ctsi_webcamp_adhoc.Labtestcost_t1 AS
SELECT Labtest,MAX(Uniquefield) as CurrUF  ## Using LIZ Wood Variable name
FROM ctsi_webcamp_pr.labtestcost
GROUP BY Labtest;

CREATE INDEX crlt ON ctsi_webcamp_adhoc.CoreRoot (LabTestID);

UPDATE 	ctsi_webcamp_adhoc.CoreRoot cr, 
		ctsi_webcamp_pr.labtestcost lu
SET cr.SvcUnitCost=lu.DEFAULTCOST
WHERE cr.LabTestID=lu.LABTEST
AND lu.UNIQUEFIELD IN (SELECT DISTINCT CurrUF from ctsi_webcamp_adhoc.Labtestcost_t1);



UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.labtest lu
	SET cr.QUANTITY_OF_SERVICE=lu.QUANTITYDEFAULT
where cr.LabTestID=lu.UNIQUEFIELD
AND cr.QUANTITY_OF_SERVICE IS NULL;


UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.coreservice_personprovider lu
SET cr.ProvPersonID=PERSON
WHERE cr.CoreSvcID=lu.CORESERVICE;

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.person lu
SET cr.ProviderPersonName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE cr.ProvPersonID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.lab lu
SET cr.VisitFacility=lu.LAB
WHERE cr.LabID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreRoot SET CoreSvcMonth=concat(Year(CoreSvcStart),"-",lpad(month(CoreSvcStart),2,"0"));
UPDATE ctsi_webcamp_adhoc.CoreRoot SET CoreSvcTotTime=time_to_sec(TimeDIFF(CoreSvcEnd,CoreSvcStart))/60 WHERE CoreSvcTotTime IS NULL;

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_adhoc.sfy_classify lu
SET cr.CoreSvcSFY=lu.SFY,
	cr.CoreSvcQuarter=lu.Quarter
WHERE cr.CoreSvcMonth=lu.Month; 


#####################################################################################################
###################   END OF CORE SERVICE TABLE CREATION ############################################
######################################################################################################



#################################################################################################### 
#################################################################################################### 
############# CREATE PROTOCOL ROOT TABLE
DROP TABLE IF Exists ctsi_webcamp_adhoc.ProtoRoot;
Create table ctsi_webcamp_adhoc.ProtoRoot AS
Select UNIQUEFIELD as ProtocolID,
       TITLE as Title,
       Person AS PIPersonID,
       Protocol as CRCNumber
FROM ctsi_webcamp_pr.protocol;    

ALTER TABLE  ctsi_webcamp_adhoc.ProtoRoot
ADD PI_NAME varchar(100);  
       
UPDATE ctsi_webcamp_adhoc.ProtoRoot pr, ctsi_webcamp_pr.person lu
SET pr.PI_NAME=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE pr.PIPersonID=lu.UNIQUEFIELD;

####################################################################################################
####################################################################################################  
#################################################################################################### 
#################################################################################################### 
############# CREATE VISIT ROOT TABLE
#################################################################################################### 

############# HANDLE MISSING TIMEIN AND TIME OUT BY VISITTYPE

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VisitRoot;
Create TABLE ctsi_webcamp_adhoc.VisitRoot
Select 	"OutPatient" AS VisitType,
		UNIQUEFIELD AS VisitID,
        VISITDATE as VisitStart,
        VISITDATE as VisitEnd,
        1.00000 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        PERSON as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID,
        VISITDATE AS tmpSTART,
        VISITDATE AS tmpEND,
        TIMEIN AS tmpTIMEIN,
        TIMEOUT as tmpTIMEOUT
from ctsi_webcamp_pr.opvisit
WHERE UNIQUEFIELD IN (SELECT distinct OPVISIT from ctsi_webcamp_adhoc.CoreRoot)
UNION ALL
Select 	"Inpatient" AS VisitType,
		UNIQUEFIELD AS VisitID,
        ADMITDATE AS VisitStart,
        DISCHDATE AS VisitEnd,
        1.00000 AS VisitLength,
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        PERSON as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID,
        ADMITDATE AS tmpSTART,
        DISCHDATE AS tmpEND,
        TIMEIN AS tmpTIMEIN,
        TIMEOUT as tmpTIMEOUT
from ctsi_webcamp_pr.admissio
WHERE UNIQUEFIELD IN (SELECT distinct ADMISSIO from ctsi_webcamp_adhoc.CoreRoot)
UNION ALL
Select 	"ScatterBed" AS VisitType,
		UNIQUEFIELD AS VisitID,
        ADMITDATE AS VisitStart,
        DISCHDATE AS VisitEnd,
        (DATEDIFF(DISCHDATE,ADMITDATE))*(24*60) AS VisitLength,  ## Minutes 
        STATUS AS VisitStatus,
        PROTOCOL AS ProtocolID,
        trim(PERSON) as PIPersonID, 
        BED as BedID,
        PATIENT AS PatientID,
        ADMITDATE AS tmpSTART,
        DISCHDATE AS tmpEND,
        NULL AS tmpTIMEIN,
        NULL as tmpTIMEOUT
from ctsi_webcamp_pr.sbadmissio
WHERE UNIQUEFIELD IN (SELECT distinct SBADMISSIO from ctsi_webcamp_adhoc.CoreRoot);

UPDATE ctsi_webcamp_adhoc.VisitRoot
SET VisitStart=ADDTIME(tmpSTART, STR_TO_DATE(concat(trim(tmpTIMEIN),"m"), '%h:%i %p')) ,
    VisitEnd=ADDTIME(tmpEND, STR_TO_DATE(concat(trim(tmpTIMEOUT),"m"), '%h:%i %p')),
    VisitLength=TIME_TO_SEC(TimeDiff(ADDTIME(tmpSTART, STR_TO_DATE(concat(trim(tmpTIMEOUT),"m"), '%h:%i %p')),ADDTIME(tmpSTART, STR_TO_DATE(concat(trim(tmpTIMEIN),"m"), '%h:%i %p'))))/60
WHERE tmpTIMEOUT IS NOT NULL 
  AND tmpTIMEIN IS NOT NULL    ;                        

##### ADD ROOMS
ALTER TABLE ctsi_webcamp_adhoc.VisitRoot
ADD Room varchar(12),
ADD RoomID bigint(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.VisitRoot vr, ctsi_webcamp_pr.bed lu
SET vr.RoomID=lu.room
WHERE vr.BedID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.VisitRoot vr, ctsi_webcamp_pr.room lu
SET vr.Room=lu.room
WHERE vr.RoomID=lu.UNIQUEFIELD;

####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################  
################### CREATE CORE VISIT TABLE 
#####################################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreVisit;
Create table ctsi_webcamp_adhoc.CoreVisit AS
	SELECT * from ctsi_webcamp_adhoc.CoreRoot;


ALTER TABLE ctsi_webcamp_adhoc.CoreVisit
	ADD VisitType	varchar(10),
	ADD VisitID		int(20),
	ADD VisitStart	datetime,
	ADD VisitEnd	datetime,
	ADD VisitLength	decimal(18,4),
	ADD VisitStatus	int(5),
	ADD VisitProtocolID	int(20),
	ADD PIPersonID	int(20),
	ADD BedID	    int(20),
    ADD Room varchar(12),
    ADD RoomID bigint(20),
	ADD PatientID	int(20),
    ADD ParticipantName varchar(60),
    ADD ParticipantID varchar(15);


CREATE INDEX cvip  ON ctsi_webcamp_adhoc.CoreVisit (ADMISSIO);
CREATE INDEX cvsb  ON ctsi_webcamp_adhoc.CoreVisit (SBADMISSIO);
CREATE INDEX cvop  ON ctsi_webcamp_adhoc.CoreVisit (OPVISIT);
CREATE INDEX vrvid ON ctsi_webcamp_adhoc.VisitRoot (VisitID);


UPDATE ctsi_webcamp_adhoc.CoreVisit cv, ctsi_webcamp_adhoc.VisitRoot lu
SET 	cv.VisitType=lu.VisitType,
		cv.VisitID=lu.VisitID,
		cv.VisitStart=lu.VisitStart,
		cv.VisitEnd=lu.VisitEnd,
		cv.VisitLength=lu.VisitLength,
		cv.VisitStatus=lu.VisitStatus,
		cv.VisitProtocolID=lu.ProtocolID,
		cv.PIPersonID=lu.PIPersonID,
		cv.BedID=lu.BedID,
        cv.RoomID=lu.RoomID,
        cv.Room=lu.Room,
		cv.PatientID=lu.PatientID
WHERE cv.ADMISSIO=lu.VisitID
AND lu.VisitType="Inpatient"  ;      

UPDATE ctsi_webcamp_adhoc.CoreVisit cv, ctsi_webcamp_adhoc.VisitRoot lu
SET 	cv.VisitType=lu.VisitType,
		cv.VisitID=lu.VisitID,
		cv.VisitStart=lu.VisitStart,
		cv.VisitEnd=lu.VisitEnd,
		cv.VisitLength=lu.VisitLength,
		cv.VisitStatus=lu.VisitStatus,
		cv.VisitProtocolID=lu.ProtocolID,
		cv.PIPersonID=lu.PIPersonID,
		cv.BedID=lu.BedID,
        cv.RoomID=lu.RoomID,
        cv.Room=lu.Room,
		cv.PatientID=lu.PatientID
WHERE cv.SBADMISSIO=lu.VisitID
AND lu.VisitType="ScatterBed"  ;      

UPDATE ctsi_webcamp_adhoc.CoreVisit cv, ctsi_webcamp_adhoc.VisitRoot lu
SET 	cv.VisitType=lu.VisitType,
		cv.VisitID=lu.VisitID,
		cv.VisitStart=lu.VisitStart,
		cv.VisitEnd=lu.VisitEnd,
		cv.VisitLength=lu.VisitLength,
		cv.VisitStatus=lu.VisitStatus,
		cv.VisitProtocolID=lu.ProtocolID,
		cv.PIPersonID=lu.PIPersonID,
		cv.BedID=lu.BedID,
        cv.RoomID=lu.RoomID,
        cv.Room=lu.Room,
		cv.PatientID=lu.PatientID
WHERE cv.OPVISIT=lu.VisitID
AND lu.VisitType="OutPatient"  ;  
 
UPDATE ctsi_webcamp_adhoc.CoreVisit cv,  ctsi_webcamp_pr.patient lu
SET cv.ParticipantName=concat(trim(LASTNAME),", ",trim(FIRSTNAME)),
	cv.ParticipantID=lu.PATIENT
WHERE cv.PatientID=lu.UNIQUEFIELD;    

UPDATE ctsi_webcamp_adhoc.CoreVisit cv,  ctsi_webcamp_pr.patient lu
SET cv.ParticipantName=concat(trim(LASTNAME),", ",trim(FIRSTNAME)),
	cv.ParticipantID=lu.PATIENT
WHERE cv.PatientID=lu.UNIQUEFIELD;  


sELECT UNIQUEFIELD, lABTEST FROM ctsi_webcamp_pr.labtest where LABTEST LIKE "%DRIVER%";

sELECT * FROM ctsi_webcamp_pr.labtestCOST WHERE LABTEST IN
(505,
506,
507,
508,
509,
510);
#####################################################################################################
################### CREATE CORE VISIT PROTOCOL TABLE 
#####################################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreVisitProto;
Create table ctsi_webcamp_adhoc.CoreVisitProto AS
	SELECT * from ctsi_webcamp_adhoc.CoreVisit;
    
ALTER TABLE ctsi_webcamp_adhoc.CoreVisitProto
	ADD Title 		varchar(90),
	ADD CRCNumber	varchar(25),
	ADD PI_NAME		varchar(100);
    
CREATE INDEX cvpptc  ON ctsi_webcamp_adhoc.CoreVisitProto (ProtocolID);
CREATE INDEX prptc ON ctsi_webcamp_adhoc.ProtoRoot (ProtocolID);    
    
UPDATE ctsi_webcamp_adhoc.CoreVisitProto cvp, ctsi_webcamp_adhoc.ProtoRoot lu
SET cvp.Title =lu.Title,
	cvp.CRCNumber=lu.CRCNumber,
    cvp.PI_NAME=lu.PI_NAME
WHERE cvp.ProtocolID=lu.ProtocolID;
######################################################################################################################
######################################################################################################################
### REFORMAT FINAL TABLE
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VRCP_Master;
Create table ctsi_webcamp_adhoc.VRCP_Master as
SELECT       CoreSvcSFY,
             CoreSvcQuarter,
             CoreSvcMonth,
             ProtocolID,
             CRCNumber,
             PIPersonID,
             PI_NAME,
             Title,
             VisitID,
             VisitType,
             VisitStatus,
             VisitStart,
             VisitEnd,
             VisitLength,
             PatientID,
             ParticipantID,
             ParticipantName,
             VisitProtocolID,
             LabID,
             LabTestID,
             SERVICE,
             VisitFacility,
             BedID,
             Room,
             CoreSvcID,
             CoreSvcStart,
             CoreSvcEnd,
             CoreSvcTimeIn,
             CoreSvcTimeOut,
             QUANTITY_OF_SERVICE,
             CoreSvcStatus,
             ProvPersonID,
             ProviderPersonName,
             CoreSvcDTStart,
             CoreSvcDTEnd,
             CoreServiceDTDur,
             CoreSvcTotTime,
             QuantityType,
             QUANTITYUNITS,
             BillingUnitSrvc,
             #### DefaultSvcUnitCost,
             ProtoSpecRate,
             ProtoSvcUnitCost,
             SvcUnitCost,
             Amount,
             DONOTBILL,
             OMIT,
             OPVISIT,
             ADMISSIO,
             SBADMISSIO
FROM ctsi_webcamp_adhoc.CoreVisitProto
ORDER BY CoreSvcMonth, ProtocolID,  VisitID; 

######################################################################################################################
######################################################################################################################
######################################################################################################################
######################################################################################################################
##  SERVICE PRICING ##################################################################################################
######################################################################################################################

SET SQL_SAFE_UPDATES = 0;

ALter table ctsi_webcamp_adhoc.VRCP_Master
ADD BillingUnit varchar(20),
ADD BillingAmt decimal(65,10);

UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit=NULL WHERE QuantityType IN (0,NULL);
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Minutes' WHERE QuantityType=1;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE QuantityType=2;  ##
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Days' WHERE QuantityType=3;   ## 
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance' WHERE QuantityType=4; ##
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit= 'Other Specify' WHERE QuantityType=5;   ## Appears to Be Units
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Weeks' WHERE QuantityType=6; 
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Months' WHERE QuantityType=7; ##
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Years' WHERE QuantityType=8; 
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Dollars' WHERE QuantityType=9; 
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Participants' WHERE QuantityType=10; 

## RIG
UPDATE ctsi_webcamp_adhoc.VRCP_Master Set BillingUnit='Instance' WHERE Service='CTRB: Outpatient Visit (Instance)';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='CTRB:  Outpatient visit (budgeted)';
####  OTHER SPECIFY  QuantityType=5
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE BillingUnitSrvc='1' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE BillingUnitSrvc='Total Time' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE BillingUnitSrvc='Hours' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Dollars' WHERE BillingUnitSrvc='Total Dollars' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Pounds' WHERE BillingUnitSrvc='lb' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='1' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='bag' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='Days' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='Dispense' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='dose' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='Each' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE QUANTITYUNITS='Hour' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE QUANTITYUNITS='Hours' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='inhaler' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='injection' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='instance' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='kit' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='lb' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='meal' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance' WHERE QUANTITYUNITS='overnight' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='pc' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance' WHERE QUANTITYUNITS='protocol' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='spray' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='tablet' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='vial' AND QuantityType=5;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Each' WHERE QUANTITYUNITS='YSI' AND QuantityType=5;

####
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='CTRB:  Outpatient visit (budgeted)';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='' WHERE Service='CTRB: IOA';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='CTRB: Specimen drop off only';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='DIET: Controlled diet (foods weighed)';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='DIET: Regular meal';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='EQS: ECG machine';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='LAB: Specimen Processing - Hourly';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='LAB: Specimen processing - Instance';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='LAB: Specimen shipping';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='NUR: IP Medication administration';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='NUR: Nurse performed ECG';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service='NUR: Nursing Service (Instance)';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='NUR: Scheduled nursing services';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Hours' WHERE Service='NUR: Specimen collection /Blood draw';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingUnit='Instance ' WHERE Service LIKE ('%Instance%') AND BillingUnit='Other Specify';

SELECT * FROM 
#########################################################################################
### USE Protocol Specific Rates if available
UPDATE 	ctsi_webcamp_adhoc.VRCP_Master SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.VRCP_Master cr, ctsi_webcamp_pr.approvedresource ar
SET cr.ProtoSvcUnitCost=ar.RATESPEC,
    cr.ProtoSpecRate=1
WHERE cr. ProtocolID=ar.PROTOCOL
  AND cr.LabTestID=ar.LABTEST
  and (cr.CoreSvcStart>=ar.STARTDATE OR ar.STARTDATE IS NULL)
  and (cr.CoreSvcStart<=ar.ENDDATE OR ar.ENDDATE IS NULL);
  
##UPDATE ctsi_webcamp_adhoc.VRCP_Master SET SvcUnitCost=DefaultSvcUnitCost;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET SvcUnitCost=ProtoSvcUnitCost WHERE ProtoSpecRate=1 AND ProtoSvcUnitCost IS NOT NULL ;


#####
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=0;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=CoreSvcTotTime*SvcUnitCost WHERE BillingUnit='Minutes' ;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/60)*SvcUnitCost WHERE BillingUnit='Hours'; #### 2
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/(60*24))*SvcUnitCost WHERE BillingUnit='Days'; ##### 3
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=1*SvcUnitCost WHERE BillingUnit='Instance' ; ##### 4  Should units be 1 (default unit?)
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=QUANTITY_OF_SERVICE*SvcUnitCost WHERE BillingUnit='Each' ; ## NEW
##UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=QUANTITY_OF_SERVICE*SvcUnitCost WHERE BillingUnit='Other Specify' ;  #### 5 IS THIS CORRECT?
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/(60*24*7))*SvcUnitCost WHERE BillingUnit='Weeks'; 
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/(60*24*7*30.25))*SvcUnitCost WHERE BillingUnit='Months'; ###### 7
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/(60*24*7*30.25*12))*SvcUnitCost WHERE BillingUnit='Months';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(CoreSvcTotTime/(60*24*7*30.25*12))*SvcUnitCost WHERE BillingUnit='Years';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=QUANTITY_OF_SERVICE*SvcUnitCost WHERE  BillingUnit='Dollars';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=QUANTITY_OF_SERVICE*SvcUnitCost WHERE  BillingUnit='Participants';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=QUANTITY_OF_SERVICE*SvcUnitCost WHERE BillingUnitSrvc='Total Time';



UPDATE ctsi_webcamp_adhoc.VRCP_Master SET BillingAmt=(VisitLength/60)*SvcUnitCost WHERE BillingUnit='Hours' AND CoreSvcTotTime=0 AND VisitLength>0 AND SUBSTR(SERVICE,1,4)="CTRB"; 

######################################################################################################################
##### SET OMIT FLAG
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET OMIT=0;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET OMIT=1 Where DONOTBILL=1;
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET OMIT=1 Where SERVICE='CTRB: Outpatient visit (actual)';
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET OMIT=1 WHERE CoreSvcEnd<=str_to_date('06,30,2016','%m,%d,%Y');
UPDATE ctsi_webcamp_adhoc.VRCP_Master SET OMIT=1 WHERE CoreSvcEnd IS NULL;
######################################################################################################################
#### TEST

SELECT       CoreSvcMonth,
             ProtocolID,
             VisitType,
             VisitStatus,
             LabTestID,
             SERVICE,
             VisitFacility,
             CoreSvcID,
             CoreSvcStart,
             CoreSvcEnd,
             CoreSvcTimeIn,
             CoreSvcTimeOut,
             QUANTITY_OF_SERVICE,
             CoreSvcStatus,
             CoreSvcDTStart,
             CoreSvcDTEnd,
             CoreServiceDTDur,
             CoreSvcTotTime,
             QuantityType,
             QUANTITYUNITS,
             BillingUnitSrvc,
             #### DefaultSvcUnitCost,
             ProtoSpecRate,
             ProtoSvcUnitCost,
             SvcUnitCost,
             Amount,
             BillingUnit,
             BillingAmt
from ctsi_webcamp_adhoc.VRCP_Master
WHERE BillingAmt=0  
AND CoreSvcMonth="2022-12" ;       


SELECT 		 LabTestID,
			 ProtocolID,
             SERVICE, 
             QuantityType,
             QUANTITYUNITS,
             CoreServiceDTDur,
             CoreSvcTotTime,
             BillingUnitSrvc,
             DefaultSvcUnitCost,
             
             ProtoSpecRate,
             ProtoSvcUnitCost,
             SvcUnitCost,
             VisitStatus,
             VisitStart,
             VisitEnd,
             VisitLength,
             Amount,
             BillingUnit,
             BillingAmt
from ctsi_webcamp_adhoc.VRCP_Master
WHERE BillingAmt=0  
AND CoreSvcMonth="2022-12" ;   
########################################################## CREATE SERVICE RECONCILIATION
drop table if exists ctsi_webcamp_adhoc.recon1;
create table ctsi_webcamp_adhoc.recon1
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT DISTINCT SERVICE
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12" ;

drop table if exists ctsi_webcamp_adhoc.recon;
create table ctsi_webcamp_adhoc.recon
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.recon1;

ALTER TABLE ctsi_webcamp_adhoc.recon
ADD TotalInvoice float,
ADD TotalVRC float,
ADD DIFF float;  


drop table if exists ctsi_webcamp_adhoc.reconVRCP;
create table ctsi_webcamp_adhoc.reconVRCP
SELECT SERVICE, SUM(BillingAmt) AS TotalVRC
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12"
GROUP BY SERVICE;   
## 14217.6249954100

drop table if exists ctsi_webcamp_adhoc.reconINV;
create table ctsi_webcamp_adhoc.reconINV
Select SERVICE, SUM(AmountDue) as TotalInvoice  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
GROUP BY SERVICE;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconINV lu
SET rc.TotalInvoice=lu.TotalInvoice
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconVRCP lu
SET rc.TotalVRC=lu.TotalVRC
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon 
SET DIFF=TotalInvoice-TotalVRC;

DELETE FROM ctsi_webcamp_adhoc.recon
WHERE TotalInvoice IS NULL
AND TotalVRC IS NULL;

select * from ctsi_webcamp_adhoc.recon;

SELECT "Invoice" As Source, SUM(AmountDue) as Total  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT "VRC" As Source, SUM(BillingAmt) AS Total
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12";


SELECT * from ctsi_webcamp_adhoc.VRCP_Master
WHERE  CoreSvcMonth="2022-12"
AND SERVICE IN (
'LAB: Specimen Processing - Hourly'
##7
);

SELECT * from ctsi_webcamp_adhoc.dec_2022_invoice
WHERE 
SERVICE IN ('LAB: Specimen Processing - Hourly');
) and Principal_Investigator_Last_Name='Atkinson';





select * FROM ctsi_webcamp_adhoc.dec_2022_invoice;

SELECT SERVICE from ctsi_webcamp_adhoc.recon
WHERE SERVICE NOT IN (SELECT DISTINCT LABTEST from ctsi_webcamp_pr.labtest);

Select * from ctsi_webcamp_adhoc.VRCP_Master
WHERE SERVICE="LAB: Specimen Processing - Hourly"
AND CoreSvcMonth="2022-12";

Select * from ctsi_webcamp_adhoc.dec_2022_invoice
WHERE SERVICE="LAB: Specimen Processing - Hourly";

SELECT * from ctsi_webcamp_pr.labtest
where UNIQUEFIELD=90; 

SELECT * from ctsi_webcamp_pr.labtestcost
where labtest=90; 
90
;
##########################################################################################################################################################
##########################################################################################################################################################
##########################################################################################################################################################
##########################################################################################################################################################
##########################################################################################################################################################
##########################################################################################################################################################
##########################################################################################################################################################
/*
DROP TABLE if Exists ctsi_webcamp_adhoc.rec1;
CREATE TABLE ctsi_webcamp_adhoc.rec1 as
Select 	* 
FROM ctsi_webcamp_adhoc.dec_2022_invoice
WHERE SERVICE IN 
(Select DISTINCT SERVICE from ctsi_webcamp_adhoc.VRCP_Master WHERE BillingAmt=0)
Group By Service;


Select * from ctsi_webcamp_pr.labtest 
WHERE LABTEST IN 
(Select 	DISTINCT SERVICE  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
WHERE SERVICE IN 
(Select DISTINCT SERVICE from ctsi_webcamp_adhoc.VRCP_Master WHERE BillingAmt=0))
;

*/





######################################################################################################################
## EOF ###############################################################################################################
######################################################################################################################
######################################################################################################################
######################################################################################################################
######################################################################################################################
######################################################################################################################
######################################################################################################################

/*
select * from ctsi_webcamp_adhoc.CoreRoot;
select * from ctsi_webcamp_adhoc.ProtoRoot;
select * from ctsi_webcamp_adhoc.CoreVisit;
select * from ctsi_webcamp_adhoc.VisitRoot;
select * from ctsi_webcamp_adhoc.CoreVisitProto;
select * from ctsi_webcamp_adhoc.VRCP_Master;

DESC ctsi_webcamp_adhoc.CoreRoot;
DESC ctsi_webcamp_adhoc.ProtoRoot;
DESC ctsi_webcamp_adhoc.CoreVisit;
DESC ctsi_webcamp_adhoc.VisitRoot;
DESC ctsi_webcamp_adhoc.CoreVisitProto;
DESC ctsi_webcamp_adhoc.VRCP_Master;



QuantityType
0 or null=not specified
1=Time in minutes
2=Time in hours
3=Time in whole days
4=Instances
5=Other (specify)
6=Time in weeks
7=Time in months
8=Time in years
9=Dollars
10=Participants
*/
####################################################################################################
###################################################################################################
######################################################################################################  
######################################################################################################






/*  QuantityType
	0 or null=not specified
1=Time in minutes
2=Time in hours
3=Time in whole days
4=Instances
5=Other (specify)
6=Time in weeks
7=Time in months
8=Time in years
9=Dollars
10=Participants
*/