
select * from crc.crc_time_all_years;

drop table if exists crc.timerept;
Create table crc.timerept AS
select * from crc.crc_time_all_years;

ALTER TABLE crc.timerept
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD WorkTime decimal (65,30),
ADD NonWorkTime decimal (65,30)
;

SELECT Time_Reporting_Code_Code,Time_Reporting_Code from crc.crc_time_all_years group by Time_Reporting_Code_Code,Time_Reporting_Code;



SET SQL_SAFE_UPDATES = 0;

UPDATE crc.timerept SET MONTH=concat(YEAR(Date_Used),"-",LPAD(MONTH(Date_Used),2,"0")) ;
UPDATE crc.timerept SET SvcMon = substr(Month,6,2);
UPDATE crc.timerept SET SvcYear = substr(Month,1,4);

UPDATE crc.timerept SET WorkTime = 0, NonWorkTime=0 ;

UPDATE crc.timerept 
SET WorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Work Hours");


UPDATE crc.timerept 
SET NonWorkTime = Quantity
WHERE Time_Reporting_Code_Code IN (SELECT DISTINCT Time_Reporting_Code_Code 
									from crc.timecode_lookup 
                                    WHERE Work_Classification="Non-Work Hours");




UPDATE crc.timerept SET SFY="SFY 2017-2018"
WHERE Month IN (
'2017-07',
'2017-08',
'2017-09',
'2017-10',
'2017-11',
'2017-12',
'2018-01',
'2018-02',
'2018-03',
'2018-04',
'2018-05',
'2018-06');

UPDATE crc.timerept SET SFY="SFY 2018-2019"
WHERE Month IN (
'2018-07',
'2018-08',
'2018-09',
'2018-10',
'2018-11',
'2018-12',
'2019-01',
'2019-02',
'2019-03',
'2019-04',
'2019-05',
'2019-06');

UPDATE crc.timerept SET SFY="SFY 2019-2020"
WHERE Month IN (
'2019-07',
'2019-08',
'2019-09',
'2019-10',
'2019-11',
'2019-12',
'2020-01',
'2020-02',
'2020-03',
'2020-04',
'2020-05',
'2020-06');

UPDATE crc.timerept SET SFY="SFY 2020-2021"
WHERE Month IN (
'2020-07',
'2020-08',
'2020-09',
'2020-10',
'2020-11',
'2020-12',
'2021-01',
'2021-02',
'2021-03',
'2021-04',
'2021-05',
'2021-06');

drop table if exists crc.UFtimeMonSumm;
Create table crc.UFtimeMonSumm AS
SELECT 	"UFHealth" as Employer,
        tr.SFY,
        tr.Month,
		tr.Employee_ID,
        tr.Name,
        round(SUM(tr.Quantity),2) AS TotalHours,
        round(SUM(tr.WorkTime),2) AS WorkedHours,
        round(SUM(tr.NonWorkTime),2) AS NonWorkedHours,
        Min(ah.Avail_hours) as Avail_hours
from crc.timerept tr 
LEFT JOIN crc.avail_hours ah
ON tr.Month=ah.Month
GROUP BY "UFHealth",tr.SFY,tr.Month,tr.Employee_ID,tr.Name;


####################################################################
## SHANDS
drop table if exists crc.shandstime;
Create table crc.shandstime AS
select * from crc.shands_shifts;



ALTER TABLE crc.shandstime
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD TotalHours decimal(65,11),
ADD WorkedHours decimal(65,11),
ADD NonWorkedHours decimal(65,11),
ADD Avail_hours int(11);

SET SQL_SAFE_UPDATES = 0;

UPDATE crc.shandstime SET MONTH=concat(YEAR(Apply_Date),"-",LPAD(MONTH(Apply_Date),2,"0")) ;
UPDATE crc.shandstime SET SvcMon = substr(Month,6,2);
UPDATE crc.shandstime SET SvcYear = substr(Month,1,4);


UPDATE crc.shandstime SET TotalHours=0, WorkedHours=0, NonWorkedHours=0;

UPDATE crc.shandstime SET TotalHours=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;
UPDATE crc.shandstime SET WorkedHours=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;

/*
TotalHours 
WorkedHours 
NonWorkedHours
*/


UPDATE crc.shandstime SET SFY="SFY 2017-2018"
WHERE Month IN (
'2017-07',
'2017-08',
'2017-09',
'2017-10',
'2017-11',
'2017-12',
'2018-01',
'2018-02',
'2018-03',
'2018-04',
'2018-05',
'2018-06');

UPDATE crc.shandstime SET SFY="SFY 2018-2019"
WHERE Month IN (
'2018-07',
'2018-08',
'2018-09',
'2018-10',
'2018-11',
'2018-12',
'2019-01',
'2019-02',
'2019-03',
'2019-04',
'2019-05',
'2019-06');

UPDATE crc.shandstime SET SFY="SFY 2019-2020"
WHERE Month IN (
'2019-07',
'2019-08',
'2019-09',
'2019-10',
'2019-11',
'2019-12',
'2020-01',
'2020-02',
'2020-03',
'2020-04',
'2020-05',
'2020-06');

UPDATE crc.shandstime SET SFY="SFY 2020-2021"
WHERE Month IN (
'2020-07',
'2020-08',
'2020-09',
'2020-10',
'2020-11',
'2020-12',
'2021-01',
'2021-02',
'2021-03',
'2021-04',
'2021-05',
'2021-06');



select * from crc.shandstime;

drop table if exists crc.ShandstimeMonSumm;
Create table crc.ShandstimeMonSumm AS
SELECT 	"Shands" as Employer,
        tr.SFY,
        tr.Month,
		tr.ID as Employee_ID,
        tr.Name,
        round(SUM(tr.TotalHours),2) AS TotalHours,
        round(SUM(tr.WorkedHours),2) AS WorkedHours,        
        round(SUM(tr. NonWorkedHours),2) AS  NonWorkedHours,        
        Min(ah.Avail_hours) as Avail_hours
from crc.shandstime tr 
LEFT JOIN crc.avail_hours ah
ON tr.Month=ah.Month
GROUP BY "Shands",tr.SFY,tr.Month,tr.ID,tr.Name;

/*
TotalHours
WorkedHours 
NonWorkedHours
*/


drop table if exists crc.TimeMonSumm;
Create table crc.TimeMonSumm AS
SELECT * from crc.UFtimeMonSumm
UNION ALL 
SELECT * from crc.ShandstimeMonSumm;


UPDATE crc.TimeMonSumm ts, crc.avail_work_hours lu
SET ts.Avail_hours=lu.WorkHours
WHERE ts.MOnth=lu.Month;


UPDATE crc.TimeMonSumm SET Employee_ID=lPAD(Employee_ID,8,"0");


select * from crc.TimeMonSumm ;




drop table if exists crc.emplist;
Create table crc.emplist AS
SELECT  Name,
		Employer,
		lPAD(Employee_ID,8,"0") AS Employee_ID
from crc.TimeMonSumm
group by Name,
		Employer,
		Employee_ID
order by Name;     


ALTER TABLE crc.emplist
	ADD FTE decimal(12,2),
	ADD Job_Code varchar(255),
	ADD Salary_Plan varchar(255),
    ADD empname varchar(255);

UPDATE crc.emplist el, lookup.active_emp lu
SET el.FTE=lu.FTE,
	el.Job_Code=lu.Job_Code,
    el.Salary_Plan=lu.Salary_Plan,
    el.empname=lu.Name
WHERE el.Employee_ID=lu.Employee_ID;

UPDATE crc.emplist el, lookup.Employees lu
SET el.FTE=lu.FTE,
	el.Job_Code=lu.Job_Code,
    el.Salary_Plan=lu.Salary_Plan,
    el.empname=lu.Name
WHERE el.Employee_ID=lu.Employee_ID
  AND el.empname IS NULL;

SELECT * from crc.emplist;



#############
## EMPLOYEE LOOKUP
##


################################################################
################################################################
## COST DISTIB

SELECT * from crc.cost_dist;

ALTER TABLE crc.cost_dist
DROP CRC_DeptID,
DROP Non_CRCDeptID;


ALTER TABLE crc.cost_dist
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD CRC_Activities decimal (65,11),
ADD CRC_Other_Activities decimal (65,11);

ALTER TABLE crc.cost_dist
ADD CRC_CTSI_Funded decimal (65,11);

/*
•	CRC_Activities  --  DeptID="29680300" and Fund_Code="149"
•	CRC_CTSI_Funded  –   DeptID=”xxxx2968”
•	CRC_Other_Activities – Anything Else
*/
select distinct DeptID from crc.cost_dist;


SET SQL_SAFE_UPDATES = 0;

UPDATE crc.cost_dist SET CRC_Activities=NULL, CRC_CTSI_Funded=Null , CRC_Other_Activities=Null ;

UPDATE crc.cost_dist SET MONTH=concat(YEAR(Accounting_Date),"-",LPAD(MONTH(Accounting_Date),2,"0")) ;
UPDATE crc.cost_dist SET SvcMon = substr(Month,6,2);
UPDATE crc.cost_dist SET SvcYear = substr(Month,1,4);
UPDATE crc.cost_dist SET  CRC_Activities=`Salary_+_Fringe` WHERE DeptID="29680300" and Fund_Code="149";
UPDATE crc.cost_dist SET  CRC_CTSI_Funded= `Salary_+_Fringe` WHERE DeptID LIKE "2968%" AND CRC_Activities IS NULL;
UPDATE crc.cost_dist SET  CRC_Other_Activities=`Salary_+_Fringe` WHERE CRC_Activities IS NULL AND CRC_CTSI_Funded  IS NULL;  

SELECT * from crc.cost_dist WHERE CRC_Activities IS NULL AND CRC_Other_Activities IS NULL;



UPDATE crc.cost_dist SET SFY="SFY 2017-2018"
WHERE Month IN (
'2017-07',
'2017-08',
'2017-09',
'2017-10',
'2017-11',
'2017-12',
'2018-01',
'2018-02',
'2018-03',
'2018-04',
'2018-05',
'2018-06');

UPDATE crc.cost_dist SET SFY="SFY 2018-2019"
WHERE Month IN (
'2018-07',
'2018-08',
'2018-09',
'2018-10',
'2018-11',
'2018-12',
'2019-01',
'2019-02',
'2019-03',
'2019-04',
'2019-05',
'2019-06');

UPDATE crc.cost_dist SET SFY="SFY 2019-2020"
WHERE Month IN (
'2019-07',
'2019-08',
'2019-09',
'2019-10',
'2019-11',
'2019-12',
'2020-01',
'2020-02',
'2020-03',
'2020-04',
'2020-05',
'2020-06');

UPDATE crc.cost_dist SET SFY="SFY 2020-2021"
WHERE Month IN (
'2020-07',
'2020-08',
'2020-09',
'2020-10',
'2020-11',
'2020-12',
'2021-01',
'2021-02',
'2021-03',
'2021-04',
'2021-05',
'2021-06');


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

UPDATE crc.emplist el, lookup.Employees lu
SET el.FTE=lu.FTE,
	el.Job_Code=lu.Job_Code,
    el.Salary_Plan=lu.Salary_Plan,
    el.empname=lu.Name
WHERE el.Employee_ID=lu.Employee_ID
  AND el.empname IS NULL;


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
       ts.Avail_hours,
       lu.CRC_Activities,
       lu.CRC_CTSI_Funded,
       lu.CRC_Other_Activities,
       lu.Total AS TotalSalFRng
FROM crc.TimeMonSumm ts 
	 left join crc.empsallu lu 
     on ts.Month=lu.Month AND ts.Employee_ID=lu.Employee_ID;
     
     
ALTER TABLE crc.EmpTimeSal ADD FTE decimal(65,11);


SET SQL_SAFE_UPDATES = 0;

drop table if exists crc.fte1 ;
create table crc.fte1 AS
SELECT Employee_ID,Name,Salary_Plan,FTE
FROM lookup.active_emp
WHERE Employee_ID IN (SELECT DISTINCT Employee_ID from crc.EmpTimeSal);

drop table if exists crc.fte_lookup;
Create table crc.fte_lookup as
SELECT * from crc.fte1
UNION ALL 
SELECT Employee_ID,Name,Salary_Plan,FTE
FROM lookup.Employees
WHERE Employee_ID IN (SELECT DISTINCT Employee_ID from crc.EmpTimeSal)
AND Employee_ID  NOT IN (SELECT DISTINCT Employee_ID from crc.fte1);


SELECT * from crc.fte_lookup;


UPDATE crc.EmpTimeSal es, crc.emplist lu
SET es.FTE=lu.FTE
WHERE es.Employee_ID=lu.Employee_id;    

UPDATE crc.EmpTimeSal SET FTE=1 WHERE Employer="Shands"; 
UPDATE crc.EmpTimeSal SET FTE=1 WHERE Employee_ID="50435800";

UPDATE crc.EmpTimeSal SET CRC_Activities=0 WHERE CRC_Activities IS NULL;
UPDATE crc.EmpTimeSal SET CRC_CTSI_Funded=0 WHERE CRC_CTSI_Funded IS NULL;
UPDATE crc.EmpTimeSal SET CRC_Other_Activities=0 WHERE CRC_Other_Activities IS NULL;

select * from crc.EmpTimeSal;

drop table if exists  crc.staffsummoa;
Create table crc.staffsummoa as
Select Name,max(FTE) As FTE, sum(WorkedHours) AS WorkedHours, Sum(Avail_hours) as AvailbleHours, sum(FTE*Avail_hours) as FTE_AvailHrs
from crc.EmpTimeSal WHERE MOnth<>"2020-08"
group by Name;
