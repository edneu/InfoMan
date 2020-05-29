drop table if exists work.irbtemp;
create table work.irbtemp
select * from work.irbcat0527;

drop table if exists work.proptemp;
create table work.proptemp
select * from work.propcat0527;


###########################################################################################################
##### IRB COVID-19 DASHBOARD ITEMS ########################################################################
###########################################################################################################

## ADD SUMMARY STATUS TO IRM FOR REPORTING
Alter table work.irbtemp
ADD Summ_Status varchar(45);

UPDATE work.irbtemp SET Summ_Status='Approved' WHERE Current_Status='Approved';
UPDATE work.irbtemp SET Summ_Status='Changes Requested' WHERE Current_Status='Awaiting Correspondence';
UPDATE work.irbtemp SET Summ_Status='Changes Requested' WHERE Current_Status='Changes Requested by Exempt Reviewer';
UPDATE work.irbtemp SET Summ_Status='Changes Requested' WHERE Current_Status='Changes Requested by Expedited Reviewer';
UPDATE work.irbtemp SET Summ_Status='Changes Requested' WHERE Current_Status='Changes Requested By IRB Staff';
UPDATE work.irbtemp SET Summ_Status='Changes Requested' WHERE Current_Status='Contingencies Pending';
UPDATE work.irbtemp SET Summ_Status='Approved' WHERE Current_Status='Exempt Approved';
UPDATE work.irbtemp SET Summ_Status='In Review' WHERE Current_Status='In Exempt Review IRB Staff Action Required';
UPDATE work.irbtemp SET Summ_Status='In Review' WHERE Current_Status='In Expedited Review IRB Staff Action Required';
UPDATE work.irbtemp SET Summ_Status='IRB Assignment' WHERE Current_Status='IRB Assignment';
UPDATE work.irbtemp SET Summ_Status='In Review' WHERE Current_Status='IRB Staff Review';
UPDATE work.irbtemp SET Summ_Status='Presubmission' WHERE Current_Status='Pre Submission';
UPDATE work.irbtemp SET Summ_Status='Presubmission' WHERE Current_Status='Template';
UPDATE work.irbtemp SET Summ_Status='Withdrawn' WHERE Current_Status='Withdrawn';



DROP TABLE IF EXISTS work.irbstatcomm;
Create table work.irbstatcomm as 
SELECT DISTINCT Summ_Status FROM work.irbtemp;

ALTER TABLE work.irbstatcomm
	ADD IRB01 int(5),
	ADD IRB02 int(5);



DROP TABLE IF EXISTS work.irbcommsumm;
Create table work.irbcommsumm as 
Select Committee, Summ_Status, count(*) AS N
from  work.irbtemp
group by Committee, Summ_Status;



UPDATE work.irbstatcomm ic, work.irbcommsumm lu
SET ic.IRB01=lu.N 
WHERE lu.Committee="IRB-01"
AND   ic.Summ_Status=lu.Summ_Status;  



UPDATE work.irbstatcomm ic, work.irbcommsumm lu
SET ic.IRB02=lu.N 
WHERE lu.Committee="IRB-02"
AND   ic.Summ_Status=lu.Summ_Status;

SELECT * from work.irbstatcomm;


# # # # # # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # #
Drop table if exists work.irbcommcat;
Create table work.irbcommcat as 
Select Committee, Reporting_Category, count(*) AS N
from  work.irbtemp
WHERE Summ_Status="Approved"
group by Committee, Reporting_Category;

DROP TABLE IF EXISTS work.irbcatcomm;
Create table work.irbcatcomm as 
SELECT DISTINCT Reporting_Category FROM work.irbtemp;

ALTER TABLE work.irbcatcomm
	ADD IRB01 int(5),
	ADD IRB02 int(5);


UPDATE work.irbcatcomm ic,  work.irbcommcat lu
SET ic.IRB01=lu.N 
WHERE lu.Committee="IRB-01"
AND   ic.Reporting_Category=lu.Reporting_Category;  



UPDATE work.irbcatcomm ic,  work.irbcommcat lu
SET ic.IRB02=lu.N 
WHERE lu.Committee="IRB-02"
AND   ic.Reporting_Category=lu.Reporting_Category;


SELECT * from work.irbcatcomm
WHERE Reporting_Category<>"IGNORE" ;




###########################################################################################################
##### UFIRST PROPOSALS ####################################################################################
###########################################################################################################


   
  
  
SELECT Reporting_Category,count(*), SUM(CLK_GRAND_TOTAL) AS Total
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
GROUP BY Reporting_Category;

 
# AWARD OR PENDINF  
SELECT Reporting_Category,count(*) as N, SUM(CLK_GRAND_TOTAL) AS Total
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
AND CLK_CURRENTSTATE IN ('Awarded','Award Pending')
GROUP BY Reporting_Category;
    
## In  process
    
 SELECT Reporting_Category,count(*)
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
AND CLK_CURRENTSTATE IN (	'Core Office Review',
							'Core Office Review Post Submission Updates',
							'Department Review',
							'Draft',
							'Pending Proposal Team Response: Core Office Review',
							'Pending Sponsor Review'
                            )
GROUP BY Reporting_Category;
                            
#  Not Funded or withdrawn
SELECT Reporting_Category,count(*)
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
AND CLK_CURRENTSTATE IN ('Not Funded','Terminated','Withdrawn')
GROUP BY Reporting_Category;
    




')
GROUP BY Reporting_Category;   
    
    
    
select distinct CLK_CURRENTSTATE from work.proptemp  ;  
    
    
    
        SELECT Reporting_Cateogiry,CLK_TITLE,CLK_PI_NAME,CLK_TOTAL_DIRECT_COSTS,CLK_TOTAL_INDIRECT_COSTS,CLK_GRAND_TOTAL
        from work.proptemp7 
    WHERE CLK_CURRENTSTATE='Awarded' ;
    
    
    
    select * from work.oppcat;
    
    
    select Sponsor_Cateogry, count(*) from  work.oppcat group by Sponsor_Cateogry;
    
  select count(distinct Orig_program) from lookup.roster;