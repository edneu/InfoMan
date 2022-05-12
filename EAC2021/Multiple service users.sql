DROP Table if Exists work.temp1;
create table work.temp1 as
SELECT 	Year,
		UFID,
        Count(Distinct STD_PROGRAM) as nProgUsed
from lookup.roster
where Year in (2020,2021)
AND UFID=Person_Key   # Include only those records with UFIDS
AND Faculty="Faculty"
GROUP by YEar, UFID; 


DROP Table if Exists work.temp2;
create table work.temp2 as
SELECT 	Year,
		nProgUsed,
        Count(Distinct UFID) as nUndupFac
from work.temp1
GROUP by Year,
		  nProgUsed;





DROP Table if Exists work.ServUse;
create table work.ServUse as
SELECT distinct nProgUsed
FROM work.temp1;

Alter Table work.ServUse
ADD YR_2020 int(5),
ADD YR_2021 int(5);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.ServUse
SET YR_2020=0,
	YR_2021=0;

UPDATE work.ServUse su, work.temp2 lu 
SET su.YR_2020=lu.nUndupFac
WHERE su.nProgUsed=lu.nProgUsed 
AND lu.Year=2020;

UPDATE work.ServUse su, work.temp2 lu 
SET su.YR_2021=lu.nUndupFac
WHERE su.nProgUsed=lu.nProgUsed 
AND lu.Year=2021;

Select * from work.ServUse;


SELECT Year,STD_PROGRAM,Count(distinct UFID) as UNDUP
from lookup.roster
where Year in (2020,2021)
AND UFID=Person_Key   # Include only those records with UFIDS
AND Faculty="Faculty" 
group by Year,STD_PROGRAM;  