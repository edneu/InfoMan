DROP TABLE IF EXISTS finance.ReftransWORK;
Create table finance.ReftransWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);

Alter Table finance.ReftransWORK
	ADD DeptName	varchar(45),
	ADD College	varchar(45),
    ADD TypeFlag varchar(25);


SET SQL_SAFE_UPDATES = 0;
 
CREATE INDEX rtw ON finance.ReftransWORK (Alt_Dept_ID);
CREATE INDEX DeptLookup ON lookup.deptlookup (DEPTID);


UPDATE finance.ReftransWORK tw, lookup.deptlookup lu
SET tw.DeptName=lu.Department,
	tw.College=lu.College
WHERE tw.Alt_Dept_ID=lu.DeptID;    
    