
select * from crc.crc_occ_fy_2017_2020 ;



ALTER TABLE crc.crc_occ_fy_2017_2020 
ADD Avail_Hours int(5),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15);

SET SQL_SAFE_UPDATES = 0;


UPDATE crc.crc_occ_fy_2017_2020 cu, crc.avail_hours lu
SET cu.Avail_Hours = lu.Avail_hours
WHERE cu.Month=lu.Month;

UPDATE crc.crc_occ_fy_2017_2020 SET SvcMon = substr(Month,6,2);
UPDATE crc.crc_occ_fy_2017_2020 SET SvcYear = substr(Month,1,4);

UPDATE crc.crc_occ_fy_2017_2020 SET SFY="SFY 2017-2018"
WHERE Month IN (
'2017-07',
'2017-08',
'2017-09',
'2017-10',
'2017-11',
'2017-12',
'2018-01',
'2018-02',
'2018-03',
'2018-04',
'2018-05',
'2018-06');

UPDATE crc.crc_occ_fy_2017_2020 SET SFY="SFY 2018-2019"
WHERE Month IN (
'2018-07',
'2018-08',
'2018-09',
'2018-10',
'2018-11',
'2018-12',
'2019-01',
'2019-02',
'2019-03',
'2019-04',
'2019-05',
'2019-06');

UPDATE crc.crc_occ_fy_2017_2020 SET SFY="SFY 2019-2020"
WHERE Month IN (
'2019-07',
'2019-08',
'2019-09',
'2019-10',
'2019-11',
'2019-12',
'2020-01',
'2020-02',
'2020-03',
'2020-04',
'2020-05',
'2020-06');


## Overall
SELECT 
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020;

## BY SFY
SELECT 
SFY,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by SFY;

## Month of eavch year (seasonal)
SELECT 
SvcMon,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by SvcMon;


## by Room (Bed)
SELECT 
Bed,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by Bed;


## Month and SFY for graph (seasonal)
SELECT 
SFY,SvcMon,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by SFY,SvcMon;

## FOR TIME SERIES CHART
SELECT 
Month,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by Month;


#For Room servies months Adustment
SELECT Bed,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
Count(Distinct Month)
from crc.crc_occ_fy_2017_2020
group by Bed;


#
SELECT 
MONTH,
BED AS ROOM,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by Month, Bed;

DROP TABLE IF EXISTS work.Temp1;
create table work.Temp1 AS
select Bed
FROM crc.crc_month_room_occ
GROUP BY Bed; 
#
SELECT 
Month,
SUM(Hours_Used) AS Hours_Used, 
Sum(Avail_Hours) as Avail_Hours,
Sum(Avail_Hours)-SUM(Hours_Used) AS UnusedHours,
SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
(Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
from crc.crc_occ_fy_2017_2020
group by Month;


drop table if Exists crc.load1328;
create table crc.load1328 AS
SELECT 
	MONTH AS Month,
	max("1238") AS Bed,
	sum(Duration)/60 AS Hours_Used,
	max(SvcMon) AS SvcMon,
	max(SvcYear) AS SvcYear,
	max(SFY) AS SFY
from crc.room_1238
GROUP BY Month;

ALTER TABLE crc.load1328
	ADD crc_occ_id int(11),
    ADD Occupancy1 Decimal(65,20),
	ADD le2hr int(11),
	ADD le4hr int(11),
	ADD le8hr int(11),
	ADD gt8hr int(11),
	ADD Extended int(11),
	ADD Weekend int(11),
    ADD Overnight int(11),
	ADD Avail_Hours int(5);
    
    
UPDATE crc.load1328 lf, crc.avail_hours lu
SET lf.Avail_Hours=lu.Avail_hours
WHERE lf.Month=lu.Month ;   

UPDATE crc.load1328 SET Occupancy1=Hours_Used/Avail_Hours;


     SET SQL_SAFE_UPDATES = 0;
      UPDATE crc.load1328 SET crc_occ_id = 0 ;
      SELECT @i:=(SELECT max(crc_occ_id) from crc.crc_occ_fy_2017_2020);
      UPDATE crc.load1328  SET crc_occ_id = @i:=@i+1;





drop table if exists crc.crc_month_room_occ;
create table crc.crc_month_room_occ AS 
SELECT * from crc.crc_occ_fy_2017_2020
UNION ALL
select crc_occ_id,
		Month,
        Bed,
        Hours_Used,
        Occupancy1,
        le2hr,
        le4hr,
        le8hr,
        gt8hr,
        Overnight,
        Extended,
        Weekend,
        SvcMon,
        SvcYear,
        SFY,
        Avail_Hours
from crc.load1328 WHERE Avail_Hours is NOT NULL;

select * from crc.load1328;
select * from crc.crc_month_room_occ;