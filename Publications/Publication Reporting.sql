################################################
################# PUBLICATIONS REPORTING #######
################################################
################################################
################################################
## Make File for PubMed Compliance

drop table if exists pubs.noncomptemp;
create table pubs.noncomptemp as
SELECT *
from pubs.PUB_CORE 
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed')
;



drop table if exists pubs.noncomp_cat;
create table pubs.noncomp_cat as
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
from pubs.noncomptemp nc 
	left join pubs.PUB_PROGRAM_ASSIGN lu
	on nc.pubmaster_id2=lu.pubmaster_id2
;



################################
################################
### COMPLIANCE STATUS
SELECT NIHMS_Status,
SUM(May18Grant) AS May2018Grant,
SUM(PilotPub) AS PilotPub,
SUM(ProgOct2018) As ProgRept2018,
COUNT(*) as Undup
from pubs.PUB_CORE
group by NIHMS_Status;


#####################################
#####################################
### NON Compliant PMIDs for PUBMED Lookup
SELECT DISTINCT PMID from pubs.PUB_CORE
WHERE NIHMS_Status in ('Available Online','In Process','Not in NIHMS','Not in Pubmed');



######################################
######################################
### CREATE TABLE FOR DEFINING PROGRAM LEADS
#######################################

drop table if exists work.pubcompout;
Create table work.pubcompout as 
select 	pubmaster_id2,
		PMID,
		NIHMS_Status,
		May18Grant,
		PilotPub,
		ProgReptSrce,
		ProgRLead_LAST,
		ProgRLead_FIRST,
		ProgRLead_EMAIL,
		PI_LAST,
		PI_FIRST,
		email AS PI_EMAIL,
		PubDate,
		CTSI_GRANT,
		Grant_Numbers,
		Citation,
		OnlineLink
from pubs.PUB_CORE 
WHERE NIHMS_Status NOT IN  ('PMC Compliant','Conference Presentation','Book Chapter','In Process','Removed NIHMS')
AND EXCLUDED=0
AND (YEAR(PubDate)<=2017 OR May18Grant=1);


