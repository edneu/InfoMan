


select * from Adhoc.mult_room;

drop table if exists Adhoc.mult_room_norm;

CREATE TABLE Adhoc.mult_room_norm AS
SELECT UFID, EMPLOYEE_NAME, room01 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room02 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room03 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room04 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room05 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room06 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room07 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room08 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room09 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room10 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room11 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room12 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room13 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room14 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room15 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room16 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room17 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room18 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room19 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room20 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room21 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room22 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room23 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room24 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room25 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room26 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room27 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room28 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room29 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room30 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room31 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room32 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room33 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room34 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room35 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room36 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room37 AS Room from Adhoc.mult_room  UNION ALL
SELECT UFID, EMPLOYEE_NAME, room38 AS Room from Adhoc.mult_room  ;



SET SQL_SAFE_UPDATES = 0;
DELETE FROM Adhoc.mult_room_norm where Room is Null;




ALter table Adhoc.mult_room_norm
ADD RoomID Varchar(120),
ADD InitDate varchar(220),
ADD BLDGID varchar(12),
ADD BldgName varchar(145),
ADD RoomNum varchar(12),
ADD RoomUse varchar(45),
ADD Aging int(1);

Update Adhoc.mult_room_norm
SET RoomID=substr(Room,7,Locate("(",Room)-8);

Update Adhoc.mult_room_norm
SET BLDGID=substr(Room,1,4);

Update Adhoc.mult_room_norm
SET BldgName=substr(RoomID,1,locate(":",Room)-5);

Update Adhoc.mult_room_norm
SET BldgName=substr(RoomID,1,locate(":",Room)-5);

Update Adhoc.mult_room_norm
SET RoomNum=substr(RoomID,locate(":",Room)-5,length(Room));

Update Adhoc.mult_room_norm
SET InitDate= SUBSTR(Room,locate("/",Room)-2,10);


Update Adhoc.mult_room_norm
SET InitDate=SUBSTR(Room,locate('-PRESENT',Room)-10,10) 
WHERE InitDate IN
('er/Genetic',
'NT/EXAM SE',
'NT/EXAMINA');

Update Adhoc.mult_room_norm
SET RoomUse=SUBSTR(Room,locate("(",Room)+1,locate(")",Room)-locate("(",Room)-1);



UPDATE Adhoc.mult_room_norm SET Aging=0;


UPDATE Adhoc.mult_room_norm SET Aging=1
WHERE BldgName=' Clinical & Translational Research Building: '
AND (RoomNum Like " 11%" OR
    RoomNum Like " 21%" OR
    RoomNum Like " 31%");






DELETE from Adhoc.mult_room_norm WHERE Aging=1;
DELETE FROM Adhoc.mult_room_norm WHERE RoomUse<>' OFFICE'


SELECT * from Adhoc.mult_room_norm;


SELECT UFID,EMPLOYEE_NAME,COUNT(*) from Adhoc.mult_room_norm Group by UFID,EMPLOYEE_NAME;



