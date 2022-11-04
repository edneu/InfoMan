
###################################################################################################
###################################################################################################
### LOAD FROM EXCEL SPREADHEET
### This proceduuyre assumes that the Cumulative transaction file and Secim File are laoded (NO Appending)

create table loaddata.newtranshist202211 as 
SELECT * from loaddata.page1;

desc loaddata.newtranshist202211;
##drop table loaddata.newtranshist202205 ;

desc Adhoc.combined_hist_rept;

select "Combined Hist" as tablename, min(Journal_date) as FromDate, Max(Journal_date) ToDate,count(*) nRecords, sum(Posted_Amount) as Total from Adhoc.combined_hist_rept
UNION ALL
select "New Transaction File" as tablename, min(Journal_date) as FromDate, Max(Journal_date) ToDate,count(*) AS nRecords, sum(Posted_Amount) as Total  from loaddata.newtranshist202211;

desc loaddata.newtranshist;

#################
#################
### MANAGE DUPLICATE RECORDS BETWEEN NEW TRANSATIONS AND SECIM



drop table if exists loaddata.newtranshist;
Create table loaddata.newtranshist as
SELECT * from  loaddata.newtranshist202211;
/*
ALTER TABLE loaddata.newtranshist	ADD UnDupFlag int(1),
									ADD	DupKEY varchar(4000);

select * from loaddata.newtranshist;

SET SQL_SAFE_UPDATES = 0;
*/
### Alter table loaddata.newtranshist CHANGE newtranshist202110_id newtranshist_id int(11);


#############################################################################
#############################################################################

SET SQL_SAFE_UPDATES = 0;

DELETE FROM loaddata.newtranshist where Journal_Date is Null;

ALTER TABLE loaddata.newtranshist
			ADD Grant_year varchar(24),
			ADD	 CTSI_Fiscal_Year int(4),
            ADD  TransMonth varchar(8),
            ADD Alt_Dept_ID varchar(45);
            
UPDATE loaddata.newtranshist SET TransMonth=concat(YEAR(Journal_Date),"-",LPAD(MONTH(Journal_Date),2,"0")) ;


#### UPDATE CTSI FISCAL YEAR
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year= NULL;
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2000 WHERE Journal_Date BETWEEN str_to_date('07,01,2000', '%m,%d,%Y') AND  str_to_date('06,30,2001','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2001 WHERE Journal_Date BETWEEN str_to_date('07,01,2001', '%m,%d,%Y') AND  str_to_date('06,30,2002','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2002 WHERE Journal_Date BETWEEN str_to_date('07,01,2002', '%m,%d,%Y') AND  str_to_date('06,30,2003','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2003 WHERE Journal_Date BETWEEN str_to_date('07,01,2003', '%m,%d,%Y') AND  str_to_date('06,30,2004','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2004 WHERE Journal_Date BETWEEN str_to_date('07,01,2004', '%m,%d,%Y') AND  str_to_date('06,30,2005','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2005 WHERE Journal_Date BETWEEN str_to_date('07,01,2005', '%m,%d,%Y') AND  str_to_date('06,30,2006','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2006 WHERE Journal_Date BETWEEN str_to_date('07,01,2006', '%m,%d,%Y') AND  str_to_date('06,30,2007','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2007 WHERE Journal_Date BETWEEN str_to_date('07,01,2007', '%m,%d,%Y') AND  str_to_date('06,30,2008','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2008 WHERE Journal_Date BETWEEN str_to_date('07,01,2008', '%m,%d,%Y') AND  str_to_date('06,30,2009','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2009 WHERE Journal_Date BETWEEN str_to_date('07,01,2009', '%m,%d,%Y') AND  str_to_date('06,30,2010','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2010 WHERE Journal_Date BETWEEN str_to_date('07,01,2010', '%m,%d,%Y') AND  str_to_date('06,30,2011','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2011 WHERE Journal_Date BETWEEN str_to_date('07,01,2011', '%m,%d,%Y') AND  str_to_date('06,30,2012','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2012 WHERE Journal_Date BETWEEN str_to_date('07,01,2012', '%m,%d,%Y') AND  str_to_date('06,30,2013','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2013 WHERE Journal_Date BETWEEN str_to_date('07,01,2013', '%m,%d,%Y') AND  str_to_date('06,30,2014','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2014 WHERE Journal_Date BETWEEN str_to_date('07,01,2013', '%m,%d,%Y') AND  str_to_date('06,30,2014','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2015 WHERE Journal_Date BETWEEN str_to_date('07,01,2014', '%m,%d,%Y') AND  str_to_date('06,30,2015','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2016 WHERE Journal_Date BETWEEN str_to_date('07,01,2015', '%m,%d,%Y') AND  str_to_date('06,30,2016','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2017 WHERE Journal_Date BETWEEN str_to_date('07,01,2016', '%m,%d,%Y') AND  str_to_date('06,30,2017','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2018 WHERE Journal_Date BETWEEN str_to_date('07,01,2017', '%m,%d,%Y') AND  str_to_date('06,30,2018','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2019 WHERE Journal_Date BETWEEN str_to_date('07,01,2018', '%m,%d,%Y') AND  str_to_date('06,30,2019','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2019', '%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2021 WHERE Journal_Date BETWEEN str_to_date('07,01,2020', '%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2022 WHERE Journal_Date BETWEEN str_to_date('07,01,2021', '%m,%d,%Y') AND  str_to_date('06,30,2022','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2023 WHERE Journal_Date BETWEEN str_to_date('07,01,2022', '%m,%d,%Y') AND  str_to_date('06,30,2023','%m,%d,%Y');
UPDATE loaddata.newtranshist SET CTSI_Fiscal_Year=2024 WHERE Journal_Date BETWEEN str_to_date('07,01,2023', '%m,%d,%Y') AND  str_to_date('06,30,2024','%m,%d,%Y');



#### UPDATE GRANT YEAR
UPDATE loaddata.newtranshist SET Grant_Year=NULL;
UPDATE loaddata.newtranshist SET Grant_Year='Year -1' WHERE Journal_Date BETWEEN str_to_date('06,01,2002', '%m,%d,%Y') AND  str_to_date('03,31,2008','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 0' WHERE Journal_Date BETWEEN str_to_date('04,01,2008', '%m,%d,%Y') AND  str_to_date('03,31,2009','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 1' WHERE Journal_Date BETWEEN str_to_date('04,01,2009', '%m,%d,%Y') AND  str_to_date('03,31,2010','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 2' WHERE Journal_Date BETWEEN str_to_date('04,01,2010', '%m,%d,%Y') AND  str_to_date('03,31,2011','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 3' WHERE Journal_Date BETWEEN str_to_date('04,01,2011', '%m,%d,%Y') AND  str_to_date('03,31,2012','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 4' WHERE Journal_Date BETWEEN str_to_date('04,01,2012', '%m,%d,%Y') AND  str_to_date('03,31,2013','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 5' WHERE Journal_Date BETWEEN str_to_date('04,01,2013', '%m,%d,%Y') AND  str_to_date('03,31,2014','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 6' WHERE Journal_Date BETWEEN str_to_date('04,01,2014', '%m,%d,%Y') AND  str_to_date('08,14,2015','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 1 /7' WHERE Journal_Date BETWEEN str_to_date('08,15,2015', '%m,%d,%Y') AND  str_to_date('03,31,2016','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 2/8' WHERE Journal_Date BETWEEN str_to_date('04,01,2016', '%m,%d,%Y') AND  str_to_date('03,31,2017','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 3/9' WHERE Journal_Date BETWEEN str_to_date('04,01,2017', '%m,%d,%Y') AND  str_to_date('03,31,2018','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 4/10' WHERE Journal_Date BETWEEN str_to_date('04,01,2018', '%m,%d,%Y') AND  str_to_date('03,31,2019','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 4/10 Gap' WHERE Journal_Date BETWEEN str_to_date('04,01,2019', '%m,%d,%Y') AND  str_to_date('07,01,2019','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 1-R' WHERE Journal_Date BETWEEN str_to_date('07,02,2019', '%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 2-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2020', '%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 3-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2021', '%m,%d,%Y') AND  str_to_date('06,30,2022','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 4-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2022', '%m,%d,%Y') AND  str_to_date('06,30,2023','%m,%d,%Y');
UPDATE loaddata.newtranshist SET Grant_Year='Year 5-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2023', '%m,%d,%Y') AND  str_to_date('06,30,2024','%m,%d,%Y');






### VERIFY FY assignemnts
select Journal_Date,count(*) from loaddata.newtranshist  group by Journal_Date;
select Grant_Year,count(*) from loaddata.newtranshist  group by Grant_Year;
select CTSI_Fiscal_Year,count(*) from loaddata.newtranshist  group by CTSI_Fiscal_Year;
SELECT CTSI_Fiscal_Year,Grant_Year,TransMonth,count(*) as nRecs from loaddata.newtranshist  group by CTSI_Fiscal_Year,Grant_Year,TransMonth;

SELECT TransMonth,count(*) as nRecs from loaddata.newtranshist group by TransMonth;

select Journal_Date,count(*) from loaddata.newtranshist where CTSI_Fiscal_Year IS NULL group by Journal_Date;
select Journal_Date,count(*) from loaddata.newtranshist where Grant_Year IS NULL group by Journal_Date;


######################   FLEX CODES

## Check for undefined Flex Codes
SELECT Flex_Code,count(*) from loaddata.newtranshist 
WHERE Flex_Code NOT IN (SELECT DISTINCT DeptFlex from Adhoc.flex_codes)
AND Year(Journal_Date)=2021
group by Flex_Code;

desc Adhoc.flex_codes;

select Alt_Dept_ID,count(*) from  loaddata.newtranshist group by Alt_Dept_ID;

SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.newtranshist SET Alt_Dept_ID=NULL;

CREATE INDEX flex1 ON loaddata.newtranshist (Flex_Code);
CREATE INDEX flex2 ON Adhoc.flex_codes (DeptFlex);

### Assign from Flex Code Table
UPDATE loaddata.newtranshist hr, Adhoc.flex_codes lu
SET hr.Alt_Dept_ID=lu.DeptID
WHERE hr.Flex_Code=lu.DeptFlex;


UPDATE loaddata.newtranshist 
SET Alt_Dept_ID=DeptID
WHERE Alt_Dept_ID IS NULL;

select * from  loaddata.newtranshist  where Alt_Dept_ID is null;

########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
#############################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################



desc loaddata.newtranshist ;




####################################################
drop table if exists Adhoc.combined_hist_rept_NEW;
create table Adhoc.combined_hist_rept_NEW AS
SELECT 
	newtranshist_id AS combined_hist_report_id,
	Transaction_Detail,
	TransMonth,
    DeptID,
	Alt_Dept_ID,
    ##DeptID_Desc,
	Fund_Code,
	Program_Code,
	Source_of_Funds_Code,
	Flex_Code,
	Project_Code,
	ERP_Account_Level_4,
	Account_Code,
	Doc_Desc,
	Doc_Detail,
	Encumbrance_Description,
	Journal_ID,
	Journal_Date,
	Fiscal_Year,
    Accounting_Period,
    Grant_Year,
	CTSI_Fiscal_Year,
	Posted_Amount
from loaddata.newtranshist ;








SELECT "Previous Combined File"  as Measure, COUNT(*) as N from Adhoc.combined_hist_rept
UNION ALL
SELECT "New File Total N"  as Measure, COUNT(*) as N from loaddata.newtranshist
UNION ALL
SELECT "New Combined File"  as Measure, COUNT(*) as N from Adhoc.combined_hist_rept_NEW;



select CTSI_Fiscal_Year,min(Journal_Date),max(Journal_Date),count(*) from Adhoc.combined_hist_rept_NEW group by CTSI_Fiscal_Year;
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
##### BACKUP AND RENAME
/*
CREATE TABLE Adhoc.comb_hist_report202211BU AS
SELECT * from Adhoc.combined_hist_rept;

drop table if exists Adhoc.combined_hist_rept;



*/
/*


DROP TABLE IF EXISTS Adhoc.combined_hist_rept;
CREATE TABLE Adhoc.combined_hist_rept AS
SELECT 	combined_hist_report_id,
		Alt_Dept_ID,
        CTSI_Fiscal_Year,
        TransMonth,
        ##DeptID_Desc,
        Grant_Year,
        Transaction_Detail,
        DeptID,
        Fund_Code,
        Program_Code,
        Source_of_Funds_Code,
        Flex_Code,
        Project_Code,
        ##Project_Descr,
        ERP_Account_Level_4,
        Account_Code,
        Doc_Desc,
        Doc_Detail,
        Encumbrance_Description,
        Journal_ID,
        Journal_Date,
        Fiscal_Year,
        Accounting_Period,
        Posted_Amount
 from Adhoc.combined_hist_rept_NEW;
*/
/*

SELECT * from Adhoc.combined_hist_rept_NEW;


SELECT Grant_Year,sum(Posted_Amount)
from Adhoc.combined_hist_rept
group by Grant_Year;
*/



###################################################################################################################################
###################################################################################################################################
###################################################################################################################################
##CREATE REPORT TABLES
###################################################################################################################################
DROP TABLE IF EXISTS Adhoc.MattOut;
create table Adhoc.MattOut AS
SELECT Grant_Year,Alt_Dept_ID,Fund_Code,Account_Code,ERP_Account_Level_4,round(sum(Posted_Amount),2) AS Amount
from Adhoc.combined_hist_rept
#WHERE Journal_Date>str_to_date('04,01,2012', '%m,%d,%Y')
group by Grant_Year,Alt_Dept_ID,Fund_Code,Account_Code,ERP_Account_Level_4
ORDER BY Grant_Year,Alt_Dept_ID,Fund_Code,Account_Code,ERP_Account_Level_4;




DROP TABLE IF EXISTS Adhoc.MattOutALL;
create table Adhoc.MattOutALL AS
SELECT *
from Adhoc.combined_hist_rept;
##WHERE Journal_Date>=str_to_date('07,01,2018', '%m,%d,%Y');


###################################################################################################################################
###################################################################################################################################
###################################################################################################################################
###################################################################################################################################
###################################################################################################################################
###################################################################################################################################


###################### TEST
select * from Adhoc.combined_hist_rept WHERE Alt_Dept_ID<>DeptID;


select * from Adhoc.MattOutALL;

select distinct Alt_Dept_ID from Adhoc.MattOutALL;
select Grant_Year,count(*) as N, sum(Posted_Amount) as Amount from  Adhoc.MattOutALL group by Grant_Year;


select Grant_Year,count(*) as N, sum(Posted_Amount) as Amount from  Adhoc.combined_hist_rept group by Grant_Year;


select Fiscal_Year,count(*) as N, sum(Posted_Amount) as Amount from  Adhoc.combined_hist_rept group by Fiscal_Year;

############################################################################################################################################
################### UPDATE OLD DATAWITN ADDED FLEX CODES 2020-08-05 
CREATE TABLE loaddata.BU_CombinedHist20200810 AS SELECT * from Adhoc.combined_hist_rept;

CREATE INDEX flex11 ON Adhoc.combined_hist_rept (Flex_Code);
CREATE INDEX flex2 ON Adhoc.flex_codes (DeptFlex);



UPDATE Adhoc.combined_hist_rept hr, Adhoc.flex_codes lu
SET hr.Alt_Dept_ID=lu.DeptID
WHERE hr.Flex_Code=lu.DeptFlex;

UPDATE Adhoc.combined_hist_rept 
SET Alt_Dept_ID=DeptID
WHERE Alt_Dept_ID IS NULL;


Jul 11, 2020

##################################

SELECT Flex_Code,count(*) from loaddata.combined_hist_rept
WHERE Flex_Code NOT IN (SELECT DISTINCT DeptFlex from Adhoc.flex_codes)
group by Flex_Code;

/*
Alt Dept ID or Dept ID 29680300 and filter for August 2020 I should see $93k in payroll transactions with an account code 6XXXXX but I don't. thoughts? 
*/

SELECT sum(Posted_Amount)
from Adhoc.combined_hist_rept
WHERE Journal_Date>=str_to_date('08,01,2020','%m,%d,%Y')
  AND Journal_Date<=str_to_date('08,31,2020','%m,%d,%Y')
  AND (Alt_Dept_ID='29680300' OR DeptID='29680300')
  AND Account_Code like "6%";
  
  
SELECT sum(Posted_Amount)
from loaddata.newtranshist
WHERE Journal_Date>=str_to_date('08,01,2020','%m,%d,%Y')
  AND Journal_Date<=str_to_date('08,31,2020','%m,%d,%Y')
  AND (Alt_Dept_ID='29680300' OR DeptID='29680300')
  AND Account_Code like "6%";  
  
  
  
  
  
  
  SELECT sum(Posted_Amount)
from Adhoc.combined_hist_rept
WHERE Journal_Date>=str_to_date('07,01,2020','%m,%d,%Y')
  AND Journal_Date<=str_to_date('07,31,2020','%m,%d,%Y')
  AND (Alt_Dept_ID='29680300' OR DeptID='29680300')
  AND Account_Code like "6%";
  
select * from Adhoc.master1;

select distinct DeptID from Adhoc.MattOutALL order by DeptID;
