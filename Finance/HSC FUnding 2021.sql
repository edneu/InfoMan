####HSCFunding


## Hsc Map is the mapping of Deptid to Reporting Colleges.
select * from finance.hsc_map;
DESC finance.hsc_map;

## UPDATE finance.hsc_map SET ReportCollege="Review PHHP-COM" WHERE CollAbbr='PHHP-COM';
## UPDATE finance.hsc_map SET ReportCollege="Office of Research" WHERE DEPTID='11300000';

## DELETE from  finance.hsc_map where hsc_map_id IN (147,148,150,152,154);


DROP TABLE IF EXISTS finance.transWORK;
Create table finance.transWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);




Alter Table finance.transWORK
	ADD DeptName	varchar(45),
	ADD CollAbbr	varchar(12),
	ADD College	varchar(45),
	ADD ReportCollege	varchar(45),
    ADD TypeFlag varchar(20);
    





SET SQL_SAFE_UPDATES = 0;

    
UPDATE finance.transWORK tw, finance.hsc_map lu
SET tw.DeptName=lu.DeptName,
	tw.CollAbbr=lu.CollAbbr,
	tw.College=lu.College,
	tw.ReportCollege=lu.ReportCollege
WHERE tw.Alt_Dept_ID=lu.DeptID; 


UPDATE finance.transWORK tw SET TypeFlag="Transaction";
 
## SELECT * from finance.transWORK;
## desc finance.transWORK;

UPDATE  finance.transWORK SET TypeFlag="Voucher" WHERE Alt_Dept_ID="29680704";  ### VOUCHER will be Substituted
UPDATE  finance.transWORK SET TypeFlag="GAP" WHERE Alt_Dept_ID="29680705";  ### GAP CAN REMAIN ASSISGN TO pediatirc Medicine
UPDATE  finance.transWORK SET TypeFlag="TransPilots" WHERE Alt_Dept_ID="29680703"; ## CAN REMAIN ASSIGN TO PROJECT PI
UPDATE  finance.transWORK SET TypeFlag="Pilots"  WHERE Alt_Dept_ID IN ('29680701','29680702','296800506');
UPDATE  finance.transWORK SET TypeFlag="NIHPilots"  WHERE Alt_Dept_ID IN ('29680520');

UPDATE  finance.transWORK SET TypeFlag="KL"  WHERE Alt_Dept_ID IN ('29680601');
UPDATE  finance.transWORK SET TypeFlag="KL Schoch", ReportCollege='Medicine' WHERE Alt_Dept_ID IN ('29350000');
UPDATE  finance.transWORK SET TypeFlag="KL Nichols", ReportCollege='Engineering' WHERE Alt_Dept_ID IN ('19340100');
UPDATE  finance.transWORK SET TypeFlag="KL Black", ReportCollege= 'Medicine Jacksonville' WHERE Alt_Dept_ID IN ('30290100');
UPDATE  finance.transWORK SET TypeFlag="KL Seraphin", ReportCollege='Medicine'  WHERE Alt_Dept_ID IN ('29050800');

UPDATE finance.transWORK SET TypeFlag="TL"  WHERE Alt_Dept_ID IN ('29680600');

## UPDATE TL1 FROM TABLE (source Matt Alday)
UPDATE finance.transWORK tw, finance.TL_ProjMap lu
SET tw.TypeFlag=lu.TypeFlag,
    tw.DeptName=lu.DeptName,
    tw.CollAbbr=lu.CollAbbr,
    tw.College=lu.College,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.Project_Code=lu.Project_Code;

UPDATE finance.transWORK SET ReportCollege='OMIT - TL' WHERE Project_Code='00126398';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL MAIN' WHERE Project_Code='P0166321';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main' WHERE Project_Code='P0131091';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main OLD' WHERE Project_Code='P0072521';
UPDATE finance.transWORK SET ReportCollege='OMIT - COM TL Main' WHERE Project_Code='P0134522';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL CTSI Main' WHERE Project_Code='P0035601';


##############################################################################################################################
SELECT CollAbbr,College,ReportCollege from  finance.transWORK group by CollAbbr,College,ReportCollege;
desc finance.transWORK ;
select * from finance.transWORK where TypeFlag="TL";
SELECT Distinct Project_Code from finance.transWORK where TypeFlag="TL";

################################################################################################################################


SET SQL_SAFE_UPDATES = 0;

##Matts Exlusion List
UPDATE finance.transWORK SeT ReportCollege='OMIT -Exclude AcctCode' 
WHERE Account_Code IN
            ('411120',
            '411130',
            '411150',
            '420000',
            '430000',
            '440000',
            '440400',
            '440500',
            '441600',
            '480000',
            '480006',
            '521000',
            '541000',
            '542000',
            '571100',
            '571200',
            '571800');
            
##Matts REVIEW List            
UPDATE finance.transWORK SeT ReportCollege='REVIEW - Matt' 
WHERE Account_Code IN 
		   ('811000',
            '811005',
            '813000',
            '813101',
            '814000',
            '815000',
            '816000',
            '817000',
            '818000',
            '819000',
            '819001',
            '820800',
            '830000',
            '831000',
            '870000',
            '890000',
            '891000',
            '899999');



## update from Matt's Pivot Table
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0072753';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0072753' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0078514';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0078514' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0078516';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0078516' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0080885';
UPDATE finance.transWORK Set ReportCollege='Medicine CTSI (Home, CRC, Service Center)' WHERE Project_Code='P0080885' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='Pharmacy' WHERE Project_Code='P0081771';
UPDATE finance.transWORK Set ReportCollege='Medicine' WHERE Project_Code='P0081771' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='Medicine CTSI (Home, CRC, Service Center)' WHERE Project_Code='P0098260';
UPDATE finance.transWORK Set ReportCollege='Medicine CTSI (Home, CRC, Service Center)' WHERE Project_Code='P0098260' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='Medicine' WHERE Project_Code='P0098260' AND Account_Code='719300';
UPDATE finance.transWORK Set ReportCollege='PHHP' WHERE Project_Code='P0118957';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0118957' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='Medicine' WHERE Project_Code='P0129403';
UPDATE finance.transWORK Set ReportCollege='Medicine' WHERE Project_Code='P0129403' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0150080' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0152023' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0167633' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0167639' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0177868' AND Account_Code='420000';
UPDATE finance.transWORK Set ReportCollege='OMIT - Project' WHERE Project_Code='P0181206' AND Account_Code='420000';

## GAP  FUNDING

UPDATE finance.transWORK
 SET DeptName="MD-PEDS-ADMINISTRATION",
     CollAbbr="MD",
     College="Medicine",
     ReportCollege="Medicine"
where TypeFlag="GAP"; 


###  Matts Expense Elimination  Redundant with PIvot Table

UPDATE finance.transWORK Set ReportCollege='OMIT -RevTran' WHERE  Account_Code LIKE '42%';  
UPDATE finance.transWORK Set ReportCollege='OMIT -RevTran' WHERE  Account_Code LIKE '57%';  

################################################# CHECK
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege LIKE '%OMIT%' GROUP BY  ReportCollege ;
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege NOT LIKE '%OMIT%' GROUP BY  ReportCollege ;
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege ;
SELECT ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege,TypeFlag ;

SELECT * from finance.transWORK WHERE TypeFlag="TL" and ReportCollege is Null;



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

SELECT count(*) as n, SUM(Posted_Amount) as Total from finance.transvouch;
#	n	Total
#	62	32921.00

SELECT  count(*) as n, SUM(Amount_Issued) AS Issued,sum(Amount_Billed) as Billed, SUm(Actual_Award) Award
FROM finance.voucher2
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y')




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



