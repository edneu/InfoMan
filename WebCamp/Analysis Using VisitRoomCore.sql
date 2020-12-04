

select * from ctsi_webcamp_adhoc.VisitRoomCore;

select VisitID,Service,Room,VisitDate,CoreSvcVisitDate,VisitStartTIme,CoreSvcStartTIme,VisitEndTIme,CoreSvcEndTIme,VisitLength,CoreSvcVistLen
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitLength<>CoreSvcVistLen
AND YEAR(VisitDate)=2020;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.RoomMonthUtil;
create table ctsi_webcamp_adhoc.RoomMonthUtil AS
SELECT concat(YEAR(CoreSvcVisitDate),"-",LPAD(MONTH(CoreSvcVisitDate),2,"0")) AS Month,
		VisitID,
        Room,
        CoreSvcVisitDate,
        max(VisitLength) AS Duration,
        SUM(Amount) as Amount
from ctsi_webcamp_adhoc.VisitRoomCore
#WHERE YEAR(VisitDate)=2020
GROUP BY Month, VisitID,Room,CoreSvcVisitDate;


SELECT Month, 
       Room,
	   Sum(Duration) as DurMin,
       SUM(DUration)/60 as DurHrs
FROM  ctsi_webcamp_adhoc.RoomMonthUtil 
GROUP BY Month,Room
UNION ALL 
SELECT Month, 
       "zzALL Rooms" AS Room,
	   Sum(Duration) as DurMin,
       SUM(DUration)/60 as DurHrs
FROM  ctsi_webcamp_adhoc.RoomMonthUtil 
GROUP BY Month;



DROP TABLE IF EXISTS ctsi_webcamp_adhoc.Temp;
create table ctsi_webcamp_adhoc.Temp AS
SELECT Room, Count(Distinct VisitID) As Visits
from ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY Room;



DROP TABLE IF EXISTS ctsi_webcamp_adhoc.Temp1;
create table ctsi_webcamp_adhoc.Temp1 AS
select Bed,
       Count FROM crc.crc_month_room_occ
GROUP BY Bed; 


############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
### PERSON MONTHS

Select VisitType,
VisitID,
VisitDate,
VisitLength,
Room,
CoreSvcVisitDate,
CoreSvcStartTIme,
CoreSvcVistLen,
Service,
ProvPersonName,
Amount
from ctsi_webcamp_adhoc.visitroomcore
WHERE substr(Service,1,4)<>"CTRB"
AND ProvPersonName IS NOT NULL
AND VISITID=54415
;


SELECT  VisitType, VisitID, VisitDate, Room, ProvPersonName,CoreSvcVistLen AS SrvTime
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE YEAR(VisitDate)=2020
AND substr(Service,1,4)<>"CTRB"
AND ProvPersonName IS NOT NULL
GROUP BY VisitType, VisitID, VisitDate, Room, ProvPersonName
;

select * from ctsi_webcamp_adhoc.visitroomcore
WHERE VISITID=4026;


SELECT VisitDate,VisitStartTIme,ADDTIME(CONVERT(VisitDate, DATETIME), VisitStartTIme)
FROM ctsi_webcamp_adhoc.visitroomcore;



select * from ctsi_webcamp_adhoc.visitroomcore
WHERE VisitLength<0;

