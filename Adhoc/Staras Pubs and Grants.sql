

Select * from lookup.ufids where UF_LAST_NM Like "STARAS%";
29519101

drop table if exists work.starasPI;
create table work.starasPI as
SELECT CLK_AWD_ID,
	   Max(CLK_AWD_PI) as CLK_AWD_PI,
       MAX(CLK_PI_UFID) as CLK_PI_UFID,
       MAX(REPORTING_SPONSOR_NAME) as REPORTING_SPONSOR_NAME,
       MAX(CLK_AWD_FULL_TITLE) AS AwardTitle,
       SUM(DIRECT_AMOUNT) as DIRECT_AMOUNT,
       SUM(INDIRECT_AMOUNT) as INDIRECT_AMOUNT,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt,
       MIN(FUNDS_ACTIVATED) as FirstPaymentDate,
       MAX(FUNDS_ACTIVATED) as MostRecentPaymentDate
FROM lookup.awards_history
WHERE CLK_PI_UFID='29519101'
GROUP BY CLK_AWD_ID;


drop table if exists work.starasPPI;
create table work.starasPPI as
SELECT CLK_AWD_ID,
	   Max(CLK_AWD_PI) as CLK_AWD_PI,
       MAX(CLK_PI_UFID) as CLK_PI_UFID,
       MAX(REPORTING_SPONSOR_NAME) as REPORTING_SPONSOR_NAME,
       MAX(CLK_AWD_FULL_TITLE) AS AwardTitle,
       SUM(DIRECT_AMOUNT) as DIRECT_AMOUNT,
       SUM(INDIRECT_AMOUNT) as INDIRECT_AMOUNT,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt,
       MIN(FUNDS_ACTIVATED) as FirstPaymentDate,
       MAX(FUNDS_ACTIVATED) as MostRecentPaymentDate
FROM lookup.awards_history
WHERE CLK_AWD_PROJ_MGR_UFID='29519101'
GROUP BY CLK_AWD_ID;