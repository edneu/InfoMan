

desc loaddata.irb_raw_August_2018;

drop table if exists work.irb;
create table work.irb as
select * from loaddata.irb_jan_2019;

#### Fix Date ERROR
SET SQL_SAFE_UPDATES = 0;
UPDATE work.irb SET Approval_Date=str_to_date('05,30,2018','%m,%d,%Y') ,
                    Date_Originally_Approved=str_to_date('05,30,2018','%m,%d,%Y')   
    WHERE irb_jan_2019_id=7421;

SET SQL_SAFE_UPDATES = 1;
### FIX UFIDS


SET SQL_SAFE_UPDATES = 0;
UPDATE work.irb SET PI_UFID=LPAD(PI_UFID,8,'0');


ALTER TABLE work.irb
ADD 	IRB_Approval_Year integer(4),
ADD 	IRB_Approval_Month varchar(12),
ADD		IRB_APPROVAL_TIME integer(10),
ADD		IRB_APPROVAL_TIME_NOPRESCREEN integer(10),
ADD     PreReview_Days integer(10);



UPDATE work.irb SET IRB_Approval_Year=Year(Date_Originally_Approved);
UPDATE work.irb SET IRB_Approval_Month=concat(Year(Date_Originally_Approved),"-",LPAD(month(Date_Originally_Approved),2,'0'));

UPDATE work.irb SET PreReview_Days=0;
UPDATE work.irb SET PreReview_Days=datediff(First_Review_Date, Date_IRB_Received ) where First_Review_Date is not null;



UPDATE work.irb SET IRB_APPROVAL_TIME_NOPRESCREEN = datediff(Date_Originally_Approved, Date_IRB_Received);
UPDATE work.irb SET IRB_APPROVAL_TIME = datediff(Date_Originally_Approved, Date_IRB_Received)-PreReview_Days;





####
select IRB_Approval_Year,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_NOPRESCREEN)
from work.irb
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Year;


select IRB_Approval_Month,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_NOPRESCREEN)
from work.irb
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Month;
;

########## ANNUAL MEDIANS!!!!!




###########################################################################
###########################################################################
################## COMMON METRICS TABLE ###################################
################# NOTE TRICK MEDIAN CODE ##################################
###########################################################################


SET @ROW_NUMBER:=0; 
SET @median_group:='';

DROP TABLE if exists work.full;
Create table work.full AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Year THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Year AS median_group,
			IRB_Approval_Year,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type="Full IRB Review" AND 
					a.IRB_Approval_Year = IRB_Approval_Year) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Year, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type="Full IRB Review"
	ORDER BY IRB_Approval_Year, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;

##select distinct Review_Type from work.irb;

############# 'Expedited'
DROP TABLE if exists work.Expedited;
Create table work.Expedited AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Year THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Year AS median_group,
			IRB_Approval_Year,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type='Expedited' AND 
					a.IRB_Approval_Year = IRB_Approval_Year) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Year, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type='Expedited'
	ORDER BY IRB_Approval_Year, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;

############# 'Exempt'
DROP TABLE if exists work.Exempt;
Create table work.Exempt AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Year THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Year AS median_group,
			IRB_Approval_Year,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type='Exempt' AND 
					a.IRB_Approval_Year = IRB_Approval_Year) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Year, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type='Exempt'
	ORDER BY IRB_Approval_Year, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;


drop table if exists results.IRB_CM_MEDIAN  ;
create table results.IRB_CM_MEDIAN AS
SELECT IRB_Approval_Year as IRB_Approval_Year
from work.irb
WHERE IRB_Approval_Year IS NOT NULL
group by IRB_Approval_Year;

ALTER TABLE results.IRB_CM_MEDIAN
ADD FullReview decimal(10.2),
ADD Expedited decimal(10.2),
ADD Exempt decimal(10.2);

SET SQL_SAFE_UPDATES = 0;

UPDATE results.IRB_CM_MEDIAN ms, work.full lu
SET ms.FullReview=lu.median
WHERE ms.IRB_Approval_Year=lu.median_group;

UPDATE results.IRB_CM_MEDIAN ms, work.Expedited lu
SET ms.Expedited=lu.median
WHERE ms.IRB_Approval_Year=lu.median_group;

UPDATE results.IRB_CM_MEDIAN ms, work.Exempt lu
SET ms.Exempt=lu.median
WHERE ms.IRB_Approval_Year=lu.median_group;


select * from results.IRB_CM_MEDIAN;

##################################################################################
##################################################################################
########## MONTHLY MEDIANS
##################################################################################
SET @ROW_NUMBER:=0; 
SET @median_group:='';

DROP TABLE if exists work.mfull;
Create table work.mfull AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Month THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Month AS median_group,
			IRB_Approval_Month,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type="Full IRB Review" AND 
					a.IRB_Approval_Month = IRB_Approval_Month) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Month, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type="Full IRB Review"
	ORDER BY IRB_Approval_Month, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;


############# 'Expedited'
DROP TABLE if exists work.mExpedited;
Create table work.mExpedited AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Month THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Month AS median_group,
			IRB_Approval_Month,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type='Expedited' AND 
					a.IRB_Approval_Month = IRB_Approval_Month) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Month, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type='Expedited'
	ORDER BY IRB_Approval_Month, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;

############# 'Exempt'
DROP TABLE if exists work.mExempt;
Create table work.mExempt AS 
SELECT 
	median_group, AVG(IRB_APPROVAL_TIME) AS median
FROM
	(SELECT 
		@ROW_NUMBER:=CASE
				WHEN @median_group = IRB_Approval_Month THEN @ROW_NUMBER + 1
				ELSE 1
			END AS count_of_group,
			@median_group:=IRB_Approval_Month AS median_group,
			IRB_Approval_Month,
			IRB_APPROVAL_TIME,
			(SELECT 
					COUNT(*)
				FROM
					work.irb
				WHERE Committee="IRB-01" AND  Review_Type='Exempt' AND 
					a.IRB_Approval_Month = IRB_Approval_Month) AS total_of_group
			     
	FROM
		(SELECT 
		IRB_Approval_Month, IRB_APPROVAL_TIME
	FROM
		work.irb
			WHERE Committee="IRB-01"
			AND Review_Type='Exempt'
	ORDER BY IRB_Approval_Month, IRB_APPROVAL_TIME) AS a) AS b
WHERE
	count_of_group BETWEEN total_of_group / 2.0 AND total_of_group / 2.0 + 1
GROUP BY median_group;


drop table if exists results.IRB_monthly_MEDIAN  ;
create table results.IRB_monthly_MEDIAN AS
SELECT IRB_Approval_Month as IRB_Approval_Month
from work.irb
WHERE IRB_Approval_Month IS NOT NULL
group by IRB_Approval_Month;

ALTER TABLE results.IRB_monthly_MEDIAN
ADD FullReview decimal(10.2),
ADD Expedited decimal(10.2),
ADD Exempt decimal(10.2);

SET SQL_SAFE_UPDATES = 0;

UPDATE results.IRB_monthly_MEDIAN ms, work.mfull lu
SET ms.FullReview=lu.median
WHERE ms.IRB_Approval_Month=lu.median_group;

UPDATE results.IRB_monthly_MEDIAN ms, work.mExpedited lu
SET ms.Expedited=lu.median
WHERE ms.IRB_Approval_Month=lu.median_group;

UPDATE results.IRB_monthly_MEDIAN ms, work.mExempt lu
SET ms.Exempt=lu.median
WHERE ms.IRB_Approval_Month=lu.median_group;


##############################################################################
######## REPORT TABLES 
##############################################################################

DROP TABLE IF EXISTS results.IRB_Approval_Monthly;
create table results.IRB_Approval_Monthly AS
select IRB_Approval_Month,
       Exempt,
       Expedited,
       FullReview 
from results.IRB_monthly_MEDIAN;


DROP TABLE IF EXISTS results.IRB_Approval_CM_YEAR;
create table results.IRB_Approval_CM_YEAR AS
select IRB_Approval_Year,
	   Exempt,
       Expedited,
       FullReview
 from results.IRB_CM_MEDIAN;  # Annual Medians

##########################################################
##########################################################
### IRB VOLUME
SELECT 	IRB_Approval_Year,
		COUNT(*) 
from work.irb
WHERE Committee="IRB-01"
	AND Review_Type='Full IRB Review'
group by IRB_Approval_Year;

SELECT 	IRB_Approval_Month,
		COUNT(*) 
from work.irb
WHERE Committee="IRB-01"
	AND Review_Type='Full IRB Review'
group by IRB_Approval_Month;






select * from work.irb where IRB_Approval_Year=201;

UPDATE work.irb SET Approval_Date=str_to_date('05,30,2018','%m,%d,%Y')     WHERE irb_jan_2019_id=7421;

##########################################################
##########################################################
##########################################################
/*
	DROP TABLE IF EXISTS lookup.myirb;
	CREATE TABLE lookup.myirb AS
	SELECT * from work.irb;
*/
##########################################################
################## EOF ###################################
##########################################################

#create table loaddata.myIRBBackup201710 AS Select * from lookup.
Create table lookup.myIRB as Select * from work.irb;

select Review_Type,Committee,min(IRB_Approval_Month) from lookup.myIRB group by Committee,Review_Type;
