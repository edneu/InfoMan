
#############################################################################
#############################################################################
#############################################################################
#############################################################################
####################### 
## CREATE COMBINED BUDGET TABLE
## CREATE TABLE BASED ON Standardized Format combined budget tables (SFY 2020-2021 and SFY 2021-2022)
/*
drop table if exists finance.Budget2020_2022;
create table finance.Budget2020_2022 
(
		recid Integer auto_increment primary key,
        BudgetSFY varchar(45) NULL,
        RFA_COMPONENT varchar(45) NULL,
        RFA_Function_Module varchar(128) NULL,
        CTSI_Funding_Bucket_RFA varchar(45) NULL,
        Primary_CTSI_Funding_Bucket varchar(45) NULL,
        ASSIST_Primary_Category varchar(128) NULL,
        Employee_Type varchar(45) NULL,
        CAS_Required varchar(25) NULL,
        PS_Sal_Plan varchar(25) NULL,
        ASSIST_Secondary varchar(128) NULL,
        Line_Item_Detail varchar(255) NULL,
        Last_Name varchar(128) NULL,
        UFID varchar(12) NULL,
        Program_Dept_ID varchar(25) NULL,
        Home_Dept_ID varchar(12) NULL,
        CTSI_Role varchar(255) NULL,
        NOA_SK varchar(5) NULL,
        Biosketch varchar(12) NULL,
        eRA_Username varchar(45) NULL,
        Base_Salary decimal(65,10) NULL,
        NIH_Cap decimal(65,10) NULL,
        Base_Increase varchar(5) NULL,
        New_Base_CAP decimal(65,10) NULL,
        Effort_Total_All_Effort_CTSI decimal(65,10) NULL,
        Cal_Mo decimal(65,10) NULL,
        Salary_Request decimal(65,10) NULL,
        Fringe decimal(65,10) NULL,
        Fringe_Request decimal(65,10) NULL,
        Total_Request decimal(65,10) NULL,
        Cap_Request_Salary decimal(65,10) NULL,
        Cap_Request_Fringe decimal(65,10) NULL,
        Cap_Request decimal(65,10) NULL,
        NIH_EFFORT decimal(65,10) NULL,
        NIH_CAL_MO decimal(65,10) NULL,
        NIH_Salary decimal(65,10) NULL,
        NIH_Fringe decimal(65,10) NULL,
        Checksum decimal(65,10) NULL,
        NIH_Sal_and_Fringe decimal(65,10) NULL,
        Expense_Type varchar(128) NULL,
        Narrative_ varchar(5) NULL,
        Commons varchar(5) NULL,
        NIH_TOTAL decimal(65,10) NULL,
        NIH_PIl_UNLIQ varchar(5) NULL,
        NIH_Admin_Supplement varchar(5) NULL,
        COM decimal(65,10) NULL,
        COM_Billable varchar(5) NULL,
        HSC decimal(65,10) NULL,
        OOR decimal(65,10) NULL,
        OoR_Old decimal(65,10) NULL,
        Norton_Commitment decimal(65,10) NULL,
        ROH decimal(65,10) NULL,
        DSR_ROH decimal(65,10) NULL,
        Unfunded decimal(65,10) NULL,
        AUX decimal(65,10) NULL,
        FTE_Cost_Recovery decimal(65,10) NULL,
        Program_Funded_Total decimal(65,10) NULL,
        OTC_Dept_Paid decimal(65,10) NULL,
        Adtl_Support_Request decimal(65,10) NULL,
        MD_PhD_NIH decimal(65,10) NULL,
        MD_PhD_State decimal(65,10) NULL,
        COM_OTC_211 decimal(65,10) NULL,
        F30_Grants decimal(65,10) NULL,
        MD_Phd_COM decimal(65,10) NULL,
        MD_Phd_Endowment decimal(65,10) NULL,
        COM_Carry_Forward decimal(65,10) NULL,
        INST_KL_TL decimal(65,10) NULL,
        SECIM_NIH_Grant_and_carryforward decimal(65,10) NULL,
        SECIM_ROH_and_DSR_Match decimal(65,10) NULL,
        SECIM_Aux decimal(65,10) NULL,
        CERHB_State decimal(65,10) NULL,
        CERHB_DOCE decimal(65,10) NULL,
        CTSI_NIH_OCR decimal(65,10) NULL,
        State_OCR decimal(65,10) NULL,
        State_OCR_RAC decimal(65,10) NULL,
        COM_OCR decimal(65,10) NULL,
        OoR_OCR decimal(65,10) NULL,
        Cancer_OCR_171 decimal(65,10) NULL,
        OoR_Pilots_Carryforward decimal(65,10) NULL,
        Norton_cGMP decimal(65,10) NULL,
        Nelson_cGMP decimal(65,10) NULL,
        Cancer_cGMP decimal(65,10) NULL,
        Total_Line_Item decimal(65,10) NULL,
        Check_Sum_2 decimal(65,10) NULL,
        Email varchar(45) NULL,
        Notes varchar(128) NULL,
        Updated_Jan_2021 varchar(12) NULL

);   
#######################     
## LOAD DATA FORM Combined file standardized Format combined budget tables  (SFY 2020-2021 and SFY 2021-2022)
## NOTE infile is Pipe '|' delimited 
##
 load data local infile "P:\\My Documents\\My Documents\\Loaddata\\newbudget202122.csv" 
into table finance.Budget2020_2022 
fields terminated by '|'
lines terminated by '\n'
IGNORE 1 LINES
(    BudgetSFY,
     RFA_COMPONENT,
     RFA_Function_Module,
     CTSI_Funding_Bucket_RFA,
     Primary_CTSI_Funding_Bucket,
     ASSIST_Primary_Category,
     Employee_Type,
     CAS_Required,
     PS_Sal_Plan,
     ASSIST_Secondary,
     Line_Item_Detail,
     Last_Name,
     UFID,
     Program_Dept_ID,
     Home_Dept_ID,
     CTSI_Role,
     NOA_SK,
     Biosketch,
     eRA_Username,
     Base_Salary,
     NIH_Cap,
     Base_Increase,
     New_Base_CAP,
     Effort_Total_All_Effort_CTSI,
     Cal_Mo,
     Salary_Request,
     Fringe,
     Fringe_Request,
     Total_Request,
     Cap_Request_Salary,
     Cap_Request_Fringe,
     Cap_Request,
     NIH_EFFORT,
     NIH_CAL_MO,
     NIH_Salary,
     NIH_Fringe,
     Checksum,
     NIH_Sal_and_Fringe,
     Expense_Type,
     Narrative_,
     Commons,
     NIH_TOTAL,
     NIH_PIl_UNLIQ,
     NIH_Admin_Supplement,
     COM,
     COM_Billable,
     HSC,
     OOR,
     OoR_Old,
     Norton_Commitment,
     ROH,
     DSR_ROH,
     Unfunded,
     AUX,
     FTE_Cost_Recovery,
     Program_Funded_Total,
     OTC_Dept_Paid,
     Adtl_Support_Request,
     MD_PhD_NIH,
     MD_PhD_State,
     COM_OTC_211,
     F30_Grants,
     MD_Phd_COM,
     MD_Phd_Endowment,
     COM_Carry_Forward,
     INST_KL_TL,
     SECIM_NIH_Grant_and_carryforward,
     SECIM_ROH_and_DSR_Match,
     SECIM_Aux,
     CERHB_State,
     CERHB_DOCE,
     CTSI_NIH_OCR,
     State_OCR,
     State_OCR_RAC,
     COM_OCR,
     OoR_OCR,
     Cancer_OCR_171,
     OoR_Pilots_Carryforward,
     Norton_cGMP,
     Nelson_cGMP,
     Cancer_cGMP,
     Total_Line_Item,
     Check_Sum_2,
     Email,
     Notes,
     Updated_Jan_2021
);


#############################################################################
#############################################################################
## VERIFY LOADED TABLE
Select 	BudgetSFY,
		SUM(Total_Line_Item) as Amount
 FROM finance.Budget2020_2022
 GROUP BY BudgetSFY
		;

select distinct email from finance.Budget2020_2022;  ## Check Field Alignment
*/
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################
#############################################################################

## CREATE WORK TABLE
drop table if exists finance.workBudget;
create table finance.workBudget AS 
select * from finance.Budget2020_2022;



#############################################################################
#############################################################################
### ADD AND POPULATE REPORT COLLEGE BASED ON HOME DEPARTMENT
### ADD RECORD MANAGEMENT VARIABLE (RecordType)

ALTER TABLE finance.workBudget
ADD REPORT_COLLEGE varchar(255),
ADD RecordType varchar(45);

SET SQL_SAFE_UPDATES = 0;

## Initialize
UPDATE 	finance.workBudget fb SET RecordType="Orginal"; 
UPDATE 	finance.workBudget fb SET REPORT_COLLEGE="UNDEFINED"; 



## Assign Report College base on Home Dept ID
UPDATE 	finance.workBudget fb,
		lookup.deptlookup lu
SET fb.REPORT_COLLEGE=lu.College
WHERE fb.Home_Dept_ID=lu.DEPTID;

### Update report College for Home Dept ID not Found in lookup.deptlookup.
UPDATE finance.workBudget
SET REPORT_COLLEGE="COLLEGE-MEDICINE"
WHERE Home_Dept_ID IN 
	('29680247',
	 '29680304',
	 '24240701',
	 '29680214');


DELETE from finance.workBudget WHERE Total_Line_Item=0;

### OMIT EAC Members
UPDATE finance.workBudget SET 	RecordType="OMIT - EAC Member"
WHERE Primary_CTSI_Funding_Bucket='Govern - EAC' ;

### Assign Report College for FSU
UPDATE finance.workBudget
SET REPORT_COLLEGE="FSU"
WHERE Home_Dept_ID = 'FSU';

### Standardize TBD TBA
UPDATE finance.workBudget
SET Home_Dept_ID="TBD"
WHERE Home_Dept_ID = 'TBA';

#### BASED ON MANUAL UPDATE 1 FROM MATT
UPDATE 	finance.workBudget fb,
		finance.hsc21_lookup1 lu
SET fb.REPORT_COLLEGE=lu.Report_College
WHERE   fb.RFA_COMPONENT=lu.RFA_COMPONENT
        AND fb.RFA_Function_Module=lu.RFA_Function_Module
        AND fb.CTSI_Funding_Bucket_RFA=lu.CTSI_Funding_Bucket_RFA
        AND fb.Primary_CTSI_Funding_Bucket=lu.Primary_CTSI_Funding_Bucket
        AND fb.Line_Item_Detail=lu.Line_Item_Detail
        AND fb.REPORT_COLLEGE ="UNDEFINED";

## SET VOUCHERs TO UNDEFINED FOR DEPARTMENT ALLOCATION
UPDATE finance.workBudget 
		SET REPORT_COLLEGE="UNDEFINED" ,
            RecordType="Omit - Replaced with Voucher Detail"
        WHERE CTSI_Funding_Bucket_RFA="Vouchers";    
## SET PILOTS TO UNDEFINED FOR DEPARTMENT ALLOCATION 
Update finance.workBudget SET RecordType="Omit - Replaced with Pilot Detail"
where RFA_COMPONENT='X. Existing Pilots'
;

## SET KL2 and TL1 records to Omit to replace with DETAIL Records 
UPDATE finance.workBudget
SET RecordType='Omit - Replaced with KL2 TL1 Detail'
WHERE RFA_COMPONENT IN ('I. Inst Carreer Dev Core','J. NRSA (TL)')
;
 
      
## ADD VOUCHER, PILOT, and KLTL DETAIL RECORDS

drop table if exists work.tempBudget;
Create table work.tempBudget as
SELECT * from finance.workBudget 
UNION ALL
SELECT * from finance.Vouchers_2020_2022
UNION ALL 
SELECT * from finance.PIlots_2020_2022
UNION ALL
SELECT * from finance.KLTL_2020_2022 ;


/*
SELECT  BudgetSFY,  RecordType, SUM(Total_Line_Item) AS Amount
from  work.tempBudget  
GROUP BY BudgetSFY,  RecordType; 
*/       

DROP TABLE IF EXISTS finance.workBudget;
Create table finance.workBudget as
SELECT * from work.tempBudget ;


select distinct REPORT_COLLEGE from finance.workBudget;  

## CLEAN UP REPORT COLLEGE NAMES
UPDATE finance.workBudget SET Report_College='Trustees' WHERE Report_College='BOARD OF TRUSTEES';
UPDATE finance.workBudget SET Report_College='Agriculture & Natural Resources' WHERE Report_College='COLLEGE- AGRICUL / NAT RES';
UPDATE finance.workBudget SET Report_College='Dentistry' WHERE Report_College='COLLEGE-DENTISTRY';
UPDATE finance.workBudget SET Report_College='Engineering' WHERE Report_College='COLLEGE-ENGINEERING';
UPDATE finance.workBudget SET Report_College='Journalism & Communications' WHERE Report_College='COLLEGE-JOURNALISM / COMMUNICA';
UPDATE finance.workBudget SET Report_College='Liberal Arts And Sciences' WHERE Report_College='COLLEGE-LIBERAL ARTS/SCIENCES';
UPDATE finance.workBudget SET Report_College='Medicine' WHERE Report_College='COLLEGE-MEDICINE';
UPDATE finance.workBudget SET Report_College='Medicine - Jacksonville' WHERE Report_College IN ('COLLEGE-MEDICINE JACKSONVILLE','Medicine Jacksonville');
UPDATE finance.workBudget SET Report_College='Nursing' WHERE Report_College='COLLEGE-NURSING';
UPDATE finance.workBudget SET Report_College='Pharmacy' WHERE Report_College='COLLEGE-PHARMACY';
UPDATE finance.workBudget SET Report_College='Public Health & Health Professions' WHERE Report_College IN ('COLLEGE-PUBL HLTH / HLTH PROFS','Public Health and Health Professions','PHHP');
UPDATE finance.workBudget SET Report_College='Veterinary Medicine' WHERE Report_College='COLLEGE-VETERINARY MED';
UPDATE finance.workBudget SET Report_College='FSU' WHERE Report_College='FSU';
UPDATE finance.workBudget SET Report_College='Health Affairs' WHERE Report_College='OFFICE OF HEALTH AFFAIRS';
UPDATE finance.workBudget SET Report_College='OMIT' WHERE Report_College='OMIT';
UPDATE finance.workBudget SET Report_College='PHHP-COM' WHERE Report_College='PHHP-COM INTEGRATED PROGRAMS';
UPDATE finance.workBudget SET Report_College='Type One Centers' WHERE Report_College='TYPE ONE CENTERS';
UPDATE finance.workBudget SET Report_College='Office of Research' WHERE Report_College='UF RESEARCH';
UPDATE finance.workBudget SET Report_College='Undefined' WHERE Report_College='UNDEFINED';
UPDATE finance.workBudget SET Report_College='Libraries' WHERE Report_College='UNIVERSITY LIBRARIES';
UPDATE finance.workBudget SET Report_College='Health & Human Performance' WHERE Report_College in ('COLLEGE-HLTH/HUMAN PERFORMANCE','Health and Human Performance');
UPDATE finance.workBudget SET Report_College='Business Administration' WHERE Report_College='COLLEGE-BUSINESS ADMINSTRATION';
UPDATE finance.workBudget SET Report_College='Design & Construction' WHERE Report_College='COLLEGE-DESIGN CONSTRUC / PLAN';
UPDATE finance.workBudget SET Report_College='Medicine - Jacksonville' WHERE Report_College='Trustees' AND CTSI_Funding_Bucket_RFA='Jax Res';
UPDATE finance.workBudget SET Report_College='Medicine' WHERE Report_College='Trustees' AND Email='handbem@medicine.ufl.edu';
UPDATE finance.workBudget SET Report_College='PHHP-COM' WHERE Report_College='Trustees' AND Primary_CTSI_Funding_Bucket='UF Data Coordinating Center';
select REPORT_COLLEGE,count(*) as N from finance.workBudget WHERE RecordType NOT LIKE "OMIT%" group by REPORT_COLLEGE ORDER BY REPORT_COLLEGE;  
Update finance.workBudget SET Report_College='Public Health & Health Professions' WHERE RFA_COMPONENT ='B. Informatics' AND Line_Item_Detail='TBA Data Management Analyst';
Update finance.workBudget SET Report_College='Medicine' WHERE RFA_COMPONENT ='G. Network Capacity' AND CTSI_Funding_Bucket_RFA='Recruitment Center' AND Line_Item_Detail IN ('TBA Coordinator','TBA Coordinator flood');
#############################################################################
#############################################################################
############# SUMMARY BY REPORT COLLEGE AND SFY

drop table if exists finance.SumSFYCollege;
create table finance.SumSFYCollege AS
Select 	BudgetSFY,
		REPORT_COLLEGE,
        SUM(Total_Line_Item) as Amount
 FROM finance.workBudget
 WHERE RecordType NOT LIKE "OMIT%"
 GROUP BY 	BudgetSFY,
			REPORT_COLLEGE
		;
        
drop table if exists finance.SummaryCollege;
create table finance.SummaryCollege AS        
SELECT DISTINCT REPORT_COLLEGE
FROM  finance.SumSFYCollege;       

ALTER TABLE  finance.SummaryCollege
ADD SFY2021 decimal(65,10),
ADD SFY2122 decimal(65,10);


UPDATE finance.SummaryCollege
SET SFY2021=0,
	SFY2122=0;
    
UPDATE finance.SummaryCollege sc, finance.SumSFYCollege lu
SET sc.SFY2021=lu.Amount
WHERE lu.BudgetSFY='SFY 2020-2021'
AND sc.REPORT_COLLEGE=lu.REPORT_COLLEGE;

UPDATE finance.SummaryCollege sc, finance.SumSFYCollege lu
SET sc.SFY2122=lu.Amount
WHERE lu.BudgetSFY='SFY 2021-2022'
AND sc.REPORT_COLLEGE=lu.REPORT_COLLEGE;

select * from finance.SummaryCollege;
##########################################################################
##########################################################################
## DETAIL

drop table if exists finance.HSCdetail;
create table finance.HSCdetail AS
SELECT *
FROM finance.workBudget
##WHERE RecordType NOT LIKE "OMIT%"
ORDER BY BudgetSFY,RFA_COMPONENT,REPORT_COLLEGE;


SELECT BudgetSFY,RecordType,sum(Total_Line_Item) as Amount
FROM finance.workBudget
group by BudgetSFY,RecordType;

##########################################################################
##########################################################################
##########################################################################
##########################################################################
##########################################################################
/*
drop table if exists finance.kltl_loader;
create table finance.kltl_loader as
Select * from finance.workBudget
WHERE RecordType='Omit - Replaced with KL2 TL1 Detail';


SELECT BudgetSFY,RFA_COMPONENT,REPORT_COLLEGE,SUM(Total_Line_Item) as Amount from finance.workBudget
WHERE RFA_COMPONENT IN
('I. Inst Carreer Dev Core','J. NRSA (TL)')
GROUP BY BudgetSFY,RFA_COMPONENT,REPORT_COLLEGE;

*/

select distinct RecordType from finance.workBudget;
select distinct REPORT_COLLEGE from finance.workBudget;

#############################################################################



/*
select * from finance.workBudget where REPORT_COLLEGE in ('Office of Research') and RecordType NOT LIKE "OMIT%";


SELECT DEPTID,Department,College 
from lookup.deptlookup 
WHERE DEPTID in
(SELECT DISTINCT Program_Dept_ID from finance.workBudget where REPORT_COLLEGE in ('Office of Research') and RecordType NOT LIKE "OMIT%")
GROUP BY DEPTID,Department,College ;
*/

/*   ####VERIFY APPEND
SELECT  BudgetSFY,  RecordType, SUM(Total_Line_Item) AS Amount
from  work.tempBudget  
GROUP BY BudgetSFY,  RecordType; 

        

#### Update finance.workBudget SET Report_College="Undefined" where recid in (203,502,906,1198);
*/
#############################################################################
#############################################################################
## DIAGNOSTICS

drop table if exists finance.tempout2;
create table finance.tempout2 as
select * from finance.workBudget 
where  REPORT_COLLEGE IN("UNDEFINED","OMIT")
and RecordType not like "OMIT%";  


Select BudgetSFY, SUM(Total_Line_Item) as Total
from finance.workBudget where  REPORT_COLLEGE IN("UNDEFINED","OMIT")
and RecordType not like "OMIT%"
GROUP BY  BudgetSFY ;



SELECT Home_Dept_ID, REPORT_COLLEGE, count(*) as N
from finance.workBudget
WHERE REPORT_COLLEGE="UNDEFINED"
AND RecordType NOT LIKE 'OMIT%'
group by Home_Dept_ID, REPORT_COLLEGE
;        

Select * from finance.workBudget
WHERE REPORT_COLLEGE="UNDEFINED"
AND RecordType NOT LIKE 'OMIT%';

SELECT REPORT_COLLEGE,count(*) as nRECs
from finance.workBudget
WHERE RecordType NOT LIKE 'OMIT%'
GROUP BY  REPORT_COLLEGE;





#############################################################################
#############################################################################
### UNDEFINED REPORT COLLEGE SUMMARY

drop table if exists finance.tempout;
create table finance.tempout AS 
SELECT  RFA_COMPONENT,
		RFA_Function_Module,
        CTSI_Funding_Bucket_RFA,
		Primary_CTSI_Funding_Bucket, 
        Line_Item_Detail,
        ASSIST_Primary_Category,
        ASSIST_Secondary,
        REPORT_COLLEGE,
        count(*) nRECs,
        SUM(Total_Line_Item) as Amount
from finance.workBudget
WHERE REPORT_COLLEGE="UNDEFINED" AND RecordType NOT LIKE "OMIT%"
group by RFA_COMPONENT,
		RFA_Function_Module,
        CTSI_Funding_Bucket_RFA,
		Primary_CTSI_Funding_Bucket, 
        Line_Item_Detail,
        ASSIST_Primary_Category,
        ASSIST_Secondary,
        REPORT_COLLEGE;
##############################################################################
##############################################################################
### UNDEFINED REPORT COLLEGE Detail

DROP TABLE IF EXISTS finance.tempout2;
create table finance.tempout2 AS
SELECT *
from finance.workBudget
WHERE RecordType NOT LIKE 'OMIT%'
AND REPORT_COLLEGE="UNDEFINED" ;

SELECT DISTINCT Report_College from finance.workBudget
WHERE RecordType NOT LIKE "OMIT%";

#############################################################################
#############################################################################





#############################################################################
## VERIFY 
Select 	BudgetSFY,
		SUM(Total_Line_Item) as Amount
 FROM finance.workBudget
 GROUP BY BudgetSFY;	
 
 SELECT SUM(SFY2021) AS SFY2021, 
		SUM(SFY2122) AS SFY2122 
 FROM  finance.SummaryCollege;      

#### OK!
SFY 2020-2021	30825949.6300000000
SFY 2021-2022	30836729.0100000000

30825949.6300000000	30836729.0100000000

SELECT * from finance.workBudget where Line_Item_Detail like "Fillingim%";

select * from finance.workBudget   Where CTSI_Funding_Bucket_RFA="Vouchers";

UPDATE finance.workBudget SET REPORT_COLLEGE="UNDEFINED" WHERE CTSI_Funding_Bucket_RFA="Vouchers";

select * from finance.workBudget where REPORT_COLLEGE="OMIT";




/* Correct records 
UPDATE finance.workBudget
SET Total_Request=Total_Line_Item
WHERE Line_Item_Detail like 'Voucher%';
*/

Create table finance.Vouchers_2020_2022 AS
SELECT * from finance.workBudget
WHERE RecordType='Detail Voucher Record';

create table finance.pilotsnew AS
select * from pilots.PILOTS_MASTER
WHERE AwardLetterDate>=str_to_date('07,01,2019','%m,%d,%Y');

select max(recid)+1  from finance.workBudget;
/*
Create table finance.PIlots_2020_2022 AS
SELECT * from finance.workBudget
WHERE RecordType='Detailed Pilot Award Record';

delete from finance.workBudget
WHERE RecordType='Detailed Pilot Award Record';
*/

select max(recid)+1 from finance.workBudget;


Create table finance.KLTL_2020_2022 AS
SELECT * from finance.workBudget
WHERE RecordType IN ('Detail KL Record','Detail TL Record');



#########################

select  * from finance.workBudget
WHERE RecordType='Detailed Pilot Award Record';

DROP TABLE IF EXISTS finance.tempout;
Create table finance.tempout AS
SELECT Name,Employee_ID,Department_Code,Department,EMAIL,Job_Code,FTE 
from lookup.Employees 
WHERE Employee_ID
in  (
      '71115326',
      '71115326',
      '49944451',
      '49944451',
      '39669980',
      '72577910',
      '98191998',
      '73489561',
      '95662175',
      '95662175',
      '47965609',
      '70361985',
      '97961359',
      '03696810',
      '03696810',
      '60129563',
      '99183498',
      '99183498',
      '62932149',
      '62932149',
      '93733852',
      '83309336',
      '49381334',
      '83964657',
      '51155969',
      '51155969',
      '11043911',
      '88018150',
      '70330304',
      '70330304',
      '19186141',
      '64966975',
      '64966975',
      '90416992',
      '90416992'
);
select distinct Report Co