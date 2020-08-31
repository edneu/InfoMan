
select * from crc.crc_time_all_years;

drop table if exists crc.timerept;
Create table crc.timerept AS
select * from crc.crc_time_all_years;

ALTER TABLE crc.timerept
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15);

SET SQL_SAFE_UPDATES = 0;

UPDATE crc.timerept SET MONTH=concat(YEAR(Date_Used),"-",LPAD(MONTH(Date_Used),2,"0")) ;
UPDATE crc.timerept SET SvcMon = substr(Month,6,2);
UPDATE crc.timerept SET SvcYear = substr(Month,1,4);


UPDATE crc.timerept SET SFY="SFY 2017-2018"
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

UPDATE crc.timerept SET SFY="SFY 2018-2019"
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

UPDATE crc.timerept SET SFY="SFY 2019-2020"
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

UPDATE crc.timerept SET SFY="SFY 2020-2021"
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

drop table if exists crc.UFtimeMonSumm;
Create table crc.UFtimeMonSumm AS
SELECT 	"UFHealth" as Employer,
        tr.SFY,
        tr.Month,
		tr.Employee_ID,
        tr.Name,
        round(SUM(tr.Quantity),2) AS HoursWorked,
        Min(ah.Avail_hours) as Avail_hours
from crc.timerept tr 
LEFT JOIN crc.avail_hours ah
ON tr.Month=ah.Month
GROUP BY "UFHealth",tr.SFY,tr.Month,tr.Employee_ID,tr.Name;


####################################################################
## SHANDS
drop table if exists crc.shandstime;
Create table crc.shandstime AS
select * from crc.shands_shifts;


ALTER TABLE crc.shandstime
ADD Month varchar(7),
ADD SvcMon varchar(2),
ADD SvcYear varchar(4),
ADD SFY varchar(15),
ADD  HoursWorked decimal(65,11),
ADD Avail_hours int(11);

SET SQL_SAFE_UPDATES = 0;

UPDATE crc.shandstime SET MONTH=concat(YEAR(Apply_Date),"-",LPAD(MONTH(Apply_Date),2,"0")) ;
UPDATE crc.shandstime SET SvcMon = substr(Month,6,2);
UPDATE crc.shandstime SET SvcYear = substr(Month,1,4);
UPDATE crc.shandstime SET HoursWorked=TIME_TO_SEC(timediff(Shift_End_Time_,Shift_Start_Time_))/3600;


UPDATE crc.shandstime SET SFY="SFY 2017-2018"
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

UPDATE crc.shandstime SET SFY="SFY 2018-2019"
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

UPDATE crc.shandstime SET SFY="SFY 2019-2020"
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

UPDATE crc.shandstime SET SFY="SFY 2020-2021"
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



select * from crc.shandstime;

drop table if exists crc.ShandstimeMonSumm;
Create table crc.ShandstimeMonSumm AS
SELECT 	"Shands" as Employer,
        tr.SFY,
        tr.Month,
		tr.ID as Employee_ID,
        tr.Name,
        round(SUM(tr.HoursWorked),2) AS HoursWorked,
        Min(ah.Avail_hours) as Avail_hours
from crc.shandstime tr 
LEFT JOIN crc.avail_hours ah
ON tr.Month=ah.Month
GROUP BY "Shands",tr.SFY,tr.Month,tr.ID,tr.Name;


drop table if exists crc.TimeMonSumm;
Create table crc.TimeMonSumm AS
SELECT * from crc.UFtimeMonSumm
UNION ALL 
SELECT * from crc.ShandstimeMonSumm;


drop table if exists crc.emplist;
Create table crc.emplist AS

SELECT  Name,
		Employer,
		Employee_ID
from crc.TimeMonSumm
group by Name,
		Employer,
		Employee_ID
order by Name;        
        
        