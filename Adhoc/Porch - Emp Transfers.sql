##############
#### CLINICAL EMPLOYEEE TRANSFERS


##  CREATE WORK FILE
DROP TABLE IF EXISTS work.emp_transfers;
Create table work.emp_transfers AS
SELECT * from work.clinical_emp_transfers;

Alter table  work.emp_transfers
ADD Old_College varchar(45),
ADD New_College varchar(45),
ADD SalaryChangeHourly decimal(65,10),
ADD SalaryChangeAnnual decimal(65,10),
ADD SameCollege int(1),
ADD SameDept int(1),
ADD MultiTransfers int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.emp_transfers et, lookup.deptlookup lu
SET et.Old_College=lu.College
WHERE et.Old_Dept_ID=lu.DEPTID;

UPDATE work.emp_transfers et, lookup.deptlookup lu
SET et.New_College=lu.College
WHERE et.New_DeptID=lu.DEPTID;

####VERIFY COLLEGE ASSIGNMENTS
select Old_Dept_ID,Old_Dept,Old_College,
	   New_DeptID,New_dept,New_College
FROM work.emp_transfers   ;    

#### UPDATE MISSING COLLEGE ASSIGNEMENTS
UPDATE  work.emp_transfers	
	SET Old_College='COLLEGE-MEDICINE'
	WHERE Old_Dept_ID IN ('29680247','29360000');

UPDATE  work.emp_transfers
	SET New_College='COLLEGE-MEDICINE'
	WHERE New_DeptID IN ('29680247','29360000');

UPDATE  work.emp_transfers
SET SalaryChangeHourly=New_Hrly_Rate-Old_Hrly_Rate,
	SalaryChangeAnnual=New_Annual_Rt-Old_Annual_Rt;
    
UPDATE  work.emp_transfers Set 	SameCollege=0,
								SameDept=0,
                                MultiTransfers=0;    

UPDATE  work.emp_transfers Set SameCollege=1
WHERE Old_College=New_College;

UPDATE  work.emp_transfers Set SameDept=1
WHERE Old_Dept_ID=New_DeptID;   

DROP TABLE IF EXISTS work.multitemp;
Create table work.multitemp as 
 select DISTINCT ID 
 from  work.emp_transfers
WHERE ID IN (SELECT DISTINCT ID from work.emp_transfers WHERE Span>1); 


UPDATE  work.emp_transfers Set MultiTransfers=1
WHERE ID IN (SELECT DISTINCT ID from work.multitemp); 


#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
select * from work.emp_transfers;
desc work.emp_transfers;

select * from work.emp_transfers where SameCollege=1;

select * from work.emp_transfers where SameDept=1;
    
select * from work.emp_transfers where MultiTransfers=1;    
    
drop table if Exists  work.tempout;
Create table work.tempout as    
select * from work.emp_transfers where MultiTransfers=1;       

#################################
drop table if Exists  work.tempout;
Create table work.tempout as    
select ID,
Name,
Eff_Date,
Old_Descr,
Old_College,
Old_Dept,
Old_Annual_Rt,
Old_Hrly_Rate,
New_Descr,
New_dept,
New_College,
New_Annual_Rt,
New_Hrly_Rate,
Descr AS Reason,
SameCollege,
SameDept
from work.emp_transfers where MultiTransfers=1
ORDER BY ID, EFF_DATE;   




### Same College Different Departments
drop table if Exists  work.tempout;
Create table work.tempout as
SELECT 	Old_Dept,
		New_dept,
        count(distinct ID) as nPeople,
        Avg(SalaryChangeHourly) AS AvgHourlySalChng,
		Avg(SalaryChangeAnnual) AS AvgAnnualSalChng
from work.emp_transfers
WHERE 		SameCollege=1
AND 		SameDept=0
AND         MultiTransfers=0
Group by 	Old_Dept,
			New_dept;

### Differnt Colleges
SELECT 	Old_College,
		New_College,
        count(distinct ID) as nPeople,
        Avg(SalaryChangeHourly) AS AvgHourlySalChng,
		Avg(SalaryChangeAnnual) AS AvgAnnualSalChng
from work.emp_transfers
WHERE 		SameCollege=0
AND 		SameDept=0
AND         MultiTransfers=0
Group by 	Old_College,
			New_College;





ALTER TABLE work.emp_transfers
ADD TransColl varchar(155),
ADD TransDept varchar(155),
ADD TransPos varchar(155);

UPDATE work.emp_transfers SET TransColl=CONCAT(Old_College, " -> ",New_College);  
UPDATE work.emp_transfers SET TransDept=CONCAT(Old_Dept, " -> ",New_dept);  
UPDATE work.emp_transfers SET TransPos=CONCAT(Old_Descr, " -> ",New_Descr);  

#####################
## Same College
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	New_College,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE SameCollege=1
GROUP BY New_College;         
        
## DIFFERENT COLLEGE
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	TransColl,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE SameCollege=0
GROUP BY TransColl;   

### SAME DEPT
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	New_dept,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE SameDept=1
GROUP BY New_dept; 

### DIFFERENT DEPARTMENT
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	TransDept,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE SameDept=0
GROUP BY TransDept;

### DIFFERENT DEPARTMENT - SAME COLLEGE
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	TransDept,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE SameDept=0
AND SameCollege=1
GROUP BY TransDept;

#### Same Position 
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	Old_Descr,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE Old_Descr=New_Descr
GROUP BY Old_Descr;

### DIFFERENT POSITION 
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT 	concat(Old_Descr," -> ",New_Descr) As PosCng,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
WHERE Old_Descr<>New_Descr
GROUP BY concat(Old_Descr," -> ",New_Descr);

#### REasons
drop table if exists work.tempdtl;
create table work.tempdtl as
SELECT Descr,
		count(*) as nTransfers,
		count(distinct ID) as Undup,
        AVG(SalaryChangeAnnual) as AvgSalChange
from work.emp_transfers 
GROUP BY Descr;

#### SUMMARY TABLE
SELECT "Total Transfers" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
UNION ALL
SELECT "Transfers Between Colleges" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE SameCollege=0
UNION ALL    
SELECT "Transfers Within Same College" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE SameCollege=1
UNION ALL
SELECT "Transfers within Department " as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE SameDept=1    
UNION ALL
SELECT "Transfer to Different Department" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE SameDept=0 
UNION ALL
SELECT "Transfer to Different Department within College" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE SameDept=0 AND SameCollege=1 
UNION ALL    
SELECT "Multiple Transfers" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE MultiTransfers=1  
UNION ALL    
SELECT "Transfer with Same Position" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE Old_Descr=New_Descr
UNION ALL     
SELECT "Transfer to Different Position" as Measure, Count(*) as nTransfers, count(Distinct ID) as Undup, avg(SalaryChangeAnnual) as AvgSalChng from work.emp_transfers
	WHERE Old_Descr<>New_Descr  ;  
    
####### MULTi TRASNFERS
select * from work.multitrans;
select count(distinct ID) from work.multitrans;

alter table work.multitrans
ADD SalChng_1_3 decimal(65,10);
SET SQL_SAFE_UPDATES = 0;
UPDATE work.multitrans SET SalChng_1_3 =(New_Annual_Rt_2-Old_Annual_Rt);

select 
       count(*) as N,
       avg(SalChng_1_2) as salchg12,
	   avg(SalChng_2_3) as salchg23,
       avg(SalChng_1_3) as salchg13,
       avg(Months_in_Prior) as MonthInPrior
from work.multitrans;

select Old_Dept,New_dept,Old_Dept_2,New_dept_2,
       count(*) as N,
       avg(SalChng_1_2) as salchg12,
	   avg(SalChng_2_3) as salchg23,
       avg(SalChng_1_3) as salchg13,
       avg(Months_in_Prior) as MonthInPrior
from work.multitrans 
WHERE SameCollege_2 = 1 AND SameCollege=1
  and (SameDept=0 OR SameDept_2=0)  
GROUP BY Old_Dept,New_dept,Old_Dept_2,New_dept_2;

 ;

