DROP TABLE IF EXISTS  ctsi_webcamp_adhoc.byrnes_work;
create table ctsi_webcamp_adhoc.byrnes_work AS
Select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus IN (1,2)
AND PI_NAME Like '%Byrne%';


## Protocols by Year
Select SFY,
       count(distinct ProtocolID) as nProtocols,
       count(distinct VisitID) as nCompleted_Visits, 
       Count(distinct PatientID) as nPatients
From ctsi_webcamp_adhoc.byrnes_work
group by SFY;  

## All Protocols 

Select 
       count(distinct ProtocolID) as nProtocols,
       count(distinct VisitID) as nCompleted_Visits, 
       Count(distinct PatientID) as nPatients
From ctsi_webcamp_adhoc.byrnes_work
;     


DROP TABLE IF EXISTS  ctsi_webcamp_adhoc.TempOut;
create table ctsi_webcamp_adhoc.TempOut AS       
Select 	Title,
		min(VisitStart) as EarilestVisit,
        Max(VisitStart) as LatestVisit,
        count(distinct VisitID) as nCompleted_Visits, 
        Count(distinct PatientID) as nPatients
From ctsi_webcamp_adhoc.byrnes_work
Where Title is not NULL
group by Title    ;    
              

