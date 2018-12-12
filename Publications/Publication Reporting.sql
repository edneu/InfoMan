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

