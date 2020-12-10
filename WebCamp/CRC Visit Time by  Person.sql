

select * from  ctsi_webcamp_adhoc.VisitRoomCore; 


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
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE ProvPersonName IS NOT NULL
GROUP BY ProvPersonName,
       VisitType,
       VisitID;        

Alter table ctsi_webcamp_adhoc.TmpPersonVisit Add Month varchar(8);


UPDATE ctsi_webcamp_adhoc.TmpPersonVisit 
SET Month=concat(YEAR(VisitStart),"-",LPAD(MONTH(VisitStart),2,"0"));

select * from ctsi_webcamp_adhoc.TmpPersonVisit ; 


SELECT Month,
       ProvPersonName,
       CRCNumber,
       Max(Title) as Title,
       max(PI_name) as PI_Name,
       sum(VisitDur) as VisitDurMin
from ctsi_webcamp_adhoc.TmpPersonVisit   
GROUP BY Month,CRCNumber;     
       
       