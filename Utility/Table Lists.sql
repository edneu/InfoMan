
####Schema Size LIst
SELECT table_schema AS 'Database', 
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS SizeMB
FROM information_schema.TABLES 
GROUP BY table_schema
ORDER BY SizeMB DESC;
;


### Table Sizes in Specific Schema
SELECT table_schema,table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)',
UPDATE_TIME
FROM information_schema.TABLES
###WHERE table_schema NOT IN ("lookup", "space")
ORDER BY (data_length + index_length) DESC;


desc information_schema.TABLES;

### FILE LIST BY SIZE




desc information_schema.TABLES;
#######################
select "lookup" as DB, min(FUNDS_ACTIVATED) MinDate, MAX(FUNDS_ACTIVATED) as MaxDate from lookup.awards_history
UNION ALL
select "loadDROP TABLE IF EXISTS  work.TableList;
CREATE TABLE work.TableList AS
SELECT 
TABLE_SCHEMA AS 'Schema',
table_name AS 'Table',
UPDATE_TIME ,
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA NOT IN ('mysql','information_schema','sys','performance_schema')
ORDER BY ROUND(((data_length + index_length) / 1024 / 1024), 2)  DESC;data" as DB, min(FUNDS_ACTIVATED) MinDate, MAX(FUNDS_ACTIVATED) as MaxDate from loaddata.awards_history;


Select count(*) from lookup.roster;
Select count(*) from loaddata.newroster;

#######################################################




#########################



#WHERE table_schema = "space"
ORDER BY (data_length + index_length) DESC;


/*
select count(*) from lookup.email_master;

select count(*) from space.Salary2016;
select count(*) from space.salary2016;

select count(*) from lookup.email;
*/

select * from information_schema.TABLES;
select distinct TABLE_SCHEMA from information_schema.TABLES;

OPTIMIZE TABLE lookup.ufids;
OPTIMIZE TABLE lookup.awards_history;
OPTIMIZE TABLE lookup.email_master;
OPTIMIZE TABLE loaddata.PedsEmp181920;
OPTIMIZE TABLE lookup.email;
OPTIMIZE TABLE lookup.roster;

OPTIMIZE TABLE Adhoc.combined_hist_rept;
OPTIMIZE TABLE Adhoc.comb_hist_report20211202BU;


#################### clEAR OUT OLD TABLES 02-09-2024
drop table if exists loaddata.awards_history;
drop table if exists loaddata.ufids;
drop table if exists loaddata.backupAwardsHistory20230705;
drop table if exists work.ufidtemp;
drop table if exists work.nih;
drop table if exists loaddata.email_lu;
drop table if exists work.email_name2;
drop table if exists work.email_name;
drop table if exists loaddata.newtranshist202301;
drop table if exists loaddata.roosterBU20230828;
drop table if exists loaddata.newroster;
drop table if exists loaddata.rostertemp;
drop table if exists loaddata.rosterBU20231004;
drop table if exists loaddata.rosterBU20230531;
drop table if exists Adhoc.pubmedT32_master;
drop table if exists work.PubmedT32;
drop table if exists work.pubmedT32_master;
drop table if exists work.pubmedT32_undup;
drop table if exists finance.ReftransWORK;
drop table if exists finance.transWORK;
drop table if exists work.ActiveEmpEmail;
drop table if exists biblio.jcr_impact_factor;
drop table if exists clinical.ctgov20230222;
drop table if exists clinical.ct_worktemp;
drop table if exists clinical.ct_work;
drop table if exists loaddata.active_emp_20230410;
drop table if exists `loaddata.Active 20230519`;
drop table if exists loaddata.actvemp20230303;
drop table if exists work.activeemp;
drop table if exists work.active_emp_20220104;
drop table if exists finance.TransSHC;
drop table if exists loaddata.activeemp202309;
drop table if exists work.ss_rqst1;
drop table if exists work.ctsiufid;
drop table if exists biblio.jcr_impact_lookup;
drop table if exists ctsi_survey.hr;
drop table if exists work.rosterAGG;
drop table if exists finance.workBudget;
drop table if exists finance.Budget2020_2022;
drop table if exists work.BR_INST_BU;
drop table if exists finance.puac_lookup;
drop table if exists finance.crc_hours_08_2022;
drop table if exists finance.crc_hours;
drop table if exists work.leadstemp;
drop table if exists work.rosterleads;
drop table if exists work.KL2awardsRaw;
drop table if exists work.biblio_impact;
drop table if exists work.pubs;
drop table if exists work.roster_additions;
drop table if exists ctsi_survey.progrost;
drop table if exists finance.RosterFacAwd1;
drop table if exists finance.trans_2022;
drop table if exists work.bri_public;
drop table if exists work.br_Inst_publicrank;
drop table if exists work.pedspropsals;
drop table if exists space.redsurveyresults2020;
drop table if exists work.projected_payroll;
drop table if exists work.porchout;
drop table if exists work.irb_summ;
drop table if exists work.newsletter;
drop table if exists work.RosterNewRec;
drop table if exists loaddata.q1_2023_roster;
drop table if exists pilots.updated_pilot_master_20221014;
drop table if exists work.usersLU;
drop table if exists work.UF_ENG;
drop table if exists work.qlink;
drop table if exists finance.reportNullColl;
drop table if exists work.userslist;
drop table if exists work.bmr_sponsors;
drop table if exists work.rosterlist;
drop table if exists work.ProgAct;
drop table if exists work.placemat;
drop table if exists pilots.backupPIlotMaster20220131;
drop table if exists pilots.BUPilotsMaster20220914;
drop table if exists work.payrollmatchaug26;
drop table if exists work.PedsEmp;
drop table if exists work.febdeptsrce;
drop table if exists work.payrollmatchaug22;
drop table if exists work.new_peds_emp;
drop table if exists work.nct_4_irb;
drop table if exists work.pedawdsumm1;
drop table if exists work.ahdeptid;
drop table if exists finance.reportMattReview;
drop table if exists work.cm_kl_tl_2021;
drop table if exists work.PorchRecon;
drop table if exists work.salplanlookup;
drop table if exists work.PedsEmptemp;
drop table if exists finance.crc_PersonMonthSumm;
drop table if exists finance.OmitTrans;
drop table if exists lookup.U01Master;
drop table if exists work.Roster_Need_Faculty_Data;
drop table if exists work.Awdlist;
drop table if exists work.quick_links_announcements_susbs;
drop table if exists work.all;
drop table if exists finance.KLTL_2020_2022;
drop table if exists work.covidprop;
drop table if exists work.emp_transfers;
drop table if exists work.temp1;
drop table if exists work.clinical_emp_transfers;
drop table if exists work.porchcensus;
drop table if exists work.kristina_emails;
drop table if exists finance.crc_monthlyhoursLU;
drop table if exists work.NIHRank;
drop table if exists work.vocuhers;
drop table if exists finance.reportNoCollDetail;
drop table if exists finance.puac_ufid;
drop table if exists lookup.vocuher2;
drop table if exists work.assistmap;
drop table if exists work.temp;
drop table if exists work.pymatch;
drop table if exists work.kl2_awards_agg;
drop table if exists work.pedsPropsalsSumm;
drop table if exists work.assist_erm;
drop table if exists work.pedawdsumm;
drop table if exists work.payrollmatchsept20;
drop table if exists backuppilot.pilot_pubs;
drop table if exists clinical.UF_FSU_TRIALS;
drop table if exists finance.VouchWORK;
drop table if exists finance.voucherwork;
drop table if exists work.peds_ufid;
drop table if exists work.reptcat_jobs;
drop table if exists work.fla_nih;
drop table if exists work.issn_work;
drop table if exists work.rschmeth;
drop table if exists work.rppr_pubs;
drop table if exists work.pilots_since_2018;
drop table if exists work.pilots2018;
drop table if exists work.crcood;
drop table if exists work.pyxmatch;
drop table if exists work.porchfactype;
drop table if exists work.t32range;
drop table if exists work.ltawd;
drop table if exists work.kl2;
drop table if exists work.idc2022;
drop table if exists work.fedcovid;
drop table if exists work.hubcap;
drop table if exists work.act_R01;
drop table if exists work.ct_nct_lu;
drop table if exists work.oldbio;
drop table if exists work.biomaster;
drop table if exists backuppilot.roi_awards;
drop table if exists backuppilot.roiSRM;
drop table if exists results.YearFacOut;
drop table if exists results.ProgClassSumm;
drop table if exists results.NIH_FUND_ATTRIB;
drop table if exists results.GrYearFacOut;
drop table if exists results.budget_deptlist;
drop table if exists work.ImpactUsers1;
drop table if exists work.hscassign;
drop table if exists work.aaaphonelu;
drop table if exists work.ufe_reconcile;
drop table if exists work.rosterTemp2;
drop table if exists work.bio_undup_roles;
drop table if exists work.ProgUsersUndup;
drop table if exists work.kl2personYear;
drop table if exists work.proguserout;
drop table if exists work.SpTyYR;
drop table if exists work.ImpactSvcUsers;
drop table if exists work.high20noCTSI;
drop table if exists work.aaaphone;
drop table if exists work.porchfillsal;
drop table if exists work.falos;
drop table if exists work.covidpilotnoaward;
drop table if exists work.pilotlist;
drop table if exists work.temp2;
drop table if exists work.peds_type_summ;
drop table if exists work.rosterTemp;
drop table if exists work.bioDept;
drop table if exists work.ProgUsersOut;
drop table if exists work.kl2_scholars;
drop table if exists work.progtemp;
drop table if exists work.ServUse;
drop table if exists work.ClinRsch_AmtYR;
drop table if exists work.YearSponCatSumm;
drop table if exists work.porchfactypeagg;
drop table if exists work.FedSponsorYR;
drop table if exists work.high10;
drop table if exists work.kl2_awards_history;
drop table if exists work.progowners;
drop table if exists work.SA_AWD_Summ;
drop table if exists work.peds_type_LU;
drop table if exists work.assisthomedept;
drop table if exists work.YearSponCat;
drop table if exists work.out_irb;
drop table if exists work.grYearFac;
drop table if exists work.CTSI_PI_Funding;
drop table if exists work.kl;
drop table if exists work.proclass;
drop table if exists work.roster22Summ;
drop table if exists work.YearFac;
drop table if exists work.porchfacagg;
drop table if exists work.fla_nih_FFY;
drop table if exists work.ltout2;
drop table if exists work.VerifyRosterNames;
drop table if exists work.PilotProgressSumm;
drop table if exists work.kfemaillu;
drop table if exists work.kl2_awards_Summ;
drop table if exists work.preshlth;
drop table if exists work.assist_compsumm;
drop table if exists work.dmSPONTout;
drop table if exists work.lhspilots;
drop table if exists work.pubmed_raw;
drop table if exists work.UF_ENG_ACTV;
drop table if exists work.ltout;
drop table if exists work.kl2_2015;
drop table if exists work.PilotProgressLU;
drop table if exists work.dmSPONSORout;
drop table if exists work.no_ufids;
drop table if exists work.fixPorchSalPlan;
drop table if exists work.pm_omitflag;
drop table if exists work.lhs;
drop table if exists work.pilot_ul_tl;
drop table if exists work.PubmedOUT;
drop table if exists work.deptlu;
drop table if exists work.nihtotal;
drop table if exists work.vouchufid;
drop table if exists work.pilot_kl_tl_undup;
drop table if exists work.starasPPI;
drop table if exists work.informat;
drop table if exists work.nihctsitotal;
drop table if exists work.userprogram2;
drop table if exists work.pilotstemp;
drop table if exists work.custlu;
drop table if exists work.vouchers;
drop table if exists work.T32raqngeUndup;
drop table if exists work.starasPI;
drop table if exists work.userprogram;
drop table if exists work.cust;
drop table if exists work.nih_affil_lu;
drop table if exists work.kltemp;
drop table if exists work.proguserout_FMT_2;
drop table if exists work.T32PMcnt;
drop table if exists work.pilot_kl_tl;
drop table if exists work.staffufid;
drop table if exists work.bmrSponorTem;
drop table if exists work.porchwork;
drop table if exists work.pilots2022;
drop table if exists work.nih_affil;
drop table if exists work.SpTyYRlu;
drop table if exists work.Prog_Owners;
drop table if exists work.verifydept;
drop table if exists work.kl2work;
drop table if exists work.proguserout_FMT2;
