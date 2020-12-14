###Production CRC analysis;

## Utilization By Room

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_VISITMON;
create table ctsi_webcamp_adhoc.PR_VISITMON AS
SELECT 	MONTH,
		SFY,
        QUARTER,
        VisitID,
        max(ROOM) as Room,
        max(VisitLenMin/60) AS VistDurHours
from ctsi_webcamp_adhoc.visitroomcore
GROUP BY 	MONTH,
			SFY,
			QUARTER,
			VisitID;        
            
SELECT * from ctsi_webcamp_adhoc.PR_VISITMON where Room=1246 and Quarter="Q1 20-21";
            
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_ROOM_UTIL;
create table ctsi_webcamp_adhoc.PR_ROOM_UTIL AS
SELECT MONTH,
		SFY,
        QUARTER,
        ROOM, 
        SUM(VistDurHours) as HoursUsed
FROM ctsi_webcamp_adhoc.PR_VISITMON
WHERE ROOM IS NOT NULL
GROUP BY MONTH,
		SFY,
        QUARTER,
        ROOM;

SELECT * from ctsi_webcamp_adhoc.PR_ROOM_UTIL where Room="1246" AND Quarter="Q1 20-21";


ALTER TABLE ctsi_webcamp_adhoc.PR_ROOM_UTIL 
ADD CRC_Avail_hours int(10),
ADD HoursUnused decimal(56,6),
ADD UtilRate decimal(56,6);

UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL ru, 
		ctsi_webcamp_adhoc.utilization_hours lu
SET ru.CRC_Avail_hours=lu.CRC_Avail_hours
WHERE ru.MOnth=lu.Month;

UPDATE 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
SET HoursUnused=CRC_Avail_hours-HoursUsed,
	UtilRate=HoursUsed/CRC_Avail_hours;
    
Select * from ctsi_webcamp_adhoc.PR_ROOM_UTIL;

Select * from ctsi_webcamp_adhoc.PR_ROOM_UTIL WHERE Room=1216 AND Quarter="Q1 20-21";


SELECT 	Quarter,
		Room,
        Sum(HoursUsed) as HoursUsed,
        SUM(CRC_avail_hours) as AvailHours
FROM 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
WHERE Quarter="Q1 20-21"
GROUP BY Quarter,
		Room;
        

SELECT 	Month,
		Room,
        Sum(HoursUsed) as HoursUsed,
        SUM(CRC_avail_hours) as AvailHours
FROM 	ctsi_webcamp_adhoc.PR_ROOM_UTIL
WHERE Month="2020-10"
GROUP BY Month,
		Room;
        


;
            
### CLEANUP
/*
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PR_VISITMON;    

*/        
            