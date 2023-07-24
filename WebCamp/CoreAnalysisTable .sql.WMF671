
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
    TOTAL_TIME AS CoreSvcTotTime,
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
From ctsi_webcamp_pr.coreservice;

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
    ADD BillingUnitSrvc varchar(25),
    ADD ProvPersonID INT(20),
    ADD ProviderPersonName VARCHAR(100),
    ADD VisitFacility varchar(45),
    ADD DefaultSvcUnitCost decimal(65,10),
    ADD ProtoSvcUnitCost decimal(65,10),
    ADD SvcUnitCost decimal(65,10),
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

  
  ###select * from ctsi_webcamp_adhoc.CoreRoot;

##########################



UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.labtest lu
SET cr.Service=lu.LABTEST,
	cr.QuantityType=lu.QUANTITYTYPE,
    cr.BillingUnitSrvc=lu.QUANTITYLABEL
where cr.LabTestID=lu.UNIQUEFIELD;



UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.coreservice_personprovider lu
SET cr.ProvPersonID=PERSON
WHERE cr.CoreSvcID=lu.CORESERVICE;
    

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.person lu
SET cr.ProviderPersonName=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE cr.ProvPersonID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.lab lu
SET cr.VisitFacility=lu.LAB
WHERE cr.LabID=lu.UNIQUEFIELD;


UPDATE ctsi_webcamp_adhoc.CoreRoot SET CoreSvcMonth=concat(Year(CoreSvcEnd),"-",lpad(month(CoreSvcEnd),2,"0"));
UPDATE ctsi_webcamp_adhoc.CoreRoot SET CoreSvcTotTime=time_to_sec(TimeDIFF(CoreSvcEnd,CoreSvcStart))/60 WHERE CoreSvcTotTime IS NULL;


UPDATE ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_adhoc.sfy_classify lu
SET cr.CoreSvcSFY=lu.SFY,
	cr.CoreSvcQuarter=lu.Quarter
WHERE cr.CoreSvcMonth=lu.Month; 



UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc=NULL WHERE QuantityType IN (0,NULL);
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Minutes' WHERE QuantityType=1;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Hours' WHERE QuantityType=2;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Days' WHERE QuantityType=3;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Instance' WHERE QuantityType=4;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc= 'Other Specify' WHERE QuantityType=5;  ## Appears to Be Units
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Weeks' WHERE QuantityType=6; 
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Months' WHERE QuantityType=7; 
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Years' WHERE QuantityType=8; 
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Dollars' WHERE QuantityType=9; 
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Participants' WHERE QuantityType=10; 


## RIG
UPDATE ctsi_webcamp_adhoc.CoreRoot Set BillingUnitSrvc='Instance' WHERE Service='CTRB: Outpatient Visit (Instance)';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET BillingUnitSrvc='Hours' WHERE Service='CTRB:  Outpatient visit (budgeted)';
##
 

##### SET OMIT FLAG
UPDATE ctsi_webcamp_adhoc.CoreRoot SET OMIT=0;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET OMIT=1 Where DONOTBILL=1;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET OMIT=1 Where SERVICE='CTRB: Outpatient visit (actual)';


###1392

####################################
#####  Add Pricing
UPDATE 	ctsi_webcamp_adhoc.CoreRoot cr, 
		ctsi_webcamp_pr.labtestcost lu
SET cr.DefaultSvcUnitCost=lu.DEFAULTCOST
WHERE cr.LabTestID=lu.LABTEST;

### USE Protocol Specific Rates if available
UPDATE 	ctsi_webcamp_adhoc.CoreRoot SET ProtoSpecRate=0;

UPDATE 	ctsi_webcamp_adhoc.CoreRoot cr, ctsi_webcamp_pr.approvedresource ar
SET cr.ProtoSvcUnitCost=ar.RATESPEC,
    cr.ProtoSpecRate=1
WHERE cr. ProtocolID=ar.PROTOCOL
  AND cr.LabTestID=ar.LABTEST
  and (cr.CoreSvcStart>=ar.STARTDATE OR ar.STARTDATE IS NULL)
  and (cr.CoreSvcStart<=ar.ENDDATE OR ar.ENDDATE IS NULL);
  
UPDATE ctsi_webcamp_adhoc.CoreRoot SET SvcUnitCost=DefaultSvcUnitCost;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET SvcUnitCost=ProtoSvcUnitCost WHERE ProtoSpecRate=1;


UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=NULL WHERE BillingUnitSrvc=NULL;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=CoreSvcTotTime*SvcUnitCost WHERE BillingUnitSrvc='Minutes' ;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/60)*SvcUnitCost WHERE BillingUnitSrvc='Hours';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/(60*24))*SvcUnitCost WHERE BillingUnitSrvc='Days';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=QUANTITY_OF_SERVICE*SvcUnitCost WHERE BillingUnitSrvc='Instance' ;
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=QUANTITY_OF_SERVICE*SvcUnitCost WHERE BillingUnitSrvc='Other Specify' ;  #### IS THIS CORRECT?
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/(60*24*7))*SvcUnitCost WHERE BillingUnitSrvc='Weeks'; 
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/(60*24*7*30.25))*SvcUnitCost WHERE BillingUnitSrvc='Months';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/(60*24*7*30.25*12))*SvcUnitCost WHERE BillingUnitSrvc='Months';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=(CoreSvcTotTime/(60*24*7*30.25*12))*SvcUnitCost WHERE BillingUnitSrvc='Years';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=QUANTITY_OF_SERVICE*SvcUnitCost WHERE  BillingUnitSrvc='Dollars';
UPDATE ctsi_webcamp_adhoc.CoreRoot SET Amount=QUANTITY_OF_SERVICE*SvcUnitCost WHERE  BillingUnitSrvc='Participants';

## RIG
UPDATE ctsi_webcamp_adhoc.CoreRoot Set AMOUNT=QUANTITY_OF_SERVICE*.25*SvcUnitCost WHERE Service='NUR: Specimen collection /Blood draw';
##

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

select * from ctsi_webcamp_adhoc.ProtoRoot where PI_NAME like "%Shenk%";

select * from ctsi_webcamp_adhoc.ProtoRoot where CRCNumber like "%1392%";
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
WHERE UNIQUEFIELD IN (SELECT distinct  ADMISSIO from ctsi_webcamp_adhoc.CoreRoot)
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



select * from ctsi_webcamp_adhoc.VisitRoot where ProtocolID=812;
####################################################################################################
####################################################################################################  
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
	ADD PatientID	int(20);


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
		cv.PatientID=lu.PatientID
WHERE cv.OPVISIT=lu.VisitID
AND lu.VisitType="OutPatient"  ;   



desc ctsi_webcamp_adhoc.VisitRoot;

SELECT * from ctsi_webcamp_adhoc.CoreVisit where ProtocolID=812;

SELECT * from ctsi_webcamp_adhoc.CoreVisit where CoreSvcMonth="2022-12"; 

Select * from ctsi_webcamp_adhoc.CoreVisit 
WHERE CoreSvcStart is NULL
AND CoreSvcEnd is NULL 
AND  VisitStart is NULL
AND  VisitEND IS NULL;

select * from ctsi_webcamp_pr.opvisit where Uniquefield =25792;

## EOF
####################################################################################################
###################################################################################################
######################################################################################################  
SELECT * from ctsi_webcamp_adhoc.CoreRoot where ProtocolID=812;
select * from ctsi_webcamp_adhoc.CoreRoot WHERE CoreSvcMonth="2022-12" ;
#AND OMIT=0;  

select sum(Amount) from ctsi_webcamp_adhoc.CoreRoot WHERE CoreSvcMonth="2022-12" AND OMIT=0;  
######################################################################################################

select * from ctsi_webcamp_pr.coreservice where Protocol=812;


SELECT *
from ctsi_webcamp_adhoc.CoreRoot 
WHERE DONOTBILL=0
AND ProtocolID like "%4%";


select distinct ProtocolID from ctsi_webcamp_adhoc.CoreRoot;

SELECT * from ctsi_webcamp_pr.protocol where Protocol like "%1636A%";
;
;
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
 




/*
	Quantity of the specified service (LABTEST field) performed in connection with the current record. 
    The label and units of quantity are dictated by the QUANTITYLABEL and QUANTITYUNITS fields in the associated LABTEST record;
    the inclusion of this field in data-entry screens is dictated by the INCLUDEQUANTITY field in the associated LABTEST record
*/




select * from ctsi_webcamp_adhoc.ProtoRoot; 

select count(*) from ctsi_webcamp_adhoc.CoreRoot where ProtocolID not in (select distinct ProtocolID from ctsi_webcamp_adhoc.ProtoRoot);




select * from ctsi_webcamp_adhoc.CoreRoot WHERE DONOTBILL=0;
select SERVICE,BillingUnitSrvc from ctsi_webcamp_adhoc.CoreRoot GROUP BY SERVICE,BillingUnitSrvc;

desc ctsi_webcamp_adhoc.CoreRoot;

######################################################################################################



SELECT  Service,QuantityType,count(*) from ctsi_webcamp_adhoc.CoreRoot 
WHERE CoreSvcMonth="2022-12" 
GROUP BY QuantityType ;


DESC ctsi_webcamp_adhoc.visitroomcore;

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