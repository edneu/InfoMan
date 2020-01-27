#### Medians for Ceded Reviews


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
ADD FullReview decimal(10,2),
ADD Expedited decimal(10,2),
ADD Exempt decimal(10,2);

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

