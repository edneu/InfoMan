#######################################################################################
#######################   Production CRC analysis   ###################################
#######################################################################################
#######################################################################################
USE crc_quarterly;
SET sql_mode = '';
############################   Required Files  ########################################
#######################################################################################
##########################  DATA TABLES ###############################################
###########  VisitRoomCore - Result of "Make VistitRoomCore.sql"
###########  crc_time  - CRC Employee time records Current Version: 1/1/2018-9/30/2020 
###########  crc_pay_v1  - CRC EMployee payroll records v1 = 7/12/2018 - 12/10/2020
#######################################################################################
##########################  Classification Tables  ####################################
###########  avail_hours - the available work hours and CRC facity hours by month in format YYYY-MM
###########  person_classify  - Defines person roles for report filtering
###########  date_classify  Table conting the SFY and SF Quarter values for a month formatted as YYYY-MM
#######################################################################################
#######################################################################################
#######################################################################################
#### CREATE WORK TABLES
#### 
DROP TABLE IF EXISTS crc_time_work ;
CREATE TABLE crc_time_work AS
SELECT * from crc_time ;

SET SQL_SAFE_UPDATES = 0;
UPDATE crc_time_work SET Employee_ID=LPAD(Employee_ID,8,"0");

#### 
DROP TABLE IF EXISTS crc_pay_work ;
CREATE TABLE crc_pay_work AS
SELECT * from crc_pay_v1 ;
#######################################################################################
#######################################################################################
#######################################################################################

#######################################################################################
#######################################################################################
#####  Create Person Adjusted Visit Length (for comparison with Nursing work hours
#####  Result file PR_PersonAdjustedLen Indexed on VisitID
#######################################################################################
DROP TABLE IF EXISTS ProvContib;
CREATE TABLE ProvContib AS 
SELECT VisitID,ProvPersonName,
	   SUM(CoreSvcLenDurMin) AS ProvMin,
       max(VisitLenMin) AS VisitLenMin,
       IF (SUM(CoreSvcLenDurMin)/max(VisitLenMin) >1,1,SUM(CoreSvcLenDurMin)/max(VisitLenMin)) AS ProvPctContib
FROM visitroomcore 
WHERE CoreSvcQuant IS NOT NULL
AND ProvPersonName IS NOT NULL  
GROUP BY VISITID, ProvPersonName;


SET SQL_SAFE_UPDATES = 0;

ALTER TABLE ProvContib
	ADD ProvContibMin decimal(20,2);
    
UPDATE ProvContib
    SET  ProvContibMin=ProvPctContib*VisitLenMin;

DROP TABLE IF EXISTS ProvContibSumm;
CREATE TABLE ProvContibSumm AS
SELECT 	VisitID,
		MAX(VisitLenMin) AS VisitLenMin,
        COUNT(DISTINCT ProvPersonName) as nPROVs,
        SUM(ProvContibMin) as ProvTotalMin
        FROM ProvContib
        GROUP BY VisitID;

    
ALTER TABLE ProvContibSumm
ADD AdjVisitMin int(20);
       
UPDATE ProvContibSumm
SET AdjVisitMin=GREATEST(ProvTotalMin,VisitLenMin)	;


    

DROP TABLE IF EXISTS PR_PersonAdjustedLen;
CREATE TABLE PR_PersonAdjustedLen AS
SELECT 	VisitID,
        nPROVS as nPROVs,
        AdjVisitMin/60 as PersAdjVisitHours
FROM ProvContibSumm        
        GROUP BY VisitID;



CREATE INDEX PAL ON PR_PersonAdjustedLen (VisitID);
#######################################################################################
#######################################################################################
#######################################################################################
#####  Create Utilization By Room 
#####  Result file: PR_ROOM_UTIL
#######################################################################################
## Utilization By Room

DROP TABLE IF EXISTS PR_VISITMON;
create table PR_VISITMON AS
SELECT 	MONTH,
		SFY,
        QUARTER,
        VisitID,
        max(ROOM) as Room,
        max(VisitLenMin/60) AS VistDurHours
from visitroomcore
GROUP BY 	MONTH,
			SFY,
			QUARTER,
			VisitID;

Alter table PR_VISITMON 
ADD nPROVs int(21),
ADD PersAdjVisitHours decimal(23,4) ;       

CREATE INDEX VML ON PR_VISITMON (VisitID);

UPDATE PR_VISITMON vm, PR_PersonAdjustedLen lu
SET vm.nPROVs=lu.nPROVs,
	vm.PersAdjVisitHours=lu.PersAdjVisitHours
WHERE vm.VisitID=lu.VisitID   ; 

     
            
SELECT * from PR_VISITMON ;
SELECT count(*) from PR_VISITMON ;
            
DROP TABLE IF EXISTS PR_ROOM_UTIL;
create table PR_ROOM_UTIL AS
SELECT MONTH,
		SFY,
        QUARTER,
        ROOM, 
        SUM(VistDurHours) as HoursUsed,
        SUM(nPROVS) as nPROVs,
        SUM(PersAdjVisitHours) as PrsnAdjHours
FROM PR_VISITMON
WHERE ROOM IS NOT NULL
GROUP BY MONTH,
		SFY,
        QUARTER,
        ROOM;



ALTER TABLE PR_ROOM_UTIL 
ADD CRC_Avail_hours int(10),
ADD HoursUnused decimal(56,6),
ADD UtilRate decimal(56,6);


UPDATE 	PR_ROOM_UTIL ru, 
		avail_hours lu
SET ru.CRC_Avail_hours=lu.CRC_Avail_hours
WHERE ru.MOnth=lu.Month;

UPDATE 	PR_ROOM_UTIL
SET HoursUnused=CRC_Avail_hours-HoursUsed,
	UtilRate=HoursUsed/CRC_Avail_hours;
    
UPDATE 	PR_ROOM_UTIL
SET PrsnAdjHours=HoursUsed
Where PrsnAdjHours IS NULL;    

UPDATE 	PR_ROOM_UTIL
SET PrsnAdjHours=HoursUsed
Where PrsnAdjHours IS NULL;  
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
## Create Staff Hours Analysis File
#########################################################################################
#########################################################################################







    
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
FROM 	PR_ROOM_UTIL
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
FROM 	PR_ROOM_UTIL
WHERE Month="2020-10"
GROUP BY Month,
		Room;
        


###########################################################################################
######################### CLEANUP  ########################################################
###########################################################################################
/*
DROP TABLE IF EXISTS ProvContibSumm;
DROP TABLE IF EXISTS ProvContib;
DROP TABLE IF EXISTS PR_VISITMON;    

*/        
            