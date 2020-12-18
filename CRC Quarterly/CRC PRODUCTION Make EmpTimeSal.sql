USE crc_quarterly;
##############################################################################
#### CREATE WORK TABLES 
##############################################################################
#### Time Reporting  ########################################################
drop table if exists timerept;
Create table timerept AS
SELECT * from crc_time ;
##############################################################################
#### Shands Time  ######################################################
drop table if exists shandstime;
Create table shandstime AS
select * from shands_shifts;
##############################################################################
#### Cost Distribution  ######################################################
DROP TABLE IF EXISTS cost_dist;
CREATE TABLE cost_dist AS
SELECT * from crc_pay_v1;
##############################################################################
#### Date Ranges #############################################################

select "timerept" as Filename, count(*) as nRecs, min(Date_Used) as MinDate, max(Date_Used) as MaxDate from timerept
UNION ALL
select "shandstime" as Filename, count(*) as nRecs, min(Shift_Start_Time_) as MinDate, max(Shift_Start_Time_) as MaxDate from shandstime
UNION ALL
select "cost_dist" as Filename, count(*) as nRecs, min(Accounting_Date) as MinDate, max(Accounting_Date) as MaxDate from cost_dist
UNION ALL
select "visitroomcore" as Filename, count(*) as nRecs, min(VisitStart) as MinDate, max(VisitStart) as MaxDate from visitroomcore;

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##### BUILD EmpTimeSal #######################################################
##############################################################################

ALTER TABLE timerept
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD WorkTime decimal (65,30),
ADD NonWorkTime decimal (65,30),
ADD OPS_WorkTime decimal (65,30),
ADD Teams_WorkTime decimal (65,30),
ADD FTE_OPS decimal (12,2),
ADD FTE_Teams decimal (12,2),
ADD SalPlanType varchar(5);



SET SQL_SAFE_UPDATES = 0;

UPDATE timerept SET Employee_ID=lPAD(Employee_ID,8,"0");
UPDATE timerept SET MONTH=concat(YEAR(Date_Used),"-",LPAD(MONTH(Date_Used),2,"0")) ;
UPDATE timerept SET SvcMon = substr(Month,6,2);
UPDATE timerept SET SvcYear = substr(Month,1,4);
UPDATE timerept tr, lookup.sfy_classify lu SET tr.SFY=lu.SFY WHERE tr.MONTH=lu.MONTH;

UPDATE timerept SET SalPlanType="OPS" WHERE Salary_Admin_Plan LIKE "%OPS%";
UPDATE timerept SET SalPlanType="OPS" WHERE Salary_Admin_Plan LIKE "%Stu Ast%";
UPDATE timerept SET SalPlanType="Teams" WHERE Salary_Admin_Plan LIKE "%TEAMS%";

### INITALIZE Time Variables
UPDATE timerept SET WorkTime = 0, 
						NonWorkTime=0, 
						OPS_WorkTime=0, 
                        Teams_WorkTime=0,
                        FTE_OPS=0,
                        FTE_Teams=0;
### Total WorkTime (hours)



UPDATE timerept 
SET WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from timecode_lookup 
                                    WHERE Work_Classification="Work Hours");
### Total Non-WorkTime (hours)
UPDATE timerept 
SET NonWorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from timecode_lookup 
                                    WHERE Work_Classification="Non-Work Hours");
### Total  OPS WorkTime (hours)                                    
UPDATE timerept 
SET OPS_WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from timecode_lookup 
                                    WHERE Work_Classification="Work Hours")
AND SalPlanType="OPS";  

### Total Teams WorkTime (hours)  
UPDATE timerept 
SET Teams_WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from timecode_lookup 
                                    WHERE Work_Classification="Work Hours")
AND SalPlanType="Teams";                                   ;                                    


####################################################################
## CREATE FTE LOOKUP TABLE #########################################
####################################################################
SET SQL_SAFE_UPDATES = 0;

drop table if exists fte1 ;
create table fte1 AS
SELECT Employee_ID AS Employee_ID,
	   Name,
       Salary_Plan,
       FTE
FROM lookup.active_emp
WHERE Employee_ID IN (SELECT DISTINCT lPAD(Employee_ID,8,"0") from timerept);

drop table if exists fte_lookup;
Create table fte_lookup as
SELECT * from fte1
UNION ALL 
SELECT Employee_ID,Name,Salary_Plan,FTE
FROM lookup.Employees
WHERE Employee_ID IN (SELECT DISTINCT lPAD(Employee_ID,8,"0") from timerept)
AND Employee_ID  NOT IN (SELECT DISTINCT Employee_ID from fte1);

ALter table fte_lookup ADD SalPlanType varchar(5);

UPDATE fte_lookup SET SalPlanType="OPS" WHERE Salary_Plan LIKE "%OPS%";
UPDATE fte_lookup SET SalPlanType="OPS" WHERE Salary_Plan LIKE "%Stu Ast%";
UPDATE fte_lookup SET SalPlanType="Teams" WHERE Salary_Plan LIKE "%TEAMS%";


####################################################################
## Populate FTE_OPS and FTE_Teams Fields
####################################################################
update timerept SET FTE_OPS=0, FTE_Teams=0;

UPDATE timerept  tr, fte_lookup lu
SET tr.FTE_OPS=lu.FTE
WHERE tr.Employee_ID=lu.Employee_ID
  AND lu.SalPlanType="OPS";

UPDATE timerept  tr, fte_lookup lu
SET tr.FTE_Teams=lu.FTE
WHERE tr.Employee_ID=lu.Employee_ID
  AND lu.SalPlanType="Teams";

####################################################################
### CREATE MOnth Person Summary to Append to Shands Personnel Table 
####################################################################
drop table if exists UFtimeMonSumm;
Create table UFtimeMonSumm AS
SELECT 	"UFHealth" as Employer,
        tr.SFY,
        tr.Month,
		lPAD(tr.Employee_ID,8,"0") AS Employee_ID,
        tr.Name,
        round(SUM(tr.Quantity),2) AS TotalHours,
        round(SUM(tr.WorkTime),2) AS WorkedHours,
        round(SUM(tr.NonWorkTime),2) AS NonWorkedHours,
        round(SUM(tr.OPS_WorkTime),2) as OPS_WorkedHours, 
        round(SUM(tr.Teams_WorkTime),2) as Teams_WorkedHours,        
        max(tr.FTE_OPS) as FTE_OPS ,
        max(tr.FTE_Teams) AS FTE_Teams , 
        Min(ah.WorkHours) as Avail_hours
from timerept tr 
LEFT JOIN avail_hours ah
ON tr.Month=ah.Month
GROUP BY "UFHealth",tr.SFY,tr.Month,tr.Employee_ID,tr.Name;

/*
### VERIFY
SELECT * from timerept WHERE NAME LIKE '%EVAN%'  AND Salary_Admin_Plan like "%OPS%";
SELECT * from UFtimeMonSumm WHERE EMPLOYEE_ID LIKE '96991999' ;
###
*/
####################################################################
####################################################################
####################################################################
####################################################################
## SHANDS
####################################################################


## Create indentical structure to UF Data
ALTER TABLE shandstime
ADD Month varchar(7),    			#
ADD SvcMon varchar(2),   			#
ADD SvcYear varchar(4),				#
ADD SFY varchar(15),				#
ADD WorkTime decimal (65,30),		#	
ADD NonWorkTime decimal (65,30),	#
ADD OPS_WorkTime decimal (65,30),	#
ADD Teams_WorkTime decimal (65,30), # 
ADD FTE_OPS decimal (12,2),			#
ADD FTE_Teams decimal (12,2),	
ADD SalPlanType varchar(5),
ADD ShandsPersID varchar(12);
######################################################HEREH

SET SQL_SAFE_UPDATES = 0;

UPDATE shandstime SET MONTH=concat(YEAR(Apply_Date),"-",LPAD(MONTH(Apply_Date),2,"0")) ;
UPDATE shandstime SET SvcMon = substr(Month,6,2);
UPDATE shandstime SET SvcYear = substr(Month,1,4);
UPDATE shandstime st, lookup.sfy lu SET st.SFY=lu.SFY WHERE st.MONTH=lu.MONTH;

UPDATE shandstime SET WorkTime=0, Teams_WorkTime=0;

UPDATE shandstime SET WorkTime=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;
UPDATE shandstime SET Teams_WorkTime=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;
UPDATE shandstime SET 	OPS_WorkTime=0,
							FTE_OPS=0,
                            NonWorkTime=0,
						    FTE_Teams=1,
                            SalPlanType="Shand";


##select Name,ID from shandstime group by Name,ID;

update shandstime SET NAME='Brunson, Roberta A' WHERE NAME='Brunson, Roberta Anne';
update shandstime SET NAME='Caraecle, Jerylen' WHERE NAME='Caraecle, Jerylen';
update shandstime SET NAME='Garrett, Kimberly V' WHERE NAME='Garrett, Kimberly Vee';

update shandstime SET ShandsPersID=CONCAT("SHANDS-",substr(Name,1,5));

###############################################################################
### CREATE Shands Table to Append to UF Health STaff Time Table (UFtimeMonSumm)
#################################################################################
drop table if exists ShandstimeMonSumm;
Create table ShandstimeMonSumm AS
SELECT 	"Shands" as Employer,
tr.SFY,
        tr.Month,
		ShandsPersID AS Employee_ID,
        tr.Name,
        round(SUM(tr.WorkTime),2) AS TotalHours,
        round(SUM(tr.WorkTime),2) AS WorkedHours,
        round(SUM(tr.NonWorkTime),2) AS NonWorkedHours,
        round(SUM(tr.OPS_WorkTime),2) as OPS_WorkedHours, 
        round(SUM(tr.Teams_WorkTime),2) as Teams_WorkedHours,        
        max(tr.FTE_OPS) as FTE_OPS ,
        max(tr.FTE_Teams) AS FTE_Teams , 
        Min(ah.WorkHours) as Avail_hours
from shandstime tr 
LEFT JOIN avail_hours ah
ON tr.Month=ah.Month
GROUP BY "Shands",tr.SFY,tr.Month,tr.ID,tr.Name;


###############################################################################
########## COMBINE TABLES UF and Shands Monthly summary by Person
###############################################################################
drop table if exists TimeMonSumm;
Create table TimeMonSumm AS
SELECT * from UFtimeMonSumm
UNION ALL 
SELECT * from ShandstimeMonSumm;

################################################

###############################################################################
#### Make Employee List
###############################################################################
drop table if exists emplist;
Create table emplist AS
SELECT   Name,
		 Employee_ID,
         Employer,
         FTE_OPS,
         FTE_Teams
from TimeMonSumm
group by Name,
		 Employee_ID,
         Employer,
         FTE_OPS,
         FTE_Teams
order by Name;     

ALTER TABLE emplist ADD Title Varchar(45);

UPDATE emplist SET	Employee_ID=lPAD(Employee_ID,8,"0");
UPDATE emplist el, lookup.Employees lu
SET	el.Title=lu.Job_Code
WHERE el.Employee_ID=lu.Employee_ID;

UPDATE emplist 
SET	Title = "Shands Research Nurse"
WHERE Employer="Shands"
AND Title IS Null;


##select * from emplist;
##############################################################################
##############################################################################
#### COST DISTIB
##############################################################################

## csot_dist is work file

ALTER TABLE cost_dist
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD CRC_Activities decimal (65,11),
ADD CRC_Other_Activities decimal (65,11),
ADD CRC_CTSI_Funded decimal (65,11);

/*
•	CRC_Activities  --  DeptID="29680300" and Fund_Code="149"
•	CRC_CTSI_Funded  –   DeptID=”xxxx2968”
•	CRC_Other_Activities – Anything Else
*/



SET SQL_SAFE_UPDATES = 0;

UPDATE cost_dist SET CRC_Activities=0, CRC_CTSI_Funded=0 , CRC_Other_Activities=0 ;

UPDATE cost_dist SET MONTH=concat(YEAR(Accounting_Date),"-",LPAD(MONTH(Accounting_Date),2,"0")) ;
UPDATE cost_dist SET SvcMon = substr(Month,6,2);
UPDATE cost_dist SET SvcYear = substr(Month,1,4);
UPDATE cost_dist SET  CRC_Activities=`Salary_+_Fringe` WHERE DeptID="29680300" and Fund_Code="149";
UPDATE cost_dist SET  CRC_CTSI_Funded= `Salary_+_Fringe` WHERE DeptID LIKE "2968%" AND CRC_Activities =0;
UPDATE cost_dist SET  CRC_Other_Activities=`Salary_+_Fringe` WHERE CRC_Activities=0 AND CRC_CTSI_Funded =0;  
UPDATE cost_dist cd, lookup.sfy_classify lu SET cd.SFY=lu.SFY WHERE cd.MONTH=lu.MONTH;

#######################################################################################
#### Create Monthly summary by Person of Categorized Salary Data
#######################################################################################
drop table if exists empsallu;
create table empsallu AS
SELECT Month,
       Person_ID AS Employee_ID,
       max(Name_) AS Emp_Name,
       sum(CRC_Activities) as CRC_Activities,
       sum(CRC_CTSI_Funded) AS CRC_CTSI_Funded,
       sum(CRC_Other_Activities) as CRC_Other_Activities,
       sum(`Salary_+_Fringe`) as Total
from cost_dist   
group by Month, Person_ID  ;  

#######################################################################################
#######################################################################################
###  Combine Monthly Time 
############### (Segemetned by Working Nonworking OPS and Teams 
################s             Salary and fringe data and activity Type  
#######################################################################################
drop table if exists EmpTimeSal;
create table EmpTimeSal AS
SELECT ts.Employer,
	   ts.Month,
       ts.SFY,
       ts.Employee_ID,
       ts.Name,
       ts.TotalHours, 
	   ts.WorkedHours, 
	   ts.NonWorkedHours,
       ts.OPS_WorkedHours,
       ts.Teams_WorkedHours,
       ts.FTE_OPS,
       ts.FTE_Teams,
       ts.Avail_hours,
       ts.FTE_OPS*ts.Avail_hours AS OPS_FTE_ADJ_Avail,
       ts.FTE_Teams*ts.Avail_hours AS Teams_FTE_ADJ_Avail,
       lu.CRC_Activities,
       lu.CRC_CTSI_Funded,
       lu.CRC_Other_Activities,
       lu.Total AS TotalSalFRng
FROM TimeMonSumm ts 
	 left join empsallu lu 
     on ts.Month=lu.Month AND ts.Employee_ID=lu.Employee_ID;

#######################################################################################     
### ADD Shands Salary 
#######################################################################################
SET SQL_SAFE_UPDATES = 0;

UPDATE EmpTimeSal ts, shands_salary lu
SET    ts.CRC_Activities=lu.Hourly*ts.WorkedHours,
       ts.OPS_FTE_ADJ_Avail=0,
       ts.Teams_FTE_ADJ_Avail=lu.FTE*ts.Avail_hours,
       ts.CRC_CTSI_Funded=0,
       ts.CRC_Other_Activities=0,
       ts.TotalSalFRng=lu.Hourly*ts.WorkedHours,
       ts.FTE_OPS=0,
       ts.FTE_Teams=lu.FTE
WHERE ts.Employee_ID=lu.Employee_ID
AND ts.Employer="Shands";

#######################################################################################
### CLEAN UP Nulls for Salary Categegory Allocations  
#######################################################################################
UPDATE EmpTimeSal SET CRC_Activities=0 WHERE CRC_Activities IS NULL;
UPDATE EmpTimeSal SET CRC_CTSI_Funded=0 WHERE CRC_CTSI_Funded IS NULL;
UPDATE EmpTimeSal SET CRC_Other_Activities=0 WHERE CRC_Other_Activities IS NULL;

#### PUT SHANDS UPDATES HERE 

DROP TABLE IF EXISTS EMPCount;
Create table EMPCount AS
SELECT Employer,
	   Month,
       Employee_ID,
       MAX(FTE_OPS) AS nOPSEmp,
       MAX(FTE_Teams) AS nTeamsEmp
FROM EmpTimeSal
GROUP BY Employer,
	     Month,
         Employee_ID;
         

         

UPDATE EMPCount SET nOPSEmp=1 WHERE nOPSEmp >0; 
UPDATE EMPCount SET nTeamsEmp=1 WHERE  nTeamsEmp>0; 

ALTER TABLE EmpTimeSal
 	ADD nOPSEmp int(1),
 	ADD nTeamsEmp int(1),
    ADD Quarter varchar(12);


UPDATE EmpTimeSal ts, lookup.sfy_classify lu
SET ts.Quarter=lu.Quarter
WHERE ts.Month=lu.Month;

    
UPDATE EmpTimeSal ts,  EMPCount lu
SET ts.nOPSEmp=lu.nOPSEmp,
	ts.nTeamsEmp=lu.nTeamsEmp
WHERE ts.Employer=lu.Employer
  AND ts.Month=lu.Month
  AND ts.Employee_ID=lu.Employee_ID;
  
  
  



## HAVE A LOOK!
##SELECT * FROM EmpTimeSal;


#Create a formatted file
DROP TABLE IF EXISTS EmpTimeSalTEMP;
CREATE TABLE EmpTimeSalTEMP AS SELECT * FROM EmpTimeSal;
DROP TABLE IF EXISTS EmpTimeSal;
CREATE TABLE EmpTimeSal AS
SELECT  Employer,
		Month,
        Quarter,
        SFY,
        Employee_ID,
        Name,
        nTeamsEMP,
        nOPSEmp,
        TotalHours,
        WorkedHours,
        NonWorkedHours,
        Teams_WorkedHours,
        OPS_WorkedHours,
        FTE_Teams,
        FTE_OPS,
		Avail_hours,
        Teams_FTE_ADJ_Avail,
        OPS_FTE_ADJ_Avail,
        CRC_Activities,
        CRC_CTSI_Funded,
        CRC_Other_Activities,
        TotalSalFRng
FROM EmpTimeSalTEMP
ORDER BY Month,Name;

##SELECT * FROM EmpTimeSal;

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
##############################################################################


########################################  EOF  #################################################################
################################################################################################################
################################################################################################################
################################################################################################################