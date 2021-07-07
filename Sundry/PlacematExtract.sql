##############################

https://teams.microsoft.com/l/team/19%3a9f96a73e0d72480580cf6ac1558a4bb1%40thread.tacv2/conversations?groupId=54c68f39-d8c0-4710-a177-65faa0539f3b&tenantId=0d4da0f8-4a31-4d76-ace6-0a62331e1b84
/*
•	Administration
X	Community and Collaboration
X	Hub Capacity
X	Informatics
X	Network Capacity
X	Network Science
•	Precision Health
X	Research Methods
X	Translational Endeavors

work.comcolab
work.hubcap
work.informat
work.netcap
work.netsci
work.preshlth
work.rschmeth
work.tranendv

*/
DROP TABLE IF EXISTS work.progtemp;
Create table work.progtemp AS
SELECT * from work.preshlth;

DROP TABLE IF EXISTS work.combcomp;
Create table work.combcomp AS
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M1 as Action
from work.progtemp
WHERE M1<>""
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M2 as Action
from work.progtemp
WHERE M2<>""
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M3 as Action
from work.progtemp
WHERE M3<>""        
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M4 as Action
from work.progtemp
WHERE M4<>""        
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M5 as Action
from work.progtemp
WHERE M5<>""  
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M6 as Action
from work.progtemp
WHERE M6<>"" 
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M7 as Action
from work.progtemp
WHERE M7<>"" 
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M8 as Action
from work.progtemp
WHERE M8<>"" 
UNION ALL
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M9 as Action
from work.progtemp
WHERE M9<>"" 
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M10 as Action
from work.progtemp
WHERE M10<>"" 
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M11 as Action
from work.progtemp
WHERE M11<>"" 
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M12 as Action
from work.progtemp
WHERE M12<>"" 
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M13 as Action
from work.progtemp
WHERE M13<>""
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M14 as Action
from work.progtemp
WHERE M14<>""
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M15 as Action
from work.progtemp
WHERE M15<>""
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M16 as Action
from work.progtemp
WHERE M16<>""
UNION ALL   
SELECT 	Module As ProgComp,
		AIM AS Aim,
        Owner as Owner,
        M17 as Action
from work.progtemp
WHERE M17<>""     ;

###############
/*
DROP TABLE IF EXISTS work.CompPresHlth;
Create table  work.CompPresHlth AS
SELECT * from work.combcomp;

*/
#################################
UPDATE work.CompNetSci SET ProgComp="Network Science";


drop table if exists work.placemat;
CREATE TABLE work.placemat AS
SELECT * from work.compRSCHMETH
UNION ALL
SELECT * from work.CompHUBCAP
UNION ALL
SELECT * from work.CompNETCAP
UNION ALL
SELECT * from work.CompINFOMAT
UNION ALL
SELECT * from work.CompCOMCOLAB
UNION ALL
SELECT * from work.CompTRANENDV
UNION ALL
SELECT * FROM work.CompNetSci
UNION ALL
SELECT * FROM work.CompPresHlth;


Alter Table work.placemat ADD RecNo int(5);


SET SQL_SAFE_UPDATES = 0;
SET @rank:=0;
update work.placemat
set RecNo=@rank:=@rank+1;

drop table if exists work.ProgAct;
CREATE TABLE work.ProgAct AS
SELECT	RecNo,
		ProgComp,
        Aim,
        Owner,
        Action	
FROM work.placemat
ORDER BY RecNo;



Alter table work.ProgAct Add OmitFlag int(1);

SET SQL_SAFE_UPDATES = 0;
UPDATE work.ProgAct SET OmitFlag=0;

UPDATE work.ProgAct SET OmitFlag=1
WHERE Recno in (select distinct RecNo from work.pm_omitflag); 


drop table if exists work.ProgActOut;
CREATE TABLE work.ProgActOut AS
SELECT	RecNo,
		ProgComp,
        Aim,
        Owner,
        Action	
FROM work.ProgAct
WHERE OmitFLag=0
ORDER BY RecNo;



SELECT Owner,count(*) as mREC
FROM work.ProgActOut
GROUP BY OWNER
ORDER BY OWNER;


SELECT ProgComp,Owner,count(*) as mREC
FROM work.ProgActOut
GROUP BY ProgComp, OWNER
ORDER BY OWNER;
