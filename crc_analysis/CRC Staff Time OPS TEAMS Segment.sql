

#### CREATE WORK TABLE 
drop table if exists crc.timerept;
Create table crc.timerept AS
select * from crc.crc_time_all_years;



ALTER TABLE crc.timerept
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

UPDATE crc.timerept SET Employee_ID=lPAD(Employee_ID,8,"0");
UPDATE crc.timerept SET MONTH=concat(YEAR(Date_Used),"-",LPAD(MONTH(Date_Used),2,"0")) ;
UPDATE crc.timerept SET SvcMon = substr(Month,6,2);
UPDATE crc.timerept SET SvcYear = substr(Month,1,4);
UPDATE crc.timerept tr, lookup.sfy lu SET tr.SFY=lu.SFY WHERE tr.MONTH=lu.MONTH;

UPDATE crc.timerept SET SalPlanType="OPS" WHERE Salary_Admin_Plan LIKE "%OPS%";
UPDATE crc.timerept SET SalPlanType="OPS" WHERE Salary_Admin_Plan LIKE "%Stu Ast%";
UPDATE crc.timerept SET SalPlanType="Teams" WHERE Salary_Admin_Plan LIKE "%TEAMS%";

### INITALIZE Time Variables
UPDATE crc.timerept SET WorkTime = 0, 
						NonWorkTime=0, 
						OPS_WorkTime=0, 
                        Teams_WorkTime=0,
                        FTE_OPS=0,
                        FTE_Teams=0;
### Total WorkTime (hours)
UPDATE crc.timerept 
SET WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Work Hours");
### Total Non-WorkTime (hours)
UPDATE crc.timerept 
SET NonWorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Non-Work Hours");
### Total  OPS WorkTime (hours)                                    
UPDATE crc.timerept 
SET OPS_WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Work Hours")
AND SalPlanType="OPS";  

### Total Teams WorkTime (hours)  
UPDATE crc.timerept 
SET Teams_WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Work Hours")
AND SalPlanType="Teams";                                   ;                                    


####################################################################
## CREATE FTE LOOKUP TABLE #########################################
####################################################################
SET SQL_SAFE_UPDATES = 0;

drop table if exists crc.fte1 ;
create table crc.fte1 AS
SELECT Employee_ID AS Employee_ID,
	   Name,
       Salary_Plan,
       FTE
FROM lookup.active_emp
WHERE Employee_ID IN (SELECT DISTINCT lPAD(Employee_ID,8,"0") from crc.timerept);

drop table if exists crc.fte_lookup;
Create table crc.fte_lookup as
SELECT * from crc.fte1
UNION ALL 
SELECT Employee_ID,Name,Salary_Plan,FTE
FROM lookup.Employees
WHERE Employee_ID IN (SELECT DISTINCT lPAD(Employee_ID,8,"0") from crc.timerept)
AND Employee_ID  NOT IN (SELECT DISTINCT Employee_ID from crc.fte1);

ALter table crc.fte_lookup ADD SalPlanType varchar(5);

UPDATE crc.fte_lookup SET SalPlanType="OPS" WHERE Salary_Plan LIKE "%OPS%";
UPDATE crc.fte_lookup SET SalPlanType="OPS" WHERE Salary_Plan LIKE "%Stu Ast%";
UPDATE crc.fte_lookup SET SalPlanType="Teams" WHERE Salary_Plan LIKE "%TEAMS%";


####################################################################
####################################################################
## Populate FTE_OPS and FTE_Teams Fields

update crc.timerept SET FTE_OPS=0, FTE_Teams=0;

UPDATE crc.timerept  tr, crc.fte_lookup lu
SET tr.FTE_OPS=lu.FTE
WHERE tr.Employee_ID=lu.Employee_ID
  AND lu.SalPlanType="OPS";

UPDATE crc.timerept  tr, crc.fte_lookup lu
SET tr.FTE_Teams=lu.FTE
WHERE tr.Employee_ID=lu.Employee_ID
  AND lu.SalPlanType="Teams";

####################################################################
### CREATE MOnth Person Summary to Append to Shands Personnel Table 
drop table if exists crc.UFtimeMonSumm;
Create table crc.UFtimeMonSumm AS
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
from crc.timerept tr 
LEFT JOIN crc.avail_work_hours ah
ON tr.Month=ah.Month
GROUP BY "UFHealth",tr.SFY,tr.Month,tr.Employee_ID,tr.Name;

/*
### VERIFY
SELECT * from crc.timerept WHERE NAME LIKE '%EVAN%'  AND Salary_Admin_Plan like "%OPS%";
SELECT * from crc.UFtimeMonSumm WHERE EMPLOYEE_ID LIKE '96991999' ;
###
*/
####################################################################
####################################################################
####################################################################
####################################################################
## SHANDS
####################################################################
## Create work File
drop table if exists crc.shandstime;
Create table crc.shandstime AS
select * from crc.shands_shifts;

## Create indentical structure to UF Data
ALTER TABLE crc.shandstime
ADD Month varchar(7),    			#
ADD SvcMon varchar(2),   			#
ADD SvcYear varchar(4),				#
ADD SFY varchar(15),				#
ADD WorkTime decimal (65,30),		#	
ADD NonWorkTime decimal (65,30),	#
ADD OPS_WorkTime decimal (65,30),	#
ADD Teams_WorkTime decimal (65,30), # 
ADD FTE_OPS decimal (12,2),			#
ADD FTE_Teams decimal (12,2),		#
ADD SalPlanType varchar(5);

######################################################HEREH

SET SQL_SAFE_UPDATES = 0;

UPDATE crc.shandstime SET MONTH=concat(YEAR(Apply_Date),"-",LPAD(MONTH(Apply_Date),2,"0")) ;
UPDATE crc.shandstime SET SvcMon = substr(Month,6,2);
UPDATE crc.shandstime SET SvcYear = substr(Month,1,4);
UPDATE crc.shandstime st, lookup.sfy lu SET st.SFY=lu.SFY WHERE st.MONTH=lu.MONTH;

UPDATE crc.shandstime SET WorkTime=0, Teams_WorkTime=0;

UPDATE crc.shandstime SET WorkTime=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;
UPDATE crc.shandstime SET Teams_WorkTime=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;
UPDATE crc.shandstime SET 	OPS_WorkTime=0,
							FTE_OPS=0,
                            NonWorkTime=0,
						    FTE_Teams=1,
                            SalPlanType="Shand";


################################################
### CREATE Shands Table to Append to UF Health STaff Time Table (crc.UFtimeMonSumm)
drop table if exists crc.ShandstimeMonSumm;
Create table crc.ShandstimeMonSumm AS
SELECT 	"Shands" as Employer,
tr.SFY,
        tr.Month,
		lPAD(ID,8,"0") AS Employee_ID,
        tr.Name,
        round(SUM(tr.WorkTime),2) AS TotalHours,
        round(SUM(tr.WorkTime),2) AS WorkedHours,
        round(SUM(tr.NonWorkTime),2) AS NonWorkedHours,
        round(SUM(tr.OPS_WorkTime),2) as OPS_WorkedHours, 
        round(SUM(tr.Teams_WorkTime),2) as Teams_WorkedHours,        
        max(tr.FTE_OPS) as FTE_OPS ,
        max(tr.FTE_Teams) AS FTE_Teams , 
        Min(ah.WorkHours) as Avail_hours
from crc.shandstime tr 
LEFT JOIN crc.avail_work_hours ah
ON tr.Month=ah.Month
GROUP BY "Shands",tr.SFY,tr.Month,tr.ID,tr.Name;

################################################
################################################
################################################
########## COMBINE TABLES UF and Shands Monthly summary by Person

drop table if exists crc.TimeMonSumm;
Create table crc.TimeMonSumm AS
SELECT * from crc.UFtimeMonSumm
UNION ALL 
SELECT * from crc.ShandstimeMonSumm;

################################################
################################################

select * from crc.TimeMonSumm ;
select * from crc.TimeMonSumm WHERE Employee_ID='96991999';

################################################
################################################
########### Make Employee List

drop table if exists crc.emplist;
Create table crc.emplist AS
SELECT   Name,
		 Employee_ID,
         Employer,
         FTE_OPS,
         FTE_Teams
from crc.TimeMonSumm
group by Name,
		 Employee_ID,
         Employer,
         FTE_OPS,
         FTE_Teams
order by Name;     

ALTER TABLE crc.emplist ADD Title Varchar(45);

UPDATE crc.emplist SET	Employee_ID=lPAD(Employee_ID,8,"0");
UPDATE crc.emplist el, lookup.Employees lu
SET	el.Title=lu.Job_Code
WHERE el.Employee_ID=lu.Employee_ID;

select * from crc.emplist;
################################################################
################################################################
################################################################
################################################################
################################################################
## COST DISTIB

DROP TABLE IF EXISTS crc.cost_dist;
CREATE TABLE crc.cost_dist AS
SELECT * from crc.cost_dist_master;



select * from crc.cost_dist;

ALTER TABLE crc.cost_dist
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
#select distinct DeptID from crc.cost_dist;


SET SQL_SAFE_UPDATES = 0;

UPDATE crc.cost_dist SET CRC_Activities=0, CRC_CTSI_Funded=0 , CRC_Other_Activities=0 ;

UPDATE crc.cost_dist SET MONTH=concat(YEAR(Accounting_Date),"-",LPAD(MONTH(Accounting_Date),2,"0")) ;
UPDATE crc.cost_dist SET SvcMon = substr(Month,6,2);
UPDATE crc.cost_dist SET SvcYear = substr(Month,1,4);
UPDATE crc.cost_dist SET  CRC_Activities=`Salary_+_Fringe` WHERE DeptID="29680300" and Fund_Code="149";
UPDATE crc.cost_dist SET  CRC_CTSI_Funded= `Salary_+_Fringe` WHERE DeptID LIKE "2968%" AND CRC_Activities =0;
UPDATE crc.cost_dist SET  CRC_Other_Activities=`Salary_+_Fringe` WHERE CRC_Activities=0 AND CRC_CTSI_Funded =0;  
UPDATE crc.cost_dist cd, lookup.sfy lu SET cd.SFY=lu.SFY WHERE cd.MONTH=lu.MONTH;

################################################################
################################################################
#### Create Montly summary by Person of Categorized Salary Data

drop table if exists crc.empsallu;
create table crc.empsallu AS
SELECT Month,
       Person_ID AS Employee_ID,
       max(Name_) AS Emp_Name,
       sum(CRC_Activities) as CRC_Activities,
       sum(CRC_CTSI_Funded) AS CRC_CTSI_Funded,
       sum(CRC_Other_Activities) as CRC_Other_Activities,
       sum(`Salary_+_Fringe`) as Total
from crc.cost_dist   
group by Month, Person_ID  ;  


##  Combine Monthly Time (Segemetned by Wrking Nonworking OPS and Teams salary and fringe data (segmented by activity Type  
drop table if exists crc.EmpTimeSal;
create table crc.EmpTimeSal AS
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
       lu.CRC_Activities,
       lu.CRC_CTSI_Funded,
       lu.CRC_Other_Activities,
       lu.Total AS TotalSalFRng
FROM crc.TimeMonSumm ts 
	 left join crc.empsallu lu 
     on ts.Month=lu.Month AND ts.Employee_ID=lu.Employee_ID;
     

## CLEAN UP Nulls for Salary Categroy Allocations  
UPDATE crc.EmpTimeSal SET CRC_Activities=0 WHERE CRC_Activities IS NULL;
UPDATE crc.EmpTimeSal SET CRC_CTSI_Funded=0 WHERE CRC_CTSI_Funded IS NULL;
UPDATE crc.EmpTimeSal SET CRC_Other_Activities=0 WHERE CRC_Other_Activities IS NULL;


## HAVE A LOOK!
SELECT * FROM crc.EmpTimeSal;

################################################################################################################
################################################################################################################
################################################################################################################
################################################################################################################
################################################################################################################