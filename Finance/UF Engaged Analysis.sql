

select * from finance.uf_eng_oct22;
select * from finance.actv_emp_oct2022;

select Period_Begin_Date,Period_End_Date, count(*) as N from finance.uf_eng_oct22 group by Period_Begin_Date,Period_End_Date;
######################################################################################
######################################################################################
######################################################################################
### Create Work Tables
DROP TABLE IF EXISTS work.UF_ENG;
CREATE TABLE work.UF_ENG AS
SELECT * from finance.uf_eng_oct22;

DROP TABLE IF EXISTS work.UF_ENG_ACTV;
CREATE TABLE work.UF_ENG_ACTV AS
SELECT * from finance.actv_emp_oct2022;

ALTER TABLE work.UF_ENG
	ADD ActvEmp int(1),
    ADD ActvSup int(1),
    ADD ReviewCancelled int(1),
    ADD ReviewComplete int(1),
    ADD ReviewInProgress int(1);
    

##### FLAG ACTIVE EMPLOYEES
SET SQL_SAFE_UPDATES = 0;   

UPDATE work.UF_ENG 
	SET ActvEmp=0;

UPDATE work.UF_ENG ufeg, work.UF_ENG_ACTV lu
	SET ActvEmp=1
    WHERE ufeg.Employee_UFID=lu.ID;

##### FLAG ACTIVE SUPERVISORS    
UPDATE work.UF_ENG 
	SET ActvSup=0;

UPDATE work.UF_ENG ufeg, work.UF_ENG_ACTV lu
	SET ActvSup=1
    WHERE ufeg.Supervisor_UFID=lu.ID;
    
###     Flag Review Status

UPDATE work.UF_ENG ufeg
	SET ReviewCancelled=0,
		ReviewComplete=0,
        ReviewInProgress=0;


UPDATE work.UF_ENG
SET ReviewCancelled=1
WHERE Review_Status='Canceled';

UPDATE work.UF_ENG
SET ReviewComplete=1
WHERE Review_Status='Completed';

UPDATE work.UF_ENG
SET ReviewInProgress=1
WHERE Review_Status='Evaluation in Progress';

Select 	Supervisor_UFID,
		Supervisor_Name,
        Sum(ReviewComplete) as Completed,
        Sum(ReviewCancelled) as Cancelled,
        Sum(ReviewInProgress) as InProgress,
        Count(*) as nRec
FROM work.UF_ENG        
WHERE ActvSup=1
  AND ActvEmp=1
GROUP BY Supervisor_UFID,
		 Supervisor_Name  
ORDER BY  Supervisor_Name        ;			


Select * from  work.UF_ENG  where Supervisor_Name  like "Neu%";

############### RECONCILE LISTS 
DROP TABLE if EXISTS work.ufe_reconcile;
CREATE TABLE work.ufe_reconcile as
SELECT  Supervisor_UFID AS UF_ENGAGED_MGR_UFID,
		Supervisor_Name AS UF_ENGAGED_MGR_NAME
FROM work.UF_ENG 
GROUP BY Supervisor_UFID,
		 Supervisor_Name  
ORDER BY  Supervisor_Name    ;       

ALTER TABLE  work.ufe_reconcile
	ADD EmpList_UFID varchar(12),
	ADD EmpList_Name varchar(45);

SET SQL_SAFE_UPDATES = 0;
UPDATE work.ufe_reconcile ur, work.UF_ENG_ACTV lu
SET ur.EmpList_UFID=lu.ID,
	ur.EmpList_Name=lu.NAME
WHERE ur.UF_ENGAGED_MGR_UFID=lu.ID;    


  