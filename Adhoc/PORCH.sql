select * from work.porchlist;
desc work.porchlist;

SELECT SFY,
		count(*) as nRecs, 
        count(Distinct Employee_ID) AS nPeople, 
        COUNT(DISTINCT Salary_PLan) As nSalPlan,
        COUNT(DISTINCT New_Sal_Plan ) AS nNewSalPLAN
from work.porchlist
 group by SFY;
 
 
 DROP TABLE IF EXISTS work.fixPorchSalPlan;
 CREATE TABLE work.fixPorchSalPlan
 SELECT Job_Code,
		Salary_Plan 
 from work.porchlist 
 where Salary_Plan not in ('Housestaff') AND 
		Salary_Plan is not null
 GROUP BY  Job_Code,
			Salary_Plan ;    


### CREATE WORKFILE	
DROP TABLE IF EXISTS   work.PorchPeople;   
Create table work.PorchPeople AS
SELECT * from work.porchlist;
 
Alter table work.PorchPeople ADD New_Sal_Plan varchar(45);



SET SQL_SAFE_UPDATES = 0;

UPDATE work.PorchPeople SET New_Sal_Plan=NULL;

UPDATE work.PorchPeople 
	SET New_Sal_Plan=Salary_Plan 
    WHERE Salary_Plan IS NOT NULL;

DROP TABLE IF EXISTS work.salplanlookup ;
Create table work.salplanlookup AS    
SELECT seq,
	   Employee_ID,
	   Job_Code,
       Salary_Plan 
FROM work.PorchPeople    
 WHERE Salary_Plan IS NULL;  
 
 UPDATE work.salplanlookup sl, work.PorchPeople lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND lu.SFY='SFY 2017-2018' ;
 
  UPDATE work.salplanlookup sl, work.PorchPeople lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND lu.SFY='SFY 2019-2020' ;

  UPDATE work.salplanlookup sl, lookup.Employees lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND sl.Salary_Plan IS NULL; ;

  UPDATE work.salplanlookup sl, work.porchfillsal lu
 SET sl.Salary_Plan=lu.Salary_Code
 WHERE sl.Job_Code=lu.Job_Code
   AND sl.Salary_Plan IS NULL; ; 


SELECT Employee_ID,
	   Job_Code,
       Salary_Plan 
FROM work.salplanlookup   
 WHERE Salary_Plan IS NULL;
 
 
UPDATE work.PorchPeople pp, work.salplanlookup lu
SET pp.New_Sal_Plan=lu.Salary_Plan 
where pp.seq=lu.seq;



SELECT SFY,
		count(*) as nRecs, 
        count(Distinct Employee_ID) AS nPeople, 
        COUNT(DISTINCT Salary_PLan) As nSalPlan,
        COUNT(DISTINCT New_Sal_Plan ) AS nNewSalPLAN
from work.PorchPeople 
 group by SFY;
 
 
 Alter table work.PorchPeople 
		ADD Faculty varchar(12),
        ADD Factype varchar(25);
 
 
 UPDATE  work.PorchPeople SET Faculty="Non-Faculty";
 
 UPDATE  work.PorchPeople SET Faculty="Faculty"
 WHERE New_Sal_Plan LIKE '%Faculty%';
 
 
UPDATE work.PorchPeople pp, work.porchfactype lu
SET pp.FacType=lu.FacType
WHERE 	pp.Job_Code=lu.Job_Code
	AND	pp.New_Sal_Plan=lu.New_Sal_Plan
    AND pp.Faculty=lu.Faculty;
    
UPDATE work.PorchPeople pp
SET pp.FacType="Staff"
WHERE 	pp.facType is NULL;

 
SELECT Distinct FacType from work.PorchPeople;

SELECT * from work.PorchPeople ;
WHERE FacType is NULL;


#########################################################################################################





##################################
##  SCRATCH
 SELECT
	   Job_Code,
       Salary_Plan 
FROM work.salplanlookup   
 WHERE Salary_Plan IS NULL
 GROUP BY Job_Code,
       Salary_Plan;
 
 
 SELECT Job_Code,
        Salary_Plan,
        COUNT(*) As N
from work.PorchPeople
WHERE Salary_Plan IS NOT NULL
AND Job_Code in (        
					SELECT DISTINCT(Job_Code)
					FROM work.salplanlookup   
					WHERE Salary_Plan IS NULL
                )
 GROUP BY Job_Code,
        Salary_Plan;
        
        
        