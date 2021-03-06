select * from crc.room_1238;

select * from crc.room_1238 WHERE TimeOut<TImeIn;


SET SQL_SAFE_UPDATES = 0;


UPDATE crc.room_1238
SET TimeOut=DATE_ADD(TimeOut, INTERVAL 1 DAY)
WHERE TimeOut<TImeIn;


ALTER TABLE crc.room_1238
ADD MONTH varchar(12),
ADD Duration int(11),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15);

SET SQL_SAFE_UPDATES = 0;


ALTER TABLE crc.room_1238
ADD Duration int(11);

UPDATE crc.room_1238
SET Duration=ROUND(time_to_sec(TIMEDIFF(TimeOut,TImeIn))/60,0);


UPDATE crc.room_1238
SET MONTH=concat(YEAR(DATE),"-",LPAD(MONTH(DATE),2,"0")) ;
;


UPDATE crc.room_1238 SET SvcMon = substr(Month,6,2);
UPDATE crc.room_1238 SET SvcYear = substr(Month,1,4);


UPDATE crc.room_1238 SET SFY="SFY 2017-2018"
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

UPDATE crc.room_1238 SET SFY="SFY 2018-2019"
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

UPDATE crc.room_1238 SET SFY="SFY 2019-2020"
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

UPDATE crc.room_1238 SET SFY="SFY 2020-2021"
WHERE Month IN (
'2020-07',
'2020-08',
'2020-09',
'2020-10',
'2020-11',
'2020-12',
'2021-01',
'2021-02',
'2021-03',
'2021-04',
'2021-05',
'2021-06');


##### ALL SAME ROOM Need to set Avail Hours By Month 

DROP TABLE IF EXISTS crc.temp1328A;
create table crc.temp1328A AS
SELECT MONTH,
SUM(Duration/60) As Hours_Used
from crc.room_1238 
WHERE Status NOT IN ('Request cancelled')
GROUP BY MONTH;


/*    
  ;
 select distinct Status from crc.room_1238      ;   
Completed
Request cancelled
Scheduled
Stopped prematurely
No-show
*/






ALTER TABLE crc.temp1328A
ADD Avail_Hours int(11),
ADD UnusedHours decimal(65,10),
ADD URate decimal(65,10),
ADD PCTnotUsed decimal(65,10);


UPDATE crc.temp1328A cu, crc.avail_hours lu
SET cu.Avail_Hours = lu.Avail_hours
WHERE cu.Month=lu.Month;

UPDATE crc.temp1328A
SET UnusedHours=Avail_Hours-(Hours_Used) ,
    URate=Hours_Used/Avail_Hours, 
    PCTnotUsed=1-(Hours_Used/Avail_Hours) ;
    
ALTER TABLE crc.temp1328A



 select * from crc.temp1328A ;
 
 SELECT SUM(Hours_Used) AS Hours_Used,
		SUM(Avail_Hours) AS Avail_Hours,
        SUM(UnusedHours) AS UnusedHours,
        SUM(Hours_Used)/Sum(Avail_Hours) AS URate,
        (Sum(Avail_Hours)-SUM(Hours_Used))/Sum(Avail_Hours) as PCTnotUsed
 FROM crc.temp1328A;  
 
 
 ############
 SELECT SUM(Hours_Used) AS Hours_Used,
		SUM(Avail_Hours) AS Avail_Hours,
        SUM(UnusedHours) AS UnusedHours,
        COUNT(DISTINCT Month) as  nMonth
 FROM crc.temp1328A; 
 
 #################################################################
 
DROP TABLE IF EXISTS crc.temp1328lu;
create table crc.temp1328lu AS
SELECT MONTH,
	   trim(User) as User,
       SUM(DURATION/60) AS HoursUsed  
from crc.room_1238
GROUP BY MONTH, User;


DROP TABLE IF EXISTS crc.temp1328B;
create table crc.temp1328B AS
SELECT DISTINCT Month from crc.room_1238
ORDER BY MONTH;
        
ALTER TABLE crc.temp1328B
	ADD Vandenborne decimal(65,10),
	ADD Lott decimal(65,10),
	ADD George decimal(65,10),
	ADD Avail_Hours decimal(65,10);
    
SET SQL_SAFE_UPDATES = 0;
    
UPDATE crc.temp1328B cr,   crc.temp1328lu lu
SET cr.Vandenborne=lu.HoursUsed
WHERE lu.User='Vandenborne '
AND cr.Month=lu.Month ;

UPDATE crc.temp1328B cr,   crc.temp1328lu lu
SET cr.Lott=lu.HoursUsed
WHERE lu.User='Lott'
AND cr.Month=lu.Month ;

UPDATE crc.temp1328B cr,   crc.temp1328lu lu
SET cr.George=lu.HoursUsed
WHERE lu.User='George '
AND cr.Month=lu.Month ;

UPDATE crc.temp1328B cu, crc.avail_hours lu
SET cu.Avail_Hours = lu.Avail_hours
WHERE cu.Month=lu.Month;


UPDATE crc.temp1328B SET Vandenborne=0 WHERE Vandenborne IS NULL and Avail_Hours IS NOT NULL;
UPDATE crc.temp1328B SET Lott=0 WHERE Lott IS NULL and Avail_Hours IS NOT NULL;
UPDATE crc.temp1328B SET George=0 WHERE George IS NULL and Avail_Hours IS NOT NULL;


select * from crc.temp1328B;