
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc1349;
Create table ctsi_webcamp_adhoc.vrc1349 as
Select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber='1349'
AND VisitStart>str_to_date('10,13,2022','%m,%d,%Y')
AND ParticipantID=1467706;


;
select * from ctsi_webcamp_pr.patient
WHERE UNIQUEFIELD=34746;

select * from ctsi_webcamp_pr.patient
WHERE PATIENT=1467706;

####################################################################################
################## Raw tables for Sand CRC 1349

## Tables USED  ###
## ctsi_webcamp_pr.protocol
## ctsi_webcamp_pr.coreservice
##v ctsi_webcamp_pr.approvedresource
## ctsi_webcamp_pr.labtestcost


## Find Internal PROTOCOL PRIMARY KEY FOR CRC1349
SELECT UNIQUEFIELD as ProtocolID FROM ctsi_webcamp_pr.protocol WHERE Protocol=1349;  ## Get Key for CRCNumber
### 775 is protocol key for CRC# 1349


### Core Service Records for this protocl since 7/1/2022
drop table if exists ctsi_webcamp_adhoc.coreservice1349;
create table ctsi_webcamp_adhoc.coreservice1349 as
SELECT * from ctsi_webcamp_pr.coreservice
WHERE PROTOCOL=775
AND STARTDATE>=str_to_date('07,01,2022','%m,%d,%Y');

## Any protocol specific rates - THERE are none for CRC1349
drop table if exists ctsi_webcamp_adhoc.approvederes1349;
create table ctsi_webcamp_adhoc.approvederes1349 as
SELECT * from ctsi_webcamp_pr.approvedresource
WHERE LABTEST IN (select distinct LABTEST from ctsi_webcamp_adhoc.coreservice1349)
AND PROTOCOL=775;
## EMPTY ##Protocol 775 has no special rates on file.
;
### DEFAULT LABTEST COSTS for CORESERVICES USED IN THIS PROTOCOL
drop table if exists ctsi_webcamp_adhoc.labtestcost1349;
create table ctsi_webcamp_adhoc.labtestcost1349 as
SELECT * from ctsi_webcamp_pr.labtestcost
WHERE LABTEST IN (select distinct LABTEST from ctsi_webcamp_adhoc.coreservice1349);

### Labtest record for all Labtests used in this Protocol - contain Service name in the field "LABTEST"
drop table if exists ctsi_webcamp_adhoc.labtest1349;
create table ctsi_webcamp_adhoc.labtest1349 as
SELECT * from ctsi_webcamp_pr.labtest
WHERE UNIQUEFIELD IN (select distinct LABTEST from ctsi_webcamp_adhoc.coreservice1349);




select distinct  from ctsi_webcamp_adhoc.coreservice1349;


select * from ctsi_webcamp_pr.coreservice
WHERE UNIQUEFIELD=344848;


select distinct VisitFacility from ctsi_webcamp_adhoc.visitroomcore;

##############################################################################################
##############################################################################################
##############################################################################################
##############################################################################################
##############################################################################################
##############################################################################################
drop table if exists ctsi_webcamp_adhoc.coreservice1349;
create table ctsi_webcamp_adhoc.coreservice1349 as
SELECT * from ctsi_webcamp_pr.coreservice
WHERE PROTOCOL=775
AND STARTDATE>=str_to_date('07,01,2022','%m,%d,%Y');


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc1349;
Create table ctsi_webcamp_adhoc.vrc1349 as
Select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber='1349'
AND VisitID='65322';

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc1349;
Create table ctsi_webcamp_adhoc.vrc1349 as
Select SUM(Amount) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber='1349'
AND VisitID='65322';

SELECT Service, UnitOfService, count(*) as nOccurance
FROM ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY Service, UnitOfService;
############################################################################
############################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc1349;
Create table ctsi_webcamp_adhoc.vrc1349 as
Select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber='1349'
AND VisitID='65322';

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc1349;
Create table ctsi_webcamp_adhoc.vrc1349 as
Select  Service,  ## LABTEST
        ProvPersonName,
        CoreSvcID,
        CoreSvcStart,
        CoreSvcEnd,
        SvcUnitCost,
        CoreSvcQuant,
        CoreSvcLenDurMin,
        CoreSvcLenDurMin/60 AS CoreSvcLenDurHRS,
        UnitOfService,
        BillingUnitSrvc,
        Amount
 from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber='1349'
AND VisitID='65322'
ORDER BY SERVICE;

select * from ctsi_webcamp_pr.coreservice
WHERE UNIQUEFIELD IN (344856, 344856);




