select * from work.dh_payroll2;


DROP TABLE IF EXISTS work.dh_payroll_agg;
CREATE TABLE work.dh_payroll_agg AS
SELECT Employee_ID,
	   Name,
       Department_Code,
       Department_name,
       Fund_Code,
       Fund,
       Project_Code,
       Project,
       SUM(Monetary_Amount) as SalPaid
from work.dh_paroll3
GROUP BY Employee_ID,
	   Name,
       Department_Code,
       Department_name,
       Fund_Code,
       Fund,
       Project_Code,
       Project
ORDER BY NAME       ;
	   
       
select * from  work.dh_payroll_agg;       
    
    
select * from      work.dh_salary;


DROP TABLE IF EXISTS work.dh_salary_lu;
CREATE TABLE work.dh_salary_lu AS
SELECT UFID,
       max(NAME) as Name,
       max(FTE) as FTE,
       max(Sal_Plan) as Sal_Plan,
       max(`Annual/Hourly`) AS SalaryAnnHour,
       max(`Annual/Hourly`) AS AnnualSalary
FROM  work.dh_salary       
GROUP BY UFID
ORDER BY Name;       



SET SQL_SAFE_UPDATES = 0;

UPDATE work.dh_salary_lu 
SET AnnualSalary=FTE*2088*SalaryAnnHour
WHERE AnnualSalary<1000;  


ALTER TABLE work.dh_payroll_agg
	ADD Sal_Plan varchar(5),
	ADD FTE decimal(12,2),
	ADD SalaryAnnHour decimal(65,30),
	ADD AnnualSalary decimal(65,30),
    ADD PCT_TOTAL_SAL decimal(65,20);

UPDATE work.dh_payroll_agg pa, work.dh_salary_lu lu
SET pa.Sal_Plan=lu.Sal_Plan,
	pa.FTE=lu.FTE,
	pa.SalaryAnnHour=lu.SalaryAnnHour,
	pa.AnnualSalary=lu.AnnualSalary
WHERE pa.Employee_ID = lu.UFID;


UPDATE work.dh_payroll_agg
SET PCT_TOTAL_SAL=(SalPaid/AnnualSalary)
WHERE AnnualSalary<>0;


select * from work.dh_payroll_agg;


DROP TABLE IF EXISTS work.dh_calmon;
CREATE TABLE work.dh_calmon AS
Select Employee_ID,
	   Name,
       Max(FTE)*12 as CalMon
from work.dh_payroll_agg
GROUP BY Employee_ID,
	   Name;       
       


DROP TABLE IF EXISTS work.dh_saldepcode;
CREATE TABLE work.dh_saldepcode AS
Select Employee_ID,
	   Name,
       Department_Code,
       Department_name,
       SUM(SalPaid) as SalPaid,
       MAX(AnnualSalary) as Salary,
       0.00  AS PctPaid
       
from work.dh_payroll_agg

GROUP BY Employee_ID,
	   Name,
       Department_Code,
       Department_name;       
       

UPDATE work.dh_saldepcode
SET PctPaid=SalPaid/Salary
WHERE Salary<>0;



select distinct Sal_Plan from work.dh_salary_lu Where Salary>1000;

