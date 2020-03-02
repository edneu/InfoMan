


###DELETE FROM Adhoc.combined_hist_rept where Journal_Date is Null;






UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_= NULL;

UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2000 WHERE Journal_Date BETWEEN str_to_date('07,01,2000', '%m,%d,%Y') AND  str_to_date('06,30,2001','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2001 WHERE Journal_Date BETWEEN str_to_date('07,01,2001', '%m,%d,%Y') AND  str_to_date('06,30,2002','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2002 WHERE Journal_Date BETWEEN str_to_date('07,01,2002', '%m,%d,%Y') AND  str_to_date('06,30,2003','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2003 WHERE Journal_Date BETWEEN str_to_date('07,01,2003', '%m,%d,%Y') AND  str_to_date('06,30,2004','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2004 WHERE Journal_Date BETWEEN str_to_date('07,01,2004', '%m,%d,%Y') AND  str_to_date('06,30,2005','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2005 WHERE Journal_Date BETWEEN str_to_date('07,01,2005', '%m,%d,%Y') AND  str_to_date('06,30,2006','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2006 WHERE Journal_Date BETWEEN str_to_date('07,01,2006', '%m,%d,%Y') AND  str_to_date('06,30,2007','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2007 WHERE Journal_Date BETWEEN str_to_date('07,01,2007', '%m,%d,%Y') AND  str_to_date('06,30,2008','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2008 WHERE Journal_Date BETWEEN str_to_date('07,01,2008', '%m,%d,%Y') AND  str_to_date('06,30,2009','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2009 WHERE Journal_Date BETWEEN str_to_date('07,01,2009', '%m,%d,%Y') AND  str_to_date('06,30,2010','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2010 WHERE Journal_Date BETWEEN str_to_date('07,01,2010', '%m,%d,%Y') AND  str_to_date('06,30,2011','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2011 WHERE Journal_Date BETWEEN str_to_date('07,01,2011', '%m,%d,%Y') AND  str_to_date('06,30,2012','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2012 WHERE Journal_Date BETWEEN str_to_date('07,01,2012', '%m,%d,%Y') AND  str_to_date('06,30,2013','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2013 WHERE Journal_Date BETWEEN str_to_date('07,01,2013', '%m,%d,%Y') AND  str_to_date('06,30,2014','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2014 WHERE Journal_Date BETWEEN str_to_date('07,01,2013', '%m,%d,%Y') AND  str_to_date('06,30,2014','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2015 WHERE Journal_Date BETWEEN str_to_date('07,01,2014', '%m,%d,%Y') AND  str_to_date('06,30,2015','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2016 WHERE Journal_Date BETWEEN str_to_date('07,01,2015', '%m,%d,%Y') AND  str_to_date('06,30,2016','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2017 WHERE Journal_Date BETWEEN str_to_date('07,01,2016', '%m,%d,%Y') AND  str_to_date('06,30,2017','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2018 WHERE Journal_Date BETWEEN str_to_date('07,01,2017', '%m,%d,%Y') AND  str_to_date('06,30,2018','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2019 WHERE Journal_Date BETWEEN str_to_date('07,01,2018', '%m,%d,%Y') AND  str_to_date('06,30,2019','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2019 WHERE Journal_Date BETWEEN str_to_date('07,01,2018', '%m,%d,%Y') AND  str_to_date('06,30,2019','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2019', '%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2020', '%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2021', '%m,%d,%Y') AND  str_to_date('06,30,2022','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2022', '%m,%d,%Y') AND  str_to_date('06,30,2023','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET CTSI_Fiscal_Year_=2020 WHERE Journal_Date BETWEEN str_to_date('07,01,2023', '%m,%d,%Y') AND  str_to_date('06,30,2024','%m,%d,%Y');

select Journal_Date,count(*) from Adhoc.combined_hist_rept where CTSI_Fiscal_Year_ IS NULL group by Journal_Date;


UPDATE Adhoc.combined_hist_rept SET Grant_Year=NULL;

UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year -1' WHERE Journal_Date BETWEEN str_to_date('06,01,2002', '%m,%d,%Y') AND  str_to_date('03,31,2008','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 0' WHERE Journal_Date BETWEEN str_to_date('04,01,2008', '%m,%d,%Y') AND  str_to_date('03,31,2009','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 1' WHERE Journal_Date BETWEEN str_to_date('04,01,2009', '%m,%d,%Y') AND  str_to_date('03,31,2010','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 2' WHERE Journal_Date BETWEEN str_to_date('04,01,2010', '%m,%d,%Y') AND  str_to_date('03,31,2011','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 3' WHERE Journal_Date BETWEEN str_to_date('04,01,2011', '%m,%d,%Y') AND  str_to_date('03,31,2012','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 4' WHERE Journal_Date BETWEEN str_to_date('04,01,2012', '%m,%d,%Y') AND  str_to_date('03,31,2013','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 5' WHERE Journal_Date BETWEEN str_to_date('04,01,2013', '%m,%d,%Y') AND  str_to_date('03,31,2014','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 6' WHERE Journal_Date BETWEEN str_to_date('04,01,2014', '%m,%d,%Y') AND  str_to_date('08,14,2015','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 1 /7' WHERE Journal_Date BETWEEN str_to_date('08,15,2015', '%m,%d,%Y') AND  str_to_date('03,31,2016','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 2/8' WHERE Journal_Date BETWEEN str_to_date('04,01,2016', '%m,%d,%Y') AND  str_to_date('03,31,2017','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 3/9' WHERE Journal_Date BETWEEN str_to_date('04,01,2017', '%m,%d,%Y') AND  str_to_date('03,31,2018','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 4/10' WHERE Journal_Date BETWEEN str_to_date('04,01,2018', '%m,%d,%Y') AND  str_to_date('03,31,2019','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 4/10 Gap' WHERE Journal_Date BETWEEN str_to_date('04,01,2019', '%m,%d,%Y') AND  str_to_date('07,01,2019','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 1-R' WHERE Journal_Date BETWEEN str_to_date('07,02,2019', '%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 2-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2020', '%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 3-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2021', '%m,%d,%Y') AND  str_to_date('06,30,2022','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 4-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2022', '%m,%d,%Y') AND  str_to_date('06,30,2023','%m,%d,%Y');
UPDATE Adhoc.combined_hist_rept SET Grant_Year='Year 5-R' WHERE Journal_Date BETWEEN str_to_date('07,01,2023', '%m,%d,%Y') AND  str_to_date('06,30,2024','%m,%d,%Y');


select Journal_Date,count(*) from Adhoc.combined_hist_rept where Grant_Year IS NULL group by Journal_Date;


######################   FLEX CODES

SELECT count(*) from Adhoc.combined_hist_rept 
WHERE Flex_Code NOT IN (SELECT DISTINCT DeptFlex from Adhoc.flex_codes)
group by Flex_Code;


select Alt_Dept_ID,count(*) from  Adhoc.combined_hist_rept group by Alt_Dept_ID;

SET SQL_SAFE_UPDATES = 0;

UPDATE Adhoc.combined_hist_rept SET Alt_Dept_ID=NULL;

CREATE INDEX flex1 ON Adhoc.combined_hist_rept (Flex_Code);
CREATE INDEX flex2 ON Adhoc.flex_codes (DeptFlex);



UPDATE Adhoc.combined_hist_rept hr, Adhoc.flex_codes lu
SET hr.Alt_Dept_ID=lu.DeptID
WHERE hr.Flex_Code=lu.DeptFlex;

UPDATE Adhoc.combined_hist_rept 
SET Alt_Dept_ID=DeptID
WHERE Alt_Dept_ID IS NULL;


SELECT Grant_Year,sum(Posted_Amount)
from Adhoc.combined_hist_rept
group by Grant_Year;


DROP TABLE IF EXISTS Adhoc.MattOut;
create table Adhoc.MattOut AS
SELECT Grant_Year,Account_Code,ERP_Account_Level_4,sum(Posted_Amount)
from Adhoc.combined_hist_rept
WHERE Alt_Dept_ID='29680300'
AND Journal_Date>str_to_date('04,01,2012', '%m,%d,%Y')
group by Grant_Year,Account_Code,ERP_Account_Level_4
ORDER BY Grant_Year,Account_Code,ERP_Account_Level_4;

DROP TABLE IF EXISTS Adhoc.MattOut2;
create table Adhoc.MattOut2 AS
SELECT Grant_Year,Alt_Dept_ID,Account_Code,ERP_Account_Level_4,sum(Posted_Amount)
from Adhoc.combined_hist_rept
WHERE Journal_Date>str_to_date('04,01,2012', '%m,%d,%Y')
AND Alt_Dept_ID IN ('29680240',
                   '29680220',
                   '29680200',
                   '29680230',
                   '29680231',
                   '29680241',
                   '29680244',
                   '29680245',
                   '29680301',
                   '29680504',
                   '29680508',
                   '29680510',
                   '29680512'
)
group by Grant_Year,Alt_Dept_ID,Account_Code,ERP_Account_Level_4
ORDER BY Grant_Year,Alt_Dept_ID,Account_Code,ERP_Account_Level_4;



