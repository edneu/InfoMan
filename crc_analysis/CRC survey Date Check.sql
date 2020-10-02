

select * from ctsi_webcamp_pr.databasestructuredescriptions;


select * from ctsi_webcamp_pr.databasestructuredescriptions WHERE FIELDNAME like "%Proto%def%";

MANDOPROJECTTYPES

MANDOPROJECTTYPES

USR

select * from ctsi_webcamp_pr.usr

desc ctsi_webcamp_pr.usr;

select MANDOPROJECTTYPES from ctsi_webcamp_pr.usr;

drop table if exists ctsi_webcamp_adhoc.CRC_Dates ;
CREATE TABLE ctsi_webcamp_adhoc.CRC_Dates AS
SELECT 	pl.UNIQUEFIELD AS Protocol_ID, 
		pl.protocol AS CRC_Number,
        lu.LASTNAME AS PI_Lastname,
        lu.FIRSTNAME As PI_FirstName,
        pl.LONGTITLE AS TITLE,
        pl.EXPSTART,
		pl.EXPSTARTDATACOLLECTION,
		pl.EXPENDDATACOLLECTION,
        pl.DATACOLLECTIONSTARTDATE,
		pl.DATACOLLECTIONENDDATE,
		pl.DATEFIRSTSUBJECTACCRUED,
		pl.DATECLOSEDTOACCRUAL,
		pl.AWARDSTARTDATE,
		pl.AWARDENDDATE
from ctsi_webcamp_pr.protocol pl LEFT JOIN ctsi_webcamp_pr.person lu ON pl.PERSON=lu.UNIQUEFIELD
WHERE protocol in
('1448','1456','1459','1465','1471','1373','1382','1481','1306','1307','1341','1358','1410','1491','1400','342',
'1005','1007','1103','1106','1106.2','1240','1272','1285','1288','1381','1422','1526','809','1061','1345','1359','1454','1549','699',
'910','1402','1273','1303','1320','1433','859','1370','1401','1420','1473','1360','1100','1376','1444','1485','1515',
'1437','1377','1158','1321','1330','1470','1125','1194','1225','1327','1407','1480','1482','1496','1497','564','893','908',
'1383','1371','1451','1167','1228','1353','1375','1423','1034','1234','1349','1428','1461','1174','1176','1501',
'1032','1036','958','1040','1391','1490','1369','1379','1418','1429','1296A','1143A','1264','1291','1346','1388',
'1405','678','182','1147','1082','1552','1024','1186','1298','1325','1478','1519','1289A','1026','1445',
'600','804','1159A','1253','1397','1492','1304','1453','1315','1187','1311','1398','1499')
ORDER BY lu.LASTNAME, CRC_Number;

 
 ALTER TABLE ctsi_webcamp_adhoc.CRC_Dates
 ADD FirstVisit datetime,
 ADD LastVisit datetime;
 
 drop table if exists ctsi_webcamp_adhoc.visittemp;
 CREATE TABLE ctsi_webcamp_adhoc.visittemp as
 SELECT PROTOCOL AS Protocol_ID,
		min(VISITDATE) AS FirstVisit,
		max(VISITDATE) AS LastVisit 
  FROM ctsi_webcamp_pr.opvisit
  WHERE PROTOCOL IN (SELECT DISTINCT  Protocol_ID from ctsi_webcamp_adhoc.CRC_Dates)
  GROUP BY PROTOCOL;
 
 SET SQL_SAFE_UPDATES = 0;
 UPDATE ctsi_webcamp_adhoc.CRC_Dates cd, ctsi_webcamp_adhoc.visittemp lu
 SET 	cd.FirstVisit=lu.FirstVisit,
		cd.LastVisit=lu.LastVisit
WHERE cd.Protocol_ID=lu.Protocol_ID;
 