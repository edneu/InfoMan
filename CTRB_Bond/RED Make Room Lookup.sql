/*
This code creates a room lookup table for each grant

*/



drop table if exists work.bondSRMRoom; 
create table work.bondSRMRoom AS
select CLK_AWD_PI,
       CLK_AWD_ID,
       CLK_AWD_PROJ_ID, 
       CLK_AWD_PROJ_NAME 
FROM lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (select distinct PRJNUM from space.ctrb_projects_2017)
and CLK_AWD_PRJ_START_DT<=STR_TO_DATE(concat('06,30,',year(curdate())),'%m,%d,%Y')
and CLK_AWD_PRJ_END_DT>=STR_TO_DATE(concat('07,01,',year(curdate())-1),'%m,%d,%Y')
GROUP BY CLK_AWD_PI,
       CLK_AWD_ID,
       CLK_AWD_PROJ_ID, 
       CLK_AWD_PROJ_NAME ;


drop table if exists work.bondSRMProj; 
create table work.bondSRMProj AS
select sr.CLK_AWD_PI,
       sr.CLK_AWD_ID,
       sr.CLK_AWD_PROJ_ID, 
       sr.CLK_AWD_PROJ_NAME, 
       sp.ROOM  
from work.bondSRMRoom sr LEFT JOIN space.space2016 sp ON sr.CLK_AWD_PROJ_ID=sp.PRJNUM ;


drop table if exists work.bondSRMProjOcc; 
create table work.bondSRMProjOcc AS
select bsp.CLK_AWD_PI,
       bsp.CLK_AWD_ID,
       bsp.CLK_AWD_PROJ_ID, 
       bsp.CLK_AWD_PROJ_NAME, 
       bsp.ROOM,  
       occ.NAME AS Room_Occupant,
       occ.DEPT_NAME AS Room_Occupant_Dept,
       occ.DESCR AS OCCDESC 
from work.bondSRMProj bsp LEFT JOIN space.ctrb_occ_2017 occ ON bsp.ROOM=occ.ROOM
 where occ.DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202') ;



drop table if exists work.bondSRMProjStaffTemp1; 
create table work.bondSRMProjStaffTemp1 AS
SELECT CLK_AWD_ID,
       CONCAT(Room_Occupant," (CTRB",ROOM,", ",OCCDESC ,", ",Room_Occupant_Dept,")")   AS OccString
FROM work.bondSRMProjOcc
WHERE Room_Occupant<>""
GROUP BY CLK_AWD_ID,
       Room_Occupant ;


drop table if exists work.bondSRMProjStaffTemp2; 
create table work.bondSRMProjStaffTemp2 AS
SELECT CLK_AWD_ID,
       OccString
FROM work.bondSRMProjStaffTemp1
GROUP BY CLK_AWD_ID,
       OccString;


drop table if exists work.bondSRMProjStaff; 
create table work.bondSRMProjStaff AS
SELECT CLK_AWD_ID,
GROUP_CONCAT(OccString SEPARATOR '; ') AS Staff
FROM work.bondSRMProjStaffTemp2
GROUP BY CLK_AWD_ID;


Select * from work.bondSRMProjStaff;


####ADD STAFF TO BONDMASTER
ALTER TABLE space.bondmaster ADD Staff Text;

UPDATE space.bondmaster bm, work.bondSRMProjStaff lu
SET bm.Staff=lu.Staff
WHERE bm.AWARD_ID_Number=lu.CLK_AWD_ID ;



######################################## SCXRATCH

select * from space.bondmaster;

select * from space.ctrb_occ_2017;


select * from space.bondmaster where Staff is Null;

/*
drop table if exists space.RoomLookup2016; 
create table space.RoomLookup2016 AS
select Contract_PI,
       PS_Contract, 
       max(Title) AS Title,
       ROOM,
       Room_Occupant,
       Room_Occupant_Dept 
 from work.bondSRMProjOcc
WHERE Contract_PI<>""
group by Contract_PI,
         PS_Contract, 
         ROOM,
         Room_Occupant,
         Room_Occupant_Dept 
Order by Contract_PI, 
         PS_Contract; 
         



## Cleanup
drop table if exists work.bondSRM; 
drop table if exists work.bondSRMProj; 
drop table if exists work.bondSRMProjOcc; 