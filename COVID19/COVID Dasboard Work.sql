drop table if exists work.irbtemp;
create table work.irbtemp
select * from work.irbcat0603d;

drop table if exists work.proptemp;
create table work.proptemp
select * from work.propcat0603b;



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


SELECT Summ_Status, SUM(IRB01+IRB02) AS Total_Prot
FROM work.irbstatcomm
GROUP BY Summ_Status;


# # # # # # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # ## # # #
Drop table if exists work.irbcommcat;
Create table work.irbcommcat as 
Select Committee, Reporting_Category, count(*) AS N
from  work.irbtemp
WHERE Summ_Status="Approved"
group by Committee, Reporting_Category;

Reporting_Category

desc work.irbtemp;

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




select * from work.proptemp;


## ADD SUMMARY STATUS TO IRM FOR REPORTING
Alter table work.proptemp
ADD Summ_Status varchar(45);

UPDATE work.proptemp SET Summ_Status='Award Pending' WHERE CLK_CURRENTSTATE='Award Pending';
UPDATE work.proptemp SET Summ_Status='Awarded' WHERE CLK_CURRENTSTATE='Awarded';
UPDATE work.proptemp SET Summ_Status='Core Office/ Dept / Team Review' WHERE CLK_CURRENTSTATE='Core Office Review';
UPDATE work.proptemp SET Summ_Status='Core Office/ Dept / Team Review' WHERE CLK_CURRENTSTATE='Core Office Review Post Submission Updates';
UPDATE work.proptemp SET Summ_Status='Core Office/ Dept / Team Review' WHERE CLK_CURRENTSTATE='Department Review';
UPDATE work.proptemp SET Summ_Status='Draft Submission' WHERE CLK_CURRENTSTATE='Draft';
UPDATE work.proptemp SET Summ_Status='Not Funded' WHERE CLK_CURRENTSTATE='Not Funded';
UPDATE work.proptemp SET Summ_Status='Core Office/ Dept / Team Review' WHERE CLK_CURRENTSTATE='Pending Proposal Team Response: Dept Review';
UPDATE work.proptemp SET Summ_Status='Pending Sponsor Review' WHERE CLK_CURRENTSTATE='Pending Sponsor Review';
UPDATE work.proptemp SET Summ_Status='Teminated' WHERE CLK_CURRENTSTATE='Terminated';
UPDATE work.proptemp SET Summ_Status='Withdrawn' WHERE CLK_CURRENTSTATE='Withdrawn';

select distinct concat(Summ_Status," - ",CLK_CURRENTSTATE) from work.proptemp;

select count(*) from work.proptemp;

select Summ_Status,count(*) 
from work.proptemp
group by Summ_Status;


### NO Block Grants
select Summ_Status,count(*) AS N, sum(CLK_GRAND_TOTAL) as Total 
from work.proptemp
WHERE Reporting_Category NOT IN ('FED Approp/Block Grant')
group by Summ_Status;

### Block GRANTS
select Summ_Status,count(*) AS N, sum(CLK_GRAND_TOTAL) as Total 
from work.proptemp
WHERE Reporting_Category IN ('FED Approp/Block Grant')
group by Summ_Status;


### CAtegory Table

drop table if exists work.catpro1;
create table work.catpro1 as
select Reporting_Category,count(*) AS N
from work.proptemp
group by Reporting_Category
ORDER BY Reporting_Category;



drop table if exists work.catirb1;
create table work.catirb1 as
Select Reporting_Category, count(*) AS N
from  work.irbtemp
WHERE Committee="IRB-01"
group by Reporting_Category;


drop table if exists work.catirb2;
create table work.catirb2 as
Select Reporting_Category, count(*) AS N
from  work.irbtemp
WHERE Committee="IRB-02"
group by Reporting_Category;


drop table if exists work.cattab;
create table work.cattab AS
SELECT distinct Reporting_Category from work.irbtemp
UNION ALL
SELECT distinct Reporting_Category from proptemp
WHERE Reporting_Category  NOT IN (SELECT distinct Reporting_Category from work.irbtemp);


ALTER TABLE work.cattab
ADD IRB01 int(5),
ADD IRB02 int(5),
ADD UFIRST int(5);


UPDATE work.cattab ct, work.catpro1 lu SET ct.UFIRST=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;
UPDATE work.cattab ct, work.catirb1 lu SET ct.IRB01=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;
UPDATE work.cattab ct, work.catirb2 lu SET ct.IRB02=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;

select * from work.cattab WHERE Reporting_Category<>'IGNORE' ORDER BY Reporting_Category;

#### # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


### PROPOSLA BY CATEGORY AND STATUS

drop table if exists work.catstat;
create table work.catstat AS
SELECT distinct Reporting_Category from proptemp;

ALTER TABLE work.catstat
ADD AppPend int(5),
ADD InProcess int(5),
ADD WithNF int(5);


 
# AWARD OR PENDINF  
drop table if exists work.catstatAPP;
create table work.catstatAPP As
SELECT Reporting_Category,count(*) as N, SUM(CLK_GRAND_TOTAL) AS Total
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
AND CLK_CURRENTSTATE IN ('Awarded','Award Pending')
GROUP BY Reporting_Category;
    
## In  process

drop table if exists work.catstatPro;
create table work.catstatPro As
SELECT Reporting_Category,count(*) AS N
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
drop table if exists work.catstatWNF;
create table work.catstatWNF As
SELECT Reporting_Category, count(*) AS N
from work.proptemp
WHERE Reporting_Category <>"IGNORE"
AND CLK_CURRENTSTATE IN ('Not Funded','Terminated','Withdrawn')
GROUP BY Reporting_Category;
    



UPDATE work.catstat ct, work.catstatAPP lu SET  ct.AppPend=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;
UPDATE work.catstat ct, work.catstatPro lu SET  ct.InProcess=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;
UPDATE work.catstat ct, work.catstatWNF lu SET  ct.WithNF=lu.N WHERE ct.Reporting_Category=lu.Reporting_Category;


SELECT * from work.catstat WHERE Reporting_Category<>'IGNORE' ORDER BY Reporting_Category;




##############################################################################################################################
## Summarize Oppurtunities by Sponsor Category

select * from work.covidopps;

Select Sponsor_Cateogry,count(*) AS N from work.covidopps group by Sponsor_Cateogry;


##############################################################################################################################
###########################   EOF ############################################################################################
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
