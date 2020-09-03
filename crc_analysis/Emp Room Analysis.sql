
######################################################
########### CREATE COMBINED MONHLY SUMMARY

drop table if exists crc.EmpTimeSalSumm;
create table crc.EmpTimeSalSumm AS
SELECT   
      Month,
      max(SFY) as SFY,
      count(Distinct Employee_ID) AS Num_emps,
      sum(HoursWorked) AS HoursWorked,
      sum(Avail_Hours) AS Avail_Hours,
      sum(CRC_Activities) AS CRC_Activities,
      sum(CRC_Other_Activities) AS CRC_Other_Activities
FROM crc.EmpTimeSal
GROUP BY Month;       


### crc.crc_month_room_occ   ALL ROOMS INCLUDING 1328

drop table if exists crc.UtilMaster;
create table crc.UtilMaster AS
SELECT * from crc.EmpTimeSalSumm;



drop table if exists crc.RoomMonth;
create table crc.RoomMonth AS
select Month AS Month,
       count(distinct Bed) As Num_Rooms,
       sum(Hours_Used) as Room_Hours_Used,
       SUM(Avail_Hours) as Room_Hours_Avail,
       ROUND((sum(Hours_Used)/SUM(Avail_Hours))*100,2) AS Room_Occ_Rate
FROM crc.crc_month_room_occ
GROUP BY MONTH;       
       


ALTER TABLE crc.UtilMaster
	ADD Num_CRC_Rooms_Used int(11),
	ADD Room_Hours_Used decimal(58,4),
	ADD Room_Hours_Avail decimal(32,0),
	ADD Room_Occ_Rate decimal(60,2);
    
UPDATE crc.UtilMaster um, crc.RoomMonth lu
	SET um.Num_CRC_Rooms_Used=lu.Num_Rooms,
		um.Room_Hours_Used=lu.Room_Hours_Used,
        um.Room_Hours_Avail=lu.Room_Hours_Avail,
        um.Room_Occ_Rate=lu.Room_Occ_Rate
WHERE um.Month=lu.Month;        
    
select * from crc.UtilMaster;    