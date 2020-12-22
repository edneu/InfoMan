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
####Tables for Reporting
### VisitRoomCare Utilization by Room
### TimeMonSumm  CRC Hours Shands and UF
### AllPay Shands and UF MOnthly Payroll Summary
### EmpTimeSal - Combines Time reporting and Pay - Do not use Incomplete time reporting See reconsile Worksheet.
################################################################################################################
#### Date Ranges #############################################################

select "timerept" as Filename, count(*) as nRecs, min(Date_Used) as MinDate, max(Date_Used) as MaxDate from timerept
UNION ALL
select "shandstime" as Filename, count(*) as nRecs, min(Shift_Start_Time_) as MinDate, max(Shift_Start_Time_) as MaxDate from shandstime
UNION ALL
select "cost_dist" as Filename, count(*) as nRecs, min(Accounting_Date) as MinDate, max(Accounting_Date) as MaxDate from cost_dist
UNION ALL
select "visitroomcore" as Filename, count(*) as nRecs, min(VisitStart) as MinDate, max(VisitStart) as MaxDate from visitroomcore
UNION ALL
select "EmpTimeSal" as Filename, count(*) as nRecs, min(Month) as MinDate, max(Month) as MaxDate from EmpTimeSal;



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

select * from PR_ROOM_UTIL;

DROP TABLE UTIL_BY_ROOM_Quarter;
Create table UTIL_BY_ROOM_Quarter AS
SELECT Quarter,
	   ROOM,
       SUM(HoursUsed) AS HoursUsed,
       SUM(CRC_Avail_Hours) HoursAvail,
       (SUM(HoursUsed)/SUM(CRC_Avail_Hours))*100 As UtilRate,
       SUM(PrsnAdjHours) as PrsnAdjHours
 FROM PR_ROOM_UTIL
 WHERE Quarter="Q1 20-21"
 GROUP BY 	Quarter,
			ROOM;


    
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
################################### Reporting  ##########################################
#########################################################################################
USE crc_quarterly;
SET sql_mode = '';
#########################################################################################
#### Utilization by Room for a Quarter
#########################################################################################

## Create standard Available Hours
DROP TABLE IF Exists QuarterAvail;
Create table QuarterAvail as
SELECT sf.Quarter,
       SUM(ah.CRC_Avail_hours) AS AvailQuartHrs
FROM lookup.sfy_classify sf RIGHT JOIN avail_hours ah
ON sf.Month=ah.Month
GROUP BY sf.quarter;


DROP TABLE UTIL_BY_ROOM_Quarter;
Create table UTIL_BY_ROOM_Quarter AS
SELECT ru.Quarter,
	   ROOM,
       qa.AvailQuartHrs AS CRC_Avail_Hours,
       SUM(HoursUsed) AS HoursUsed,
       qa.AvailQuartHrs-SUM(HoursUsed) AS HoursUnused,
       (SUM(HoursUsed)/qa.AvailQuartHrs) As UtilRate,
       SUM(PrsnAdjHours) as PrsnAdjHours
 FROM PR_ROOM_UTIL ru 
		LEFT JOIN QuarterAvail qa 
        on ru.Quarter=qa.Quarter
 WHERE ru.Quarter="Q1 20-21"
 GROUP BY 	ru.Quarter,
			ROOM,
            qa.AvailQuartHrs
 ORDER BY SUM(HoursUsed) DESC   ;        
 

        
###########################################################################################
####Teans Hours and FSE adjusted Hours by Month  ##########################################
#### Nurses ONLY ##########################################################################

DROP TABLE IF EXISTS CRCTimeMonth;
CREATE TABLE CRCTimeMonth AS
SELECT MONTH,
       SUM(HoursUsed) AS CRCHoursUsed,
       SUM(CRC_Avail_Hours) CRCHoursAvail,
       (SUM(HoursUsed)/SUM(CRC_Avail_Hours))*100 As UtilRate,
       SUM(PrsnAdjHours) as CRCPrsnAdjHours
 FROM PR_ROOM_UTIL
WHERE Quarter in (	'Q2 19-20',
					'Q3 19-20',
					'Q4 19-20',
					'Q1 20-21')
 GROUP BY Month;


Select * from TimeMonSumm;
select distinct Quarter from TimeMonSumm;

DROP TABLE IF EXISTS NurseTime;
Create table NurseTime AS
SELECT Month,
       SUM(Teams_WorkedHours) AS TeamsWorkedHrs,
       SUM(NonWorkedHours) AS NonWorkedHrs,
       SUM(OPS_WorkedHours) as OPSWorkedHrs,
       SUM(FTE_OPS) AS FTE_OPS,
       SUM(FTE_Teams) AS FTE_TEAMS,
       SUM(Avail_hours) as Avail_hours,
       SUM(OPS_FTE_ADJ_Avail) AS OPS_FTE_ADJ_Avail,
       SUM(Teams_FTE_ADJ_Avail) AS Teams_FTE_ADJ_Avail
FROM TimeMonSumm
WHERE Quarter in (	'Q2 19-20',
					'Q3 19-20',
					'Q4 19-20',
					'Q1 20-21')
AND Nurse=1
GROUP BY MONTH;

###########################################################################################
#### ALL STAFF ONLY ##########################################################################
DROP TABLE IF EXISTS AllTime;
Create table AllTime AS
SELECT Month,
       SUM(Teams_WorkedHours) AS TeamsWorkedHrs,
       SUM(NonWorkedHours) AS NonWorkedHrs,
       SUM(OPS_WorkedHours) as OPSWorkedHrs,
       SUM(FTE_OPS) AS FTE_OPS,
       SUM(FTE_Teams) AS FTE_TEAMS,
       SUM(Avail_hours) as Avail_hours,
       SUM(OPS_FTE_ADJ_Avail) AS OPS_FTE_ADJ_Avail,
       SUM(Teams_FTE_ADJ_Avail) AS Teams_FTE_ADJ_Avail
FROM TimeMonSumm
WHERE Quarter in (	'Q2 19-20',
					'Q3 19-20',
					'Q4 19-20',
					'Q1 20-21')
GROUP BY MONTH;
###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################



###########################################################################################
######################### CLEANUP  ########################################################
###########################################################################################
/*
DROP TABLE IF EXISTS ProvContibSumm;
DROP TABLE IF EXISTS ProvContib;
DROP TABLE IF EXISTS PR_VISITMON; 
DROP TABL EIF EXISTS EmpTimeSalTEMP;  
DROP TABLE IF EXISTS CRCTimeMonth; 

*/        
            