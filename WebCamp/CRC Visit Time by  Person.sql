
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.TmpPersonVisit;
Create table ctsi_webcamp_adhoc.TmpPersonVisit as
SELECT ProvPersonName,
       VisitType,
       VisitID,
       max(CRCNumber) as CRCNumber,
       max(Title) as Title,
       max(PI_NAME) as PI_Name,
       min(VisitStart) as VisitStart,
       max(VisitEnd) as VisitEnd,
       max(VisitLenMin) as VisitDur
       ##sum(CoreSvcLenDurMin) ServiceDurMin
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE ProvPersonName IS NOT NULL
GROUP BY ProvPersonName,
       VisitType,
       VisitID;        

Alter table ctsi_webcamp_adhoc.TmpPersonVisit Add Month varchar(8);

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.TmpPersonVisit 
SET Month=concat(YEAR(VisitStart),"-",LPAD(MONTH(VisitStart),2,"0"));




DROP TABLE IF EXISTS ctsi_webcamp_adhoc.TmpPersonMonthProto;
Create table ctsi_webcamp_adhoc.TmpPersonMonthProto as
SELECT Month,
       ProvPersonName,
       CRCNumber,
       Max(Title) as Title,
       max(PI_name) as PI_Name,
       sum(VisitDur) as VisitDurMin,
       sum(VisitDur)/60 as VisitDurHrs
from ctsi_webcamp_adhoc.TmpPersonVisit
WHERE MONTH IN ("2020-10")
AND  ProvPersonName NOT IN ('Abernathy, Meghan',
							'Biernacki, Diane',
							'Braxton, April',
							'Browning, Marilyn',
							'Crizaldo, Maria',
							'Demers, Samantha',
							'Hennings, Olivia',
							'King, Janet',
							'Mathew, Tomy',
							'Michelson, Jean',
							'Paguio, Glenna',
							'Pflugrad, Jeremy',
							'Simmons, Paula',							
							'Wood, Janet')
GROUP BY Month,ProvPersonName,CRCNumber
ORDER BY Month,ProvPersonName,CRCNumber;     








DROP TABLE IF EXISTS ctsi_webcamp_adhoc.TmpPersonMonth;
Create table ctsi_webcamp_adhoc.TmpPersonMonth as
select Month,
       ProvPersonName,
       sum(VisitDurMin) as VisitDurMin,
       sum(VisitDurHrs) as VisitDurHrs
from ctsi_webcamp_adhoc.TmpPersonMonthProto
Group by Month,        ProvPersonName;   

       

