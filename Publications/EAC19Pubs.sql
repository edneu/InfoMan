select iCITE_Year as Year,
     SUM(Comp_CommEng) AS Comp_CommEng,
     SUM(Comp_Hub_Cap) AS Comp_Hub_Cap,
     SUM(Comp_Inform) AS Comp_Inform,
     SUM(Comp_NetCap) AS Comp_NetCap,
##     SUM(Comp_NetSci) AS Comp_NetSci,
     SUM(Comp_Pilot) AS Comp_Pilot,
     SUM(Comp_PresMed) AS Comp_PresMed,
     SUM(Comp_RschMeth) AS Comp_RschMeth,
##     SUM(Comp_SvcCtr) AS Comp_SvcCtr,
     SUM(Comp_Trans) AS Comp_Trans,
     SUM(Comp_TWD) AS Comp_TWD
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by iCITE_Year
order by iCITE_Year ;


##########################
drop table if exists plan.pubcomp1;
create table plan.pubcomp1 as
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Community Engagement' AS Component, Citation FROM plan.pubmaster WHERE Comp_CommEng=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Hub Capacity' AS Component, Citation FROM plan.pubmaster WHERE Comp_Hub_Cap=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Informatics' AS Component, Citation FROM plan.pubmaster WHERE Comp_Inform=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Network Capacity' AS Component, Citation FROM plan.pubmaster WHERE Comp_NetCap=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Network Science' AS Component, Citation FROM plan.pubmaster WHERE Comp_NetSci=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Pilot Awards' AS Component, Citation FROM plan.pubmaster WHERE Comp_Pilot=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Precision Medicine' AS Component, Citation FROM plan.pubmaster WHERE Comp_PresMed=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Research Methods' AS Component, Citation FROM plan.pubmaster WHERE Comp_RschMeth=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Service Center' AS Component, Citation FROM plan.pubmaster WHERE Comp_SvcCtr=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'Translational' AS Component, Citation FROM plan.pubmaster WHERE Comp_Trans=1 UNION ALL
SELECT iCITE_Year as Year, NIHMS_STATUS,  'TWD / Team Science' AS Component, Citation FROM plan.pubmaster WHERE Comp_TWD=1 ;
########################




SELECT Component,
       Year,
       Citation 
from plan.pubcomp1
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
ORDER BY Component,Citation;

select Component,count(*) from plan.pubcomp1 group by Component;


####################

DROP TABLE IF EXISTS pubs.EAC19_PUBS;
CREATE TABLE pubs.EAC19_PUBS AS
SELECT * From pubs.PUB_CORE;

ALTER TABLE pubs.EAC19_PUBS
ADD PrimaryCat varchar(45),
ADD Comp_CommEng int(1),
ADD Comp_Hub_Cap int(1),
ADD Comp_Inform int(1),
ADD Comp_NetCap int(1),
ADD Comp_NetSci int(1),
ADD Comp_Pilot int(1),
ADD Comp_PresMed int(1),
ADD Comp_RschMeth int(1),
ADD Comp_SvcCtr int(1),
ADD Comp_TWD int(1),
ADD Comp_Trans int(1),
ADD Comp_HubNet int(1),
ADD CatCount int(10),
ADD Compmask varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE pubs.EAC19_PUBS
SET  Comp_CommEng=0,
     Comp_Hub_Cap=0,
     Comp_Inform=0,
     Comp_NetCap=0,
     Comp_NetSci=0,
     Comp_Pilot=0,
     Comp_PresMed=0,
     Comp_RschMeth=0,
     Comp_SvcCtr=0,
     Comp_TWD=0,
     Comp_Trans=0,
     Comp_HubNet=0,
     CatCount=0;

UPDATE pubs.EAC19_PUBS ep, pubs.PUB_PROGRAM_ASSIGN lu
SET   ep.Comp_CommEng=lu.Comp_CommEng,
      ep.Comp_Hub_Cap=lu.Comp_Hub_Cap,
      ep.Comp_Inform=lu.Comp_Inform,
      ep.Comp_NetCap=lu.Comp_NetCap,
      ep.Comp_NetSci=lu.Comp_NetSci,
      ep.Comp_Pilot=lu.Comp_Pilot,
      ep.Comp_PresMed=lu.Comp_PresMed,
      ep.Comp_RschMeth=lu.Comp_RschMeth,
      ep.Comp_SvcCtr=lu.Comp_SvcCtr,
      ep.Comp_TWD=lu.Comp_TWD,
      ep.Comp_Trans=lu.Comp_Trans,
      ep.Compmask=lu.Compmask,
      ep.Comp_HubNet=lu.Comp_HubNet,
      ep.CatCount=lu.CatCount,
      ep.PrimaryCat=lu.PrimaryCat
WHERE ep.pubmaster_id2=lu.pubmaster_id2;

select distinct PrimaryCat from pubs.PUB_PROGRAM_ASSIGN;
