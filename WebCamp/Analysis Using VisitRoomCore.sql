

select * from ctsi_webcamp_adhoc.VisitRoomCore;


Alter table ctsi_webcamp_adhoc.VisitRoomCore
ADD Month varchar(7),
ADD SFY varchar(14);

UPDATE ctsi_webcamp_adhoc.VisitRoomCore
SET MONTH=concat(Year(VisitStart),"-",lpad(month(VisitStart),2,"0"));

#CREATE INDEX sfymon ON ctsi_webcamp_adhoc.sfy (Month);

UPDATE ctsi_webcamp_adhoc.VisitRoomCore vrc, ctsi_webcamp_adhoc.sfy lu
SET vrc.SFY=lu.SFY
WHERE vrc.MONTH=lu.MONTH;




#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContib;
CREATE TABLE ctsi_webcamp_adhoc.ProvContib AS 
SELECT VisitID,ProvPersonName,
	   SUM(CoreSvcLenDurMin) AS ProvMin,
       max(VisitLenMin) AS VisitLenMin,
       IF (SUM(CoreSvcLenDurMin)/max(VisitLenMin) >1,1,SUM(CoreSvcLenDurMin)/max(VisitLenMin)) AS ProvPctContib
FROM ctsi_webcamp_adhoc.VisitRoomCore 
WHERE CoreSvcQuant IS NOT NULL
AND ProvPersonName IS NOT NULL  
GROUP BY VISITID, ProvPersonName;


ALTER TABLE ctsi_webcamp_adhoc.ProvContib
	ADD ProvContibMin decimal(20,2);
    
    UPDATE ctsi_webcamp_adhoc.ProvContib
    SET  ProvContibMin=ProvPctContib*VisitLenMin;
    
    

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProvContibSumm;
CREATE TABLE ctsi_webcamp_adhoc.ProvContibSumm AS
SELECT 	VisitID,
		MAX(VisitLenMin) AS VisitLenMin,
        COUNT(DISTINCT ProvPersonName) as NProvs,
        SUM(ProvContibMin) as ProvTotalMin
        FROM ctsi_webcamp_adhoc.ProvContib
        GROUP BY VisitID;

ALTER TABLE ctsi_webcamp_adhoc.ProvContibSumm
ADD AdjVisitMin int(20);
       
UPDATE ctsi_webcamp_adhoc.ProvContibSumm
SET AdjVisitMin=GREATEST(ProvTotalMin,VisitLenMin)	;



select * from ctsi_webcamp_adhoc.ProvContibSumm;       

desc ctsi_webcamp_adhoc.ProvContibSumm; 
#################################################################################################
## AGG BY VISIT

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VistMonth;
CREATE TABLE ctsi_webcamp_adhoc.VistMonth AS
SELECT  Month,
        VisitType,
        VisitID
FROM  ctsi_webcamp_adhoc.visitroomcore
GROUP BY Month,
        VisitType,
        VisitID;
        
        
ALTER TABLE ctsi_webcamp_adhoc.VistMonth
	ADD VisitLenMin	decimal(30,2),
	ADD	NProvs	bigint(21),
	ADD	ProvTotalMin	decimal(42,2),
	ADD	AdjVisitMin	int(20);


CREATE INDEX pcs1 ON ctsi_webcamp_adhoc.VistMonth (VisitID);
CREATE INDEX vr1 ON ctsi_webcamp_adhoc.ProvContibSumm (VisitID);

        
UPDATE ctsi_webcamp_adhoc.VistMonth vr1, ctsi_webcamp_adhoc.ProvContibSumm lu
SET	vr1.VisitLenMin=lu.VisitLenMin,
	vr1.NProvs=lu.NProvs,
	vr1.ProvTotalMin=lu.ProvTotalMin,
	vr1.AdjVisitMin=lu.AdjVisitMin
WHERE vr1.VisitID=lu.VisitID;

#############################################################################################
##Visit Summary


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.MonthSummAdj;
CREATE TABLE ctsi_webcamp_adhoc.MonthSummAdj AS
SELECT 	Month,
		SUM(VisitLenMin) as VisitMin,
		SUM(ProvTotalMin) as ProvTotalMin,
        SUM(AdjVisitMin) as AdjVisitMin
FROM ctsi_webcamp_adhoc.VistMonth
GROUP BY MOnth;

##############################################################################################
## AGG BY ROOM

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VistRoomMonth;
CREATE TABLE ctsi_webcamp_adhoc.VistRoomMonth AS
SELECT  Month,
        VisitType,
        VisitID,
        Room
FROM  ctsi_webcamp_adhoc.visitroomcore
GROUP BY Month,
        VisitType,
        VisitID,
        Room;
        
        
ALTER TABLE ctsi_webcamp_adhoc.VistRoomMonth
	ADD VisitLenMin	decimal(30,2),
	ADD	NProvs	bigint(21),
	ADD	ProvTotalMin	decimal(42,2),
	ADD	AdjVisitMin	int(20);


CREATE INDEX pcrs1 ON ctsi_webcamp_adhoc.VistRoomMonth (VisitID);
CREATE INDEX vr1 ON ctsi_webcamp_adhoc.ProvContibSumm (VisitID);

        
UPDATE ctsi_webcamp_adhoc.VistRoomMonth vr1, ctsi_webcamp_adhoc.ProvContibSumm lu
SET	vr1.VisitLenMin=lu.VisitLenMin,
	vr1.NProvs=lu.NProvs,
	vr1.ProvTotalMin=lu.ProvTotalMin,
	vr1.AdjVisitMin=lu.AdjVisitMin
WHERE vr1.VisitID=lu.VisitID;


##############################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.MonthRoomSummAdj;
CREATE TABLE ctsi_webcamp_adhoc.MonthRoomSummAdj AS
SELECT 	Room,
		SUM(VisitLenMin) as VisitMin,
		SUM(ProvTotalMin) as ProvTotalMin,
        SUM(AdjVisitMin) as AdjVisitMin
FROM ctsi_webcamp_adhoc.VistRoomMonth
WHERE SUBSTR(Month,1,4) IN ('2018','2019','2020')
GROUP BY Room;

        

##############################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PersonnelTemp;
CREATE TABLE ctsi_webcamp_adhoc.PersonnelTemp AS
SELECT ProvPersonName,
       Service,
       Count(*) as nOccurances,
       COUNT(distinct VisitID) as nVisits
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE ProvPersonName like "Browning%" 
GROUP BY ProvPersonName,
       Service;   



## Personnel List
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.PersonnelTemp;
CREATE TABLE ctsi_webcamp_adhoc.PersonnelTemp AS
SELECT ProvPersonName,
       Max(VisitStart) LastServiceDate,
       Count(*) as nOccurances,
       COUNT(Distinct Service) as nServices,
       COUNT(distinct VisitID) as nVisits
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE ProvPersonName IS NOT NULL
GROUP BY ProvPersonName
ORDER BY ProvPersonName;
       

## Service List
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ServiceTemp;
CREATE TABLE ctsi_webcamp_adhoc.ServiceTemp AS
SELECT Service,
       Max(VisitStart) LastServiceDate,
       Count(*) as nOccurances
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE Service IS NOT NULL
GROUP BY Service
ORDER BY Service;


#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
#############################################################################################
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

#############################################################################################
## ROOMS








############################################################################################
############################################################################################
############################################################################################
############################################################################################
############################################################################################
### PERSON MONTHS

Select VisitType,
VisitID,
VisitStart,
VisitEnd,
VisitLenMin,
Room,
CoreSvcStart,
CoreSvcEnd,
CoreSvcLenDurMin,
Service,
ProvPersonName,
Amount
from ctsi_webcamp_adhoc.visitroomcore
WHERE substr(Service,1,4)<>"CTRB"
AND ProvPersonName IS NOT NULL
AND ProvPersonName='Wood, Janet'
;


SELECT  VisitType,  VisitID,
max(VisitLenMin),sum(CoreSvcLenDurMin),max(VisitLenMin)-sum(CoreSvcLenDurMin) AS DIFF
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE YEAR(VisitStart)=2020
AND substr(Service,1,4)<>"CTRB"
AND ProvPersonName IS NOT NULL
AND VisitStart IS NOT NULL 
AND VisitEnd IS NOT NULL
AND ProvPersonName<>'Wood, Janet'
GROUP BY VisitType,  VisitID;

;

select * from ctsi_webcamp_adhoc.visitroomcore
WHERE VISITID=4026;


SELECT VisitDate,VisitStartTIme,ADDTIME(CONVERT(VisitDate, DATETIME), VisitStartTIme)
FROM ctsi_webcamp_adhoc.visitroomcore;



select * from ctsi_webcamp_adhoc.visitroomcore
WHERE VisitLenMin<0;

