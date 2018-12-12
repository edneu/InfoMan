######################################################################
##### PUBLICATIONS
######################################################################



drop table if exists plan.pubout;
create table plan.pubout as
select iCITE_Year as Year,
		count(*) as NumPubs
 from plan.pubmaster
group by iCITE_Year
order by iCITE_Year ;


drop table if exists plan.pubout;
create table plan.pubout as
select iCITE_Year as Year,
		count(*) as NumPubs
 from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by iCITE_Year
order by iCITE_Year ;

select distinct NIHMS_Status from plan.pubmaster;


drop table if exists plan.pubout;
create table plan.pubout as
select iCITE_Year as Year,
SUM(TranslComm) AS TranslComm,
SUM(ServiceCenter) AS ServiceCenter,
SUM(Informatics) AS Informatics,
SUM(CommEng) AS CommEng,
SUM(TeamSci) AS TeamSci,
SUM(TWD) AS TWD,
SUM(KL2) AS KL2,
SUM(TL1) AS TL1,
SUM(Pilots) AS Pilots,
SUM(BERD) AS BERD,
SUM(RKS) AS RKS,
SUM(SpPops) AS SpPops,
SUM(PCI) AS PCI,
SUM(Multisite) AS Multisite,
SUM(Recruitment) AS Recruitment,
SUM(Metabolomics) AS Metabolomics,
SUM(NetSci) AS NetSci,
SUM(PMP) AS PMP

from plan.pubmaster
group by iCITE_Year
order by iCITE_Year ;





drop table if exists plan.pubout;
create table plan.pubout as
select iCITE_Year as Year,
SUM(TranslComm) AS TranslComm,
SUM(ServiceCenter) AS ServiceCenter,
SUM(Informatics) AS Informatics,
SUM(CommEng) AS CommEng,
SUM(TeamSci) AS TeamSci,
SUM(TWD) AS TWD,
SUM(KL2) AS KL2,
SUM(TL1) AS TL1,
SUM(Pilots) AS Pilots,
SUM(BERD) AS BERD,
SUM(RKS) AS RKS,
SUM(SpPops) AS SpPops,
SUM(PCI) AS PCI,
SUM(Multisite) AS Multisite,
SUM(Recruitment) AS Recruitment,
SUM(Metabolomics) AS Metabolomics,
SUM(NetSci) AS NetSci,
SUM(PMP) AS PMP
	
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by iCITE_Year
order by iCITE_Year ;



#################
## PUBLIST
#################
drop table if exists plan.pubout;
create table plan.pubout as
select iCITE_Year as Year,
	   Citation
 from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
order by iCITE_Year,Citation;


############
##NEW CATEGORIES
SET SQL_SAFE_UPDATES = 0;

Alter table plan.pubmaster
   ADD Comp_CommEng int(1),
   ADD Comp_Hub_Cap int(1),
   ADD Comp_Inform int(1),
   ADD Comp_NetCap int(1),
   ADD Comp_NetSci int(1),
   ADD Comp_Pilot int(1),
   ADD Comp_PresMed int(1),
   ADD Comp_RschMeth int(1),
   ADD Comp_SvcCtr int(1),
   ADD Comp_TWD int(1);

Update plan.pubmaster
SET
   Comp_CommEng=0,
   Comp_Hub_Cap=0,
   Comp_Inform=0,
   Comp_NetCap=0,
   Comp_NetSci=0,
   Comp_Pilot=0,
   Comp_PresMed=0,
   Comp_RschMeth=0,
   Comp_SvcCtr=0,
   Comp_TWD=0;

Alter table plan.pubmaster
ADD Comp_Trans int(1);

Update plan.pubmaster
SET Comp_Trans=0;



Update plan.pubmaster SET Comp_CommEng=1 WHERE TranslComm=1;
Update plan.pubmaster SET Comp_SvcCtr=1 WHERE ServiceCenter=1;
Update plan.pubmaster SET Comp_Inform=1 WHERE Informatics=1;
Update plan.pubmaster SET Comp_CommEng=1 WHERE CommEng=1;
Update plan.pubmaster SET Comp_NetSci=1 WHERE TeamSci=1;
Update plan.pubmaster SET Comp_TWD=1 WHERE TWD=1;
Update plan.pubmaster SET Comp_TWD=1 WHERE KL2=1;
Update plan.pubmaster SET Comp_TWD=1 WHERE TL1=1;
Update plan.pubmaster SET Comp_Pilot=1 WHERE Pilots=1;
Update plan.pubmaster SET Comp_RschMeth=1 WHERE BERD=1;
Update plan.pubmaster SET Comp_RschMeth=1 WHERE RKS=1;
Update plan.pubmaster SET Comp_Hub_Cap=1 WHERE SpPops=1;
Update plan.pubmaster SET Comp_Hub_Cap=1 WHERE PCI=1;
Update plan.pubmaster SET Comp_NetCap=1 WHERE Multisite=1;
Update plan.pubmaster SET Comp_NetCap=1 WHERE Recruitment=1;
Update plan.pubmaster SET Comp_PresMed=1 WHERE Metabolomics=1;
Update plan.pubmaster SET Comp_NetSci=1 WHERE NetSci=1;
Update plan.pubmaster SET Comp_PresMed=1 WHERE PMP=1;

##########################################################




### SERVICE CENTER LIST FOR NELSON
drop table if exists plan.pubout;
create table plan.pubout as
select pubmaster_id2,
       iCITE_Year as Year,
       Citation
 from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
AND ServiceCenter=1
order by Citation;


########################################################################
## DRN CLASSIFY 5-10-2018
########################################################################

UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=25;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=474;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=32;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=223;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=201;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=188;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=21;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=686;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=30;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=212;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=624;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=246;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=181;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=182;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=183;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=625;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=184;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=185;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=58;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=186;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=187;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=672;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=189;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=190;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=173;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=191;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=192;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=36;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=194;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=59;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=196;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=197;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=56;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=199;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=200;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=202;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=203;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=60;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=265;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=204;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=205;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=207;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=174;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=208;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=209;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=210;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=211;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=39;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=40;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=216;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=217;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=218;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=219;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=220;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=221;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=224;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=225;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=226;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=227;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=228;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=229;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=62;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=230;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=231;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=232;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=479;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=238;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=44;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=239;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=29;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=241;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=480;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=45;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=46;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=47;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=248;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=249;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=22;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=250;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=251;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=252;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=50;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=253;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=255;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=256;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=257;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=258;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=259;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=260;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=261;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=262;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=57;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=264;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=266;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=34;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=35;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=179;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=24;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=472;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=176;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=193;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=195;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=198;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=469;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=26;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=61;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=215;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=470;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=475;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=471;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=477;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=41;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=478;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=27;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=28;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=234;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=235;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=236;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=177;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=245;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=247;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=717;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=48;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=49;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=481;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=31;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=55;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=180;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=37;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=206;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=213;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=222;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=233;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=237;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=240;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=243;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=244;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=254;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=483;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=33;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=263;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=467;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=38;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=42;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=51;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=214;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=476;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=242;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=53;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=468;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=54;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=43;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=466;

UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=25;
UPDATE plan.pubmaster SET Comp_Inform=1 WHERE pubmaster_id2=474;
UPDATE plan.pubmaster SET Comp_Inform=1 WHERE pubmaster_id2=32;
UPDATE plan.pubmaster SET Comp_NetCap=1 WHERE pubmaster_id2=223;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=201;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=188;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=21;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=686;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=30;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=212;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=624;
UPDATE plan.pubmaster SET Comp_RschMeth=1 WHERE pubmaster_id2=246;



##########
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=52;
UPDATE plan.pubmaster SET Comp_PresMed=1 WHERE pubmaster_id2=178;
UPDATE plan.pubmaster SET Comp_Trans=1 WHERE pubmaster_id2=178;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET Comp_CommEng=1 WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET Comp_Hub_Cap=1 WHERE pubmaster_id2=482;

##########


## ADD NEtwork Science to TWD
UPDATE plan.pubmaster SET Comp_TWD=1 WHERE Comp_NetSci=1;



UPDATE plan.pubmaster 
SET NIHMS_Status="Available Online" 
WHERE pubmaster_id2 IN
(297, 
178, 
518, 
614, 
524, 
703, 
670, 
464, 
271, 
487, 
526, 
702, 
528, 
616, 
648, 
503, 
534, 
640, 
535, 
707, 
166, 
507, 
540, 
639, 
689, 
671, 
687, 
714, 
620, 
455, 
555, 
358, 
473, 
695, 
508, 
641, 
679, 
652, 
562, 
563, 
665, 
708, 
660, 
509, 
572, 
611, 
573, 
637, 
580, 
582, 
393, 
690, 
593, 
510, 
52, 
600, 
673, 
512, 
601, 
172, 
706, 
683, 
657, 
482, 
711, 
656, 
701, 
631);

UPDATE plan.pubmaster 
SET NIHMS_Status="In Process" 
WHERE pubmaster_id2 IN (608);

#######################################################################
#######################################################################

select distinct NIHMS_Status from plan.pubmaster;

###################################
### OPEN ACCESS PUBS NEW Categories
### by year
###################################
drop table if exists plan.pubyear;
create table plan.pubyear as
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

###################################
### OPEN ACCESS PUBS NEW Categories
### by Component (Category)
###################################
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

drop table if exists plan.pubcomp;
create table plan.pubcomp as
SELECT Component,
       Year,
       Citation 
from plan.pubcomp1
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
ORDER BY Component,Citation;




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



##########################################
## UPDATE PUBLICALLY ACCESSIBLE PUBS
##########################################
UPDATE plan.pubmaster 
SET NIHMS_Status="Available Online" 
WHERE pubmaster_id2 IN
(297, 
178, 
518, 
614, 
524, 
703, 
670, 
464, 
271, 
487, 
526, 
702, 
528, 
616, 
648, 
503, 
534, 
640, 
535, 
707, 
166, 
507, 
540, 
639, 
689, 
671, 
687, 
714, 
620, 
455, 
555, 
358, 
473, 
695, 
508, 
641, 
679, 
652, 
562, 
563, 
665, 
708, 
660, 
509, 
572, 
611, 
573, 
637, 
580, 
582, 
393, 
690, 
593, 
510, 
52, 
600, 
673, 
512, 
601, 
172, 
706, 
683, 
657, 
482, 
711, 
656, 
701, 
631);


UPDATE plan.pubmaster SET NIHMS_Status="Available Online" Where pubmaster_id2 in (619,622);
SET SQL_SAFE_UPDATES = 0;


Alter table plan.pubmaster ADD Comp_HubNet int(1);
UPDATE plan.pubmaster SET Comp_HubNet=0;
UPDATE plan.pubmaster SET Comp_HubNet=1 WHERE Comp_Hub_Cap=1 OR Comp_NetCap=1;

#SET Compmask=CONCAT(Comp_Hub_Cap,Comp_Inform,Comp_CommEng,Comp_Pilot,Comp_PresMed,Comp_RschMeth,Comp_TWD,Comp_Trans);



Alter table plan.pubmaster ADD Compmask varchar(12);
UPDATE plan.pubmaster
SET Compmask=CONCAT(Comp_HubNet,Comp_Inform,Comp_CommEng,Comp_Pilot,Comp_PresMed,Comp_RschMeth,Comp_TWD,Comp_Trans);




select Compmask,Comp_HubNet,Comp_Inform,Comp_CommEng,Comp_Pilot,Comp_PresMed,Comp_RschMeth,Comp_TWD,Comp_Trans  from plan.pubmaster;

select sum(Comp_Trans) from plan.pubmaster;


Alter table plan.pubmaster Add CatCount int(10);
UPDATE plan.pubmaster SET CatCount=0;
UPDATE plan.pubmaster SET CatCount=Comp_HubNet+Comp_Inform+Comp_CommEng+Comp_Pilot+Comp_PresMed+Comp_RschMeth+Comp_TWD+Comp_Trans;






select Compmask,CatCount from plan.pubmaster;


select Compmask,count(*) from plan.pubmaster;

pubmaster_id2
Alter Table plan.pubmaster Add PrimaryCat varchar(45); 

UPDATE plan.pubmaster SET PrimaryCat='';
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE Compmask='10000000';
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE Compmask='00000001';
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE Compmask='00000100';
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE Compmask='00001000';
UPDATE plan.pubmaster SET PrimaryCat='TWD / Team Science' WHERE Compmask='00000010';
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE Compmask='01000000';
UPDATE plan.pubmaster SET PrimaryCat='Pilot Awards' WHERE Compmask='00010000';
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE Compmask='00100000';

UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=25;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=474;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=32;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine'  WHERE pubmaster_id2=223;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=201;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=188;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=21;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=686;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=30;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=212;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=624;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=246;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=181;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=182;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=183;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=625;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=184;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=185;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=58;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=186;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=187;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=672;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=189;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=190;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=173;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=191;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=192;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=36;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=194;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=59;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=196;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=197;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=56;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=199;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=200;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=202;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=203;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=60;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=265;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=204;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=205;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=207;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=174;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=208;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=209;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=210;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=211;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=39;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=40;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=216;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=217;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=218;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=219;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=220;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=221;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=224;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=225;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=226;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=227;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=228;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=229;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=62;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=230;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=231;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=232;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=479;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=238;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=44;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=239;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=29;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=241;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=480;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=45;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=46;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=47;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=248;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=249;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=22;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=250;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=251;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=252;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=50;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=253;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=255;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=256;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=257;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=258;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=259;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=260;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=261;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=262;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=57;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=264;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=266;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=34;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=35;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=179;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=24;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=472;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=176;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=193;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=195;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=198;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=469;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=26;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=61;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=215;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=470;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=475;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=471;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=477;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=41;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=478;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=27;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=28;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=234;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=235;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=236;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=177;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=245;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=247;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=717;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=48;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=49;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=481;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=31;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=55;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=180;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=37;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=206;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=213;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=222;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=233;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=237;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=240;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=243;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=244;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=254;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=483;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=33;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity'  WHERE pubmaster_id2=263;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine'  WHERE pubmaster_id2=467;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine'  WHERE pubmaster_id2=38;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine'  WHERE pubmaster_id2=42;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine'  WHERE pubmaster_id2=51;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=214;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=476;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=242;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=53;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=468;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=54;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods'  WHERE pubmaster_id2=43;
UPDATE plan.pubmaster SET PrimaryCat='Translational'  WHERE pubmaster_id2=466;




UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=52;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=178;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=482;



Select distinct PrimaryCat from plan.pubmaster;

drop table if exists plan.primarycat;
create table plan.primarycat as
SELECT pubmaster_id2,iCITE_Year,Citation,PrimaryCat,Comp_CommEng,Comp_HubNet,Comp_Inform,Comp_Pilot,Comp_PresMed,Comp_RschMeth,Comp_TWD,Comp_Trans
FROM plan.pubmaster
WHERE PrimaryCat="";


## DRN 5/11/2018
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=3;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=4;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=5;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=10;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=12;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=17;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=19;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=65;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=68;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=77;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=83;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=85;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=90;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=92;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=97;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=98;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=128;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=129;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=134;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=144;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=147;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=151;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=152;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=153;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=157;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=160;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=161;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=165;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=166;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=169;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=170;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=171;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=271;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=274;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=275;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=276;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=283;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=285;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=287;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=288;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=290;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=291;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=293;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=301;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=308;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=316;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=320;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=322;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=338;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=339;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=342;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=343;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=344;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=353;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=368;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=373;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=379;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=380;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=395;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=399;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=405;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=411;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=416;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=431;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=434;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=435;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=436;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=442;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=446;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=448;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=452;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=455;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=456;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=457;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=459;
UPDATE plan.pubmaster SET PrimaryCat='' WHERE pubmaster_id2=460;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=461;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=463;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=465;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=484;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=489;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=492;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=494;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=495;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=497;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=498;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=499;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=501;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=502;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=503;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=504;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=505;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=507;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=510;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=524;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=528;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=530;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=531;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=534;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=543;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=548;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=563;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=564;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=568;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=569;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=570;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=573;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=575;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=576;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=577;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=578;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=584;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=585;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=589;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=593;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=596;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=603;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=606;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=607;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=609;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=612;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=613;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=615;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=623;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=626;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=627;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=629;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=638;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=639;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=660;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=685;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=702;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=704;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=705;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=711;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=714;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=715;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=718;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=722;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=723;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=728;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=729;


## NO PRIMARY
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=17;
UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=288;
UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=308;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=316;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=379;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=460;

## PILOTS
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=1;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=2;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=6;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=7;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=8;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=9;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=11;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=13;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=14;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=15;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=16;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=18;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=20;
UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=158;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=159;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=162;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=163;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=164;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=167;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=168;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=172;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=458;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=462;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=464;
UPDATE plan.pubmaster SET PrimaryCat='Translational' WHERE pubmaster_id2=680;
UPDATE plan.pubmaster SET PrimaryCat='Precision Medicine' WHERE pubmaster_id2=682;
UPDATE plan.pubmaster SET PrimaryCat='Hub / Network Capacity' WHERE pubmaster_id2=691;

SELECT PrimaryCat,count(*) from plan.pubmaster group by PrimaryCat;








drop table if exists plan.primarycat;
create table plan.primarycat as
SELECT pubmaster_id2,iCITE_Year,Citation,PrimaryCat,Comp_CommEng,Comp_HubNet,Comp_Inform,Comp_Pilot,Comp_PresMed,Comp_RschMeth,Comp_TWD,Comp_Trans
FROM plan.pubmaster
WHERE Compmask='00010000';






select * from plan.pubmaster where Compmask="00000001";


create table plan.xxx as
select * from plan.pubmaster where Compmask="000000000"; 





#################################################################
########### TABLES and Data for Bibliography
#################################################################
drop table if exists plan.pubyear;
create table plan.pubyear as
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

############################################################################
##########  YEAR BIBLIO
############################################################################
DROP TABLE IF EXISTS plan.bib_year;
CREATE TABLE plan.bib_year As
SELECT 	iCITE_Year,
		Citation
FROM plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
ORDER BY iCITE_Year, Citation;


############################################################################
##########  PRIMARY CATEGORY BIBLIO
############################################################################
DROP TABLE IF EXISTS plan.bib_cat;
CREATE TABLE plan.bib_cat As
SELECT 	pubmaster_id2,
        PrimaryCat,
		Citation
FROM plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
ORDER BY PrimaryCat, Citation;


###########################################################################

select PrimaryCat,count(*) from plan.pubmaster WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online") group by PrimaryCat;

select iCITE_Year,count(*) from plan.pubmaster WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online") group by iCITE_Year;

UPDATE plan.pubmaster SET  PrimaryCat="Precision Health" WHERE PrimaryCat='Precision Medicine';

select NIHMS_STATUS,count(*) from plan.pubmaster WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online") group by NIHMS_STATUS;

UPDATE plan.pubmaster SET Citation="Shenkman E, Hurt M, Hogan W, Carrasquillo O, Smith S, Brickman A, Nelson D. OneFlorida Clinical Research Consortium: Linking a Clinical and Translational Science Institute With a Community-Based Distributive Medical Education Model. Acad Med. 2017 Oct 17. doi: 10.1097/ACM.0000000000002029. [Epub ahead of print]. PMID: 9045273." WHERE pubmaster_id2=612;

#### SUMMARY TABLE
drop table if exists plan.pubyear;
create table plan.pubyear as
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

drop table if exists plan.xxx;
create table plan.xxx
select PrimaryCat,
     SUM(TranslComm) AS TranslComm,
     SUM(ServiceCenter) AS ServiceCenter,
     SUM(Informatics) AS Informatics,
     SUM(CommEng) AS CommEng,
     SUM(TeamSci) AS TeamSci,
     SUM(TWD) AS TWD,
     SUM(KL2) AS KL2,
     SUM(TL1) AS TL1,
     SUM(Pilots) AS Pilots,
     SUM(BERD) AS BERD,
     SUM(RKS) AS RKS,
     SUM(SpPops) AS SpPops,
     SUM(PCI) AS PCI,
     SUM(Multisite) AS Multisite,
     SUM(Recruitment) AS Recruitment,
     SUM(Metabolomics) AS Metabolomics,
     SUM(NetSci) AS NetSci,
     SUM(PMP) AS PMP
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by PrimaryCat;



desc plan.pubmaster;


drop table if exists plan.xxx;
create table plan.xxx
select PrimaryCat,
    SUM(Comp_HubNet) AS Comp_HubNet,
    SUM(Comp_Hub_Cap) AS Comp_Hub_Cap,
    SUM(Comp_NetCap) AS Comp_NetCap,
    SUM(Comp_CommEng) AS Comp_CommEng,
    SUM(Comp_Inform) AS Comp_Inform,
    SUM(Comp_NetSci) AS Comp_NetSci,
    SUM(Comp_Pilot) AS Comp_Pilot,
    SUM(Comp_PresMed) AS Comp_PresMed,
    SUM(Comp_RschMeth) AS Comp_RschMeth,
    SUM(Comp_SvcCtr) AS Comp_SvcCtr,
    SUM(Comp_TWD) AS Comp_TWD,
    SUM(Comp_Trans) AS Comp_Trans
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by PrimaryCat;


select PrimaryCat, count(*) from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by PrimaryCat;


select PrimaryCat, iCITE_Year, count(*) from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by PrimaryCat,iCITE_Year;




Alter table plan.pubmaster Add CatCount int(10);
UPDATE plan.pubmaster SET CatCount=0;
UPDATE plan.pubmaster SET CatCount=TranslComm+ServiceCenter+Informatics+CommEng+TeamSci+TWD+KL2+TL1+Pilots+BERD+RKS+SpPops+PCI+Multisite+Recruitment+Metabolomics+NetSci+PMP;;





select Count(*)from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
and CatCount>1
;



##############
SELECT NIHMS_STATUS, count(*) from plan.pubmaster group by NIHMS_STATUS;

Alter table plan.pubmaster DROP NonPMCSufix ;

Alter table plan.pubmaster ADD NonPMCSufix varchar(125);

SET SQL_SAFE_UPDATES = 0;
UPDATE plan.pubmaster SET NonPMCSufix="";

UPDATE plan.pubmaster SET NonPMCSufix="PMC Journal – In Process." WHERE NIHMS_STATUS="In Process";

UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/article/10.1007%2Fs10943-015-0168-5' WHERE pubmaster_id2=297;
UPDATE plan.pubmaster SET NonPMCSufix='  http://ascopubs.org/doi/full/10.1200/JCO.2015.63.9674' WHERE pubmaster_id2=178;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.thieme-connect.com/products/ejournals/html/10.1055/s-0037-1601893' WHERE pubmaster_id2=518;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.1080/13611267.2017.1403579?scroll=top&needAccess=true' WHERE pubmaster_id2=614;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5548986/' WHERE pubmaster_id2=524;
UPDATE plan.pubmaster SET NonPMCSufix='  http://ovidsp.uk.ovid.com/sp-3.29.1a/ovidweb.cgi?WebLinkFrameset=1&S=GDMHPDKHMOHFLAKJFNFKHEEGMGPIAA00&returnUrl=ovidweb.cgi%3fMain%2bSearch%2bPage%3d1%26S%3dGDMHPDKHMOHFLAKJFNFKHEEGMGPIAA00&directlink=http%3a%2f%2fovidsp.uk.ovid.com%2fovftpdfs%2fPDHFFNEGHEKJMO00%2ffs046%2fovft%2flive%2fgv023%2f00000658%2f00000658-900000000-95696.pdf&filename=MySurgeryRisk%3a++Development+and+Validation+of+a+Machine-learning+Risk+Algorithm+for+Major+Complications+and+Death+After+Surgery.&navigation_links=NavLinks.S.sh.22.1&link_from=S.sh.22%7c1&pdf_key=PDHFFNEGHEKJMO00&pdf_index=/fs046/ovft/live/gv023/00000658/00000658-900000000-95696&D=ovft&link_set=S.sh.22|1|sl_10|resultSet|S.sh.22.23|0' WHERE pubmaster_id2=703;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1876285917305582?via%3Dihub' WHERE pubmaster_id2=670;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/pdf/10.1021/acs.molpharmaceut.7b00484' WHERE pubmaster_id2=464;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.futuremedicine.com/doi/10.2217/fca-2016-0045' WHERE pubmaster_id2=271;
UPDATE plan.pubmaster SET NonPMCSufix='  https://insights.ovid.com/pubmed?pmid=28267043' WHERE pubmaster_id2=487;
UPDATE plan.pubmaster SET NonPMCSufix='  http://care.diabetesjournals.org/content/40/10/e145.long' WHERE pubmaster_id2=526;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.1080/10410236.2018.1443263' WHERE pubmaster_id2=702;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.3109/00952990.2016.1165239' WHERE pubmaster_id2=528;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.1080/00949655.2017.1292276?src=recsys' WHERE pubmaster_id2=616;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1525861016306818?via%3Dihub' WHERE pubmaster_id2=648;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.1080/10810730.2017.1363324' WHERE pubmaster_id2=503;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.thieme-connect.de/products/ejournals/issue/10.1055/s-007-36226' WHERE pubmaster_id2=534;
UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/aim/fullarticle/2529686/long-term-pioglitazone-treatment-patients-nonalcoholic-steatohepatitis-prediabetes-type-2' WHERE pubmaster_id2=640;
UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/aim/fullarticle/2636750/high-generic-drug-prices-market-competition-retrospective-cohort-study' WHERE pubmaster_id2=535;
UPDATE plan.pubmaster SET NonPMCSufix='  http://ovidsp.uk.ovid.com/sp-3.29.1a/ovidweb.cgi?WebLinkFrameset=1&S=GDMHPDKHMOHFLAKJFNFKHEEGMGPIAA00&returnUrl=ovidweb.cgi%3fMain%2bSearch%2bPage%3d1%26S%3dGDMHPDKHMOHFLAKJFNFKHEEGMGPIAA00&directlink=http%3a%2f%2fovidsp.uk.ovid.com%2fovftpdfs%2fPDHFFNEGHEKJMO00%2ffs046%2fovft%2flive%2fgv023%2f00045391%2f00045391-900000000-98641.pdf&filename=Antibiotic+Stewardship+for+Acute+Exacerbation+of+Chronic+Obstructive+Pulmonary+Disease.&navigation_links=NavLinks.S.sh.24.1&link_from=S.sh.24%7c1&pdf_key=PDHFFNEGHEKJMO00&pdf_index=/fs046/ovft/live/gv023/00045391/00045391-900000000-98641&D=ovft&link_set=S.sh.24|1|sl_10|resultSet|S.sh.24.25|0' WHERE pubmaster_id2=707;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.tandfonline.com/doi/full/10.3109/01612840.2016.1153174' WHERE pubmaster_id2=166;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.researchgate.net/publication/319287487_Evaluating_the_Efficacy_of_a_Registry_linked_to_a_Consent_to_Re-Contact_Program_and_Communication_Strategies_for_Recruiting_and_Enrolling_Participants_into_Clinical_Trials' WHERE pubmaster_id2=507;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5724091/' WHERE pubmaster_id2=540;
UPDATE plan.pubmaster SET NonPMCSufix='  http://journals.sagepub.com/doi/pdf/10.1177/1090198116648291' WHERE pubmaster_id2=639;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/10.1021/acs.analchem.7b04084' WHERE pubmaster_id2=689;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/10.1021/acs.analchem.7b04463' WHERE pubmaster_id2=671;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/10.1021/acschemneuro.7b00468' WHERE pubmaster_id2=687;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5920146/' WHERE pubmaster_id2=714;
UPDATE plan.pubmaster SET NonPMCSufix='  http://revista.ibict.br/ciinf/article/viewFile/4012/3451' WHERE pubmaster_id2=620;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5836499/' WHERE pubmaster_id2=455;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S037687161730412X?via%3Dihub' WHERE pubmaster_id2=555;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0376871616300692?via%3Dihub' WHERE pubmaster_id2=358;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5553740/' WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.future-science.com/doi/pdf/10.4155/bio-2017-0209' WHERE pubmaster_id2=695;
UPDATE plan.pubmaster SET NonPMCSufix='  http://journals.sagepub.com/doi/pdf/10.1177/0261927X16663256' WHERE pubmaster_id2=508;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1744165X16300130?via%3Dihub' WHERE pubmaster_id2=641;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0149291817311049?via%3Dihub' WHERE pubmaster_id2=679;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0955286316304454?via%3Dihub' WHERE pubmaster_id2=652;
UPDATE plan.pubmaster SET NonPMCSufix='  http://bmjopen.bmj.com/content/7/7/e015136' WHERE pubmaster_id2=562;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5553004/' WHERE pubmaster_id2=563;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0147956317301607?via%3Dihub' WHERE pubmaster_id2=665;
UPDATE plan.pubmaster SET NonPMCSufix='  https://academic.oup.com/rheumatology/advance-article/doi/10.1093/rheumatology/key052/4943961' WHERE pubmaster_id2=708;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0016508517359565?via%3Dihub' WHERE pubmaster_id2=660;
UPDATE plan.pubmaster SET NonPMCSufix='  http://journals.sagepub.com/doi/pdf/10.1177/0261927X16663258' WHERE pubmaster_id2=509;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0306460317301351?via%3Dihub' WHERE pubmaster_id2=572;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/article/10.1007%2Fs10985-017-9390-7' WHERE pubmaster_id2=611;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S108112061631362X?via%3Dihub' WHERE pubmaster_id2=573;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/10.1021/acs.analchem.5b04263' WHERE pubmaster_id2=637;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.prd-journal.com/article/S1353-8020(17)30265-1/fulltext' WHERE pubmaster_id2=580;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1353802017302870?via%3Dihub' WHERE pubmaster_id2=582;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S0749379716301222?via%3Dihub' WHERE pubmaster_id2=393;
UPDATE plan.pubmaster SET NonPMCSufix='  https://onlinelibrary.wiley.com/doi/full/10.1111/trf.14510' WHERE pubmaster_id2=690;
UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/aim/fullarticle/2657698/oral-human-papillomavirus-infection-differences-prevalence-between-sexes-concordance-genital' WHERE pubmaster_id2=593;
UPDATE plan.pubmaster SET NonPMCSufix='  http://journals.sagepub.com/doi/pdf/10.1177/0261927X16663255' WHERE pubmaster_id2=510;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.annualreviews.org/doi/full/10.1146/annurev-nutr-071714-034330?url_ver=Z39.88-2003&rfr_id=ori%3Arid%3Acrossref.org&rfr_dat=cr_pub%3Dpubmed&' WHERE pubmaster_id2=52;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/protocol/10.1007%2F978-1-4939-6996-8_10' WHERE pubmaster_id2=600;
UPDATE plan.pubmaster SET NonPMCSufix='  https://pubs.acs.org/doi/10.1021/acs.analchem.7b04042' WHERE pubmaster_id2=673;
UPDATE plan.pubmaster SET NonPMCSufix='  http://ovidsp.uk.ovid.com/sp-3.29.1a/ovidweb.cgi?T=JS&PAGE=fulltext&D=ovft&AN=00001504-201701000-00009&NEWS=N&CSC=Y&CHANNEL=PubMed' WHERE pubmaster_id2=512;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5610494/' WHERE pubmaster_id2=601;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S004938481630559X?via%3Dihub' WHERE pubmaster_id2=172;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S004938481830269X?via%3Dihub' WHERE pubmaster_id2=706;
UPDATE plan.pubmaster SET NonPMCSufix='  http://jnnp.bmj.com/content/early/2018/01/11/jnnp-2017-317098.long' WHERE pubmaster_id2=683;
UPDATE plan.pubmaster SET NonPMCSufix='  https://onlinelibrary.wiley.com/doi/full/10.1002/ijc.30882' WHERE pubmaster_id2=657;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1934148216302271?via%3Dihub' WHERE pubmaster_id2=482;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/article/10.1007%2Fs10903-018-0729-2' WHERE pubmaster_id2=711;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.sciencedirect.com/science/article/pii/S1933171117301900?via%3Dihub' WHERE pubmaster_id2=656;
UPDATE plan.pubmaster SET NonPMCSufix='  https://onlinelibrary.wiley.com/doi/full/10.1002/sim.7622' WHERE pubmaster_id2=701;
UPDATE plan.pubmaster SET NonPMCSufix='  https://onlinelibrary.wiley.com/doi/full/10.1111/biom.12301' WHERE pubmaster_id2=631;

UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/aim/fullarticle/2601196/long-term-pioglitazone-treatment-patients-nonalcoholic-steatohepatitis' WHERE pubmaster_id2=640;
UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/aim/fullarticle/2657698/oral-human-papillomavirus-infection-differences-prevalence-between-sexes-concordance-genital' WHERE pubmaster_id2=593;
UPDATE plan.pubmaster SET NonPMCSufix='  http://discovery.ucl.ac.uk/10033954/1/2727930_File000005.pdf' WHERE pubmaster_id2=723;
UPDATE plan.pubmaster SET NonPMCSufix='  http://journals.sagepub.com/doi/pdf/10.1177/0308575917714714' WHERE pubmaster_id2=619;
UPDATE plan.pubmaster SET NonPMCSufix='  https://academic.oup.com/jssam/article/6/2/149/4822522' WHERE pubmaster_id2=719;
UPDATE plan.pubmaster SET NonPMCSufix='  https://insights.ovid.com/pubmed?pmid=27798487' WHERE pubmaster_id2=512;
UPDATE plan.pubmaster SET NonPMCSufix='  https://insights.ovid.com/pubmed?pmid=29489489' WHERE pubmaster_id2=703;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/content/pdf/10.1007%2Fs11192-017-2280-7.pdf' WHERE pubmaster_id2=622;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/content/pdf/10.1007%2Fs11306-017-1280-1.pdf' WHERE pubmaster_id2=720;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/content/pdf/10.1007%2Fs11306-018-1340-1.pdf' WHERE pubmaster_id2=730;
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/content/pdf/10.1007%2Fs41686-018-0018-4.pdf' WHERE pubmaster_id2=722;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.annualreviews.org/doi/pdf/10.1146/annurev-nutr-071714-034330' WHERE pubmaster_id2=52;

UPDATE plan.pubmaster SET Citation='Bihorac A, Ozrazgat-Baslanti T, Ebadi A, Motaei A, Madkour M, Pardalos PM, Lipori G, Hogan WR, Efron PA, Moore F, Moldawer LL, Wang DZ, Hobson CE, Rashidi P, Li X, Momcilovic P. MySurgeryRisk: Development and Validation of a Machine-learning Risk Algorithm for Major Complications and Death After Surgery.  Ann Surg. 2018 Feb 27. doi: 10.1097/SLA.0000000000002706. [Epub ahead of print] PubMed PMID: 29489489.' WHERE pubmaster_id2=703;
UPDATE plan.pubmaster SET Citation='Bowden, J.A., Ulmer, C.Z., Jones, C.M., Koelmel, J.P. and Yost, R.A., 2018. NIST lipidomics workflow questionnaire: an assessment of community-wide methodologies and perspectives. Metabolomics, 14(5), p.53.' WHERE pubmaster_id2=730;
UPDATE plan.pubmaster SET Citation='Flood-Grady E, Clark VC, Bauer A, Morelli L, Horne P, Krieger JL, Nelson DR. Evaluating the Efficacy of a Registry linked to a Consent to Re-Contact Program and Communication Strategies for Recruiting and Enrolling Participants into Clinical Trials. Contemp Clin Trials Commun. 2017 Dec;8:62-66. doi: 10.1016/j.conctc.2017.08.005. Epub 2017 Aug 24. PubMed PMID: 29503877; PubMed Central PMCID: PMC5831259.' WHERE pubmaster_id2=507;
UPDATE plan.pubmaster SET Citation='Patterson, R. E., A. S. Kirpich, J. P. Koelmel, S. Kalavalapalli, A. M. Morse, K. Cusi, N. E. Sunny, L. M. McIntyre, T. J. Garrett, and R. A. Yost. "Improved experimental data processing for UHPLC–HRMS/MS lipidomics applied to nonalcoholic fatty liver disease." Metabolomics 13, no. 11 (2017): 142.' WHERE pubmaster_id2=720;
UPDATE plan.pubmaster SET Citation='Sonawane K, Suk R, Chiao EY, Chhatwal J, Qiu P, Wilkin T, Nyitray AG, Sikora AG, Deshmukh AA. Oral Human Papillomavirus Infection: Differences in Prevalence Between Sexes and Concordance With Genital Human Papillomavirus Infection, NHANES 2011 to 2014. Ann Intern Med. 2017 Nov 21;167(10):714-724. doi: 10.7326/M17-1363. Epub 2017 Oct 17. PubMed PMID: 29049523.' WHERE pubmaster_id2=593;
UPDATE plan.pubmaster SET Citation='Ulmer, C.Z., Yost, R.A. and Garrett, T.J., 2017. Global UHPLC/HRMS Lipidomics Workflow for the Analysis of Lymphocyte Suspension Cultures. Lipidomics, pp.175-185.' WHERE pubmaster_id2=721;

UPDATE plan.pubmaster SET NIHMS_STATUS='Book Chapter' WHERE pubmaster_id2=721;
UPDATE plan.pubmaster SET NIHMS_STATUS='Not in NIHMS' WHERE pubmaster_id2=707;
UPDATE plan.pubmaster SET NIHMS_STATUS='Not in NIHMS' WHERE pubmaster_id2=456;
UPDATE plan.pubmaster SET NIHMS_STATUS='PMC Compliant' WHERE pubmaster_id2=507;

UPDATE plan.pubmaster SET Citation='Dietrich E, Klinker KP, Li J, Nguyen CT, Quillen D, Davis KA. Antibiotic Stewardship for Acute Exacerbation of Chronic Obstructive Pulmonary Disease. Am J Ther. 2018 Mar 20. doi: 10.1097/MJT.0000000000000717. [Epub ahead of print] PubMed PMID: 29561269.' WHERE pubmaster_id2=707;
UPDATE plan.pubmaster SET Citation='Iafrate, P., Lipori, G.P., Harle, C.A., Nelson, D.R., Barnash, T.J., Leebove, P.T., Adams, K.A. and Montgomer, D., 2016. Consent2Share: an integrated broad consenting process for re-contacting potential study subjects. J. Clin. Transl. Res, 2(4).' WHERE pubmaster_id2=456;
UPDATE plan.pubmaster SET NonPMCSufix='  http://annals.org/data/journals/aim/936603/aime201711210-m171363.pdf' WHERE pubmaster_id2=593;
UPDATE plan.pubmaster SET NonPMCSufix='  https://www.annualreviews.org/doi/pdf/10.1146/annurev-nutr-071714-034330' WHERE pubmaster_id2=52;
UPDATE plan.pubmaster SET NIHMS_STATUS='  Available Online' WHERE pubmaster_id2=456;
UPDATE plan.pubmaster SET NonPMCSufix='  http://www.jctres.com/media/filer_public/54/bc/54bc078f-888e-4c7a-bb4c-ab8973150d73/iafrate2016jclintranslres_epub.pdf' WHERE pubmaster_id2=456;

UPDATE plan.pubmaster SET NIHMS_STATUS='PMC Compliant' WHERE pubmaster_id2=507;
UPDATE plan.pubmaster set NIHMS_Status="Available Online" WHERE NIHMS_Status='  Available Online';
UPDATE plan.pubmaster SET NonPMCSufix='  https://link.springer.com/protocol/10.1007/978-1-4939-6946-3_13' WHERE pubmaster_id2=721;						
UPDATE plan.pubmaster set NIHMS_Status="Available Online" WHERE pubmaster_id2=721;

drop table if exists plan.xxx;
create table plan.xxx as
select pubmaster_id2,concat(Citation,NonPMCSufix) as fullcite
FROM plan.pubmaster
#WHERE NIHMS_STATUS IN ("In Process","Available Online");
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online");;


######## Category Changes BAsed on Exec Committee 5-15-2018
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=507;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=345;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=349;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=350;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=351;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=710;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=206;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=555;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=358;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=371;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=41;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=372;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=377;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=572;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=118;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=383;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=240;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=393;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=243;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=587;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=588;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=612;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=66;
 UPDATE plan.pubmaster SET PrimaryCat='Community Engagement' WHERE pubmaster_id2=428;
 UPDATE plan.pubmaster SET PrimaryCat='Informatics' WHERE pubmaster_id2=98;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=121;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=28;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=391;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=583;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=406;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=408;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=136;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=246;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=140;
 UPDATE plan.pubmaster SET PrimaryCat='Research Methods' WHERE pubmaster_id2=159;
 UPDATE plan.pubmaster SET PrimaryCat='TWD / Team Science' WHERE pubmaster_id2=463;
 UPDATE plan.pubmaster SET PrimaryCat='TWD / Team Science' WHERE pubmaster_id2=177;


UPDATE plan.pubmaster SET Citation="Acheampong AB, Striley CW, Cottler LB. Prescription opioid use, illicit drug use, and sexually transmitted infections among participants from a community engagement program in North Central Florida. J Subst Use. 2017;22(1):90-95. doi:  10.3109/14659891.2016.1144805. Epub 2016 May 25. PubMed PMID: 29515331; PubMed Central PMCID: PMC5836499." WHERE pubmaster_id2=455;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=455;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=455;



UPDATE plan.pubmaster SET Citation="Kline KP, Shaw L, Beyth RJ, Plumb J, Nguyen L, Huo T, Winchester DE. Perceptions of patients and providers on myocardial perfusion imaging for asymptomatic patients, choosing wisely, and professional liability. BMC Health Serv Res. 2017 Aug 11;17(1):553. doi: 10.1186/s12913-017-2510-y. PubMed PMID: 28800760; PubMed Central PMCID: PMC5553740." WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=473;


UPDATE plan.pubmaster SET Citation="Bian J, Guo Y, Xie M, Parish AE, Wardlaw I, Brown R, Modave F, Zheng D, Perry  TT. Exploring the Association Between Self-Reported Asthma Impact and Fitbit-Derived Sleep Quality and Physical Activity Measures in Adolescents. JMIR  Mhealth Uhealth. 2017 Jul 25;5(7):e105. doi: 10.2196/mhealth.7346. PubMed PMID: 28743679; PubMed Central PMCID: PMC5548986." WHERE pubmaster_id2=524;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=524;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=524;

UPDATE plan.pubmaster SET Citation="He Z, Bian J, Carretta HJ, Lee J, Hogan WR, Shenkman E, Charness N. Prevalence of Multiple Chronic Conditions Among Older Adults in Florida and the United States: Comparative Analysis of the OneFlorida Data Trust and National Inpatient  Sample. J Med Internet Res. 2018 Apr 12;20(4):e137. doi: 10.2196/jmir.8961. PubMed PMID: 29650502; PubMed Central PMCID: PMC5920146." WHERE pubmaster_id2=714;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=714;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=714;

UPDATE plan.pubmaster SET Citation="Lucero RJ, Frimpong JA, Fehlberg EA, Bjarnadottir RI, Weaver MT, Cook C, Modave F, Rathore MH, Morano JP, Ibanez G, Cook RL. The Relationship Between Individual Characteristics and Interest in Using a Mobile Phone App for HIV Self-Management: Observational Cohort Study of People Living With HIV. JMIR Mhealth Uhealth. 2017 Jul 27;5(7):e100. doi: 10.2196/mhealth.7853. PubMed PMID: 28751298; PubMed Central PMCID: PMC5553004." WHERE pubmaster_id2=563;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=563;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=563;

UPDATE plan.pubmaster SET Citation="Fehlberg EA, Lucero RJ, Weaver MT, McDaniel AM, Chandler AM, Richey PA, Mion LC, Shorr RI. Associations between hyponatraemia, volume depletion and the risk of falls in US hospitalised patients: a case-control study. BMJ Open. 2017 Aug 7;7(8):e017045. doi: 10.1136/bmjopen-2017-017045. PubMed PMID: 28790043; PubMed Central PMCID: PMC5724091." WHERE pubmaster_id2=540;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=540;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=540;

UPDATE plan.pubmaster SET Citation="Valentine-King MA, Brown MB. Antibacterial Resistance in Ureaplasma Species and Mycoplasma hominis Isolates from Urine Cultures in College-Aged Females. Antimicrob Agents Chemother. 2017 Sep 22;61(10). pii: e01104-17. doi: 10.1128/AAC.01104-17. Print 2017 Oct. PubMed PMID: 28827422; PubMed Central PMCID: PMC5610494." WHERE pubmaster_id2=601;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=601;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=601;

UPDATE plan.pubmaster SET Citation ='Koelmel JP, Kroeger NM, Ulmer CZ, et al. LipidMatch: an automated workflow for rule-based lipid identification using untargeted high-resolution tandem mass spectrometry data. BMC Bioinformatics. 2017;18:331. doi:10.1186/s12859-017-1744-3. PMID: 28693421. PMCID: PMC5504796.' WHERE pubmaster_id2=515;
UPDATE plan.pubmaster SET Citation ='O’Kell AL, Garrett TJ, Wasserfall C, Atkinson MA. Untargeted metabolomic analysis in naturally occurring canine diabetes mellitus identifies similarities to human Type 1 Diabetes. Scientific Reports. 2017;7:9467. doi:10.1038/s41598-017-09908-5. PMID: 28842637. PMCID: PMC5573354.' WHERE pubmaster_id2=516;



select distinct NonPMCSufix from plan.pubmaster;

UPDATE plan.pubmaster SET NonPMCSufix="  PMC " 
;
SELECT  NonPMCSufix from plan.pubmaster WHERE NIHMS_Status="In Process";
######################################################################################
######################################################################################
######################################################################################
###Create formatted Citations
######################################################################################
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE plan.pubmaster ADD fmt_citation varchar(4000);

UPDATE plan.pubmaster SET fmt_citation='';
UPDATE plan.pubmaster SET fmt_citation=TRIM(Citation);
UPDATE plan.pubmaster SET fmt_citation=concat(fmt_citation," ",NonPMCSufix)  WHERE NIHMS_Status="In Process";
UPDATE plan.pubmaster SET fmt_citation=concat(fmt_citation," Full Text Available:",NonPMCSufix)  WHERE NIHMS_Status="Available Online";
UPDATE plan.pubmaster SET fmt_citation=concat("* ",fmt_citation)  WHERE Comp_Pilot=1  ;
UPDATE plan.pubmaster SET fmt_citation=concat("^ ",fmt_citation)  WHERE KL2=1 OR TL1=1  ;

############################################################################
######### SUMMARY TABLE
drop table if exists plan.temp;
create table plan.temp as 
select PrimaryCat, iCITE_Year, count(*) as nPubs
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
group by PrimaryCat,iCITE_Year;

drop table if exists plan.bib_summ;
create table plan.bib_summ As
SELECT Distinct PrimaryCat
  from plan.temp;

ALTER TABLE plan.bib_summ
	ADD Y2015 int(5),
    ADD Y2016 int(5),
    ADD Y2017 int(5),
    ADD Y2018 int(5);

UPDATE plan.bib_summ bs, plan.temp lu SET bs.Y2015=lu.nPubs WHERE lu.iCITE_Year=2015 AND bs.PrimaryCat=lu.PrimaryCat;
UPDATE plan.bib_summ bs, plan.temp lu SET bs.Y2016=lu.nPubs WHERE lu.iCITE_Year=2016 AND bs.PrimaryCat=lu.PrimaryCat;
UPDATE plan.bib_summ bs, plan.temp lu SET bs.Y2017=lu.nPubs WHERE lu.iCITE_Year=2017 AND bs.PrimaryCat=lu.PrimaryCat;
UPDATE plan.bib_summ bs, plan.temp lu SET bs.Y2018=lu.nPubs WHERE lu.iCITE_Year=2018 AND bs.PrimaryCat=lu.PrimaryCat;

SELECT * from  plan.bib_summ;


############################################################################
##########  PRIMARY CATEGORY BIBLIO
############################################################################
DROP TABLE IF EXISTS plan.bib_cat;
CREATE TABLE plan.bib_cat As
SELECT 	PrimaryCat,
		fmt_citation
FROM plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online")
ORDER BY PrimaryCat, Citation;


###########################################################################
############### AVAILABLE ONLINE TABLE
###########################################################################
DROP TABLE IF EXISTS plan.bib_online;
CREATE TABLE plan.bib_online As
SELECT 	pubmaster_id2,
		PrimaryCat,
        iCITE_Year AS PubYear,
		fmt_citation,
		NonPMCSufix
FROM plan.pubmaster
WHERE NIHMS_STATUS IN ("Available Online")
ORDER BY PrimaryCat, Citation;


##create table loaddata.pubmasterBU20180516 AS select * from plan.pubmaster;

SELECT PrimaryCat,count(*) as Pubs from plan.pubmaster
WHERE NIHMS_STATUS IN ("Available Online")
GROUP BY PrimaryCat ;
/*
("PMC Compliant","In Process","Available Online")
UPDATE plan.pubmaster SET Citation="" WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=473;

UPDATE plan.pubmaster SET Citation="" WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NIHMS_Status="PMC Compliant" WHERE pubmaster_id2=473;
UPDATE plan.pubmaster SET NonPMCSufix="" WHERE pubmaster_id2=473;
*/
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE plan.kl2_pmid Add in_pubmaster int(1);
UPDATE plan.kl2_pmid SET in_pubmaster=0;
UPDATE plan.kl2_pmid kl, plan.pubmaster lu SET kl.in_pubmaster=1 WHERE kl.pmid=lu.pmid;

select count(*) from plan.pubmaster where KL2=1;




select * from plan.pubmaster
WHERE PMC ="";

select distinct pubmaster_id2,PMID from plan.pubmaster WHERE PMC ="" AND PMID<>"";


##UPDATE PMC ETC 11-17-2018
UPDATE plan.pubmaster pm, work.pubmaster_update lu
SET pm.PMC=lu.PMCID,
	pm.Citation=lu.Citation
WHERE pm.pubmaster_id2=lu.pubmaster_id2
AND   pm.PMID=lu.PMID;	


select * from plan.pubmaster where PMID='25820234';

SELECT * from plan.pubmaster WHERE pubmaster_id2 in (630,635,636,555,707,718);


select * from plan.pubmaster WHERE PMC ="" AND PMID<>"";

select * from plan.pubmaster WHERE PMID IN
('25820234');

select * from  plan.pubmaster where pubmaster_id2=723;

UPDATE plan.pubmaster
SET PMID='29854151',
	PMC='PMC5977671'
WHERE  pubmaster_id2=723;


select * from  plan.pubmaster 
WHERE pubmaster_id2 IN
(508,509,510,722,620,456,730,720,721,719,616,614,619,622);

select NIHMS_Status,count(*) from plan.pubmaster group by NIHMS_Status;

select PMID,PMC from plan.pubmaster where NIHMS_Status="In Process";


UPDATE plan.pubmaster SET NIHMS_Status='PMC Compliant' WHERE PMC<>'';

SELECT DISTINCT PMC FROM plan.pubmaster;

select * from plan.pubmaster where NIHMS_Status="Available Online" AND PMID<>"";

select * from plan.pubmaster where PMID="27539287";

#########################################

drop table if exists plan.temp;
create table plan.temp as
SELECT  PMID,
        PUBLICATION_DATE AS PubDate,
		PI_NAME,
		Grant_Numbers,
		CTSI_GRANT
 from plan.PMCompMonitor
WHERE PMID IN
(26980742,
28587997,
28657816,
28668374,
28675819,
28681310,
28737599,
28822983,
28850830,
28960154,
29060496,
29060866,
29097251,
29110740,
29122535,
29124438,
29129554,
29150307,
29165692,
29186491,
29192967,
29199394,
29206922,
29254836,
29262725,
29326035,
29351495,
29428994,
29461126,
29560807,
29569517,
29569517,
29597874,
29621886,
29631777,
29669081,
29678072,
29701153,
29704573,
29781843,
29790196,
29884075,
29908056,
29935347,
29987845,
30016565,
30020606,
30026117,
30056039,
30075352,
30089431,
30111190,
30165769,
30179709,
30190102,
30211840,
30218116,
30237584,
30244377,
30252228,
30264205,
30279155,
30280868,
30289819,
30293456,
30336683,
28280351,
28351962,
28533295,
28701941,
28361470,
28412015,
28566193,
28944303,
28983423,
29046635,
28452909,
29020472,
28954878,
29027967,
29214005,
29167654,
28542029,
28621562,
28668774,
29343948,
29323025,
29416498,
29313802,
29313802,
29450404,
28767013,
29471813,
29515435,
29515435,
29535639,
29541533,
29351371,
29351371,
29607241,
29607241,
29615060,
29340590,
29629236,
29535047,
29049133,
29523524,
29523524,
29216598,
29731719,
29731719,
29805773,
29789016,
28734680,
29848365,
29511334,
29511334,
29872540,
29542875,
29398575,
29950986,
29925376,
29977980,
29714568,
30026679,
30026679,
30009204,
30034270,
29629615,
29986848,
28899020,
29702223,
30059539,
30100713,
29966341,
30066655,
30066664,
30066651,
29077960,
30105161,
30116286,
29697553,
30067089,
30119627,
30165855,
29957870,
30081463,
30216360,
30221182,
30221182,
29634314,
30076274,
29658388,
30138228,
30118949,
30042363
)
ORDER BY PMID;

ALTER TABLE plan.PUB_CORE MODIFY COLUMN OnlineLink varchar(500);

SET SQL_SAFE_UPDATES = 0;

UPDATE plan.PUB_CORE
SET PubDate=NULL, CTSI_GRANT=NULL
WHERE CTSI_GRANT=9;


select CTSI_GRANT,count(*) from plan.PUB_CORE group by CTSI_GRANT;


select NIHMS_Status,count(*) from plan.PUB_CORE group by NIHMS_Status;

Select Count(*) from plan.PUB_CORE where Pubdate is Null;

UPDATE plan.PUB_CORE SET NIHMS_Status='Not in NIHMS' WHERE NIHMS_Status='Not Found in NIHMS';

Select * from plan.PUB_CORE where Pubdate is Null;


desc plan.PUB_CORE;


UPDATE plan.PUB_CORE pc, plan.temp2 lu
SET pc.PubDate=lu.PubDate
WHERE pc.PMID=lu.PMID;

Select * from plan.PUB_CORE where Pubdate is Null;

ALTER TABLE plan.PUB_CORE ADD EXCLUDED int(1);
UPDATE plan.PUB_CORE SET EXCLUDED=0;
UPDATE plan.PUB_CORE SET EXCLUDED=1
WHERE May18Grant=0
AND PilotPub=0
AND ProgOct2018=0;

ALTER TABLE plan.PUB_CORE ADD email varchar (128),
						  ADD PI_LAST varchar (45),
						  ADD PI_FIRST varchar (45);

select * from plan.PUB_CORE WHERE pubmaster_id2 IN(456,619,620,622,730);

UPDATE plan.PUB_CORE pc, plan.temp3 lu
SET pc.email=lu.EMAIL,
    pc.PI_LAST=lu.Lastname,
    pc.PI_FIRST=lu.Firstname,
    pc.Grant_Numbers=lu.UF_Grant_Cited,
    pc.CTSI_GRANT=lu.CTSI_GRANT
WHERE pc.pubmaster_id2=lu.pubmaster_id2 ;


CREATE TABLE plan.BACKUP_PLAN_PUB_CORE2 AS SELECT * FROM plan.PUB_CORE;

DROP TABLE plan.PUB_CORE;
CREATE TABLE plan.PUB_CORE AS SELECT * FROM plan.BACKUP_PLAN_PUB_CORE2;


UPDATE plan.PUB_CORE pc, plan.temp4 lu
SET pc.email=lu.Email,
    pc.PI_LAST=lu.Lastname,
    pc.PI_FIRST=lu.Firstname,
    pc.PubDate=lu.Publication_date,
    pc.Grant_Numbers=lu.Grant_Numbers,
    pc.CTSI_GRANT=lu.CTSI_GRANT
WHERE pc.PMID=lu.PMID ;


select NIHMS_Status,count(*) from plan.PUB_CORE group by NIHMS_Status;

SELECT Email,count(*) 
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
GROUP BY Email ;

drop table if exists plan.noncomp;
create table plan.noncomp as
SELECT *
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
;

UPDATE plan.PUB_CORE pc, pilots.PILOTS_PUB_MASTER lu
SET pc.PubDate=lu.Pubdate
WHERE pc.PMID=lu.PMID
and lu.PubDate;


CREATE TABLE plan.temp9 AS
SELECT Pilot_ID,
		PI_Last,
        PI_First,
        Email
from pilots.PILOTS_MASTER
WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from plan.noncomp WHERE Pilot_ID IS NOT NULL);

UPDATE plan.PUB_CORE pc, plan.temp9 lu
SET pc.email=lu.Email,
    pc.PI_LAST=lu.PI_Last,
    pc.PI_FIRST=lu.PI_First
WHERE pc.PIlot_ID=lu.Pilot_ID
AND pc.PIlot_ID IS NOT NULL ;




UPDATE plan.PUB_CORE pc, plan.temp8 lu
SET pc.PubDate=lu.PubDate
WHERE pc.PMID=lu.PMID
;
/*
UPDATE plan.PUB_CORE 
SET PubDate=NULL
WHERE pubmaster_id2 in
(756,454,456,508,509,510,613,614,615,
616,617,619,620,622,719,720,721,722,727,728,729,730,734,
735,736,737,923,924,925,926,927,928,929,930,931,932,933,
934,935,936,937,938,939,940,941,942,943,944,945,946,947,
948,949,950,951,952,953,954,955,956,957,958,959,960,961);
*/
select PubDate,count(*) from plan.PUB_CORE group by  PubDate;
#####################################################################################
#####################################################################################
drop table if exists plan.noncomp;
create table plan.noncomp as
SELECT *
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
AND (PubDate IS NULL OR CTSI_GRANT IS NULL OR PI_LAST IS NULL);
;

drop table if exists plan.noncomp;
create table plan.noncomp as
SELECT *
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
AND (PubDate IS NULL OR CTSI_GRANT IS NULL OR PI_LAST IS NULL);
;


ALTER TABLE 

select distinct PI_LAST from plan.PUB_CORE;


UPDATE plan.PUB_CORE set NIHMS_Status="Not in Pubmed" where pubmaster_id2=729;
SELECT *
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
#AND ProgReptSrce=""
AND Email IS NULL;
;

SELECT NIHMS_Status,count(*)
from plan.PUB_CORE 
WHERE Email IS NULL
GROUP BY NIHMS_Status;
;
select distinct EMAIL from plan.PUB_CORE;


SELECT NIHMS_Status,Count(*) from plan.PUB_CORE group by NIHMS_Status;

drop table temp99;
create table temp99 as
SELECT NIHMS_Status,
SUM(May18Grant),
SUM(PilotPub),
SUM(ProgOct2018),
SUM(Excluded),
SUM(1) as Undup
FROM plan.PUB_CORE 
GROUP BY NIHMS_Status;

SELECT 
SUM(May18Grant),
SUM(PilotPub),
SUM(ProgOct2018),
SUM(Excluded),
SUM(1) as Undup
FROM plan.PUB_CORE 
;



desc plan.PUB_CORE;

create table plan.temp7 as
select * from plan.PUB_CORE where may18Grant=1 AND NIHMS_Status="Available Online";

create table plan.exclude as
select * from plan.PUB_CORE WHERE pubmaster_id2 IN (736,928);

select * from pilots.PILOTS_PUB_MASTER where Pilot_ID=99;

select * from lookup.active_emp where Name like "Hill,A%";

Select * from lookup.ufids where UF_UFID IN ('81691781');

select UF_DISPLAY_NM,UF_EMAIL,UF_LAST_NM,UF_FIRST_NM,UF_DEPT_NM,UF_WORK_TITLE from lookup.ufids where UF_DISPLAY_NM like "Massey%jon%";



SELECT * from pilots.PILOTS_MASTER WHERE PI_LAST like "GArrett%";

########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################
CREATE TABLE plan.BACKUP_PLAN_PUB_CORE66 AS SELECT * FROM plan.PUB_CORE;

SET SQL_SAFE_UPDATES = 0;
delETE FROM plan.PUB_CORE
where pubmaster_id2 in (
454,456,508,509,510,614,615,616,619,620,622,719,720,721,728,729,730,734,735,
737,761,798,923,924,925,926,927,929,930,931,932,
933,934,935,936,937,938,939,940,941,942,943,944,
945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961
);
*/

ALTER TABLE plan.PUB_CORE DROP PI_NAME;
########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################
########################################################################################################################



SELECT NIHMS_STATUS,count(*)
from plan.pubmaster
WHERE NIHMS_STATUS IN ("PMC Compliant","In Process","Available Online") 
group by NIHMS_Status;


select PMC,count(*) from plan.PUB_CORE where NIHMS_STATUS IN ("Available Online") group by PMC;




SELECT * from plan.PUB_CORE where NIHMS_STATUS IN ("Conference Presentation","Book Chapter"
);


select count(*) from plan.PUB_CORE;

select count(*) from plan.pubmaster;

desc  plan.PUB_PROGRAM_ASSIGN ;

select * from plan.PUB_PROGRAM_ASSIGN ;


###########################################################################
###########################################################################
## Make File for Claire
drop table if exists plan.noncomptemp;
create table plan.noncomptemp as
SELECT *
from plan.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
;
;
desc plan.PUB_PROGRAM_ASSIGN;

select distinct category from plan.PUB_PROGRAM_ASSIGN;

drop table if exists plan.noncomp_cat;
create table plan.noncomp_cat as
select 
     nc.pubmaster_id2,
     nc.NIHMS_Status,
     nc.email,
     nc.PI_LAST,
     nc.PI_FIRST,
     nc.PMID,
     nc.PMC,
     nc.May18Grant,
     nc.PilotPub,
     nc.Pilot_ID,
     nc.ProgReptSrce,
     nc.ProgOct2018,
     nc.PubDate,
     nc.Grant_Numbers,
     nc.CTSI_GRANT,
     nc.Citation,
     nc.OnlineLink,
      lu.TranslComm,
      lu.ServiceCenter,
      lu.Informatics,
      lu.CommEng,
      lu.TeamSci,
      lu.TWD,
      lu.KL2,
      lu.TL1,
      lu.Pilots,
      lu.BERD,
      lu.RKS,
      lu.SpPops,
      lu.PCI,
      lu.Multisite,
      lu.Recruitment,
      lu.Metabolomics,
      lu.NetSci,
      lu.PMP,
      lu.Comp_CommEng,
      lu.Comp_Hub_Cap,
      lu.Comp_Inform,
      lu.Comp_NetCap,
      lu.Comp_NetSci,
      lu.Comp_Pilot,
      lu.Comp_PresMed,
      lu.Comp_RschMeth,
      lu.Comp_SvcCtr,
      lu.Comp_TWD,
      lu.Comp_Trans,
      lu.Compmask,
      lu.Comp_HubNet,
      lu.CatCount,
      lu.PrimaryCat
from plan.noncomptemp nc 
	left join plan.PUB_PROGRAM_ASSIGN lu
	on nc.pubmaster_id2=lu.pubmaster_id2
;

PILOTS_MASTER
PILOTS_PUB_MASTER
PILOTS_ROI_MASTER
PILOTS_ROI_DETAIL