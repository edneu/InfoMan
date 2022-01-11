Salary##########################################################################################
### Employee Payroll files provided by Lindsey Thompson 11-29-2021
### Createed | delimited file
### converted dates to text string YYYY-MM-DD


drop table if exists loaddata.PedsEmp181920;
create table loaddata.PedsEmp181920 
(
	 recid Integer auto_increment primary key,
     SFY_Source integer(5) NOT NULL ,
     Dept varchar(45) NOT NULL ,
     FundCode varchar(45) NOT NULL ,
     Program varchar(45) NOT NULL ,
     BudgetCode varchar(5) NOT NULL ,
     SourceOfFunds varchar(45) NOT NULL ,
     ProjectCode varchar(45) NOT NULL ,
     FlexCode varchar(45) NOT NULL ,
     EmplID_Name varchar(45) NOT NULL ,
     CRIS_Code varchar(45) NOT NULL ,
     AccountCode varchar(45) NOT NULL ,
     RunDate Datetime NULL ,
     EmployeeGroup varchar(45) NOT NULL ,
     Name  varchar(45) NOT NULL ,
     UFID varchar(12) NOT NULL ,
     ComboCode varchar(12) NOT NULL ,
     JobFTE decimal(25,5) NOT NULL ,
     JobDistPct decimal(25,5) NOT NULL ,
     Salary decimal(25,5) NOT NULL ,
     FringeAmt decimal(25,5) NOT NULL ,
     CostCenterCalc varchar(12) NOT NULL ,
     PayEnd Datetime NULL ,
     AccountingDate Datetime NULL ,
     EmployeeRecord varchar(5) NOT NULL 

);
commit;


load data local infile "P:\\My Documents\\My Documents\\Loaddata\\PedEmp181920.csv" 
into table loaddata.PedsEmp181920
fields terminated by '|'
lines terminated by '\n'
(    SFY_Source,
     Dept,
     FundCode,
     Program,
     BudgetCode,
     SourceOfFunds,
     ProjectCode,
     FlexCode,
     EmplID_Name,
     CRIS_Code,
     AccountCode,
     RunDate,
     EmployeeGroup,
     Name ,
     UFID,
     ComboCode,
     JobFTE,
     JobDistPct,
     Salary,
     FringeAmt,
     CostCenterCalc,
     PayEnd,
     AccountingDate,
     EmployeeRecord

);
#############################
## END OF load 
#############################

## VERIFY 

SET SQL_SAFE_UPDATES = 0;
## REMOVE HEADER
Delete from loaddata.PedsEmp181920 where UFID="UFID";

select * from loaddata.PedsEmp181920;

select UFID,count(*) as n from loaddata.PedsEmp181920 group by UFID;

select SFY_Source, year(PayEnd), count(*) as N from loaddata.PedsEmp181920 group by SFY_Source, year(PayEnd);





SELECT Dept, Count(*) as nRECS from loaddata.PedsEmp181920 group by Dept;
SELECT FundCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by FundCode;
SELECT Program, Count(*) as nRECS from loaddata.PedsEmp181920 group by Program;
SELECT BudgetCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by BudgetCode;
SELECT SourceOfFunds, Count(*) as nRECS from loaddata.PedsEmp181920 group by SourceOfFunds;
SELECT ProjectCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by ProjectCode;
SELECT FlexCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by FlexCode;
SELECT EmplID_Name, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmplID_Name;
SELECT CRIS_Code, Count(*) as nRECS from loaddata.PedsEmp181920 group by CRIS_Code;
SELECT AccountCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by AccountCode;
SELECT RunDate, Count(*) as nRECS from loaddata.PedsEmp181920 group by RunDate;
SELECT EmployeeGroup, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmployeeGroup;   #### FACULTY ID
SELECT Name, Count(*) as nRECS from loaddata.PedsEmp181920 group by Name;
SELECT UFID, Count(*) as nRECS from loaddata.PedsEmp181920 group by UFID;
SELECT ComboCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by ComboCode;
SELECT JobFTE, Count(*) as nRECS from loaddata.PedsEmp181920 group by JobFTE;
SELECT JobDistPct, Count(*) as nRECS from loaddata.PedsEmp181920 group by JobDistPct;
SELECT Salary, Count(*) as nRECS from loaddata.PedsEmp181920 group by Salary;
SELECT FringeAmt, Count(*) as nRECS from loaddata.PedsEmp181920 group by FringeAmt;
SELECT CostCenterCalc, Count(*) as nRECS from loaddata.PedsEmp181920 group by CostCenterCalc;
SELECT PayEnd, Count(*) as nRECS from loaddata.PedsEmp181920 group by PayEnd;
SELECT AccountingDate, Count(*) as nRECS from loaddata.PedsEmp181920 group by AccountingDate;
SELECT EmployeeRecord, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmployeeRecord;
;

###### END OF VERIFY
#######################################################################################
#######################################################################################
## AWARDS SUMMARY 


DROP TABLE IF EXISTS work.PedsAwards;
create table work.PedsAwards AS
SELECT * from lookup.awards_history
WHERE CLK_PI_UFID IN (select distinct UFID from  work.PedEmpSumm)
   OR  CLK_AWD_PROJ_MGR_UFID  IN (select distinct UFID from  work.PedEmpSumm);
   
   
Alter table work.PedsAwards
  ADD SFY varchar(25),
  ADD NIH INT(1),
  ADD Industry int(1),
  ADD PedsPI INT(1),
  ADD PedsContPI INT(1),
  ADD ContEQProj int(1),
  ADD PI_Classify varchar(35),
  ADD PORCH_PROJ_PI int(1),
  ADD PORCH_PI int(1),
  ADD PorchInv int(1);

  
SET SQL_SAFE_UPDATES = 0;  
UPDATE work.PedsAwards SET SFY ='SFY 2017-2018' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2017','%m,%d,%Y') and str_to_date('06,30,2018','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2018-2019' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2018','%m,%d,%Y') and str_to_date('06,30,2019','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2019-2020' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2019','%m,%d,%Y') and str_to_date('06,30,2020','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2020-2021' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2020','%m,%d,%Y') and str_to_date('06,30,2021','%m,%d,%Y');


DELETE FROM work.PedsAwards WHERE SFY IS NULL;

/*  LT awards
create table work.ltawd as
SELECT * from work.PedsAwards
WHERE CLK_PI_UFID='63522942'
OR CLK_AWD_PROJ_ID='63522942';

*/


UPDATE work.PedsAwards SET NIH=0;
UPDATE work.PedsAwards SET NIH=1 WHERE REPORTING_SPONSOR_NAME LIKE '%NATL INST OF HLTH%';
UPDATE work.PedsAwards SET NIH=1 WHERE CLK_AWD_PRIME_SPONSOR_NAME LIKE '%NATL INST OF HLTH%';

UPDATE work.PedsAwards SET Industry=0;
UPDATE work.PedsAwards SET Industry=1 WHERE CLK_AWD_PRIME_SPONSOR_CAT ='Corporations/CompanyForProfit'
                                         OR REPORTING_SPONSOR_CAT='Corporations/CompanyForProfit' ;


UPDATE  work.PedsAwards SET PI_Classify=NULL;

UPDATE work.PedsAwards SET 	PedsPI=0,
							PedsContPI=0,
                            ContEQProj=0;
                            
UPDATE work.PedsAwards SET PedsPI=1 WHERE CLK_PI_UFID IN (select distinct UFID from  work.PedEmpSumm) ;
UPDATE work.PedsAwards SET PedsContPI=1 WHERE CLK_AWD_PROJ_MGR_UFID IN (select distinct UFID from  work.PedEmpSumm) ;
UPDATE work.PedsAwards SET ContEQProj=1 WHERE CLK_PI_UFID=CLK_AWD_PROJ_MGR_UFID;

drop table if exists work.pedawdsumm1;
create table work.pedawdsumm1 AS
SELECT "Contract" as Type,
       SFY,
       CLK_PI_UFID AS UFID,
       ##CLK_AWD_ID AS CLK_AWD_ID,
       count(distinct CLK_AWD_ID) AS nAWARDS,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
FROM work.PedsAwards
WHERE PedsContPI=1 
GROUP BY "Contract",
       SFY,
       CLK_PI_UFID,
       CLK_AWD_ID     
UNION ALL      
SELECT "Project" as Type,
       SFY,
       CLK_AWD_PROJ_MGR_UFID AS UFID,
       ##CLK_AWD_ID AS CLK_AWD_ID,
       count(distinct CLK_AWD_ID) AS nAWARDS,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
FROM work.PedsAwards       
WHERE PedsContPI=0 AND CLK_AWD_PROJ_MGR_UFID IN (select distinct UFID from  work.PedEmpSumm)
GROUP BY 	"Project",
			SFY,
			CLK_AWD_PROJ_MGR_UFID,
			CLK_AWD_ID;      
            

drop table if exists work.pedawdsumm;
create table work.pedawdsumm AS 
select 	UFID,
		SFY,
	    SUM(nAWARDS) AS nAWARDS,
        SUM(Amount) as Amount
FROM work.pedawdsumm1     
GROUP BY 	UFID,
			SFY;




#######################################################################################
#######################################################################################

#### CREATE SUMMARY

DROP TABLE IF EXISTS work.PedEmpSumm;
create table work.PedEmpSumm As
select 	UFID,
		max(Name) As Name
from loaddata.PedsEmp181920
group by UFID;

##select distinct SFY_Source from loaddata.PedsEmp181920;


Alter table work.PedEmpSumm
ADD Payroll_2018 int(1),
ADD Payroll_2019 int(1),
ADD Payroll_2020 int(1),

Add EmpGrp_2018 varchar(45),
Add EmpGrp_2019 varchar(45),
Add EmpGrp_2020 varchar(45),

Add SalFrg_2018 decimal(65,10),
Add Salfrg_2019 decimal(65,10),
Add Salfrg_2020 decimal(65,10),

Add Porch_2018 int(1),
Add Porch_2019 int(1),
Add Porch_2020 int(1),


Add nAwards_2018 int(5),
Add nAwards_2019 int(5),
Add nAwards_2020 int(5),

Add AwdAmt_2018 decimal(65,10),
Add AwdAmt_2019 decimal(65,10),
Add AwdAmt_2020 decimal(65,10);


SET SQL_SAFE_UPDATES = 0;




UPDATE work.PedEmpSumm
SET Payroll_2018=0,
    Payroll_2019=0,
    Payroll_2020=0,
    
    EmpGrp_2018="",
    EmpGrp_2019="",
    EmpGrp_2020="",

    SalFrg_2018=0,
    Salfrg_2019=0,
    Salfrg_2020=0,

    Porch_2018=0,
    Porch_2019=0,
    Porch_2020=0,


    nAwards_2018=0,
    nAwards_2019=0,
    nAwards_2020=0,

    AwdAmt_2018=0,
    AwdAmt_2019=0,
    AwdAmt_2020=0;
    


DROP TABLE IF EXISTS work.pedsUfidYr;
Create table work.pedsUfidYr AS
Select UFID,
       SFY_Source,
       SUM(Salary+FringeAmt) as SalFrg,
       Max(EmployeeGroup) as EmpGrp
 from loaddata.PedsEmp181920  
 GROUP BY 	UFID,
			SFY_Source;
            
            
      
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.Payroll_2018=1 WHERE ps.UFID=lu.UFID AND SFY_Source=2018 AND SalFrg>0;
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.Payroll_2019=1 WHERE ps.UFID=lu.UFID AND SFY_Source=2019 AND SalFrg>0;    
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.Payroll_2020=1 WHERE ps.UFID=lu.UFID AND SFY_Source=2020 AND SalFrg>0;    
          
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.SalFrg_2018=lu.SalFrg WHERE ps.UFID=lu.UFID AND SFY_Source=2018 AND SalFrg>0;
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.SalFrg_2019=lu.SalFrg WHERE ps.UFID=lu.UFID AND SFY_Source=2019 AND SalFrg>0;    
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.SalFrg_2020= lu.SalFrg WHERE ps.UFID=lu.UFID AND SFY_Source=2020 AND SalFrg>0;             


UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.EmpGrp_2018=lu.EmpGrp WHERE ps.UFID=lu.UFID AND SFY_Source=2018 AND SalFrg>0;
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.EmpGrp_2019=lu.EmpGrp WHERE ps.UFID=lu.UFID AND SFY_Source=2019 AND SalFrg>0;    
UPDATE work.PedEmpSumm ps, work.pedsUfidYr lu  SET ps.EmpGrp_2020=lu.EmpGrp WHERE ps.UFID=lu.UFID AND SFY_Source=2020 AND SalFrg>0; 


UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.nAwards_2018=lu.nAwards WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2017-2018";
UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.nAwards_2019=lu.nAwards WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2018-2019";    
UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.nAwards_2020=lu.nAwards WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2019-2020"; 

UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.AwdAmt_2018=lu.Amount WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2017-2018";
UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.AwdAmt_2019=lu.Amount WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2018-2019";    
UPDATE work.PedEmpSumm ps, work.pedawdsumm lu  SET ps.AwdAmt_2020=lu.Amount WHERE ps.UFID=lu.UFID AND lu.SFY="SFY 2019-2020"; 

DELETE FROM work.PedEmpSumm WHERE UFID=' ';


select * from work.PedEmpSumm;
#################################################################
## VERIFICATION SUMMARY TABLE
drop table if exists work.peds_type_summ ;
create table work.peds_type_summ AS
Select EmployeeGroup as Employee_Type 
FROM  loaddata.PedsEmp181920 
GROUP BY EmployeeGroup ;

DROP TABLE IF EXISTS work.peds_type_LU;
Create table work.peds_type_LU AS
SELECT SFY_Source,
	   EmployeeGroup,
       count(distinct UFID) as nEMP
from loaddata.PedsEmp181920
GROUP BY SFY_Source,
	     EmployeeGroup;

Alter table work.peds_type_summ
 ADD SFY2018 int(5),
 ADD SFY2019 int(5),
 ADD SFY2020 int(5);
 

SET SQL_SAFE_UPDATES = 0;


UPDATE work.peds_type_summ
SET SFY2018=0,
	SFY2019=0,
    SFY2020=0;
    

UPDATE work.peds_type_summ ps, work.peds_type_LU lu
SET ps.SFY2018=lu.nEMP
WHERE ps.Employee_Type=lu.EmployeeGroup
AND SFY_Source=2018;


UPDATE work.peds_type_summ ps, work.peds_type_LU lu
SET ps.SFY2019=lu.nEMPnonaward
WHERE ps.Employee_Type=lu.EmployeeGroup
AND SFY_Source=2019;

UPDATE work.peds_type_summ ps, work.peds_type_LU lu
SET ps.SFY2020=lu.nEMP
WHERE ps.Employee_Type=lu.EmployeeGroup
AND SFY_Source=2020;

select * from  work.peds_type_summ;


Select SFY_Source, Count(distinct UFID) as nEMP
from loaddata.PedsEmp181920
GROUP BY SFY_Source;

############################
############################



########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################

######################################
select * from loaddata.PedsEmp181920;

drop table if exists loaddata.PedsEmp181920;
create table loaddata.PedsEmp181920 
(
	 recid Integer auto_increment primary key,
     SFY_Source integer(5) NOT NULL ,
     Dept varchar(45) NOT NULL ,
     FundCode varchar(45) NOT NULL ,
     Program varchar(45) NOT NULL ,
     BudgetCode varchar(5) NOT NULL ,
     SourceOfFunds varchar(45) NOT NULL ,
     ProjectCode varchar(45) NOT NULL ,
     FlexCode varchar(45) NOT NULL ,
     EmplID_Name varchar(45) NOT NULL ,
     CRIS_Code varchar(45) NOT NULL ,
     AccountCode varchar(45) NOT NULL ,
     RunDate Datetime NULL ,
     EmployeeGroup varchar(45) NOT NULL ,
     Name  varchar(45) NOT NULL ,
     UFID varchar(12) NOT NULL ,
     ComboCode varchar(12) NOT NULL ,
     JobFTE decimal(25,5) NOT NULL ,
     JobDistPct decimal(25,5) NOT NULL ,
     Salary decimal(25,5) NOT NULL ,
     FringeAmt decimal(25,5) NOT NULL ,
     CostCenterCalc varchar(12) NOT NULL ,
     PayEnd Datetime NULL ,
     AccountingDate Datetime NULL ,
     EmployeeRecord varchar(5) NOT NULL 

);
commit;


load data local infile "P:\\My Documents\\My Documents\\Loaddata\\PedEmp181920.csv" 
into table loaddata.PedsEmp181920
fields terminated by '|'
lines terminated by '\n'
(    SFY_Source,
     Dept,
     FundCode,
     Program,
     BudgetCode,
     SourceOfFunds,
     ProjectCode,
     FlexCode,
     EmplID_Name,
     CRIS_Code,
     AccountCode,
     RunDate,
     EmployeeGroup,
     Name ,
     UFID,
     ComboCode,
     JobFTE,
     JobDistPct,
     Salary,
     FringeAmt,
     CostCenterCalc,
     PayEnd,
     AccountingDate,
     EmployeeRecord

);
#############################
## END OF load 
#############################

## VERIFY 

SET SQL_SAFE_UPDATES = 0;
## REMOVE HEADER
Delete from loaddata.PedsEmp181920 where UFID="UFID";

select * from loaddata.PedsEmp181920;

select UFID,count(*) as n from loaddata.PedsEmp181920 group by UFID;

select SFY_Source, year(PayEnd), count(*) as N from loaddata.PedsEmp181920 group by SFY_Source, year(PayEnd);





SELECT Dept, Count(*) as nRECS from loaddata.PedsEmp181920 group by Dept;
SELECT FundCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by FundCode;
SELECT Program, Count(*) as nRECS from loaddata.PedsEmp181920 group by Program;
SELECT BudgetCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by BudgetCode;
SELECT SourceOfFunds, Count(*) as nRECS from loaddata.PedsEmp181920 group by SourceOfFunds;
SELECT ProjectCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by ProjectCode;
SELECT FlexCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by FlexCode;
SELECT EmplID_Name, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmplID_Name;
SELECT CRIS_Code, Count(*) as nRECS from loaddata.PedsEmp181920 group by CRIS_Code;
SELECT AccountCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by AccountCode;
SELECT RunDate, Count(*) as nRECS from loaddata.PedsEmp181920 group by RunDate;
SELECT EmployeeGroup, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmployeeGroup;   #### FACULTY ID
SELECT Name, Count(*) as nRECS from loaddata.PedsEmp181920 group by Name;
SELECT UFID, Count(*) as nRECS from loaddata.PedsEmp181920 group by UFID;
SELECT ComboCode, Count(*) as nRECS from loaddata.PedsEmp181920 group by ComboCode;
SELECT JobFTE, Count(*) as nRECS from loaddata.PedsEmp181920 group by JobFTE;
SELECT JobDistPct, Count(*) as nRECS from loaddata.PedsEmp181920 group by JobDistPct;
SELECT Salary, Count(*) as nRECS from loaddata.PedsEmp181920 group by Salary;
SELECT FringeAmt, Count(*) as nRECS from loaddata.PedsEmp181920 group by FringeAmt;
SELECT CostCenterCalc, Count(*) as nRECS from loaddata.PedsEmp181920 group by CostCenterCalc;
SELECT PayEnd, Count(*) as nRECS from loaddata.PedsEmp181920 group by PayEnd;
SELECT AccountingDate, Count(*) as nRECS from loaddata.PedsEmp181920 group by AccountingDate;
SELECT EmployeeRecord, Count(*) as nRECS from loaddata.PedsEmp181920 group by EmployeeRecord;
;

###### END OF VERIFY
#######################################################################################


CREATE SUMMARY

DROP TABLE IF EXISTS work.PedEmpSumm;
create table work.PedEmpSumm As
select 	UFID,
		max(Name) 
from loaddata.PedsEmp181920
group by UFID;

select distinct SFY_Source from loaddata.PedsEmp181920;


Alter table work.PedEmpSumm
ADD Payroll_2018 int(1),
ADD Payroll_2019 int(1),
ADD Payroll_2020 int(1),

Add EmpGrp_2018 varchar(45)
Add EmpGrp_2019 varchar(45)
Add EmpGrp_2020 varchar(45)





2018Porch
2019Porch
2020Porch

2018
2019
2020

2018Salary
2019
2020

2018nAwards
2019
2020

2018AwdAmt
2019
2020


##################################################################################
select * from work.PedEmpSumm;
DESC work.PedEmpSumm;

ALter table work.PedEmpSumm
ADD PORCH_17_18	int(1),
ADD PORCH_18_19	int(1),
ADD PORCH_19_20	int(1),
ADD PORCH_20_21	int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.PedEmpSumm pe
SET pe.PORCH_17_18=0,
    pe.PORCH_18_19=0,
	pe.PORCH_19_20=0,
	pe.PORCH_20_21=0;

UPDATE work.PedEmpSumm pe,work.PedsEmp lu 
SET     pe.PORCH_17_18=lu.PORCH_17_18,
        pe.PORCH_18_19=lu.PORCH_18_19,
        pe.PORCH_19_20=lu.PORCH_19_20,
        pe.PORCH_20_21=lu.PORCH_20_21
WHERE pe.UFID=lu.UFID;


drop table if exists work.porchout;
create table work.porchout AS
SELECT      UFID,
     Name,
     Payroll_2018,
     Payroll_2019,
     Payroll_2020,
     PORCH_17_18,
     PORCH_18_19,
     PORCH_19_20,
     PORCH_20_21,
     EmpGrp_2018,
     EmpGrp_2019,
     EmpGrp_2020,
     SalFrg_2018,
     Salfrg_2019,
     Salfrg_2020,
     nAwards_2018,
     nAwards_2019,
     nAwards_2020,
     AwdAmt_2018,
     AwdAmt_2019,
     AwdAmt_2020
FROM work.PedEmpSumm ;     

Alter table work.porchout ADD CurrentJobTitle varchar(255);

Alter table work.porchout ADD FacTYpe varchar(25);


CREATE INDEX tmpufid ON  work.porchout (UFID);

UPDATE  work.porchout SET CurrentJobTitle=NULL, FacType=Null;

UPDATE  work.porchout po, lookup.Employees lu
SET po.CurrentJobTitle=lu.Job_Code,
	po.FacType=lu.FacType
WHERE po.UFID=lu.Employee_ID;

select * from work.porchout;


select CurrentJobTitle,count(*) from   work.porchout group by CurrentJobTitle;


########################################

desc loaddata.PedsEmp181920;

##### CREATE Payroll work table

drop table if exists  work.pedpay ;
create table work.pedpay as
select * from loaddata.PedsEmp181920;

### ADD Porch Indicators
ALter table work.pedpay
ADD PORCH_17_18	int(1),
ADD PORCH_18_19	int(1),
ADD PORCH_19_20	int(1),
ADD PORCH_20_21	int(1);

CREATE INDEX ufid_pedpay ON work.pedpay (UFID);
CREATE INDEX ufid_pedemp ON work.PedsEmp (UFID);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.pedpay pe
SET pe.PORCH_17_18=0,
    pe.PORCH_18_19=0,
	pe.PORCH_19_20=0,
	pe.PORCH_20_21=0;

UPDATE work.pedpay pe, work.PedsEmp lu 
SET     pe.PORCH_17_18=lu.PORCH_17_18,
        pe.PORCH_18_19=lu.PORCH_18_19,
        pe.PORCH_19_20=lu.PORCH_19_20,
        pe.PORCH_20_21=lu.PORCH_20_21
WHERE pe.UFID=lu.UFID;

desc work.pedpay ;







Alter table  work.pedpay 	
	ADD CurrentJobTitle varchar(255),
	ADD FacTYpe varchar(25);


UPDATE  work.pedpay 
	SET CurrentJobTitle=NULL, 
		FacType=Null;

UPDATE work.pedpay po, lookup.Employees lu
SET po.CurrentJobTitle=lu.Job_Code,
	po.FacType=lu.FacType
WHERE po.UFID=lu.Employee_ID;


select * from work.pedpay;


select CurrentJobTitle,EmployeeGroup,FacType, count(*) as nRECs, Count(distinct UFID) as nUFID
from  work.pedpay 
WHERE CurrentJobTitle in (select distinct CurrentJobTitle from  work.pedpay WHERE FacType is Null)
GROUP BY CurrentJobTitle,EmployeeGroup, FacType; 

Select distinct factype from work.pedpay;

    Update work.pedpay SET FacType='Faculty' WHERE EmployeeGroup='COM_CLINICAL_FAC' AND FacType IS null;
    Update work.pedpay SET FacType='Faculty' WHERE EmployeeGroup='FACULTY' AND FacType IS null;
    Update work.pedpay SET FacType='Non-Faculty' WHERE EmployeeGroup='EXEMPT_TEAMS_USPS' AND FacType IS null;
    Update work.pedpay SET FacType='Non-Faculty' WHERE EmployeeGroup='NONEXEMPT_TEAMS_USPS' AND FacType IS null;
    Update work.pedpay SET FacType='Non-Faculty' WHERE EmployeeGroup='OPSOTHER' AND FacType IS null;
    Update work.pedpay SET FacType='Non-Faculty' WHERE EmployeeGroup='STUDASST' AND FacType IS null;
    Update work.pedpay SET FacType='Non-Faculty' WHERE EmployeeGroup='TEMP' AND FacType IS null;
    Update work.pedpay SET FacType='Resident' WHERE EmployeeGroup='RESIDENTS' AND FacType IS null;
    Update work.pedpay SET FacType='Trainee' WHERE EmployeeGroup='GRADASSTS' AND FacType IS null;
    Update work.pedpay SET FacType='Trainee' WHERE EmployeeGroup='POST_DOCS' AND FacType IS null;




######
SELECT SFY_Source, Count(*) as nRECS from work.pedpay  group by SFY_Source;

SELECT Dept, Count(*) as nRECS from work.pedpay  group by Dept;
SELECT FundCode, Count(*) as nRECS from work.pedpay  group by FundCode;

select CurrentJobTitle, Count(*) as nRECS from work.pedpay  group by CurrentJobTitlet;
sELECT FacType, Count(*) as nRECS from work.pedpay  group by FacType;

SELECT Dept, Count(*) as nRECS from work.pedpay  group by Dept;
SELECT FundCode, Count(*) as nRECS from work.pedpay  group by FundCode;
SELECT Program, Count(*) as nRECS from work.pedpay  group by Program;
SELECT BudgetCode, Count(*) as nRECS from work.pedpay  group by BudgetCode;
SELECT SourceOfFunds, Count(*) as nRECS from work.pedpay  group by SourceOfFunds;
SELECT ProjectCode, Count(*) as nRECS from work.pedpay  group by ProjectCode;
SELECT FlexCode, Count(*) as nRECS from work.pedpay  group by FlexCode;
SELECT EmplID_Name, Count(*) as nRECS from work.pedpay  group by EmplID_Name;
SELECT CRIS_Code, Count(*) as nRECS from work.pedpay group by CRIS_Code;
SELECT AccountCode, Count(*) as nRECS from work.pedpay group by AccountCode;
SELECT RunDate, Count(*) as nRECS from work.pedpay group by RunDate;
SELECT EmployeeGroup, Count(*) as nRECS from work.pedpay group by EmployeeGroup;   #### FACULTY ID
SELECT Name, Count(*) as nRECS from work.pedpay group by Name;
SELECT UFID, Count(*) as nRECS from work.pedpay group by UFID;
SELECT ComboCode, Count(*) as nRECS from work.pedpay group by ComboCode;
SELECT JobFTE, Count(*) as nRECS from work.pedpay group by JobFTE;
SELECT JobDistPct, Count(*) as nRECS from work.pedpay group by JobDistPct;
SELECT Salary, Count(*) as nRECS from work.pedpay group by Salary;
SELECT FringeAmt, Count(*) as nRECS from work.pedpay group by FringeAmt;
SELECT CostCenterCalc, Count(*) as nRECS from work.pedpay group by CostCenterCalc;
SELECT PayEnd, Count(*) as nRECS from work.pedpay group by PayEnd;
SELECT AccountingDate, Count(*) as nRECS from work.pedpay group by AccountingDate;
SELECT EmployeeRecord, Count(*) as nRECS from work.pedpay group by EmployeeRecord;
