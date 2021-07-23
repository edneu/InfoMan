
## drop table work.cm_kl_tl_2021;
## select * from work.cm_kl_tl_2021;

## Create work table work.cmtlkl
drop table if exists work.cmtlkl;
Create Table work.cmtlkl as
select * from work.cm_kl_tl_2021;

## ALL BY Male Female
/*
#  TL1 - Predoc
URP + Engaged	
URP + Not Engaged	
Non-URP + Engaged	
Non-URP + Not Engaged

#TL1 - PostDoc
URP + Engaged	
URP + Not Engaged	
Non-URP + Engaged	
Non-URP + Not Engaged

#KL2
URP + Engaged	
URP + Not Engaged	
Non-URP + Engaged	
Non-URP + Not Engaged
*/

drop table if exists work.cmkltlout ;
Create table work.cmkltlout 
(
Program varchar(12),
PostDoc int(1),
Measure varchar(25),
Male int(5),
Female int(5),
Other int(5)
);

## Intitalize Reporting Table
INSERT INTO work.cmkltlout
(Program,PostDoc,Measure,Male,Female,Other)
VALUES
 ("TL1",1,"URP + Engaged",0,0,0),	
 ("TL1",1,"URP + Not Engaged",0,0,0),	
 ("TL1",1,"Non-URP + Engaged",0,0,0),	
 ("TL1",1,"Non-URP + Not Engaged",0,0,0),
 ("TL1",0,"URP + Engaged",0,0,0),	
 ("TL1",0,"URP + Not Engaged",0,0,0),	
 ("TL1",0,"Non-URP + Engaged",0,0,0),	
 ("TL1",0,"Non-URP + Not Engaged",0,0,0),
 ("KL2",1,"URP + Engaged",0,0,0),	
 ("KL2",1,"URP + Not Engaged",0,0,0),	
 ("KL2",1,"Non-URP + Engaged",0,0,0),	
 ("KL2",1,"Non-URP + Not Engaged",0,0,0)
 ;
 
/* 
select * from work.cmkltlout;
select * from work.cmtlkl;
desc work.cmtlkl;
*/

drop table if exists work.cmkltlsumm;
create table work.cmkltlsumm as
SELECT Program,
	   PostDoc,
       Sum(CM_Graduate) as nGRADS,
       SUM(CM_Graduate*EngagedCTS*Underserved*Male) as MaleURPEngaged,
       SUM(CM_Graduate*NotEngagedCTS*Underserved*Male) as MaleURPNotEngaged,  
       SUM(CM_Graduate*EngagedCTS*Not_underserved*Male) as MaleNotURPEngaged,
       SUM(CM_Graduate*NotEngagedCTS*Not_underserved*Male) as MaleNotURPNotEngaged,
       SUM(CM_Graduate*EngagedCTS*Underserved*Female) as FemaleURPEngaged,
       SUM(CM_Graduate*NotEngagedCTS*Underserved*Female) as FemaleURPNotEngaged,  
       SUM(CM_Graduate*EngagedCTS*Not_underserved*Female) as FemaleNotURPEngaged,
       SUM(CM_Graduate*NotEngagedCTS*Not_underserved*Female) as FemaleNotURPNotEngaged
FROM work.cmtlkl
GROUP BY 	Program,
			PostDoc;   
            
SET SQL_SAFE_UPDATES = 0;
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Male=lu.MaleURPEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="URP + Engaged";     
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Male=lu.MaleURPNotEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="URP + Not Engaged";  
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Male=lu.MaleNotURPEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="Non-URP + Engaged"; 
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Male=lu.MaleNotURPNotEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="Non-URP + Not Engaged";

UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Female=lu.FemaleURPEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="URP + Engaged";     
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Female=lu.FemaleURPNotEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="URP + Not Engaged";  
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Female=lu.FemaleNotURPEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="Non-URP + Engaged"; 
UPDATE work.cmkltlout cm,  work.cmkltlsumm lu SET cm.Female=lu.FemaleNotURPNotEngaged WHERE cm.Program=lu.Program AND cm.PostDoc=lu.Postdoc AND cm.Measure="Non-URP + Not Engaged";


select * from work.cmkltlout;


    