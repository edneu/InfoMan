
drop table if exists  ctsi_webcamp_adhoc.vrcRPPR;
create table  ctsi_webcamp_adhoc.vrcRPPR AS
Select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStart >= str_to_date('03,1,2020','%m,%d,%Y')
  AND VisitStart <= str_to_date('02,28,2021','%m,%d,%Y');


Select count(distinct PIPersonID) aS nPIs from ctsi_webcamp_adhoc.vrcRPPR;

Select count(distinct PIPersonID) aS nNEWPIs
from ctsi_webcamp_adhoc.vrcRPPR
WHERE PIPersonID NOT IN (SELECT Distinct PIPersonID 
						from ctsi_webcamp_adhoc.VisitRoomCore
                        WHERE VisitStart < str_to_date('03,1,2020','%m,%d,%Y'));


## Unique Departments
select DEPT,count(*)
from ctsi_webcamp_pr.person
WHERE UNIQUEFIELD IN
 (SELECT Distinct PIPersonID from ctsi_webcamp_adhoc.vrcRPPR)
 GROUP BY DEPT; 
 
 ## protocols
 Select count(distinct ProtocolID) aS nProtocols from ctsi_webcamp_adhoc.vrcRPPR;
 
 
 ## Participants
  Select count(distinct PatientID) aS nPatients from ctsi_webcamp_adhoc.vrcRPPR;

## OPVISITS
   Select count(distinct VisitID) aS nOPVisits from ctsi_webcamp_adhoc.vrcRPPR WHERE VisitType="Outpatient";
   
## INPATIENT vISITS
   Select count(distinct VisitID) aS nIPVisits from ctsi_webcamp_adhoc.vrcRPPR WHERE VisitType="Inpatient";   
   
   
## OVERNIGHT
   Select count(distinct VisitID) aS nOvernight from ctsi_webcamp_adhoc.vrcRPPR 
	where VisitLenMin>1440;   