

drop Table if Exists work.bondprojr;
Create table work.bondprojr AS
select  CLK_AWD_ID, 
        CLK_AWD_PI,
        REPORTING_SPONSOR_NAME,
        CLK_AWD_PROJ_ID,
        CLK_AWD_PROJ_NAME
from lookup.awards_history 
WHERE CLK_AWD_ID IN (SELECT AWARD_ID_Number from space.bondmaster where LastName LIKE "%Brakenridge%");


drop Table if Exists work.bondprojspace;
Create table work.bondprojspace AS
Select * from space.ctrb_projects_2017
WHERE PRJNUM IN (SELECT DISTINCT CLK_AWD_PROJ_ID from work.bondprojr);


drop Table if Exists work.bondprojroom;
Create table work.bondprojroom AS
SELECT bs.PRJNUM,
       bs.FL AS Floor,
       bs.ROOM,
       oc.NAME as Occupant_Name,
       oc.DESCR,
       oc.DEPT_NAME as Occupant_Dept
from work.bondprojspace bs LEFT JOIN space.ctrb_occ_2017 oc
ON bs.ROOM=oc.ROOM
WHERE DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');


ALTER TABLE work.bondprojroom
ADD CLK_AWD_ID varchar(12),
ADD CLK_AWD_PI varchar(45),
ADD REPORTING_SPONSOR_NAME varchar(45),
ADD CLK_AWD_PROJ_NAME varchar(255)
;

SET SQL_SAFE_UPDATES = 0;

UPDATE work.bondprojroom pr, work.bondprojr lu
SET pr.CLK_AWD_ID=lu.CLK_AWD_ID,
    pr.CLK_AWD_PI=lu.CLK_AWD_PI,
    pr.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME,
    pr.CLK_AWD_PROJ_NAME=lu.CLK_AWD_PROJ_NAME
WHERE pr.PRJNUM=lu.CLK_AWD_PROJ_ID; 



SET SQL_SAFE_UPDATES = 1;


select * from work.bondprojroom;




##select * from lookup.awards_history WHERE CLK_AWD_ID="00098975";