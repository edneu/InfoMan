####HSCFunding


## Hsc Map is the mapping of Deptid to Reporting Colleges.
##select * from finance.hsc_map;
##DESC finance.hsc_map;

## UPDATE finance.hsc_map SET ReportCollege="Review PHHP-COM" WHERE CollAbbr='PHHP-COM';
## UPDATE finance.hsc_map SET ReportCollege="Office of Research" WHERE DEPTID='11300000';

## DELETE from  finance.hsc_map where hsc_map_id IN (147,148,150,152,154);
###########################################################################################################################
###########################################################################################################################
###########################################################################################################################
###########################################################################################################################
## Assigned report Colleges to Tranaction Files for SFY 2019-2020 and SFY 2020-2021

DROP TABLE IF EXISTS finance.transWORK;
Create table finance.transWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);




Alter Table finance.transWORK
	ADD DeptName	varchar(45),
	ADD CollAbbr	varchar(12),
	ADD College	varchar(45),
	ADD ReportCollege	varchar(45),
    ADD TypeFlag varchar(25);
    

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

UPDATE  finance.transWORK SET TypeFlag="GAP" WHERE Alt_Dept_ID="29680705";  ### GAP CAN REMAIN ASSISGN TO pediatirc Medicine
UPDATE  finance.transWORK SET ReportCollege="OMIT -VoucherTrans", TypeFlag="Voucher Trans" WHERE Alt_Dept_ID="29680704";  ### VOUCHER will be Substituted
UPDATE  finance.transWORK SET ReportCollege="OMIT -TransPilots", TypeFlag="Pilot Trans" WHERE Alt_Dept_ID="29680703"; ## Pilot will be substituted
UPDATE  finance.transWORK SET ReportCollege="OMIT -Pilots", TypeFlag="Pilot Trans"  WHERE Alt_Dept_ID IN ('29680701','29680702','296800506'); ## Pilot will be substituted
UPDATE  finance.transWORK SET ReportCollege="OMIT -NIHPilots", TypeFlag="Pilot Trans"  WHERE Alt_Dept_ID IN ('29680520');  ## Pilot will be substituted

UPDATE  finance.transWORK SET TypeFlag="KL"  WHERE Alt_Dept_ID IN ('29680601');
UPDATE  finance.transWORK SET TypeFlag="KL Schoch", ReportCollege='Medicine' WHERE Alt_Dept_ID IN ('29350000');
UPDATE  finance.transWORK SET TypeFlag="KL Nichols", ReportCollege='Engineering' WHERE Alt_Dept_ID IN ('19340100');
UPDATE  finance.transWORK SET TypeFlag="KL Black", ReportCollege= 'Medicine Jacksonville' WHERE Alt_Dept_ID IN ('30290100');
UPDATE  finance.transWORK SET TypeFlag="KL Seraphin", ReportCollege='Medicine'  WHERE Alt_Dept_ID IN ('29050800');

UPDATE  finance.transWORK SET TypeFlag="KL Schoch", ReportCollege='Medicine' WHERE Project_Code IN ('P0182841');
UPDATE  finance.transWORK SET TypeFlag="KL Nichols", ReportCollege='Engineering' WHERE Project_Code IN ('P0169575');
UPDATE  finance.transWORK SET TypeFlag="KL Black", ReportCollege= 'Medicine Jacksonville' WHERE Project_Code IN ('P0169576');
UPDATE  finance.transWORK SET TypeFlag="KL Moore", ReportCollege='Medicine'  WHERE Project_Code IN ('P0182841');



UPDATE finance.transWORK SET TypeFlag="TL"  WHERE Alt_Dept_ID IN ('29680600');

## UPDATE TL1 FROM TABLE (source Matt Alday)
UPDATE finance.transWORK tw, finance.TL_ProjMap lu
SET tw.TypeFlag=lu.TypeFlag,
    tw.DeptName=lu.DeptName,
    tw.CollAbbr=lu.CollAbbr,
    tw.College=lu.ReportCollege,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.Project_Code=lu.Project_Code;

UPDATE finance.transWORK SET ReportCollege='OMIT - TL' WHERE Project_Code='00126398';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL MAIN' WHERE Project_Code='P0166321';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main' WHERE Project_Code='P0131091';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main OLD' WHERE Project_Code='P0072521';
UPDATE finance.transWORK SET ReportCollege='OMIT - COM TL Main' WHERE Project_Code='P0134522';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL CTSI Main' WHERE Project_Code='P0035601';

UPDATE finance.transWORK tw, finance.tl_depts lu
SET tw.TypeFlag=lu.TypeFlag,
    tw.DeptName=lu.DeptName,
    tw.CollAbbr=lu.CollAbbr,
    tw.College=lu.ReportCollege,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.ALt_Dept_ID=lu.ALt_Dept_ID
  AND tw.Account_Code=lu.Account_Code;





## GAP  FUNDING
UPDATE finance.transWORK
 SET DeptName="MD-PEDS-ADMINISTRATION",
     CollAbbr="MD",
     College="Medicine",
     ReportCollege="Medicine"
where TypeFlag="GAP"; 

##############################################################################################################################
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

## KL2 Pay  - Remove Records for Susbitition
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612310' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612320' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='612110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='612120' AND ReportCollege IS NULL;


###  Matts Expense Elimination  Redundant with PIvot Table

UPDATE finance.transWORK Set ReportCollege='OMIT -RevTran' WHERE  Account_Code LIKE '42%';  
UPDATE finance.transWORK Set ReportCollege='OMIT -RevTran' WHERE  Account_Code LIKE '57%'; 


####################################################################################################
## APPEND Substitute Vocuher and Pilot Records
Drop table if exists finance.temptranswork;
create table finance.temptranswork AS
SELECT * from finance.transWORK;

DROP TABLE IF EXISTS finance.transWORK;
CREATE TABLE finance.transWORK AS
 Select * from finance.temptranswork
 UNION ALL
 Select * from finance.pilotvouchersubstitute
 UNION ALL
 SELECT * from finance.KL2PaySubstitute;
####################################################################################################  

## Clean Up Names
SET SQL_SAFE_UPDATES = 0;


Update finance.transWORK SET ReportCollege='Pharmacy' WHERE ReportCollege='Pharmanct';
Update finance.transWORK SET ReportCollege='OFFICE OF STUDENT AFFAIRS' WHERE ReportCollege='Student';
Update finance.transWORK SET ReportCollege='Student Affairs' WHERE ReportCollege IN ('OFFICE OF STUDENT AFFAIRS','GRADUATE SCHOOL');
UPDATE finance.transWORK SET Grant_year="Year 1-R" WHERE Grant_YEAR="Year 4/10 Gap";

### ASSIGN MISSING DEPTID
UPDATE finance.transWORK tw, finance.fix1 lu
SET tw.DeptName=lu.DeptName,
    tw.CollAbbr=lu.CollAbbr,
    tw.College=lu.ReportCollege,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.DeptID=lu.DeptID
AND tw.ReportCollege is NULL  ;  

### FROM MATTS NOTE 1-20-2021
UPDATE finance.transWORK SET ReportCollege='HSC Library' , DeptName='' WHERE ALT_DEPT_ID='29680246' AND Project_Code='P0122563' AND  Account_Code='734260' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='HSC Library' , DeptName='' WHERE ALT_DEPT_ID='29680246' AND Project_Code='P0134283' AND  Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='HSC Library' , DeptName='' WHERE ALT_DEPT_ID='29680246' AND Project_Code='P0134283' AND  Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='HSC Library' , DeptName='' WHERE ALT_DEPT_ID='29680246' AND Project_Code='P0134283' AND  Account_Code='799900' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='711600' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='719300' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='731100' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='732100' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='734250' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='735000' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='738000' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='741300' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='742100' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='742200' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='742300' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='793100' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='794200' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='799900' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND  Account_Code='799950' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND Project_Code='P0143805' AND  Account_Code='719300' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND Project_Code='P0143805' AND  Account_Code='734250' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680301' AND Project_Code='P0143805' AND  Account_Code='742200' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='611310' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='611320' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='621110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='621120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680302' AND Project_Code='00130277' AND  Account_Code='794200' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680303' AND Project_Code='00130470' AND  Account_Code='739400' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680303' AND Project_Code='00130470' AND  Account_Code='742300' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='MD-NEUROLOGY-MOVEMENT DISORDER' WHERE ALT_DEPT_ID='29680519' AND Project_Code='P0146288' AND  Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='MD-NEUROLOGY-MOVEMENT DISORDER' WHERE ALT_DEPT_ID='29680519' AND Project_Code='P0146288' AND  Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='PHHP-COM' , DeptName='PHHP-COM EPIDEMIOLOGY' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0167641' AND  Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='MD-HOP-GENERAL' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0167641' AND  Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='PHHP-COM' , DeptName='PHHP-COM EPIDEMIOLOGY' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0167641' AND  Account_Code='612110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='MD-HOP-GENERAL' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0167641' AND  Account_Code='612120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='PHHP-COM' , DeptName='PHHP-COM EPIDEMIOLOGY' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0186960' AND  Account_Code='611110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='MD-HOP-GENERAL' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0186960' AND  Account_Code='611120' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0186960' AND  Account_Code='621110' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' , DeptName='' WHERE ALT_DEPT_ID='29680521' AND Project_Code='P0186960' AND  Account_Code='621120' AND ReportCollege IS NULL;

### MATT's REVIEW Determination 1-22-2021
UPDATE finance.transWORK SET ReportCollege='OMIT-Matt Review' WHERE Alt_Dept_ID='11300000' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Liberal Arts and Sciences' WHERE Alt_Dept_ID='16120100' AND Project_Code='00114412' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680000' AND Project_Code='-' AND Account_Code='814000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100' AND Project_Code='00082127' AND Account_Code='811005' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100' AND Project_Code='00082127' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100' AND Project_Code='00128031' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100' AND Project_Code='00129698' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100' AND Project_Code='P0035601' AND Account_Code='811005' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100GCTSA' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680110' AND Project_Code='-' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680110' AND Project_Code='-' AND Account_Code='890000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680170' AND Project_Code='00127925' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680200' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680220' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680231' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680240' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680241' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680244' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680245' AND Project_Code='00128687' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680300' AND Project_Code='-' AND Account_Code='811005' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680300' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680300' AND Project_Code='-' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680300' AND Project_Code='00128184' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680300' AND Project_Code='P0068638' AND Account_Code='811005' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680301' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680400' AND Project_Code='-' AND Account_Code='811000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680400' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680400' AND Project_Code='-' AND Account_Code='830000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680400' AND Project_Code='-' AND Account_Code='831000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680504' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='OMIT-Matt Review' WHERE Alt_Dept_ID='29680506' AND Project_Code='00129201' AND Account_Code='818000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='PHHP-COM' WHERE Alt_Dept_ID='29680508' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680512' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege='REVIEW - Matt';

### TL Aduustment Net=0
UPDATE finance.transWORK SET ReportCollege='OMIT - TL Adjustment' WHERE Alt_Dept_ID='29680600' AND Project_Code='-' AND Account_Code='799900' AND  Fund_Code='171' AND ReportCollege IS NULL;


#########################################################################################################################################################
#########################################################################################################################################################
#########################################################################################################################################################
#########################################################################################################################################################
#########################################################################################################################################################
#########################################################################################################################################################
#########################################################################################################################################################



################################################# CHECK
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege LIKE '%OMIT%' OR ReportCollege is Null GROUP BY  ReportCollege ;
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege NOT LIKE '%OMIT%' OR  ReportCollege is Null  GROUP BY  ReportCollege ;


##########################################################################################################
##########################################################################################################
##########################################################################################################
############# Report COllege Summary by SFY 

DROP TABLE IF EXISTS finance.SFYbyCOLL;
create table finance.SFYbyCOLL AS
SELECT SFY,ReportCollege,SUM(Posted_Amount) AS Amount
from finance.transWORK
WHERE ReportCollege NOT LIKE '%Omit%' OR ReportCollege IS Null
GROUP BY SFY,ReportCollege
ORDER BY SFY,ReportCollege;

DROP TABLE IF Exists finance.CollSFYSumm ;
Create table finance.CollSFYSumm AS
SELECT Distinct ReportCollege from finance.SFYbyCOLL;

Alter TABLE finance.CollSFYSumm 
ADD SFY_2019_2020 decimal(65,10),
ADD SFY_2020_2021 decimal(65,10);

UPDATE finance.CollSFYSumm cs, finance.SFYbyCOLL lu
SET cs.SFY_2019_2020=lu.Amount
WHERE lu.SFY='SFY 2019-2020'
AND cs.ReportCollege=lu.ReportCollege;


UPDATE finance.CollSFYSumm cs, finance.SFYbyCOLL lu
SET cs.SFY_2020_2021=lu.Amount
WHERE lu.SFY='SFY 2020-2021'
AND cs.ReportCollege=lu.ReportCollege;


select * from finance.CollSFYSumm;


###########################################################################################################
###########################################################################################################
### Classification Premustations

DROP TABLE IF EXISTS finance.CollAssn;
Create table finance.CollAssn AS
SELECT 	 ReportCollege,
		ALt_Dept_ID,
		Project_Code,
        Fund_Code,
        Account_Code,
        TypeFlag,
        count(*) as N,
        sum(Posted_Amount) as Total
        from finance.transWORK WHERE ReportCollege NOT LIKE "OMIT%"
GROUP BY 	ReportCollege,
			ALt_Dept_ID,
			Project_Code,
			Fund_Code,
            Account_Code,
			TypeFlag;

###########################################################################################################
###########################################################################################################
### Complete listing of Included records
DROP TABLE IF EXISTS finance.DetailAssn;
Create table finance.DetailAssn AS
SELECT 	 *
        from finance.transWORK WHERE ReportCollege NOT LIKE "OMIT%";

###########################################################################################################
### Classification Premustations fro Omitted Records

DROP TABLE IF EXISTS finance.OmitTrans;
Create table finance.OmitTrans AS
SELECT 	 ReportCollege,
		ALt_Dept_ID,
		Project_Code,
        Fund_Code,
        Account_Code,
        TypeFlag,
        count(*) as N,
        sum(Posted_Amount) as Total
        from finance.transWORK WHERE ReportCollege  LIKE "OMIT%"
GROUP BY 	ReportCollege,
			ALt_Dept_ID,
			Project_Code,
			Fund_Code,
            Account_Code,
			TypeFlag;


############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
############################################################################################################
DROP TABLE IF EXISTS finance.reportDeptid;
Create table finance.reportNullColl AS



SELECT DEPTID,Department as DeptName from lookup.deptlookup WHERE DEPTID IN 
(SELECT 	Distinct DeptiD
        from finance.transWORK
        WHERE ReportCollege IS NULL);
;  


## VERIFY ASSIGNEMNTS
DROP TABLE IF EXISTS finance.VerifyHSCAssn;
Create table finance.VerifyHSCAssn AS
SELECT 	ReportCollege,
		Alt_Dept_ID,
		Fund_Code,
        Account_Code,
        Project_Code,
        TypeFlag,
        count(*) as N,
        SUM(Posted_Amount) AS Amount
from finance.transWORK 
WHERE ReportCollege NOT LIKE '%Omit%' OR ReportCollege IS Null  
GROUP BY ReportCollege,
		 Alt_Dept_ID,
	 	 Fund_Code,
         Account_Code,
         Project_Code,
         TypeFlag
ORDER BY ReportCollege,
		 Alt_Dept_ID,
	 	 Fund_Code,
         Account_Code,
         Project_Code,
         TypeFlag;
                 
Alter table finance.VerifyHSCAssn
ADD  Department Varchar(45),
ADD  College varchar(45);
      
UPDATE finance.VerifyHSCAssn vh, lookup.deptlookup lu
SET vh.Department=lu.Department,
	vh.College=lu.College
WHERE vh.Alt_Dept_ID=lu.DEPTID;      
      
####################################################################################################

select * from finance.transWORK where ReportCollege is Null;

DESC finance.transWORK;

select max(combined_hist_rept_id)+1 from finance.transWORK;

select TransMonth,CTSI_Fiscal_Year,Grant_Year,Fiscal_Year,SFY, count(*) as N from finance.transWORK GROUP BY TransMonth,CTSI_Fiscal_Year,Grant_Year,Fiscal_Year,SFY;
/*
CREATE TABLE finance.KL2PaySubstitute
select * from finance.transWORK
Where TypeFlag="KL2 Salary Substitute";
*/
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege ;
SELECT ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege,TypeFlag ;

SELECT * from finance.transWORK WHERE ReportCollege is Null;



DROP TABLE IF EXISTS finance.reportNotClass;
Create table finance.reportNotClass AS
SELECT 	ALt_Dept_ID,
		Project_Code,
        Account_Code,
        TypeFlag,
        count(*) as N,
        sum(Posted_Amount) as Total
        from finance.transWORK WHERE ReportCollege is Null 
GROUP BY ALt_Dept_ID,
		Project_Code,
        Account_Code,
        TypeFlag;
        
####
DROP TABLE IF EXISTS finance.reportMattReview;
Create table finance.reportMattReview AS
SELECT 	*
        from finance.transWORK
        WHERE ReportCollege ='REVIEW - Matt'
;
 
DROP TABLE IF EXISTS finance.reportNoCollDetail;
Create table finance.reportNoCollDetail AS
SELECT 	*
        from finance.transWORK
        WHERE ReportCollege IS NULL;
; 
 select Distinct ReportCollege from  finance.transWORK; 
 
 
DROP TABLE IF EXISTS finance.reportMattReviewFull;
Create table finance.reportMattReviewFull AS
SELECT 	ALt_Dept_ID,
		Project_Code,
        Account_Code,
        TypeFlag,
        ReportCollege,
        count(*) as N,
        sum(Posted_Amount) as Total
        from finance.transWORK WHERE ReportCollege ='REVIEW - Matt'
GROUP BY ALt_Dept_ID,
		Project_Code,
        Account_Code,
        TypeFlag,
        ReportCollege;
         
 
       
DROP TABLE IF EXISTS finance.reportNullColl;
Create table finance.reportNullColl AS
SELECT 	*
        from finance.transWORK
        WHERE ReportCollege IS NULL;
;      






