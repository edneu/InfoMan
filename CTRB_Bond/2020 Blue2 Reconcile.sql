

Select * from space.ctrb_alloc_2020;
WHERE DEPTID IN (SELECT DISTINCT DEPTID FROM space.colonylistdept WHERE Zone="Blue2");

select * from space.colonylist;


select * from space.ctrb_occs_2020;


SELECT DEPTID,DEPT_NAME,count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_alloc_2020
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;


SELECT DEPTID,DEPT_NAME,count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_alloc_2019
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;



(DR_11+OSA_17) AS RschPct,
       TOTAL_00-(DR_11+OSA_17) AS NonRschPct
       
       
       
SELECT DEPTID,DEPT_NAME,count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_occs_2020
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;


SELECT DEPTID,DEPT_NAME,count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_occ_2019
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;



SELECT  max(2019) as SFY, Count(*) as nREC, Count(distinct Person_ID) as UNDUP, Sum(Earnings+Estimated_Fringe) AS Amt, Sum(Earnings+Estimated_Fringe)*1.046 AS AdjAmt from space.salary2019
UNION ALL
SELECT  max(2020) as SFY, Count(*) as nREC, Count(distinct Person_ID) as UNDUP, Sum(Earnings+Estimated_Fringe) AS Amt, Sum(Earnings+Estimated_Fringe)*1.052 AS AdjAmt from space.salary2020;




SELECT DEPTID,DEPT_NAME,AVG((DR_11+OSA_17)) AS RschPct, AVG(TOTAL_00-(DR_11+OSA_17)) AS NonRschPct, count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_alloc_2020
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;


SELECT DEPTID,DEPT_NAME,AVG((DR_11+OSA_17)) AS RschPct, AVG(TOTAL_00-(DR_11+OSA_17)) AS NonRschPct, count(*) AS nRecs,SUM(AREA) AS Area
FROM space.ctrb_alloc_2019
GROUP BY DEPTID,DEPT_NAME
ORDER BY DEPTID,DEPT_NAME;


select * from  space.ctrb_alloc_2020;




select min(Pay_End_Date), MAX(Pay_End_Date) from space.salary2020;

drop table if exists work.suballoc;
create table work.suballoc as 
SELECT ROOM,DEPTID,DEPT_NAME,TOTAL_00,INST_01,SPINST_10,DR_11,OR_12,AGEXT_13,PS_14,DA_15,SPA_16,OSA_17,OIA_18,AUX_UF,SA_19,GA_20,LIB_21,OM_22,PC_23,VAC_29,GOV_30,UA_31,PPA_32 
from  space.ctrb_alloc_2020;


desc space.ctrb_alloc_2020;

drop table if exists space.allocrecon2020;
create table space.allocrecon2020 AS
SELECT * from work.suballoc LIMIT 0;

INSERT INTO space.allocrecon2020 (ROOM,DEPTID,DEPT_NAME)
SELECT ROOM,DEPTID,DEPT_NAME from space.ctrb_alloc_2019
UNION ALL 
SELECT ROOM,DEPTID,DEPT_NAME from space.ctrb_alloc_2020
WHERE CONCAT(ROOM,DEPTID,DEPT_NAME) NOT IN (SELECT DISTINCT CONCAT(ROOM,DEPTID,DEPT_NAME) from space.ctrb_alloc_2019);


DESC space.ctrb_alloc_2020;


SELECT count(*),Count(Distinct Room) from space.ctrb_alloc_2020;  #437
SELECT count(*),Count(Distinct Room) from space.ctrb_alloc_2019;  #600
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
###########################################################################################################
##### ALLOCA RECONCIE TABLE

drop table if Exists space.alloctest;
create table space.alloctest as
SELECT BLDG_NAME,ROOM from space.ctrb_alloc_2019 group by  BLDG_NAME,ROOM  ;

ALTER TABLE space.alloctest
            ADD DEPTID_19 varchar(12), 
            ADD DEPTID_20 varchar(12), 
			ADD DEPT_19 varchar(45), 
            ADD DEPT_20 varchar(45),
            ADD AREA_19 decimal(65,30),
            ADD AREA_20 decimal(65,30),
            ADD TOT_19 int(11),
            ADD TOT_20 int(11),
            ADD DR_11_19 int(11),
            ADD DR_11_20 int(11),            
            ADD OSA_17_19 int(11),
            ADD OSA_17_20 int(11),
            ADD RSCH_PCT_19 int(11),
            ADD RSCH_PCT_20 int(11),
            ADD NON_RSCH_PCT_19 int(11),
            ADD NON_RSCH_PCT_20 int(11),
            ADD ZONE_19 varchar(12),
            ADD ZONE_20 varchar(12),
            ADD OMIT_19 int(1),
            ADD OMIT_20 int(1);
            
 UPDATE space.alloctest allc, space.ctrb_alloc_2019 lu
 SET allc.DEPTID_19=lu.DEPTID,
     allc.DEPT_19=lu.DEPT_NAME, 
     allc.AREA_19=lu.AREA,
     allc.TOT_19=lu.TOTAL_00,
     allc.DR_11_19=lu.DR_11,
     allc.OSA_17_19=lu.OSA_17,
     allc.RSCH_PCT_19=lu.DR_11+lu.OSA_17,
     allc.NON_RSCH_PCT_19=(lu.TOTAL_00-(lu.DR_11+lu.OSA_17)),
     allc.OMIT_19=0
WHERE allc.ROOM=lu.ROOM     ;
  
  UPDATE space.alloctest allc, space.ctrb_alloc_2020 lu
 SET allc.DEPTID_20=lu.DEPTID,
     allc.DEPT_20=lu.DEPT_NAME, 
     allc.AREA_20=lu.AREA,
     allc.TOT_20=lu.TOTAL_00,
     allc.DR_11_20=lu.DR_11,
     allc.OSA_17_20=lu.OSA_17,
     allc.RSCH_PCT_20=lu.DR_11+lu.OSA_17,
     allc.NON_RSCH_PCT_20=(lu.TOTAL_00-(lu.DR_11+lu.OSA_17)),
     allc.OMIT_20=0
WHERE allc.ROOM=lu.ROOM;       ; 


UPDATE space.alloctest allc, space.colonylistdept lu
SET allc.ZONE_19=lu.Zone
WHERE allc.DEPTID_19=lu.DEPTID;

UPDATE space.alloctest allc, space.colonylistdept lu
SET allc.ZONE_20=lu.Zone
WHERE allc.DEPTID_20=lu.DEPTID;


SELECT * from space.alloctest;


Select Sum(AREA_19),Sum(AREA_20) from space.alloctest Where ZONE_20="BLUE2"
UNION ALL
Select Sum(AREA_19),Sum(AREA_20) from space.alloctest Where ZONE_19="BLUE2";



SELECT * from space.alloctest where ZONE_19<>ZONE_20;

SELECT * from space.alloctest WHERE RSCH_PCT_19<>RSCH_PCT_20;

SELECT * FROM space.ctrb_occs_2020 WHERE ROOM IN (SELECT ROOM from space.alloctest WHERE RSCH_PCT_19<>RSCH_PCT_20);

SELECT * from space.alloctest WHERE DEPT_20 IS NULL AND ZONE_20="BLUE2";


SELECT Room,COUNT(*) from space.ctrb_occ_2019 group by Room;

SELECT Room,COUNT(*) from space.ctrb_occs_2020 group by Room;



################################################################################
################################################################################
################################################################################
### VERIFY 2020 Allocate file
DROP TABLE if exists space.reconalloc;
CREATE TABLE space.reconalloc as
SELECT DISTINCT ROOM from space.ctrb_occ_2019
UNION ALL
SELECT DISTINCT ROOM from space.ctrb_occs_2020
WHERE ROOM NOT IN (SELECT DISTINCT ROOM from space.ctrb_occ_2019);

select * from space.reconalloc;

SELECT COUNT(DISTINCT ROOM) from space.reconalloc;

ALTER TABLE space.reconalloc
	ADD IN_2019 int(1),
	ADD IN_2020 int(1),
    ADD OMIT_2019 int(1),
    ADD OMIT_2020 int(1),
    ADD ZONE_2019 varchar(12),
    ADD ZONE_2020 varchar(12),
    
	ADD DEPTID_2019 varchar(12),
	ADD DEPT_2019 varchar(45),
	ADD DEPTID_2020 varchar(12),
	ADD DEPT_2020 varchar(45),

	ADD DR_11_2019 int(11),
	ADD OSA_17_2019 int(11),
	ADD TOTAL_00_2019 int(11),
	ADD RSCH_PCT_2019 int(11),


	ADD DR_11_2020 int(11),
	ADD OSA_17_2020 int(11),
	ADD TOTAL_00_2020 int(11),
	ADD RSCH_PCT_2020 int(11);



UPDATE space.reconalloc ra, space.ctrb_alloc_2019 lu
SET IN_2019=0,
	IN_2020=0,
    OMIT_2019=0, 
    OMIT_2020=0;

UPDATE space.reconalloc ra, space.ctrb_alloc_2019 lu
SET ra.IN_2019=1,
	ra.DEPTID_2019=lu.DEPTID ,
	ra.DEPT_2019=lu.DEPT_NAME,	
	ra.DR_11_2019=lu.DR_11,
	ra.OSA_17_2019=lu.OSA_17,
	ra.TOTAL_00_2019=lu.TOTAL_00,
	ra.RSCH_PCT_2019=(lu.DR_11+lu.OSA_17)
WHERE ra.ROOM=lu.ROOM;


UPDATE space.reconalloc ra, space.ctrb_alloc_2020 lu
SET ra.IN_2020=1,
	ra.DEPTID_2020=lu.DEPTID ,
	ra.DEPT_2020=lu.DEPT_NAME,	
	ra.DR_11_2020=lu.DR_11,
	ra.OSA_17_2020=lu.OSA_17,
	ra.TOTAL_00_2020=lu.TOTAL_00,
	ra.RSCH_PCT_2020=(lu.DR_11+lu.OSA_17)
WHERE ra.ROOM=lu.ROOM;


## FLAG AGING
UPDATE space.reconalloc
       SET OMIT_2019=1
       WHERE DEPTID_2019 IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');

UPDATE space.reconalloc
       SET OMIT_2020=1
       WHERE DEPTID_2020 IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');

##  ADD ZONE
UPDATE space.reconalloc rac, space.colonylistdept lu
SET rac.ZONE_2019=lu.Zone
WHERE rac.DEPTID_2019=lu.DEPTID;

UPDATE space.reconalloc rac, space.colonylistdept lu
SET rac.ZONE_2020=lu.Zone
WHERE rac.DEPTID_2020=lu.DEPTID;

select * from space.reconalloc where ZONE_2019="BLUE2" OR ZONE_2020="BLUE2";

select RSCH_PCT_2019,RSCH_PCT_2020 from space.reconalloc where ZONE_2019="BLUE2" OR ZONE_2020="BLUE2" AND RSCH_PCT_2019>RSCH_PCT_2020;


DROP TABLE IF EXISTS space.allocate;
CREATE TABLE space.ctrb_alloc_2020_V2 AS
SELECT * from sspace.ctrb_alloc_2020_V2;

UPDATE space.ctrb_alloc_2020_V2 v2, space.reconalloc lu
SET v2.DR_11=lu.DR_11_2019,
	v2.OSA_17=lu.OSA_17_2019,
    v2.TOTAL_00=lu.TOTAL_00_2019
WHERE v2.ROOM=lu.ROOM
  AND lu.RSCH_PCT_2020 IS NULL
  AND lu.ZONE_2020="BLUE2";

select TOTAL_00_2019,TOTAL_00_2020,RSCH_PCT_2019,RSCH_PCT_2020 from space.reconalloc where ZONE_2019="BLUE2" OR ZONE_2020="BLUE2";

