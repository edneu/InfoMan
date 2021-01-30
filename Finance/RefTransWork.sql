DROP TABLE IF EXISTS finance.ReftransWORK;
Create table finance.ReftransWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);

Alter Table finance.ReftransWORK
	ADD DeptName	varchar(45),
	ADD College	varchar(45),
    ADD TypeFlag varchar(25),
    ADD ProgramSupport varchar(45),
	ADD ProgramSuppCollege varchar(45);

SET SQL_SAFE_UPDATES = 0;
 
CREATE INDEX rtw ON finance.ReftransWORK (Alt_Dept_ID);
CREATE INDEX DeptLookup ON lookup.deptlookup (DEPTID);


UPDATE finance.ReftransWORK tw, lookup.deptlookup lu
SET tw.DeptName=lu.Department,
	tw.College=lu.College
WHERE tw.Alt_Dept_ID=lu.DeptID;    
    
UPDATE finance.ReftransWORK tw, finance.mattmap lu
SET tw. ProgramSupport=lu.ProgramSupport,
	tw.ProgramSuppCollege=lu.ProgramSuppCollege
WHERE tw.Alt_Dept_ID=lu.DeptID;     
    
    
    
    
UPDATE finance.ReftransWORK Set TypeFLag='Transaction';    
UPDATE finance.ReftransWORK Set TypeFLag='Revenue - Transfer' WHERE  Account_Code LIKE '42%';  
UPDATE finance.ReftransWORK Set TypeFlag='Revenue - Transfer' WHERE  Account_Code LIKE '57%';

DROP TABLE IF Exists finance.temp1; 
create table finance.temp1 AS
SELECT Fiscal_Year, Alt_Dept_ID,DeptName,College,ProgramSupport,ProgramSuppCollege,TypeFlag, SUM(Posted_Amount) AS Posted_Amount
FROM finance.ReftransWORK
GROUP BY Fiscal_Year, Alt_Dept_ID,DeptName,College,ProgramSupport,ProgramSuppCollege,TypeFlag;


DROP TABLE IF Exists finance.temp2; 
create table finance.temp2 AS
SELECT Fiscal_Year, Alt_Dept_ID,DeptName,College,ProgramSupport,ProgramSuppCollege,TypeFlag, SUM(Posted_Amount) AS Posted_Amount
FROM finance.ReftransWORK
WHERE ERP_Account_Level_4 like "%SAL%"
GROUP BY Fiscal_Year, Alt_Dept_ID,DeptName,College,ProgramSupport,ProgramSuppCollege,TypeFlag;



DROP TABLE IF Exists finance.temp3; 
create table finance.temp3 AS
select * from finance.ReftransWORK WHERE ERP_Account_Level_4 like "%SAL%";



