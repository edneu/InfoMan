####HSCFunding


## Hsc Map is the mapping of Deptid to Reporting Colleges.
##select * from finance.hsc_map;
##DESC finance.hsc_map;

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
 Select * from finance.PilotVoucherSubstitute;
####################################################################################################  

################################################# CHECK
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege LIKE '%OMIT%' GROUP BY  ReportCollege ;
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege NOT LIKE '%OMIT%' GROUP BY  ReportCollege ;
SELECT ReportCollege, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege ;
SELECT ReportCollege,TypeFlag, COUNT(*) as N  from finance.transWORK GROUP BY  ReportCollege,TypeFlag ;

SELECT * from finance.transWORK WHERE TypeFlag="TL" and ReportCollege is Null;
####################################################################################################







