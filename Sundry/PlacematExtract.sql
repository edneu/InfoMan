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

drop table if exists work.progowners;
create table work.progowners as
SELECT ProgComp,Owner,count(*) as mREC
FROM work.ProgActOut
GROUP BY ProgComp, OWNER
ORDER BY OWNER;


select * from work.ownerparse;

DROP TABLE IF EXISTS work.ownerprog1;
create table work.ownerprog1 AS
SELECT 	P1 AS Owner,
		ProgComp as ProgComp
from work.ownerparse
WHERE P1 IS NOT NULL
UNION ALL
SELECT 	P2 AS Owner,
		ProgComp as ProgComp
from work.ownerparse
WHERE P2 IS NOT NULL
UNION ALL
SELECT 	P3 AS Owner,
		ProgComp as ProgComp
from work.ownerparse
WHERE P3 IS NOT NULL
UNION ALL
SELECT 	P4 AS Owner,
		ProgComp as ProgComp
from work.ownerparse
WHERE P4 IS NOT NULL
UNION ALL
SELECT 	P5 AS Owner,
		ProgComp as ProgComp
from work.ownerparse
WHERE P5 IS NOT NULL;



DROP TABLE IF EXISTS work.ownerprog2;
create table work.ownerprog2 AS
SELECT 	Owner,
		ProgComp
from work.ownerprog1
GROUP BY   Owner,
		ProgComp;      
        
Alter table work.ownerprog2
ADD Name varchar(45),
ADD UFID varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.ownerprog2 op, work.ownerlu lu
SET op.Name=lu.Name_,
	op.UFID=lu.UFID
WHERE op.Owner=lu.KeyName;
    
SELECT * from work.ownerprog2;

        
DROP TABLE IF EXISTS work.Owners_Prog;
create table work.Owners_Prog AS    
SELECT 	Name As Owner,
		UFID as UFID,
		GROUP_CONCAT(DISTINCT ProgComp 
						ORDER BY ProgComp ASC SEPARATOR ', ') AS ProgComps
 FROM work.ownerprog2
 GROUP BY Name, UFID
 ORDER BY NAME;
 
DROP TABLE IF EXISTS work.OwnersSumm;
create table work.OwnersSumm AS    
SELECT 	Name As Owner,
		UFID as UFID
 FROM work.ownerprog2
 GROUP BY Name, UFID ;


ALTER TABLE work.OwnersSumm
     ADD CommCollab int(1),
     ADD HubCap int(1),
     ADD Informatics int(1),
     ADD NetCap int(1),
     ADD NetSci int(1),
     ADD PresHlth int(1),
     ADD ResMeth int(1),
     ADD TranEndv int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.OwnersSumm
SET  CommCollab=0,
     HubCap=0,
     Informatics=0,
     NetCap=0,
     NetSci=0,
     PresHlth=0,
     ResMeth=0,
     TranEndv=0;

 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.CommCollab=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Community And Collaboration';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.HubCap=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Hub Capacity';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.Informatics=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Informatics';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.NetCap=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Network Capacity';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.NetSci=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Network Science';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.PresHlth=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Precision Health';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.ResMeth=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Research Methods';
 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.TranEndv=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Translational Endeavors';

 UPDATE work.OwnersSumm os, work.ownerprog2 lu  SET os.CommCollab=1 WHERE os.Owner=lu.Name  AND lu.ProgComp='Community And Collaboration';
 
 
  select * from work.OwnersSumm;
 
 
 DROP TABLE IF EXISTS work.Prog_Owners;
create table work.Prog_Owners AS    
SELECT ProgComp As ProgComp,
		GROUP_CONCAT(DISTINCT Name 
						ORDER BY Name ASC SEPARATOR '|') AS Names
 FROM work.ownerprog2
 GROUP BY ProgComp
 ORDER BY ProgComp;
 
 
 
  ##############################################
 ##############################################
 ##############################################
 ######### ADD ASSIST DATADATA
 SELECT * from work.assist_erm;
 

 
 drop table if exists work.assistmap;
 CREATE TABLE work.assistmap as
 select * from work.assist_erm;
 
 Alter table work.assistmap
 ADD RFA_COMP varchar(12),
 ADD RFA_FUNC varchar(25);

 
 UPDATE  work.assistmap
 SET RFA_COMP=Null,
	 RFA_FUNC=Null;


update work.assistmap SET RFA_COMP='Admin' WHERE RFA_COMPONENT='A. Admin';
update work.assistmap SET RFA_COMP='AdminSupp' WHERE RFA_COMPONENT='A1. Admin Supplement';
update work.assistmap SET RFA_COMP='RschMeth' WHERE RFA_COMPONENT='E. Research Methods';
update work.assistmap SET RFA_COMP='Informatics' WHERE RFA_COMPONENT='B. Informatics';
update work.assistmap SET RFA_COMP='CommCollab' WHERE RFA_COMPONENT='C. Community and Collaboration  ';
update work.assistmap SET RFA_COMP='HubCap' WHERE RFA_COMPONENT='F. Hub Research Capacity';
update work.assistmap SET RFA_COMP='TransEndv' WHERE RFA_COMPONENT='D. Translational Endeavors';
update work.assistmap SET RFA_COMP='NetCap' WHERE RFA_COMPONENT='G. Network Capacity';
update work.assistmap SET RFA_COMP='NetSci' WHERE RFA_COMPONENT='H.Opt 1 Network Science';
update work.assistmap SET RFA_COMP='PrsPubHlth' WHERE RFA_COMPONENT='H.Opt 2-Precision Public Health';
update work.assistmap SET RFA_COMP='CarreerDev' WHERE RFA_COMPONENT='I. Inst Carreer Dev Core';

 
update work.assistmap SET RFA_FUNC='Informatics' WHERE `RFA_Function/Module`='B. Informatics';
update work.assistmap SET RFA_FUNC='BERD' WHERE `RFA_Function/Module`='BERD';
update work.assistmap SET RFA_FUNC='TeamScience' WHERE `RFA_Function/Module`='Collaboration and Multidisciplinary Team Science';
update work.assistmap SET RFA_FUNC='CommEng' WHERE `RFA_Function/Module`='Community Engagement';
update work.assistmap SET RFA_FUNC='Eval_CQI' WHERE `RFA_Function/Module`='Evaluation and Continious Improvement';
update work.assistmap SET RFA_FUNC='InstCarreerDev' WHERE `RFA_Function/Module`='Inst Career Development';
update work.assistmap SET RFA_FUNC='IntLifeSpan' WHERE `RFA_Function/Module`='Integrated Life Span';
update work.assistmap SET RFA_FUNC='IntgSpecialPop' WHERE `RFA_Function/Module`='Integrating Special Populations';
update work.assistmap SET RFA_FUNC='RecruitCenter' WHERE `RFA_Function/Module`='Liasion to Recruitment Innovation Center';
update work.assistmap SET RFA_FUNC='TrialInnovation' WHERE `RFA_Function/Module`='Liasion to Trial Innovation Centers';
update work.assistmap SET RFA_FUNC='NetworkSci' WHERE `RFA_Function/Module`='Network Science';
update work.assistmap SET RFA_FUNC='Org_Governce' WHERE `RFA_Function/Module`='Organization, Governance, Collagoration and Communication';
update work.assistmap SET RFA_FUNC='ParticpantClinInteract' WHERE `RFA_Function/Module`='Participant and Clinical Interations';
update work.assistmap SET RFA_FUNC='TransPilots' WHERE `RFA_Function/Module`='Pilot Translational and Clinical Studies';
update work.assistmap SET RFA_FUNC='PrecisionHlth' WHERE `RFA_Function/Module`='Precision Health';
update work.assistmap SET RFA_FUNC='Qual_Eff' WHERE `RFA_Function/Module`='Quality and Efficiency';
update work.assistmap SET RFA_FUNC='RKS' WHERE `RFA_Function/Module`='RKS';
update work.assistmap SET RFA_FUNC='SRV' WHERE `RFA_Function/Module`='SRV';
update work.assistmap SET RFA_FUNC='TWD' WHERE `RFA_Function/Module`='Translational Workforce Development';

 
############################################ 
#####CREATE RFA COMPONENT SUMMARY 
 
 drop table if exists  work.assist_compsumm;
 Create table work.assist_compsumm as
 SELECT UFID,
		MAX(Line_Item_Detail) AS Name
FROM work.assistmap
GROUP BY UFID;


ALTER TABLE work.assist_compsumm
        ADD Admin int(1),
        ADD AdminSupp int(1),
        ADD RschMeth int(1),
        ADD Informatics int(1),
        ADD CommCollab int(1),
        ADD HubCap int(1),
        ADD TransEndv int(1),
        ADD NetCap int(1),
        ADD NetSci int(1),
        ADD PrsPubHlth int(1),
        ADD CarreerDev int(1);
        
UPDATE work.assist_compsumm
SET      Admin=0,
         AdminSupp=0,
         RschMeth=0,
         Informatics=0,
         CommCollab=0,
         HubCap=0,
         TransEndv=0,
         NetCap=0,
         NetSci=0,
         PrsPubHlth=0,
         CarreerDev=0;
         
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.Admin=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='Admin';         

UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.Admin=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='Admin';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.AdminSupp=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='AdminSupp';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.RschMeth=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='RschMeth';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.Informatics=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='Informatics';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.CommCollab=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='CommCollab';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.HubCap=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='HubCap';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.TransEndv=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='TransEndv';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.NetCap=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='NetCap';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.NetSci=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='NetSci';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.PrsPubHlth=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='PrsPubHlth';
UPDATE work.assist_compsumm cs, work.assistmap lu SET cs.CarreerDev=1 WHERE cs.UFID=lu.UFID and lu.RFA_COMP='CarreerDev';

select * from work.assist_compsumm;

############################################ 
#####CREATE RFA Module SUMMARY

 drop table if exists  work.assist_modsumm;
 Create table work.assist_modsumm as
 SELECT UFID,
		MAX(Line_Item_Detail) AS Name
FROM work.assistmap
GROUP BY UFID;

ALTER TABLE work.assist_modsumm
        ADD Informatics int(1),
        ADD BERD int(1),
        ADD TeamScience int(1),
        ADD CommEng int(1),
        ADD Eval_CQI int(1),
        ADD InstCarreerDev int(1),
        ADD IntLifeSpan int(1),
        ADD IntgSpecialPop int(1),
        ADD RecruitCenter int(1),
        ADD TrialInnovation int(1),
        ADD NetworkSci int(1),
        ADD Org_Governce int(1),
        ADD ParticpantClinInteract int(1),
        ADD TransPilots int(1),
        ADD PrecisionHlth int(1),
        ADD Qual_Eff int(1),
        ADD RKS int(1),
        ADD SRV int(1),
        ADD TWD int(1);

UPDATE work.assist_modsumm
SET      Informatics=0,
         BERD=0,
         TeamScience=0,
         CommEng=0,
         Eval_CQI=0,
         InstCarreerDev=0,
         IntLifeSpan=0,
         IntgSpecialPop=0,
         RecruitCenter=0,
         TrialInnovation=0,
         NetworkSci=0,
         Org_Governce=0,
         ParticpantClinInteract=0,
         TransPilots=0,
         PrecisionHlth=0,
         Qual_Eff=0,
         RKS=0,
         SRV=0,
         TWD=0;
;
         
         
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.Informatics=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='Informatics';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.BERD=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='BERD';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.TeamScience=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='TeamScience';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.CommEng=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='CommEng';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.Eval_CQI=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='Eval_CQI';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.InstCarreerDev=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='InstCarreerDev';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.IntLifeSpan=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='IntLifeSpan';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.IntgSpecialPop=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='IntgSpecialPop';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.RecruitCenter=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='RecruitCenter';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.TrialInnovation=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='TrialInnovation';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.NetworkSci=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='NetworkSci';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.Org_Governce=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='Org_Governce';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.ParticpantClinInteract=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='ParticpantClinInteract';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.TransPilots=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='TransPilots';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.PrecisionHlth=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='PrecisionHlth';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.Qual_Eff=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='Qual_Eff';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.RKS=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='RKS';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.SRV=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='SRV';
UPDATE work.assist_modsumm cs, work.assistmap lu SET cs.TWD=1 WHERE cs.UFID=lu.UFID and lu.RFA_FUNC='TWD';



select * from  work.assist_modsumm;


############# FIX NO UFID Records in OWNER (FSU)


SET SQL_SAFE_UPDATES = 0;

UPDATE  work.OwnersSumm 
SET UFID=TRIM(Substr(Owner,1,12))
WHERE UFID="FSU";





############ Create owner and Modulke (from assist) list

drop table if exists work.temp1;
create table work.temp1 AS
select UFID,max(Name) as Name from work.assist_modsumm GROUP BY UFID
UNION ALL
select UFID,max(Owner) as Name  from work.OwnersSumm GROUP BY UFID;



drop table if exists work.UFIDOwnerModuleA;
create table work.UFIDOwnerModuleA AS
select UFID,max(Name) as Name from work.temp1 GROUP BY UFID;


drop table if exists work.UFIDOwnerModuleB;
create table work.UFIDOwnerModuleB AS
SELECT 	UOM.UFID,
		UOM.Name,
		lu.CommCollab,	
		lu.HubCap,			
		lu.Informatics,			
		lu.NetCap,
		lu.NetSci,		
		lu.PresHlth,			
		lu.ResMeth,			
		lu.TranEndv			
  FROM work.UFIDOwnerModuleA UOM
     LEFT JOIN work.OwnersSumm lu
	    ON UOM.UFID = lu.UFID;
;
drop table if exists work.UFIDOwnerModule;
create table work.UFIDOwnerModule AS
SELECT 	ta.UFID,
		ta.Name,
		ta.CommCollab,	
		ta.HubCap,			
		ta.Informatics,
		ta.NetCap,
		ta.NetSci,		
		ta.PresHlth,			
		ta.ResMeth,			
		ta.TranEndv	,
        lu.Informatics as Informatics_mod,
		lu.BERD,
		lu.TeamScience,
		lu.CommEng,
		lu.Eval_CQI,
		lu.InstCarreerDev,
		lu.IntLifeSpan,
		lu.IntgSpecialPop,
		lu.RecruitCenter,
		lu.TrialInnovation,
		lu.NetworkSci,
		lu.Org_Governce,
		lu.ParticpantClinInteract,
		lu.TransPilots,
		lu.PrecisionHlth,
		lu.Qual_Eff,
		lu.RKS,
		lu.SRV,
		lu.TWD
  FROM work.UFIDOwnerModuleB ta
     LEFT JOIN work.assist_modsumm lu
	    ON ta.UFID = lu.UFID;
;        
        
       
 desc  work.assist_modsumm;  
 
 
   
		
lu.CommCollab,	
lu.HubCap,			
lu.Informatics,			
lu.NetCap,
lu.NetSci,		
lu.PresHlth,			
lu.ResMeth,			
lu.TranEndv			