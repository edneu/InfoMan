####HSCFunding


## Hsc Map is the mapping of Deptid to Reporting Colleges.
select * from finance.hsc_map;
DESC finance.hsc_map;

DROP TABLE IF EXISTS finance.transWORK;
Create table finance.transWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);




Alter Table finance.transWORK
	ADD DeptName	varchar(45),
	ADD CollAbbr	varchar(12),
	ADD College	varchar(45),
	ADD ReportCollege	varchar(45),
    ADD TypeFlag varchar(12);
    





SET SQL_SAFE_UPDATES = 0;

    
UPDATE finance.transWORK tw, finance.hsc_map lu
SET tw.DeptName=lu.DeptName,
	tw.CollAbbr=lu.CollAbbr,
	tw.College=lu.College,
	tw.ReportCollege=lu.ReportCollege
WHERE tw.Alt_Dept_ID=lu.DeptID; 

UPDATE finance.transWORK tw SET TypeFlag="Transaction";
 


UPDATE  finance.transWORK SET TypeFlag="Voucher" WHERE Alt_Dept_ID="29680704";  ### VOUCHER will be Substituted
UPDATE  finance.transWORK SET TypeFlag="GAP" WHERE Alt_Dept_ID="29680705";  ### GAP CAN REMAIN ASSISGN TO pediatirc Medicine
UPDATE  finance.transWORK SET TypeFlag="TransPilots" WHERE Alt_Dept_ID="29680703"; ## CAN REMAIN ASSIGN TO PROJECT PI
UPDATE  finance.transWORK SET TypeFlag="Pilots"  WHERE Alt_Dept_ID IN ('29680701','29680702','296800506');
UPDATE  finance.transWORK SET TypeFlag="NIHPilots"  WHERE Alt_Dept_ID IN ('29680520');

## GAP  DONE

SELECT * from finance.transWORK where TypeFlag="GAP";
####select * from lookup.active_emp where NAME like "%schatz%";
####29090100	MD-PEDS-ADMINISTRATION

UPDATE finance.transWORK
 SET DeptName="MD-PEDS-ADMINISTRATION",
     CollAbbr="MD",
     College="Medicine",
     ReportCollege="Medicine"
where TypeFlag="GAP"; 
#################################################################################################################


#################################################################################################################
### Create Colums Subset of TransWOEK
DROP table if exists finance.TransSHC;
create table finance.TransSHC AS
SELECT 
combined_hist_rept_id,
TypeFlag,
Alt_Dept_ID,
CTSI_Fiscal_Year,
TransMonth,
SFY,
Journal_Date,
Transaction_Detail,
Project_Code,
Doc_Desc,
Doc_Detail,
DeptName,
CollAbbr,
College,
ReportCollege
FROM finance.transWORK
order BY ReportCollege,TypeFlag;


SELECT  SFY,TypeFlag,COUNT(*) FROM finance.TransSHC where ReportCollege is null GROUP BY SFY,TypeFlag;

select Alt_Dept_ID, COUNT(*) AS n FROM finance.TransSHC where ReportCollege is null and TypeFlag='Transaction' GROUP BY Alt_Dept_ID ;

select * 
FROM finance.transWORK
where Alt_Dept_ID IN (select DISTINCT Alt_Dept_ID 
				FROM finance.TransSHC 
                where ReportCollege is null 
                and TypeFlag='Transaction');	


#################################################################################################################
## VOCUHERS
drop table if exists finance.transvouch;
create table finance.transvouch as
SELECT combined_hist_rept_id,SFY,Journal_Date,Doc_Desc,Doc_Detail,Encumbrance_Description,Journal_ID,Posted_Amount
FROM finance.transWORK WHERE TypeFlag="Voucher";

SELECT count(*) as n, SUM(Posted_Amount) as Total from finance.transvouch;
#	n	Total
#	62	32921.00

SELECT  count(*) as n, SUM(Amount_Issued) AS Issued,sum(Amount_Billed) as Billed, SUm(Actual_Award) Award
FROM finance.voucher2
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y')
# n, Issued, Billed, Award
'181', '139340.00', '78906.50', '137665.00'



Create table finance.VoucherSFY20_21 
AS SELECT * from finance.VoucherFY2020on 
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y') 
  AND Date_Issued<=str_to_date('06,30,2021','%m,%d,%Y') ;


############# CLEAN UP
select Department,College from finance.VoucherSFY20_21 group by Department,College;
### FIX MISSING COLLEGES
UPDATE finance.VoucherSFY20_21 SET College='COLLEGE-JOURNALISM / COMMUNICA' WHERE Department='CJC-STEM TRANSLATIONAL COMMN';
UPDATE finance.VoucherSFY20_21 SET College='COLLEGE-MEDICINE' WHERE Department='MD-ANEST-ACUTE PAIN SERVICE';
UPDATE finance.VoucherSFY20_21 SET College='COLLEGE-MEDICINE' WHERE Department='MD-NEURO-NEUROCRITICAL CARE';
UPDATE finance.VoucherSFY20_21 SET College='COLLEGE-MEDICINE' WHERE Department='MD-SURGERY-THORACIC';
UPDATE finance.VoucherSFY20_21 SET College='COLLEGE-PHARMACY' WHERE Department='PH-CURRICULARAFF&ACCREDITATION';

select Distinct College from finance.VoucherSFY20_21;

select College, ReportCollege from lookup.deptid_budget group by College, ReportCollege;

ALTER TABLE finance.VoucherSFY20_21 ADD ReportCollege varchar(45);

UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine' WHERE College='COLLEGE-MEDICINE';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Public Health and Health Professions' WHERE College='PHHP-COM INTEGRATED PROGRAMS';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Unknown' WHERE College='Student';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Unknown' WHERE College='OFFICE OF STUDENT AFFAIRS';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Pharmacy' WHERE College='COLLEGE-PHARMACY';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Unknown' WHERE College='DSO-DIRECT SUPPORT ORG';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Dentistry' WHERE College='COLLEGE-DENTISTRY';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Engineering' WHERE College='COLLEGE-ENGINEERING';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Health and Human Performance' WHERE College='COLLEGE-HLTH/HUMAN PERFORMANCE';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Journalism and Communications' WHERE College='COLLEGE-JOURNALISM / COMMUNICA';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Public Health and Health Professions' WHERE College='COLLEGE-PUBL HLTH / HLTH PROFS';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Liberal Arts and Sciences' WHERE College='COLLEGE-LIBERAL ARTS/SCIENCES';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Unknown' WHERE College='Unknown';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Veterinary Medicine' WHERE College='COLLEGE-VETERINARY MED';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Unknown' WHERE College='GRADUATE SCHOOL';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine Jacksonville' WHERE College='COLLEGE-MEDICINE JACKSONVILLE';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Agricultural And Life Sciences' WHERE College='COLLEGE- AGRICUL / NAT RES';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Nursing' WHERE College='COLLEGE-NURSING';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Fine Arts' WHERE College='COLLEGE-FINE ARTS';
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Business Administration' WHERE College='COLLEGE-BUSINESS ADMINSTRATION';


SELECT * from finance.VoucherSFY20_21 WHERE ReportCollege="Unknown" or ReportCollege IS NULL;
## Manually Curated 
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine Jacksonville' WHERE OrigSeq =47;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine' WHERE OrigSeq =153;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Agricultural And Life Sciences'  WHERE OrigSeq =265;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Liberal Arts and Sciences'  WHERE OrigSeq =40;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Pharmacy'  WHERE OrigSeq =115;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine' WHERE OrigSeq =138;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Medicine' WHERE OrigSeq =139;
UPDATE finance.VoucherSFY20_21 SET ReportCollege='Nursing' WHERE OrigSeq =281;


ALTER TABLE finance.VoucherSFY20_21
ADD Amount_Billed decimal(12,2),
ADD Actual_Award decimal(12,2),
ADD Amount_Issued decimal(12,2);

UPDATE finance.VoucherSFY20_21 fv, finance.voucher2 lu
SET fv.Amount_Billed  =lu.Amount_Billed ,
	fv.Actual_Award  =lu.Actual_Award ,
	fv.Amount_Issued  =lu.Amount_Issued 
WHERE fv.VoucherID=lu.VocuherID;    


select AMOUNT,Amount_Billed,Actual_Award,Amount_Issued from finance.VoucherSFY20_21;

select count(*) ,sum(AMOUNT),Sum(Amount_Billed),sum(Actual_Award),sum(Amount_Issued) from finance.VoucherSFY20_21;


#################################################################################################################
## GAP  DONE

SELECT * from finance.transWORK where TypeFlag="GAP";
####select * from lookup.active_emp where NAME like "%schatz%";
####29090100	MD-PEDS-ADMINISTRATION

UPDATE finance.transWORK
 SET DeptName="MD-PEDS-ADMINISTRATION",
     CollAbbr="MD",
     College="Medicine",
     ReportCollege="Medicine"
where TypeFlag="GAP"; 
#################################################################################################################


#################################################################################################################
#################################################################################################################
#################################################################################################################
#################################################################################################################
######## PILOT AWARDS
DROP TABLE IF Exists finance.AssignPilots;
Create table finance.AssignPilots As
SELECT combined_hist_rept_id,Project_Code from finance.transWORK WHERE TypeFlag IN (  "TransPilots","Pilots","NIHPilots");

ALTER TABLE finance.AssignPilots
	ADD DEPT_ID varchar(12),
    ADD DeptName	varchar(45),
	ADD CollAbbr	varchar(12),
	ADD College	varchar(45),
	ADD ReportCollege	varchar(45);


DROP TABLE IF EXISTS finance.LUPilots;
CREATE TABLE finance.LUPilots AS
SELECT
	PROJECT_ID,
    UFID,
	PI_DEPTID AS Dept_ID,
	PI_DEPTNM As DeptName,
	"   " as CollAbbr,
	College as College
FROM pilots.PILOTS_MASTER
WHERE PROJECT_ID IN (SELECT DISTINCT Project_Code from finance.AssignPilots)
;

UPDATE finance.LUPilots lp, lookup.depts lu
SET lp.DeptName=lu.DeptName
WHERE lp.Dept_ID=lu.DeptID
AND lp.DeptName ='';




UPDATE finance.AssignPilots ap, finance.LUPilots lu
SET  ap.DEPT_ID=lu.DEPT_ID,
     ap.DeptName=lu.DeptName,
	 ap.CollAbbr=lu.CollAbbr,
	 ap.College=lu.College,
	 ap.ReportCollege=lu.College
WHERE ap.PROJECT_CODE=lu.PROJECT_ID;


UPDATE finance.AssignPilots SET CollAbbr='MD' WHERE College='Medicine';
UPDATE finance.AssignPilots SET CollAbbr='PH' WHERE College='Pharmacy';
UPDATE finance.AssignPilots SET CollAbbr='VM' WHERE College='Veterinary Medicine';
UPDATE finance.AssignPilots SET CollAbbr='VM' WHERE College='Veterinary Medicine';
UPDATE finance.AssignPilots SET CollAbbr='EG' WHERE College='Engineering';
UPDATE finance.AssignPilots SET CollAbbr='HHP' WHERE College='Health and Human Performance';
UPDATE finance.AssignPilots SET CollAbbr='PHHP' WHERE College='Public Health and Health Professions';
UPDATE finance.AssignPilots SET CollAbbr='DN' WHERE College='Dentistry';
UPDATE finance.AssignPilots SET CollAbbr='LS' WHERE College='Liberal Arts and Sciences';
UPDATE finance.AssignPilots SET CollAbbr='CJC' WHERE College='Journalism and Communications';



select* from finance.AssignPilots;
select count(*) from finance.AssignPilots where College IS Null;  #1461
select count(*) from finance.AssignPilots where College IS NOT Null; #2612



#### WHEN PILOTS ARE IDed by ProjectID Need to Update transwork
###############################################################################################################################
## BAD PILOTS
drop table if exists finance.BADPilottrans;
create table finance.BADPilottrans As
SELECT * from finance.transWORK WHERE Project_Code IN
('P0081623',
'P0101482',
'P0081624',
'00126398',
'P0037027',
'P0189304',
'P0134284',
'P0134294',
'P0013701',
'P0134524',
'P0150080',
'P0181206',
'P0118957',
'P0072753',
'P0129403',
'P0167639',
'P0167633',
'P0088971',
'P0098260',
'P0080885',
'P0078514',
'P0081335',
'P0078516',
'P0081771',
'P0132702',
'P0087381',
'P0102947',
'P0177868',
'P0152023',
'P0101454',
'P0153131',
'P0101480',
'P0080099',
'P0099918',
'P0101504',
'P0080098',
'P0104262',
'P0109553')
AND TypeFlag IN (  "TransPilots","Pilots","NIHPilots");







###############################################################
########### IDENTIFY UnMapped DeptIDs

drop table if exists finance.NotinMap;
Create table finance.NotinMap as
SELECT Distinct Alt_Dept_ID,DeptID, COunt(*) as nTrans
from  finance.transWORK 
WHERE DeptID NOT IN (SELECT DISTINCT DeptID From finance.hsc_map)
GROUP BY Alt_Dept_ID,DeptID;

Alter table finance.NotinMap
ADD DeptName varchar(45),
ADD College varchar(45),
ADD Display_College varchar(45);

UPDATE finance.NotinMap nim, lookup.dept_coll lu
SET nim.DeptName=lu.Department,
	nim.College=lu.College,
	nim.Display_College=lu.Display_College
WHERE nim.DeptID=lu.DepartmentID;



