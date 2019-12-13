

select * from award_by_location_2018;

select * from award_nih_reporter_uf_fy_2018;


drop table if exists work.nihrec1;
create table work.nihrec1 as
SELECT  PROJECT_NUMBER, PROJECT_TITLE, PI_NAME, "ABL" AS Source 
	from Adhoc.award_by_location_2018
    GROUP BY PROJECT_NUMBER, PROJECT_TITLE, PI_NAME
    
UNION ALL
SELECT  PROJECT_NUMBER, PROJECT_TITLE, `Contact_PI_/_Project_Leader` AS PI_NAME, "NRP" AS Source
	from Adhoc.award_nih_reporter_uf_fy_2018
    GROUP BY PROJECT_NUMBER, PROJECT_TITLE, PI_NAME;
    
    
SELECT count(distinct PROJECT_NUMBER) from work.nihrec1;

UPDATE work.nihrec1
SET PI_NAME=REPLACE(PI_NAME,".","");

UPDATE work.nihrec1
SET PROJECT_TITLE=REPLACE(PROJECT_TITLE,";",",");







select PROJECT_NUMBER, max(PROJECT_TITLE) AS PROJECT_TITLE, PI_NAME,count(*) 
from work.nihrec1
GROUP BY PROJECT_NUMBER, PI_NAME;

drop table if exists work.temp;
create table work.temp as
SELECT PROJECT_NUMBER,MIN(PROJECT_TITLE) as TIT1, max(PROJECT_TITLE) As TIT2, strcmp(MIN(PROJECT_TITLE),max(PROJECT_TITLE)) as Comp
from work.nihrec1
GROUP BY PROJECT_NUMBER;

select Comp,count(*) from work.temp group by Comp;


UPDATE work.nihrec1 nr, work.temp lu
SET nr.PROJECT_TITLE=lu.TIT1
WHERE Comp=1
AND nr.PROJECT_NUMBER=lu.PROJECT_NUMBER;

UPDATE work.nihrec1 nr, work.temp lu
SET nr.PROJECT_TITLE=lu.TIT2
WHERE nr.PROJECT_NUMBER=lu.PROJECT_NUMBER
AND Comp=-1;


drop table if exists work.nihrec2;
create table work.nihrec2 as
SELECT PROJECT_NUMBER,PROJECT_TITLE
FROM work.nihrec1
GROUP BY PROJECT_NUMBER,PROJECT_TITLE;


ALTER TABLE work.nihrec2
ADD NIHR_TCOST decimal(65,30),
ADD NIHR_SubCOST decimal(65,30),
ADD NIHR_GT_COST decimal(65,30),
ADD ABL_GT_COST decimal(65,30);


drop table if exists work.aggnihr;
Create table work.aggnihr AS
SELECT PROJECT_NUMBER,
       SUM(FY_Total_Cost_) AS NIHR_TCOST,
       SUM(FY_Total_Sub_Project_Cost) AS NIHR_SubCOST,
       SUM(FY_Total_Cost_)+SUM(FY_Total_Sub_Project_Cost) AS NIHR_GT_COST 
FROM Adhoc.award_nih_reporter_uf_fy_2018
GROUP BY PROJECT_NUMBER;


drop table if exists work.aggABL;
Create table work.aggABL AS
SELECT PROJECT_NUMBER,
       SUM(FUNDING) AS ABL_GT_COST
FROM Adhoc.award_by_location_2018
GROUP BY PROJECT_NUMBER;


UPDATE work.nihrec2 nr, work.aggnihr lu
	SET nr.NIHR_TCOST=lu.NIHR_TCOST,
		nr.NIHR_SubCOST=lu.NIHR_SubCOST,
        nr.NIHR_GT_COST=lu.NIHR_GT_COST
WHERE nr.PROJECT_NUMBER=lu.PROJECT_NUMBER;


UPDATE work.nihrec2 nr, work.aggABL lu
	SET nr.ABL_GT_COST=lu.ABL_GT_COST
WHERE nr.PROJECT_NUMBER=lu.PROJECT_NUMBER;


SELECT SUM(NIHR_TCOST) as NIHR, sum(ABL_GT_COST) AS ABL_COST
FROM work.nihrec2;



SET SQL_SAFE_UPDATES =0;


desc work.temp;
desc work.nihrec1;



