#################################################################################################################
#################################################################################################################
######## PILOT AWARDS

SELECT "TransWORK" as Source,count(*) as N, Sum(Posted_Amount) as Amt from finance.transWORK WHERE TypeFlag IN (  "TransPilots","Pilots","NIHPilots")
UNION ALL
SELECT "Pilots" as Source,count(*) as N, Sum(Award_Amt) as Amt from pilots.PILOTS_MASTER WHERE AwardLetterDate>=str_to_date('07,01,2019','%m,%d,%Y') AND Awarded="Awarded";

SELECT * from pilots.PILOTS_MASTER WHERE AwardLetterDate>=str_to_date('07,01,2019','%m,%d,%Y') AND Awarded="Awarded";

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



select * from finance.AssignPilots;
select count(*) from finance.AssignPilots where College IS Null;  #1461
select count(*) from finance.AssignPilots where College IS NOT Null; #2612


CREATE INDEX Tw1 ON finance.transWORK (combined_hist_rept_id);
SELECT ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege,TypeFlag ;

UPDATE finance.transWORK tw, finance.AssignPilots lu
SET tw.DeptName=lu.DeptName,
	tw.College=lu.College,
    tw.CollAbbr=lu.CollAbbr,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.combined_hist_rept_id=lu.combined_hist_rept_id
AND tw.ReportCollege IS NULL 
AND lu.ReportCollege IS NOT NULL;    

drop table if exists finance.temp;
create table finance.temp as 
SELECT Alt_Dept_ID,Account_Code,DeptName,ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK 
WHERE ReportCollege NOT LIKE "OMIT%"
GROUP BY  Alt_Dept_ID,Account_Code,DeptName,ReportCollege,TypeFlag;


drop table if exists finance.temp2;
create table finance.temp2 as 
SELECT Alt_Dept_ID,Account_Code,DeptName,ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK 
WHERE ReportCollege IS NULL
GROUP BY  Alt_Dept_ID,Account_Code,DeptName,ReportCollege,TypeFlag;

#### WHEN PILOTS ARE IDed by ProjectID Need to Update transwork
###############################################################################################################################
###############################################################################################################################
###############################################################################################################################
###############################################################################################################################
###############################################################################################################################

#################################################################################################################
### Create Colums Subset of TransWORK

                ;	

#################################################################################################################
#################################################################################################################
## VOCUHERS
drop table if exists finance.transvouch;
create table finance.transvouch as
SELECT combined_hist_rept_id,SFY,Journal_Date,Doc_Desc,Doc_Detail,Encumbrance_Description,Journal_ID,Posted_Amount
FROM finance.transWORK WHERE TypeFlag="Voucher";

select ( 

SELECT count(*) as n, SUM(Posted_Amount) as Total from finance.transvouch;
#	n	Total
#	62	32921.00

SELECT  count(*) as n, SUM(Amount_Issued) AS Issued,sum(Amount_Billed) as Billed, SUm(Actual_Award) Award
FROM finance.voucher2
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y');



DROP TABLE IF EXISTS finance.VoucherSFY20_21 ;
Create table finance.VoucherSFY20_21 
AS SELECT * from finance.VoucherFY2020on 
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y') 
  AND Date_Issued<=str_to_date('06,30,2021','%m,%d,%Y') ;
  

UPDATE finance.VoucherSFY20_21 SET AMOUNT=0;
  
UPDATE finance.VoucherSFY20_21 vm, finance.voucher2 lu
SET vm.Amount=lu.Actual_Award
WHERE vm.VoucherID=lu.VocuherID;


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
#################################################################################################################


#################################################################################################################
#################################################################################################################


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



