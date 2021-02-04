####HSCFunding

############# MATTMAP verify and curate
/*
DESC finance.mattmap

select * from finance.mattmap;

Alter TABLE finance.mattmap 
	ADD Department varchar(45),
	ADD College Varchar(45);

SET SQL_SAFE_UPDATES = 0;
    
UPDATE  finance.mattmap mm, lookup.deptlookup lu
SET mm.Department=lu.Department,
	mm.College=lu.College
Where  mm.DEPTID=lu.DEPTID; 
*/
###########################################################################################################################
###########################################################################################################################
###########################################################################################################################
###########################################################################################################################
## Assigned report Colleges to Tranaction Files for SFY 2019-2020 and SFY 2020-2021
## USING MATTS MAPPING FILE 
#############################
DROP TABLE IF EXISTS finance.transWORK;
Create table finance.transWORK
SELECT * from Adhoc.combined_hist_rept
WHERE Fiscal_Year in (2020,2021);




Alter Table finance.transWORK
	ADD DeptName	varchar(45),
    ADD College	varchar(45),
    Add CollAbbr varchar(10),
	ADD ReportCollege	varchar(45),
    ADD TypeFlag varchar(25);
    

SET SQL_SAFE_UPDATES = 0;

### SET VALUES FROM maatmap    
UPDATE finance.transWORK tw, finance.mattmap lu
SET tw.ReportCollege=lu.ReportCollege
WHERE tw.Alt_Dept_ID=lu.DeptID; 




UPDATE finance.transWORK tw SET TypeFlag="Transaction";
 
## SELECT * from finance.transWORK;
## desc finance.transWORK;


## UPDATE TL1 FROM TABLE (source Matt Alday)


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
    tw.College=lu.ReportCollege,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.Project_Code=lu.Project_Code;

/*
UPDATE finance.transWORK SET ReportCollege='OMIT - TL' WHERE Project_Code='00126398';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL MAIN' WHERE Project_Code='P0166321';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main' WHERE Project_Code='P0131091';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main OLD' WHERE Project_Code='P0072521';
UPDATE finance.transWORK SET ReportCollege='OMIT - COM TL Main' WHERE Project_Code='P0134522';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL CTSI Main' WHERE Project_Code='P0035601';
*/
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main' WHERE Project_Code='P0131091';
UPDATE finance.transWORK SET ReportCollege='OMIT - NIH TL Main OLD' WHERE Project_Code='P0072521';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL CTSI Main' WHERE Project_Code='P0035601';
UPDATE finance.transWORK SET ReportCollege='OMIT - TL Adjustment' 
		WHERE Alt_Dept_ID='29680600' AND Project_Code='-' 
        AND Account_Code='799900' AND  Fund_Code='171' AND ReportCollege IS NULL;



UPDATE finance.transWORK tw, finance.tl_depts lu
SET tw.TypeFlag=lu.TypeFlag,
    tw.DeptName=lu.DeptName,
    tw.College=lu.ReportCollege,
    tw.ReportCollege=lu.ReportCollege
WHERE tw.ALt_Dept_ID=lu.ALt_Dept_ID
  AND tw.Account_Code=lu.Account_Code;





## GAP  FUNDING
UPDATE finance.transWORK
 SET DeptName="MD-PEDS-ADMINISTRATION",
      College="Medicine",
     ReportCollege="Medicine"
where TypeFlag="GAP"; 


## KL2 Pay  - Remove Records for Susbitition
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='611110';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='611120';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612110';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612120';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612310';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0131093' AND Account_Code='612320';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='611110';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='611120';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='612110';
UPDATE finance.transWORK SET ReportCollege='OMIT - KL2 Pay Substitite' WHERE Alt_Dept_ID='29680601' AND Project_Code='P0166289' AND Account_Code='612120';

UPDATE finance.transWORK SET ReportCollege='OMIT - MATT' where ReportCollege in ('OK - Assign from KL','OK - Assign from TL','Student Affairs');  # stragglers

###  Matts Expense Elimination  

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
##########################################################
## Clean Up Names
SET SQL_SAFE_UPDATES = 0;


Update finance.transWORK SET ReportCollege='OFFICE OF STUDENT AFFAIRS' WHERE ReportCollege='Student';
Update finance.transWORK SET ReportCollege='Student Affairs' WHERE ReportCollege IN ('OFFICE OF STUDENT AFFAIRS','GRADUATE SCHOOL');
UPDATE finance.transWORK SET Grant_year="Year 1-R" WHERE Grant_YEAR="Year 4/10 Gap";
#########################################################################################################################################
#########################################################################################################################################
#########################################################################################################################################
#### NEW EDITS 
SET SQL_SAFE_UPDATES = 0;


# ELEMENTs FROM MATTS LIST
UPDATE finance.transWORK SeT ReportCollege='OMIT -Exclude AcctCode' 
WHERE Account_Code IN
            ('430000','440400','440500','480006')
AND ReportCollege is NULL;            ;
440400
440500
480006);


UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680200' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege IS NULL;
UPDATE finance.transWORK SET ReportCollege='Medicine' WHERE Alt_Dept_ID='29680100GCTSA' AND Project_Code='-' AND Account_Code='813000' AND ReportCollege IS NULL;

### UPDATE From Matts revidew of toASSN table.
UPDATE finance.transWORK tw, finance.transupdate20210201 lu
SET tw.ReportCollege=lu.ReportCollege,
	tw.TypeFlag=lu.TypeFlag
WHERE tw.Alt_Dept_ID=lu.Alt_Dept_ID
  AND tw.Project_Code=lu.Project_Code
  AND tw.Fund_Code=lu.Fund_Code
  AND tw.Account_Code=lu.Account_Code
AND tw.ReportCollege IS NULL ;



##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
## VERIFY AND CREATE EDITS
#SELECT ReportCollege, COUNT(*) as N, Sum(Posted_Amount) AS Amount  from finance.transWORK WHERE ReportCollege LIKE '%OMIT%' OR ReportCollege is Null GROUP BY  ReportCollege ;
#SELECT ReportCollege, COUNT(*) as N  from finance.transWORK WHERE ReportCollege NOT LIKE '%OMIT%' OR  ReportCollege is Null  GROUP BY  ReportCollege ;

DROP TABLE IF EXISTS finance.ALLtoASSN;
Create table finance.ALLtoASSN AS
SELECT 	*
        from finance.transWORK 
WHERE ReportCollege IS NULL
ORDER BY 	ReportCollege,
			ALt_Dept_ID,
			Project_Code,
			Fund_Code,
            Account_Code,
			TypeFlag;



DROP TABLE IF EXISTS finance.toASSN;
Create table finance.toASSN AS
SELECT 	ReportCollege,
		ALt_Dept_ID,
		Project_Code,
        Fund_Code,
        Account_Code,
        TypeFlag,
        count(*) as N,
        sum(Posted_Amount) as Total
        from finance.transWORK 
WHERE   ReportCollege like "OK%"
GROUP BY 	ReportCollege,
			ALt_Dept_ID,
			Project_Code,
			Fund_Code,
            Account_Code,
			TypeFlag;

DROP TABLE if Exists finance.temp; 
Create table finance.temp AS
SELECT *         from finance.transWORK 
WHERE   ReportCollege like "OK%";


SELECT * from  finance.toASSN;
select count(*) from finance.transWORK;
###  select sum(Total) from finance.toASSN;
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
###SUMMARY TABLE

select count(*) from finance.transWORK Where ReportCollege is Null;


Drop TABLE IF Exists finance.AllMapSFY;
Create table finance.AllMapSFY AS
SELECT 
	SFY,
	ReportCollege,
	Count(*) AS nTrans,
	SUM(Posted_Amount) as Posted_Amount
from finance.transWORK
WHERE (ReportCollege NOT LIKE "%OMIT%") OR (ReportCollege is Null)
Group BY SFY,
	     ReportCollege;
	     

UPDATE finance.AllMapSFY SET ReportCollege="***UNDEFINED***" WHERE ReportCollege IS NULL ;       
         
select count(*) from finance.transWORK WHERE  ReportCollege is Null;          
         
Drop TABLE IF Exists finance.AllMapOut;
Create table finance.AllMapOut AS
SELECT ReportCollege
FROM finance.AllMapSFY
GROUP BY ReportCollege;  

Alter table finance.AllMapOut
ADD n2020 int(6),
ADD Amount2020 Decimal(65,10),
ADD n2021 int(6),
ADD Amount2021 Decimal(65,10);

UPDATE finance.AllMapOut mo, finance.AllMapSFY lu
SET 	mo.n2020=lu.nTrans,
		mo.Amount2020= Posted_Amount
WHERE mo.ReportCollege=lu.ReportCollege
  AND lu.SFY='SFY 2019-2020';

UPDATE finance.AllMapOut mo, finance.AllMapSFY lu
SET 	mo.n2021=lu.nTrans,
		mo.Amount2021= Posted_Amount
WHERE mo.ReportCollege=lu.ReportCollege
  AND lu.SFY='SFY 2020-2021';

select * from finance.AllMapOut;


Drop TABLE IF Exists finance.CollSFYType;
Create table finance.CollSFYType AS
SELECT 	SFY,
		ReportCollege,
        TypeFlag,
        COunt(*) as nTransactions,
        SUM(Posted_Amount) as Amount
from finance.transWORK
WHERE (ReportCollege NOT LIKE "%OMIT%") OR (ReportCollege is Null)
GROUP BY  	SFY,
			ReportCollege,
			TypeFlag
ORDER BY 	SFY,
			ReportCollege,
			TypeFlag;       
            
            

Drop TABLE IF Exists finance.Detail;
Create table finance.Detail AS
SELECT 	*
from finance.transWORK
WHERE (ReportCollege NOT LIKE "%OMIT%") OR (ReportCollege is Null)
ORDER BY 	SFY,
			ReportCollege,
            Alt_Dept_ID;
              

##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
##########################################################################################################################

