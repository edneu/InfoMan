

## Using the COmpleted Visits File.

### Summary of Completed Visits by SFY;
DROP TABLE if exists ctsi_webcamp_adhoc.Comp_SFY_SUMM;
Create table ctsi_webcamp_adhoc.Comp_SFY_SUMM AS
SELECT 	SFY,
		count(distinct ProtocolID) as nProtocols,
        count(distinct VisitID) as nVisits,
        count(distinct PatientID) as nPatients,
        Sum(amount) as TotalAmt
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus =2 ## Completed
group by SFY;

### USing All Status visitroomcore
DROP TABLE if exists ctsi_webcamp_adhoc.Sched_SFY_SUMM;
Create table ctsi_webcamp_adhoc.Sched_SFY_SUMM AS
SELECT 	SFY,
		count(distinct ProtocolID) as nProtocols,
        count(distinct VisitID) as nVisits,
        count(distinct PatientID) as nPatients,
        Sum(amount) as TotalAmt
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus=1    ## Scheduled
group by SFY;

DROP TABLE if exists ctsi_webcamp_adhoc.ScheduledVisits;
Create table ctsi_webcamp_adhoc.ScheduledVisits AS
Select SFY,
       Title,
       PI_NAME,
	   ProtocolID,
       CRCNumber,
       Count(distinct visitid) as nScheduled_visits
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus=1 AND ProtocolID IS NOT NULL
GROUP BY SFY,
       Title,
       PI_NAME,
	   ProtocolID,
       CRCNumber;     




#######################################################################################
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
