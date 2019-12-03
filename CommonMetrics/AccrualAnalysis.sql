

drop table if exists work.oncore;
create table work.oncore as
select * from Adhoc.oncore1;


Select * from work.oncore;


Select PROTOCOL_TYPE,count(*) from work.oncore group by PROTOCOL_TYPE;



Select ACCRUAL_SUMMARY,count(*) from work.oncore group by ACCRUAL_SUMMARY;


Select TARGET_ACCRUAL,count(*) from work.oncore group by TARGET_ACCRUAL;
Select UF_ACCRUAL,count(*) from work.oncore group by UF_ACCRUAL;
Select DAYS_PLANNED,count(*) from work.oncore group by DAYS_PLANNED;


SELECT COUNT(*) from work.oncore WHERE UF_ACCRUAL>TARGET_ACCRUAL;
SELECT COUNT(*) from work.oncore WHERE UF_ACCRUAL>TARGET_ACCRUAL AND TARGET_ACCRUAL=0;

SELECT * from work.oncore WHERE UF_ACCRUAL>TARGET_ACCRUAL;

ALTER TABLE work.oncore
ADD TarAcrlMiss int(1),
ADD DayPlanMiss int(1),
ADD UFAccrlMiss int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.oncore
SET TarAcrlMiss=0,
	DayPlanMiss=0,
    UFAccrlMiss=0;



UPDATE work.oncore 
	SET TarAcrlMiss=1
	WHERE TARGET_ACCRUAL =0;
    
UPDATE work.oncore 
	SET DayPlanMiss=1
	WHERE DAYS_PLANNED  IS NULL;    


select count(*) from work.oncore where TarAcrlMiss=1 AND DayPlanMiss=1;
