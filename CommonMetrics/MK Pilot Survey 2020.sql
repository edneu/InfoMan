
drop table if exists work.pilotpi;
create table work.pilotpi as
SELECT 	Pilot_ID,
		UFID,
		AwardLetterDate,
        PI_First,
        PI_Last,
        Email,
        Title,
        Category,
        Award_Amt,
        Survey2019
FROM pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Status="Completed"
AND Award_Year>=2012;


Alter table work.pilotpi
ADD Has_GRANT int(1),
ADD Has_PUB int(1);

UPDATE work.pilotpi
SET  	Has_GRANT=0,
		Has_PUB=0;
        
UPDATE work.pilotpi pp, pilots.PILOTS_ROI_MASTER lu
SET pp.Has_GRANT=1
WHERE pp.Pilot_ID=lu.Pilot_ID;

        
UPDATE work.pilotpi pp, pilots.PILOTS_PUB_MASTER lu
SET pp.Has_PUB=1
WHERE pp.Pilot_ID=lu.Pilot_ID;

#########




SET sql_mode = '';

DROP TABLE IF EXISTS work.pilot_grant1;
Create table work.pilot_grant1 as 
SELECT * from lookup.awards_history
WHERE CLK_PI_UFID in (SELECT DISTINCT UFID from work.pilotpi  WHERE UFID<>'')
   OR CLK_AWD_PROJ_MGR_UFID in (SELECT DISTINCT UFID from work.pilotpi WHERE UFID<>'');
   
   
ALter table work.pilot_grant1
ADD Pilot_ID int(11),
ADD AggLevel varchar(12);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.pilot_grant1 
SET PIlot_ID=NULL,
	AggLevel=NULL;


UPDATE work.pilot_grant1 gr, work.pilotpi lu
SET gr.Pilot_ID=lu.Pilot_ID,
    gr.Agglevel = "Project"
WHERE lu.UFID=gr.CLK_AWD_PROJ_MGR_UFID
AND lu.UFID<>''
AND lu.AwardLetterDate<=gr.FUNDS_ACTIVATED
;



UPDATE work.pilot_grant1 gr, work.pilotpi lu
SET gr.Pilot_ID=lu.Pilot_ID,
    gr.AggLevel = "Award"
WHERE lu.UFID=gr.CLK_PI_UFID
AND lu.UFID<>''
AND lu.AwardLetterDate<=gr.FUNDS_ACTIVATED
;

DROP TABLE IF EXISTS work.pilot_possgrant;
Create table work.pilot_possgrant  AS
SELECT * from work.pilot_grant1 gr WHERE Pilot_ID is not Null;


#####################################################
## REMOVE ITEMS INCLUDED IN LAST SURVEY 

DROP TABLE IF EXISTS work.pilot_possgrant2;
Create table work.pilot_possgrant2  AS
SELECT * from work.pilot_grant1 gr WHERE Pilot_ID is not Null
;

ALTER TABLE work.pilot_possgrant2
ADD Survey2019 varchar(45),
ADD RelatedbyPI int(1),
ADD KeepPoss int(1);

UPDATE work.pilot_possgrant2
SET Survey2019=NULL ,
    RelatedbyPI=0,
    KeepPoss=1;

UPDATE work.pilot_possgrant2 pg, work.pilotpi lu
SET pg.Survey2019=lu.Survey2019
WHERE pg.Pilot_ID=lu.Pilot_ID;

SELECT DISTINCT Survey2019 from work.pilot_possgrant2;

UPDATE work.pilot_possgrant2 pg, pilots.PILOTS_ROI_MASTER lu 
SET pg.RelatedbyPI=1
WHERE pg.Pilot_ID=lu.Pilot_ID
AND pg.AggLevel=lu.AggLevel
AND pg.AggLevel="Award"
AND pg.CLK_AWD_ID=lu.CLK_AWD_ID;

UPDATE work.pilot_possgrant2 pg, pilots.PILOTS_ROI_MASTER lu 
SET pg.RelatedbyPI=1
WHERE pg.Pilot_ID=lu.Pilot_ID
AND pg.AggLevel=lu.AggLevel
AND pg.AggLevel="Project"
AND pg.CLK_AWD_PROJ_ID=lu.CLK_AWD_PROJ_ID;


UPDATE work.pilot_possgrant2 
SET KeepPoss=0
WHERE SUBSTR(Survey2019,1,8)="Complete"
AND FUNDS_ACTIVATED<=str_to_date('04,01,2019','%m,%d,%Y') ;

DELETE FROM work.pilot_possgrant2 WHERE KeepPoss=0;

/*
SELECT DISTINCT Survey2019 from  work.pilot_possgrant2;
SELECT DISTINCT(SUBSTR(Survey2019,1,8)) from  work.pilot_possgrant2;
*/

ALter table work.pilot_possgrant2 
		ADD Pilot_Title varchar(256),
        ADD Pilot_PI_Last varchar(45),
        ADD pg2_RecID int(5);

UPDATE work.pilot_possgrant2 pg, pilots.PILOTS_MASTER lu
SET pg.Pilot_Title=TRIM(lu.Title),
    pg.Pilot_PI_Last=lu.PI_Last
WHERE pg.Pilot_ID=lu.Pilot_ID;

SELECT @i:=0;
UPDATE work.pilot_possgrant2 SET pg2_RecID = @i:=@i+1;

SELECT * from  work.pilot_possgrant2;


### vERIFY PILOT AWARD records
drop table if exists work.possgr_match; 
Create Table work.possgr_match as
SELECT pg2_RecID,Pilot_ID,Pilot_PI_Last,Pilot_Title, CLK_AWD_PROJ_NAME,  INSTR(CLK_AWD_PROJ_NAME,trim(Pilot_PI_Last)),INSTR(CLK_AWD_PROJ_NAME,substr(Pilot_Title,1,5))
FROM work.pilot_possgrant2
WHERE pg2_RecID in (select pg2_RecID from work.pilot_possgrant2 WHERE CLK_AWD_PROJ_TYPE like "%Pilot%" );




## REMOVE PILOT AWARD REFERENCES
DELETE FROM work.pilot_possgrant2
WHERE CLK_AWD_PROJ_TYPE like "%Pilot%" ;

###############
drop table if exists work.possgr_match; 
Create Table work.possgr_match as
SELECT pg2_RecID,Pilot_ID,Pilot_PI_Last,Pilot_Title, CLK_AWD_PROJ_NAME,REPORTING_SPONSOR_NAME
FROM work.pilot_possgrant2
WHERE RelatedbyPI=0;
;


select REPORTING_SPONSOR_NAME,COUNT(*) FROM work.possgr_match GROUP BY REPORTING_SPONSOR_NAME;

#### verify uf grant sponsors
drop table if exists work.possgr_match; 
Create Table work.possgr_match as
SELECT pg2_RecID,Pilot_ID,Pilot_PI_Last,Pilot_Title, CLK_AWD_PROJ_NAME,REPORTING_SPONSOR_NAME
FROM work.pilot_possgrant2
where REPORTING_SPONSOR_NAME in 
('UF DIV OF SPONSORED RES MATCHING FUNDS', 
'UF DIV OF SPONSORED RES OPPORTUNITY FUND',
'UF DIV OF SPONSORED RESEARCH', 
'UF DSR OPPORTUNITY FUND', 
'UF FOU', 
'UF HEALTH SHANDS HOSPITAL', 
'UF OFFICE OF RESEARCH', 
'UF RESEARCH FOU', 
'UF RESEARCH FOU SALARY EXPENSE TRANSFERS', 
'UF RESEARCH FOUNDATION', 
'UNIV OF FLORIDA');

##DELETE EXACT PILOT MATCHES FROM UF SPONSOR
DELETE FROM work.pilot_possgrant2 
WHERE pg2_RecID IN
(1,2,3,115,116,261,262,3524,3533,3534,3535,4313,4316,1021,1022,
1023,1025,1026,1092,1093,142,143,144,145,254,255,4018,4037,4038,4039,4734,
4735,4336,4337,4338,4340,4661,4662,949,950,951,970,971,1584,1585,1586,1587,
1590,1815,1816,2616,2660,2661,2662,3056,3103,1504,1505,1508,1509,1610,1611,
1811,1812,1813,1814,2216,2237,4844,4845,4846,4847,4848,4849,4850,5208,5209,
4241,4242,4243,4244,4245,4322,4323,1529,1530,1531,1532,1533,1534,1535,1817,
1821,3767,3768,3769,3770,3771,3772,3784,3785,3786,3805,4739,4740,4741,4742,

4064,4065,4066,4067,4074,
4718,4719,2504,2505,2514,2515,2566,3131,3132,4098,5359,5384,5765,5766,5792,
5793,765,766,767,768,1089,1090,4396,4397,4398,4399,4696,4697,355,356,357,
358,359,626,627,870,872,873,874,875,876,877,878,879,880,881,889,890,891,
892,893,968,969,504,505,506,507,628,629,1854,1855,1857,1858,2206,2208,

2087,2088,2089,2090,2367,2368,
2369,2370,2371,2372,1566,1567,1568,1569,1570,1571,1572,1573,1574,1575,1576,1577,1976,1977,
1978,1985,1986,1987,1988,1989,1994,1995,1996,2001,972,973,976,977,978,5017,
5018,5019,5211,5212,4610,4611,4612,5147,5148,974,975,5027,4281,4282,4609);


### Check for SubProjects duplicated with Awards
SELECT pg2_RecID,Pilot_ID,AggLevel,CLK_AWD_ID,CLK_AWD_PROJ_ID
from work.pilot_possgrant2
WHERE AggLevel="Project"
AND CLK_AWD_ID in (SELECT DISTINCT CLK_AWD_ID from work.pilot_possgrant2 WHERE AggLevel="Award");


SELECT pg2_RecID,Pilot_ID,AggLevel,CLK_AWD_ID,CLK_AWD_PROJ_ID from work.pilot_possgrant2
WHERE Pilot_ID=67;

## OK


####################################################


SELECT Pilot_ID,Pilot_PI_Last,Pilot_Title, CLK_AWD_PROJ_NAME, INSTR(CLK_AWD_PROJ_NAME,trim(Pilot_PI_Last)), INSTR(CLK_AWD_PROJ_NAME,substr(Pilot_Title,1,5))
FROM work.possgr_match;


select CLK_AWD_PROJ_TYPE, count(*) from work.pilot_possgrant2 WHERE CLK_AWD_PROJ_TYPE like "%Pilot%" group by CLK_AWD_PROJ_TYPE;

select * from work.pilot_possgrant2 WHERE CLK_AWD_PROJ_TYPE like "%Pilot%" ;
################################################################
################################################################

drop table if exists work.temp;
create table work.temp as
SELECT 	Pilot_ID, 	
		count(distinct CLK_AWD_ID) AS NumAwards,
		count(distinct CLK_AWD_PROJ_ID) AS NumProj,
        sum(SPONSOR_AUTHORIZED_AMOUNT) as Totamt
FROM  work.pilot_possgrant2
GROUP BY Pilot_ID;       


Alter table work.pilotpi  	ADD NPossAWD int(11),
							ADD NPossProj int(11),
                            ADD PossTotlal decimal(65,10);
                      
                      
 UPDATE work.pilotpi pi
 SET NPossAWD=Null,
     NPossProj=Null,
     PossTotlal=Null;
                      
                            
UPDATE work.pilotpi pi, work.temp lu
SET pi.NPossAWD=lu.NumAwards,
	pi.NPossProj=lu.NumProj,
    pi.PossTotlal=lu.Totamt
WHERE pi.Pilot_ID = lu.Pilot_ID;




desc pilots.PILOTS_ROI_MASTER;


DROP TABLE IF EXISTS work.pilot_possgrantAgg;
Create table work.pilot_possgrantAgg  AS
Select 
pg.Pilot_ID,
pg.AggLevel,
pg.CLK_AWD_ID,
"" AS CLK_AWD_PROJ_ID,
Concat(pm.PI_LAST,", ", PI_FIRST) AS PilotPI,
pm.UFID AS PilotPI_UFID,
min(Year(pg.FUNDS_ACTIVATED)) AS Year_Activiated,
min(pg.FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
min(pg.CLK_AWD_PI) AS CLK_AWD_PI,
min(pg.CLK_PI_UFID) AS CLK_PI_UFID,
min(pg.CLK_AWD_PROJ_MGR) AS CLK_AWD_PROJ_MGR,
min(pg.CLK_AWD_PROJ_MGR_UFID) AS CLK_AWD_PROJ_MGR_UFID,
min(pg.REPORTING_SPONSOR_NAME) AS REPORTING_SPONSOR_NAME,
min(pg.REPORTING_SPONSOR_AWD_ID) AS REPORTING_SPONSOR_AWD_ID,
min(pg.CLK_AWD_PROJ_NAME) AS CLK_AWD_PROJ_NAME
FROM work.pilot_possgrant2 pg LEFT JOIN pilots.PILOTS_MASTER pm
ON pg.Pilot_ID=pm.Pilot_ID
WHERE AggLevel="Award"
GROUP BY 
		Pilot_ID,
		AggLevel,
		CLK_AWD_ID,
        "",
		Concat(pm.PI_LAST,", ", PI_FIRST),
		pm.UFID 
UNION ALL
Select 
pg.Pilot_ID,
pg.AggLevel,
"" AS CLK_AWD_ID,
pg.CLK_AWD_PROJ_ID,
Concat(pm.PI_LAST,", ", PI_FIRST) AS PilotPI,
pm.UFID AS PilotPI_UFID,
min(Year(pg.FUNDS_ACTIVATED)) AS Year_Activiated,
min(pg.FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
min(pg.CLK_AWD_PI) AS CLK_AWD_PI,
min(pg.CLK_PI_UFID) AS CLK_PI_UFID,
min(pg.CLK_AWD_PROJ_MGR) AS CLK_AWD_PROJ_MGR,
min(pg.CLK_AWD_PROJ_MGR_UFID) AS CLK_AWD_PROJ_MGR_UFID,
min(pg.REPORTING_SPONSOR_NAME) AS REPORTING_SPONSOR_NAME,
min(pg.REPORTING_SPONSOR_AWD_ID) AS REPORTING_SPONSOR_AWD_ID,
min(pg.CLK_AWD_PROJ_NAME) AS CLK_AWD_PROJ_NAME
FROM work.pilot_possgrant2 pg LEFT JOIN pilots.PILOTS_MASTER pm
ON pg.Pilot_ID=pm.Pilot_ID
WHERE AggLevel="Project"

GROUP BY 
		Pilot_ID,
		AggLevel,
        "",
		CLK_AWD_PROJ_ID,
		Concat(pm.PI_LAST,", ", PI_FIRST),
		pm.UFID         ;
        
        
        
drop table if exists work.pilotmatch;
create table work.pilotmatch as
Select 
pg.Pilot_ID,
pm.Category,
pg.AggLevel,
pg.CLK_AWD_ID,
pg.CLK_AWD_PROJ_ID,
pg.REPORTING_SPONSOR_NAME,
pg.FUNDS_ACTIVATED,
pm.AwardLetterDate AS Pilot_date,
pg.CLK_AWD_PROJ_NAME,
pm.Title As Pilot_title
from work.pilot_possgrantAgg pg LEFT JOIN pilots.PILOTS_MASTER pm ON pg.Pilot_ID=pm.Pilot_ID
ORDER BY pg.Pilot_ID, pg.FUNDS_ACTIVATED;



        
        
Select Pilot_ID,count(*) from work.pilot_possgrantAgg group by Pilot_ID;   
Select count(distinct Pilot_ID) from work.pilot_possgrantAgg;     

select * from work.pilot_possgrantAgg ; 

select * from lookup.ufids where UF_UFID='00063839';
MArg OH
select * from lookup.Employees where Employee_ID='00063839';



#############################
SELECT * from pilots.PILOTS_ROI_MASTER;



select * from work.pilotpi;


select * from lookup.Employees WHERE Name like 'Mitchell%D%';

select * from lookup.ufids where UF_UFID='06031259';








select sum(Has_GRANT), SUM(Has_PUB), count(*) from work.pilotpi;







