
SELECT * from work.covidproj;

DROP TABLE IF EXISTS  work.covid_detail;
create table work.covid_detail As
SELECT 	CLK_AWD_ID,
		max(CLK_AWD_FULL_TITLE) AS Title,
        max(CLK_AWD_PI) AS PI,
        MAX(CLK_PI_UFID) AS PI_UFID,
        MAX(REPORTING_SPONSOR_NAME) AS Sponsor,
        MAX(REPORTING_SPONSOR_AWD_ID) AS Sponsor_Awd_ID,
        SUM(DIRECT_AMOUNT) AS Direct,
        SUM(INDIRECT_AMOUNT) AS Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Total,
        Min(FUNDS_ACTIVATED) FirstFunds
FROM lookup.awards_history
WHERE CLK_AWD_FULL_TITLE in (SELECT Distinct ProjTitle from work.covidproj)
   OR CLK_AWD_PROJ_NAME in (SELECT Distinct ProjTitle from work.covidproj)
GROUP BY CLK_AWD_ID  ;


Alter table work.covid_detail ADD OrigProjNum int(5); 

SET SQL_SAFE_UPDATES = 0;

UPDATE work.covid_detail cd, work.covidproj lu
SET cd.OrigProjNum=lu.Project
WHERE cd.Title=lu.ProjTitle;

DROP TABLE IF EXISTS  work.covid_detailout;
create table work.covid_detailout As
SELECT OrigProjNum,
CLK_AWD_ID,
Title,
PI,
PI_UFID,
Sponsor,
Sponsor_Awd_ID,
Direct,
Indirect,
Total,
FirstFunds AS FundDate
from work.covid_detail
order by OrigProjNum
;







