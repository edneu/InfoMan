#######################################################################################
#######################   Production CRC analysis   ###################################
#######################################################################################
#######################################################################################


############################   Required Files  ########################################
#######################################################################################
##########################  DATA TABLES ###############################################
###########  ctsi_webcamp_adhoc.VisitRoomCore - Result of "Make VistitRoomCore.sql"
###########  ctsi_webcamp_adhoc.crc_time  - CRC Employee time records Current Version: 1/1/2018-9/30/2020 
###########  ctsi_webcamp_adhoc.crc_pay_v1  - CRC EMployee payroll records v1 = 7/12/2018 - 12/10/2020
#######################################################################################
##########################  Classification Tables  ####################################
###########  ctsi_webcamp_adhoc.avail_hours - the available work hours and CRC facity hours by month in format YYYY-MM
###########  ctsi_webcamp_adhoc.person_classify  - Defines person roles for report filtering
###########  ctsi_webcamp_adhoc.date_classify  Table conting the SFY and SF Quarter values for a month formatted as YYYY-MM
#######################################################################################
#######################################################################################
#######################################################################################
#### CREATE WORK TABLES
#### 
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.crc_time_work ;
CREATE TABLE ctsi_webcamp_adhoc.crc_time_work AS
SELECT * from ctsi_webcamp_adhoc.crc_time ;

SET SQL_SAFE_UPDATES = 0;
UPDATE ctsi_webcamp_adhoc.crc_time_work SET Employee_ID=LPAD(Employee_ID,8,"0");

#### 
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.crc_pay_work ;
CREATE TABLE ctsi_webcamp_adhoc.crc_pay_work AS
SELECT * from ctsi_webcamp_adhoc.crc_pay_v1 ;
#######################################################################################
#######################################################################################
#######################################################################################

#######################################################################################
#######################################################################################
#####  Create Person Adjusted Visit Length (for comparison with Nursing work hours
#####  Result file ctsi_webcamp_adhoc.PR_PersonAdjustedLen Indexed on VisitID
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContib;
CREATE TABLE ctsi_webcamp_adhoc.ProvContib AS 
SELECT VisitID,ProvPersonName,
	   SUM(CoreSvcLenDurMin) AS ProvMin,
       max(VisitLenMin) AS VisitLenMin,
       IF (SUM(CoreSvcLenDurMin)/max(VisitLenMin) >1,1,SUM(CoreSvcLenDurMin)/max(VisitLenMin)) AS ProvPctContib
FROM ctsi_webcamp_adhoc.VisitRoomCore 
WHERE CoreSvcQuant IS NOT NULL
AND ProvPersonName IS NOT NULL  
GROUP BY VISITID, ProvPersonName;


SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ctsi_webcamp_adhoc.ProvContib
	ADD ProvContibMin decimal(20,2);
    
UPDATE ctsi_webcamp_adhoc.ProvContib
    SET  ProvContibMin=ProvPctContib*VisitLenMin;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContibSumm;
CREATE TABLE ctsi_webcamp_adhoc.ProvContibSumm AS
SELECT 	VisitID,
		MAX(VisitLenMin) AS VisitLenMin,
        COUNT(DISTINCT ProvPersonName) as nPROVs,
        SUM(ProvContibMin) as ProvTotalMin
        FROM ctsi_webcamp_adhoc.ProvContib
        GROUP BY VisitID;

    
ALTER TABLE ctsi_webcamp_adhoc.ProvContibSumm
ADD AdjVisitMin int(20);
       
UPDATE ctsi_webcamp_adhoc.ProvContibSumm
SET AdjVisitMin=GREATEST(ProvTotalMin,VisitLenMin)	;


    

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_PersonAdjustedLen;
CREATE TABLE ctsi_webcamp_adhoc.PR_PersonAdjustedLen AS
SELECT 	VisitID,
        nPROVS as nPROVs,
        AdjVisitMin/60 as PersAdjVisitHours
FROM ctsi_webcamp_adhoc.ProvContibSumm        
        GROUP BY VisitID;



CREATE INDEX PAL ON ctsi_webcamp_adhoc.PR_PersonAdjustedLen (VisitID);
#######################################################################################
#######################################################################################
#######################################################################################
#####  Create Utilization By Room 
#####  Result file: ctsi_webcamp_adhoc.PR_ROOM_UTIL
#######################################################################################
## Utilization By Room

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_VISITMON;
create table ctsi_webcamp_adhoc.PR_VISITMON AS
SELECT 	MONTH,
		SFY,
        QUARTER,
        VisitID,
        max(ROOM) as Room,
        max(VisitLenMin/60) AS VistDurHours
from ctsi_webcamp_adhoc.visitroomcore
GROUP BY 	MONTH,
			SFY,
			QUARTER,
			VisitID;

Alter table ctsi_webcamp_adhoc.PR_VISITMON 
ADD nPROVs int(21),
ADD PersAdjVisitHours decimal(23,4) ;       

CREATE INDEX VML ON ctsi_webcamp_adhoc.PR_VISITMON (VisitID);

UPDATE ctsi_webcamp_adhoc.PR_VISITMON vm, ctsi_webcamp_adhoc.PR_PersonAdjustedLen lu
SET vm.nPROVs=lu.nPROVs,
	vm.PersAdjVisitHours=lu.PersAdjVisitHours
WHERE vm.VisitID=lu.VisitID   ; 

     
            
SELECT * from ctsi_webcamp_adhoc.PR_VISITMON ;
SELECT count(*) from ctsi_webcamp_adhoc.PR_VISITMON ;
            
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_ROOM_UTIL;
create table ctsi_webcamp_adhoc.PR_ROOM_UTIL AS
SELECT MONTH,
		SFY,
        QUARTER,
        ROOM, 
        SUM(VistDurHours) as HoursUsed,
        SUM(nPROVS) as nPROVs,
        SUM(PersAdjVisitHours) as PrsnAdjHours
FROM ctsi_webcamp_adhoc.PR_VISITMON
WHERE ROOM IS NOT NULL
GROUP BY MONTH,
		SFY,
        QUARTER,
        ROOM;



ALTER TABLE ctsi_webcamp_adhoc.PR_ROOM_UTIL 
ADD CRC_Avail_hours int(10),
ADD HoursUnused decimal(56,6),
ADD UtilRate decimal(56,6);


UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL ru, 
		ctsi_webcamp_adhoc.utilization_hours lu
SET ru.CRC_Avail_hours=lu.CRC_Avail_hours
WHERE ru.MOnth=lu.Month;

UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
SET HoursUnused=CRC_Avail_hours-HoursUsed,
	UtilRate=HoursUsed/CRC_Avail_hours;
    
UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
SET PrsnAdjHours=HoursUsed
Where PrsnAdjHours IS NULL;    

UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
SET PrsnAdjHours=HoursUsed
Where PrsnAdjHours IS NULL;  
    
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
################################### Reporting  ##########################################
#########################################################################################

#########################################################################################
#### Utilization by Room for a Quarter
#########################################################################################
SELECT 	Quarter,
		Room,
        Sum(HoursUsed) as HoursUsed,
        SUM(PrsnAdjHours) AS PrsnAdjHours,
        SUM(CRC_avail_hours) as AvailHours,
        (Sum(HoursUsed)/SUM(CRC_avail_hours))* 100 AS RoomUtilRate,
        (Sum(PrsnAdjHours)/SUM(CRC_avail_hours))* 100 AS PersonAdjUtilRate
FROM 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
WHERE Quarter="Q1 20-21"
GROUP BY Quarter,
		Room;
        
###########################################################################################
#### Utilization by Room for a Month 
####    for reconcilation with WEbcamp occupancy report.
########################################################################################### 
SELECT 	Month,
		Room,
        Sum(HoursUsed) as HoursUsed,
        SUM(PrsnAdjHours) AS PrsnAdjHours,
        SUM(CRC_avail_hours) as AvailHours,
        (Sum(HoursUsed)/SUM(CRC_avail_hours))* 100 AS RoomUtilRate,
        (Sum(PrsnAdjHours)/SUM(CRC_avail_hours))* 100 AS PersonAdjUtilRate
FROM 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
WHERE Month="2020-10"
GROUP BY Month,
		Room;
        


###########################################################################################
######################### CLEANUP  ########################################################
###########################################################################################
/*
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContibSumm;
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContib;
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_VISITMON;    

*/        
            