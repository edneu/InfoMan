desc ctsi_webcamp_adhoc.VisitRoomCore;

/*
07/01/2022 through 06/30/2023 by age (Peds 0-18 yrs and Adult over 19 yrs)?  Could you also run a cancelled visits vs actual visits for the same fiscal year.
*/

SELECT distinct SFY from ctsi_webcamp_adhoc.VisitRoomCore;

Alter Table ctsi_webcamp_adhoc.VisitRoomCore
ADD PedIndicator varchar(12);

UPDATE ctsi_webcamp_adhoc.VisitRoomCore
SET PedIndicator="Unknown";

UPDATE ctsi_webcamp_adhoc.VisitRoomCore
SET PedIndicator="Peds"
WHERE AgeAtDOS<=18;

UPDATE ctsi_webcamp_adhoc.VisitRoomCore
SET PedIndicator="Adult"
WHERE AgeAtDOS>18;
 
Select 	PedIndicator,
		count(distinct ProtocolID) as nProtocols,
        count(distinct VISITID) as nVisits
from  ctsi_webcamp_adhoc.VisitRoomCore       
WHERE SFY='SFY 2022-2023'
AND VisitStatus=2
AND CoreSvcStatus=2
GROUP BY PedIndicator;

#### select PedIndicator,PatientDOB,VisitStart,AgeAtDOS from ctsi_webcamp_adhoc.VisitRoomCore where PedIndicator="Unknown" and SFY='SFY 2022-2023';


# 0 or null=not entered
# 1=Scheduled
# 2=Completed
# 3=Begun
# 4=No-show
# 5=Request cancelled
# 6=Requested
# 7=Request denied
# 8=Stopped prematurely
# 9=Re-scheduling requested

Select VisitStatus, Count(distinct VisitID) as nVisits
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE SFY='SFY 2022-2023'
GROUP BY VisitStatus;