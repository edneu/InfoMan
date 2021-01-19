#################################################################################################################
##SUBSTITUTE PILOTS FROM  lookup.PILOTS_MASTER


DROP TABLE IF EXISTS  finance.PILOTS;
Create table finance.PILOTS AS
SELECT * from pilots.PILOTS_MASTER WHERE AwardLetterDate>=str_to_date('07,01,2019','%m,%d,%Y') AND Awarded="Awarded";

SELECT TransMonth,Fiscal_Year,Grant_Year,CTSI_Fiscal_Year,SFY from finance.transWORK group by  TransMonth,Fiscal_Year,Grant_Year,CTSI_Fiscal_Year,SFY ;

SELECT max(combined_hist_rept_id)+1 from finance.transWORK;



#################################################################################################################
##SUBSTITUTE VOCUHERS FROM  VOUCHERLOG
DESC finance.transWORK;

SELECT  count(*) as n, SUM(Amount_Issued) AS Issued,sum(Amount_Billed) as Billed, SUm(Actual_Award) Award
FROM finance.voucher2
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y');

DROP TABLE IF EXISTS  finance.VouchWORK;
Create table finance.VouchWORK AS
SELECT  *
FROM finance.voucher2
WHERE Date_Issued>=str_to_date('07,01,2019','%m,%d,%Y');

ALTER TABLE finance.VouchWORK
	ADD DeptName	varchar(45),
	ADD CollAbbr	varchar(12),
	ADD College	varchar(45),
	ADD ReportCollege	varchar(45),
    ADD TypeFlag varchar(25);
    
    
 UPDATE finance.VouchWORK vw, finance.VoucherSFY20_21 lu
 SET vw.DeptName=lu.Department,
	 vw.College=lu.College, 
	 vw.ReportCollege=lu.College
 WHERE vw.VocuherID=lu.VoucherID ;   
 
 SELECT Distinct ReportCollege from finance.transWORK;
#################################################################################################################