###############################################################################################################
###############################################################################################################
### ADMIN CODE TO CREATE pilot_award_master
/*
DROP TABLE IF EXISTS pilots.pilot_award_master;
Create table pilots.pilot_award_master As
SELECT     Pilot_ID,
           Award_Year,
           Category,
           AwardType,
           Cohort,
           Awarded,
           AwardLetterDate,
           Award_Amt,
           Status,
           UFID,
           Email,
           PI_First,
           PI_Last,
           Title,
           Remain_Amt,
           Return_Amt,
           Role,
           Institution,
           NumCollab,
           Begin_Date,
           End_Date,
           NCE_Date,
           PI_DEPT,
           PI_DEPTID,
           PI_DEPTNM,
           Orig_Award_Year,
           ProjectStatus,
		   CiteGrant,
           ORGINAL_AWARD,
           College,
           PI_GENDER,
           PI_DOB,
           AwardeePositionAtApp,
           AwardeeCareerStage,
           Award_HummanSubjectResearch,
           CancerScore,
           AprilPilotID
from lookup.pilots;


CREATE TABLE pilots.PILOTS_ROI_MASTER AS
SELECT * from pilots.roi_awards_master;

ALTER TABLE pilots.PILOTS_ROI_MASTER
DROP COLUMN DIRECT_AMOUNT,
DROP COLUMN INDIRECT_AMOUNT,
DROP COLUMN SPONSOR_AUTHORIZED_AMOUNT;

DROP TABLE IF EXISTS pilots.roi_awards_master;

ALTER TABLE pilots.PILOTS_ROI_MASTER CHANGE COLUMN `roi_awards_master_id` `roi_master_id` int(11);


*/
##############  Pilot Pub Admin

/*
create table pilots.pilot_pub_master AS
select * from pilots.pilot_pubs;
USE pilots;
 
select count(*) from pilot_pub_master;
select count(distinct Pilot_ID) from pilot_pub_master;

select pilot_id, count(*) from pilots.pilot_pub_master group by Pilot_id;

Alter Table pilots.pilot_pub_master;

UPDATE pilots.pilot_pub_master SET Citation='Samant, S., Jiang, X., Horenstein, R. B., Shuldiner, A. R., Yerges-Armstrong, L. M., Zheng, S., ... & Schmidt, S. (2014). A Semi-physiological Population Pharmacokinetic/Pharmacodynamic Model For The Development Of A Bedside-ready Dosing Algorithm For Clopidogrel.: oiii-3. Clinical Pharmacology & Therapeutics, 95(1), S102.' WHERE pilot_pubs_id2=6;
UPDATE pilots.pilot_pub_master SET  PMID='22689992', PMCID='PMC3387103' WHERE pilot_pubs_id2=13;
UPDATE pilots.pilot_pub_master SET  PMID='26919068', PMCID='' WHERE pilot_pubs_id2=64;
UPDATE pilots.pilot_pub_master SET  PMID='26820234', PMCID='PMC6052867' WHERE pilot_pubs_id2=63;

##drop table pilots.temp;
Create table pilots.temp AS
select * from pilots.pilot_pub_master;

##Drop table if exists pilots.pilot_pub_master;

CREATE TABLE pilots.PILOTS_PUB_MASTER AS
SELECT * from pilots.temp; 

ALTER TABLE pilots.PILOTS_PUB_MASTER CHANGE COLUMN `pilot_pubs_id2` `pub_master_id` int(11);


#################
pilot_award_master
/*

CREATE TABLE pilots.PILOTS_MASTER AS
SELECT * from pilots.pilot_award_master; 

############### CREATE backup TO TEST FOR DEPENDENCIES
Create table backuppilot.backup_roi_awards AS SELECT * from pilots.backup_roi_awards;
Create table  backuppilot.grant_summ AS SELECT * from  pilots.grant_summ;
Create table  backuppilot.grants_app AS SELECT * from  pilots.grants_app;
Create table  backuppilot.lu_pilots AS SELECT * from  pilots.lu_pilots;
Create table  backuppilot.oldpilotBU AS SELECT * from  pilots.oldpilotBU;
Create table  backuppilot.pilot_award_master AS SELECT * from  pilots.pilot_award_master;
Create table  backuppilot.pilot_pubs AS SELECT * from  pilots.pilot_pubs;
Create table  backuppilot.pilot_work AS SELECT * from  pilots.pilot_work;
Create table  backuppilot.PILOTS_MASTER AS SELECT * from  pilots.PILOTS_MASTER;
Create table  backuppilot.PILOTS_PUB_MASTER AS SELECT * from  pilots.PILOTS_PUB_MASTER;
Create table  backuppilot.PILOTS_ROI_MASTER AS SELECT * from  pilots.PILOTS_ROI_MASTER;
Create table  backuppilot.pilots_summary AS SELECT * from  pilots.pilots_summary;
Create table  backuppilot.PUB_PILOTID_AGG AS SELECT * from  pilots.PUB_PILOTID_AGG;
Create table  backuppilot.ROI_AWARD_AGG AS SELECT * from  pilots.ROI_AWARD_AGG;
Create table  backuppilot.roi_awards AS SELECT * from  pilots.roi_awards;
Create table  backuppilot.ROI_Detail AS SELECT * from  pilots.ROI_Detail;
Create table  backuppilot.ROI_PILOTID_AGG AS SELECT * from  pilots.ROI_PILOTID_AGG;
Create table  backuppilot.ROI_work AS SELECT * from  pilots.ROI_work;
Create table  backuppilot.roiAPP AS SELECT * from  pilots.roiAPP;
Create table  backuppilot.ROIAward_detail AS SELECT * from  pilots.ROIAward_detail;
Create table  backuppilot.ROIAward_detail_work AS SELECT * from  pilots.ROIAward_detail_work;
Create table  backuppilot.roiSRM AS SELECT * from  pilots.roiSRM;
Create table  backuppilot.temp AS SELECT * from  pilots.temp;

###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################
###############################################################################################################



*/
select CiteGrant,count(*) from lookup.pilots group by CiteGrant;




select GrantProjectID,count(*) from lookup.pilots group by GrantProjectID;
select GrantNote,count(*) from lookup.pilots group by GrantNote;

select GrantStartNote,count(*) from lookup.pilots group by GrantStartNote;

select VerifiedPub_CitesCTSI,count(*) from lookup.pilots group by VerifiedPub_CitesCTSI;
select VerifiedPub_CitesCTSI_Notes,count(*) from lookup.pilots group by VerifiedPub_CitesCTSI_Notes;

##############  Pilot Pub Admin

;
/*
create table pilots.pilot_pub_master AS
select * from pilots.pilot_pubs;
USE pilots;
 
select count(*) from pilot_pub_master;
select count(distinct Pilot_ID) from pilot_pub_master;

select pilot_id, count(*) from pilots.pilot_pub_master group by Pilot_id;

Alter Table pilots.pilot_pub_master;

UPDATE pilots.pilot_pub_master SET Citation='Samant, S., Jiang, X., Horenstein, R. B., Shuldiner, A. R., Yerges-Armstrong, L. M., Zheng, S., ... & Schmidt, S. (2014). A Semi-physiological Population Pharmacokinetic/Pharmacodynamic Model For The Development Of A Bedside-ready Dosing Algorithm For Clopidogrel.: oiii-3. Clinical Pharmacology & Therapeutics, 95(1), S102.' WHERE pilot_pubs_id2=6;
UPDATE pilots.pilot_pub_master SET  PMID='22689992', PMCID='PMC3387103' WHERE pilot_pubs_id2=13;
UPDATE pilots.pilot_pub_master SET  PMID='26919068', PMCID='' WHERE pilot_pubs_id2=64;
UPDATE pilots.pilot_pub_master SET  PMID='26820234', PMCID='PMC6052867' WHERE pilot_pubs_id2=63;

###############################################################################################################
########################################################################################
########################################################################################
## SCRATCH

select sum(TOTAL) from pilots.pilots_summary;


select distinct PubYear, GrantYear from pilots.pilots_summary;


select distinct AggLevel from pilots.ROI_Detail;


drop table if exists  pilots.roiSRM;
create table pilots.roiSRM as
select Pilot_ID,SUM(SPONSOR_AUTHORIZED_AMOUNT) as TOTAL
from pilots.ROI_Detail
group BY Pilot_ID
order by Pilot_ID;


drop table if exists  pilots.roiAPP;
create table pilots.roiAPP as
select Pilot_ID ,
       SUM(TotalAmt) as TOTAL
from pilots.grants_app
group BY Pilot_ID
order by Pilot_ID;

Alter Table pilots.roiAPP
ADD SRM_total decimal(12,2);

UPDATE pilots.roiAPP ap, pilots.roiSRM lu
SET ap.SRM_total=lu.TOTAL
WHERE ap.Pilot_ID=lu.Pilot_ID;

#################
### CHECK ###

select sum(TOTAL),sum(SRM_total),sum(TOTAL)-sum(SRM_total) from pilots.roiAPP;

select * from pilots.roiAPP where Total>SRM_Total;
select * from pilots.roiAPP where Total<SRM_Total;
select * from pilots.roiAPP where Total<>SRM_Total;
select * from pilots.roiAPP ;




select 	Pilot_ID,
		Award_Year,
		Category,
		PI_Last,
		PI_First,
		GrantYear,
		VerifiedGrant,
		TotalAmt
 from lookup.pilots where Pilot_id in (select distinct Pilotid from pilots.roiAPP where Total<SRM_Total);



UPDATE pilots.PILOTS_ROI_MASTER SET CLK_AWD_PROJ_NAME="Developing an Instrument to Measure Interactive eHealth Literacy" 
WHERE CLK_AWD_ID="AWD00073";


select * from pilots.PILOTS_ROI_MASTER WHERE CLK_AWD_ID="AWD00073";


select * from lookup.ufids where UF_EMAIL="cmtucker@ufl.edu";

select * from lookup.pilots where Pilot_ID=379;

select * from lookup.awards_history where CLK_PI_UFID="89917290";



select * from pilots.roi_awards where PilotID=379;

##################################################################
###### PILOT PUBS UPDATES

UPDATE pilots.PILOTS_PUB_MASTER SET PMID="26268741" WHERE pub_master_id=14;

###drop table if exists pilots.backup_PILOTS_PUB_MASTER;
create table pilots.backup_PILOTS_PUB_MASTER AS SELECT * from pilots.PILOTS_PUB_MASTERPILOTS_PUB_MASTER;


ALTER TABLE pilots.PILOTS_PUB_MASTER
ADD CTSICited varchar(12),
ADD GrantsCited varchar(255);

UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='' ,
                                    GrantsCited='';





UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='R01 AR43623, R21 AR049606, R01 AR048566, R01 AR057422, R01 AR051085, DOD W81XWH-16-1-0540' WHERE pub_master_id=53;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, F31 HL132463' WHERE pub_master_id=38;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='R03 AI122182, R21 DE023433' WHERE pub_master_id=49;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427' WHERE pub_master_id=66;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, U01 HG007269, U01 HL105198, U01 GM074492, P30 AG028740, UL1 TR001427' WHERE pub_master_id=40;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, U01 HG007269' WHERE pub_master_id=43;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='' WHERE pub_master_id=25;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='' WHERE pub_master_id=9;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='' , GrantsCited='' WHERE pub_master_id=45;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427 P30 AG028740' WHERE pub_master_id=37;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427' WHERE pub_master_id=33;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='American Cancer Society Seed Grant ' WHERE pub_master_id=30;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, P30 AG028740' WHERE pub_master_id=42;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='R01 AR048566' WHERE pub_master_id=21;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, R01 GM113945, T32 GM008721, P30 AG028740, P50 GM111152, R01 GM040586 R01 GM105893' WHERE pub_master_id=3;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, K99 DE018958, R00 DE018958, R21 DE023433' WHERE pub_master_id=48;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427' WHERE pub_master_id=69;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='TEXT' , GrantsCited='The study was funded by the University of Florida Clinical and Translational Science Institute (UF-CTSI)' WHERE pub_master_id=67;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427' WHERE pub_master_id=17;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, KL2 TR001429, R24 AG039350, P30 AG028740' WHERE pub_master_id=5;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='' WHERE pub_master_id=64;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, K23 AR062099, P30 AG028740, K23AR062099' WHERE pub_master_id=36;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, K23 AR062099, P30 AG028740, K23AR062099' WHERE pub_master_id=65;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='U24 DK097209-01A, U19 AI091175, P60DK020541, R01 GM114229, U24 DK097209, P60 DK020541' WHERE pub_master_id=63;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, T32 HD043730, T32HD043730, P01 HL59412' WHERE pub_master_id=60;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, U01 GM074492, U19 HL065962' WHERE pub_master_id=11;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, U01 GM074492' WHERE pub_master_id=57;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='2011 American Psychological Association (APA) Dissertation Research Award' WHERE pub_master_id=18;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='2011 American Psychological Association (APA) Dissertation Research Award' WHERE pub_master_id=28;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, K23 NS060660, R01NS082386, R01 NR014181, K23NS60660, R01 NS082386' WHERE pub_master_id=34;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, KL2 TR000065' WHERE pub_master_id=14;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, KL2 TR000065' WHERE pub_master_id=68;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, R01 HL054083, T32 DK074367' WHERE pub_master_id=23;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, P50 GM111152' WHERE pub_master_id=1;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, Z01 EY000350, EY000280-23, Z01 EY000280, EY000350-15, Z01 EY000280-16' WHERE pub_master_id=7;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, R01-CA136715, R01 AR054817, R01-AR054817, R01 CA136715' WHERE pub_master_id=50;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427' WHERE pub_master_id=10;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1-TR-000064, UL1 TR001427, P30 AG028740, U24 DK097209 ' WHERE pub_master_id=8;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1-TR-000064, UL1 TR001427, P30 AG028740, U24 DK097209 ' WHERE pub_master_id=15;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, T32 HD043730, R01 HL107904, R01 HL109442, R01 GM063879' WHERE pub_master_id=59;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427' WHERE pub_master_id=27;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, K01AR066077, R01HD052682-01A1, K01 AR066077, P01 HL059412, P01 HL59412-06, R01 HD052682' WHERE pub_master_id=46;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR001427, UL1 RR029890, L30 CA111002, R01 AI093370, GM62116, U54 GM062116, F32 DK101167' WHERE pub_master_id=52;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, UL1 TR000454, UL1 TR000135, U01 GM074492, RC2 GM092729, K23 HL091120' WHERE pub_master_id=62;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, R01 MH080055, MH080055, KL2 TR000065' WHERE pub_master_id=47;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='MO1 RR00082' WHERE pub_master_id=31;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064' WHERE pub_master_id=4;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='R01 HL-097088, R21 EB-015684' WHERE pub_master_id=26;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='American Heart Association (0830172N)' WHERE pub_master_id=54;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='15T32HL083810-04, K08 HD077040, K01AR066077, 1R01HD052682, K01 AR066077. P01 HL59412-06, R01 HD052682' WHERE pub_master_id=55;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1 TR001427, R01 NR014019' WHERE pub_master_id=44;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='AbbVie' WHERE pub_master_id=29;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='R01 NS041012' WHERE pub_master_id=51;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='P30 AG028740, R13 MD007621' WHERE pub_master_id=70;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1TR000064, KL2TR000065' WHERE pub_master_id=2;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='' WHERE pub_master_id=19;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, UL1TR000165, R01AG033906, K23 AR062099, L30 AG040467, P30 AG031054, P30 AG028740, R01 AG039659, L30 AG043172, R01 AG033906, T32 NS045551, 01AG039659' WHERE pub_master_id=35;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1TR000064, UL1 TR000165, T90 DE021990, L30 AG04046, P30 AG028740, R01 AG039659, R37 AG033906, L30 AG043172, R01 AG033906, AG033906' WHERE pub_master_id=22;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='' WHERE pub_master_id=61;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='P01 NS058901, R01 AR046799, AR046799, NS068897' WHERE pub_master_id=12;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='NO' , GrantsCited='U54 GM062119, R24 GM102656, T32 GM008721, T32 CA106493, K23 GM087709' WHERE pub_master_id=16;
UPDATE pilots.PILOTS_PUB_MASTER SET CTSICited='YES' , GrantsCited='UL1 TR000064, L1 RR029890, R01AI098833-01, L30 CA111002, DOD CA111002, R01 AI093370, R01 CA160436' WHERE pub_master_id=13;

select * from pilots.PILOTS_PUB_MASTER;

create table pilots.old_lookup_pilots as select * from lookup.pilots;



################# ADD SECIM WORK

###WHAT SECIM 
DROP TABLE IF EXISTS work.secim1;
CREATE TABLE work.secim1 AS
Select Pilot_ID,
		Award_Year,
Award_Amt,
Category,
AwardType,
AwardLetterDate,
PI_Last,
PI_First,
Title

from pilots.old_lookup_pilots
WHERE Award_Year>=2012
AND Category IN ("SECIM");


select * from pilots.PILOTS_MASTER where Pilot_ID=311;

drop table if exists pilots.temp;
create table pilots.temp as
select * from pilots.PILOTS_MASTER where Category IN ("SECIM") ORDER BY Pilot_id;
SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.PILOTS_MASTER SET Award_Amt=12636 where Pilot_ID=311;
SET SQL_SAFE_UPDATES = 1;

select max(pilot_id)+1 from pilots.PILOTS_MASTER;

drop table if exists pilots.temp;
create table pilots.temp as
select UF_UFID,UF_EMAIL, UF_LAST_NM,UF_FIRST_NM,UF_WORK_TITLE,UF_DEPT,UF_DEPT_NM,UF_BIRTH_DT from lookup.ufids
WHERE 
(UF_LAST_NM='Barton' AND UF_FIRST_NM LIKE 'Eli%') OR
(UF_LAST_NM='Edelmann' AND UF_FIRST_NM LIKE 'Mar%') OR
(UF_LAST_NM='Gumz' AND UF_FIRST_NM LIKE 'Mic%') OR
(UF_LAST_NM='Patterson' AND UF_FIRST_NM LIKE 'Jos%') OR
(UF_LAST_NM='Rody Junior' AND UF_FIRST_NM LIKE 'Wel%') OR
(UF_LAST_NM='Ryan' AND UF_FIRST_NM LIKE 'Jos%') OR
(UF_LAST_NM='Xiao' AND UF_FIRST_NM LIKE 'Rui%') OR
(UF_LAST_NM='Cegarra' AND UF_FIRST_NM LIKE 'Ana%') OR
(UF_LAST_NM='Ospina' AND UF_FIRST_NM LIKE 'Nay%') OR
(UF_LAST_NM='Frost' AND UF_FIRST_NM LIKE 'Sus%') OR
(UF_LAST_NM='Lemas' AND UF_FIRST_NM LIKE 'Dom%') OR
(UF_LAST_NM='DaSilva' AND UF_FIRST_NM LIKE 'Rob%') 
;

 ;
select UF_UFID,ae_Department_Code,ae_Department 
from lookup.ufids
WHERE UF_UFID IN ('11716073',
'17525080',
'49104906',
'63939828',
'64132979',
'66176671',
'68519841',
'75498680'
);

SELECT Employee_ID,Name,Department,Department_Code
from lookup.Employees WHERE 
NAME LIKE 'Ospina%' OR
NAME LIKE 'Frost%' OR
NAME LIKE 'Lemas%' OR
NAME LIKE 'DaSilva%' OR
NAME LIKE 'Elemento%' ;

SELECT Employee_ID,Name,Department,Department_Code
from lookup.Employees WHERE 
Name like "%Oliver%";

drop table if exists pilots.temp;
create table pilots.temp as
select UF_UFID,UF_EMAIL, UF_LAST_NM,UF_FIRST_NM,UF_WORK_TITLE,UF_DEPT,UF_DEPT_NM,UF_BIRTH_DT from lookup.ufids
WHERE UF_UFID IN ('85067340',
'15145623',
'73634960',
'90263930',
'63092720',
'81837153',
'13315255',
'64175514',
'15918999',
'69663436',
'77447370',
'46584250',
'34955880',
'18320540'
);


UPDATE pilots.PILOTS_MASTER SET EMAIL='cmartyn@ufl.edu' WHERE Pilot_ID=315;
UPDATE pilots.PILOTS_MASTER SET EMAIL='kcrice@ufl.edu' WHERE Pilot_ID=307;
UPDATE pilots.PILOTS_MASTER SET EMAIL='fbril@ufl.edu' WHERE Pilot_ID=322;
UPDATE pilots.PILOTS_MASTER SET EMAIL='steffiw@ufl.edu' WHERE Pilot_ID=331;
UPDATE pilots.PILOTS_MASTER SET EMAIL='mraizada@ufl.edu' WHERE Pilot_ID=330;
UPDATE pilots.PILOTS_MASTER SET EMAIL='luesch@cop.ufl.edu' WHERE Pilot_ID=327;
UPDATE pilots.PILOTS_MASTER SET EMAIL='' WHERE Pilot_ID=313;
UPDATE pilots.PILOTS_MASTER SET EMAIL='ewt@ufl.edu' WHERE Pilot_ID=319;
UPDATE pilots.PILOTS_MASTER SET EMAIL='Hans.Ghayee@medicine.ufl.edu' WHERE Pilot_ID=323;
UPDATE pilots.PILOTS_MASTER SET EMAIL='tan@chem.ufl.edu' WHERE Pilot_ID=308;
UPDATE pilots.PILOTS_MASTER SET EMAIL='julie.johnson@ufl.edu' WHERE Pilot_ID=325;
UPDATE pilots.PILOTS_MASTER SET EMAIL='kenworth@ufl.edu' WHERE Pilot_ID=314;
UPDATE pilots.PILOTS_MASTER SET EMAIL='dehoff@cop.ufl.edu' WHERE Pilot_ID=302;
UPDATE pilots.PILOTS_MASTER SET EMAIL='kchoe@ufl.edu' WHERE Pilot_ID=310;


ALTER TABLE 
###############

drop table if exists pilots.noSECIM;
create table pilots.noSECIM
SELECT * from pilots.PILOTS_MASTER
WHERE Pilot_ID NOT IN 
(315, 307, 322, 331, 330, 327, 313, 319, 323, 308, 325, 314, 302, 310, 299, 300, 301, 303, 304, 305, 306, 309, 311, 312, 316, 317, 318, 320, 321, 324, 326, 328, 329,
420, 421, 422, 423, 424, 425, 426, 427, 428, 432, 431, 430, 436, 435, 434, 433, 429, 437, 438, 439, 440, 441
);

ALTER TABLE pilots.noSECIM MODIFY COLUMN AwardType varchar(125);

select distinct End_date from 

UPDATE pilots.noSECIM SET End_Date = NULL;



SELECT * from pilots.PILOTS_MASTER
WHERE Pilot_ID =420;


ALTER TABLE pilots.noSECIM MODIFY COLUMN End_Date datetime NULL;
ALTER TABLE pilots.noSECIM MODIFY COLUMN NCE_Date datetime NULL;

select distinct NCE_Date from pilots.noSECIM;
select distinct  End_Date from pilots.noSECIM;

UPDATE pilots.noSECIM ps, pilots.PILOTS_MASTER lu
SET ps.End_Date=lu.End_Date
WHERE ps.Pilot_ID=lu.Pilot_ID
AND lu.End_Date<>'0000-00-00 00:00:00';

UPDATE pilots.noSECIM ps, pilots.PILOTS_MASTER lu
SET ps.NCE_Date=lu.NCE_Date
WHERE ps.Pilot_ID=lu.Pilot_ID
AND lu.NCE_Date<>'0000-00-00 00:00:00';

SELECT * from pilots.PILOTS_MASTER WHERE NCE_Date='0000-00-00 00:00:00' ;

SELECT DISTINCT NCE_DATE from pilots.PILOTS_MASTER;

SELECT Pilot_ID,NCE_DATE from pilots.PILOTS_MASTER WHERE NCE_DATE<>'';

UPDATE pilots.noSECIM SET NCE_Date = NULL;

UPDATE pilots.noSECIM SET NCE_Date=str_to_date('1,31,2016','%m,%d,%Y') WHERE  Pilot_ID=83;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('1,23,2016','%m,%d,%Y') WHERE  Pilot_ID=85;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('10,31,2015','%m,%d,%Y') WHERE  Pilot_ID=87;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('4,30,2017','%m,%d,%Y') WHERE  Pilot_ID=89;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('12,30,2015','%m,%d,%Y') WHERE  Pilot_ID=91;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('11,30,2016','%m,%d,%Y') WHERE  Pilot_ID=92;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('7,31,2017','%m,%d,%Y') WHERE  Pilot_ID=104;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('12,31,2016','%m,%d,%Y') WHERE  Pilot_ID=105;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('12,31,2016','%m,%d,%Y') WHERE  Pilot_ID=106;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('3,31,2016','%m,%d,%Y') WHERE  Pilot_ID=107;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('3,25,2016','%m,%d,%Y') WHERE  Pilot_ID=109;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('4,29,2016','%m,%d,%Y') WHERE  Pilot_ID=111;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('1,18,2016','%m,%d,%Y') WHERE  Pilot_ID=127;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('6,30,2016','%m,%d,%Y') WHERE  Pilot_ID=129;
UPDATE pilots.noSECIM SET NCE_Date=str_to_date('7,31,2017','%m,%d,%Y') WHERE  Pilot_ID=135;

select * from pilots.noSECIM;

create table work.test as select * from  pilots.noSECIM;

create table pilots.B4SecimBackup As select * from pilots.PILOTS_MASTER;
#######  !!!!!!!!!!!!!!!!!!!!!!
#######  CHECKS
select count(*) from pilots.PILOTS_MASTER;
select count(*) from pilots.noSECIM;

select min(Begin_Date),Max(Begin_Date) from pilots.noSECIM;

select Pilot_ID,Begin_date from pilots.noSECIM where Begin_date='2104-07-30 00:00:00';
UPDATE pilots.noSECIM SET Begin_date=str_to_date('7,30,2014','%m,%d,%Y') WHERE  Pilot_ID=108;


select min(End_Date),Max(End_Date) from pilots.noSECIM;
select min(NCE_Date),Max(NCE_Date) from pilots.noSECIM;

SELECT DISTINCT Category from pilots.noSECIM;
SELECT DISTINCT AwardType from pilots.noSECIM;


select * from pilots.noSECIM where AwardType like"%NMR%";

UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS NMR' WHERE AwardType='Global LC-MS NMR';
'Global LC-MS
NMR'

UPDATE pilots.noSECIM SET AwardType='Junior Faculty' WHERE  AwardType='Jr. Faculty';


UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR' WHERE AwardType='Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR';


SELECT Pilot_ID,AwardType from pilots.noSECIM Where Category="SECIM";

UPDATE pilots.noSECIM SET AwardType=''  Where Category="SECIM";

select distinct AwardType from pilots.noSECIM Category="SECIM";

UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 3: IROA' WHERE Pilot_ID=315;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=307;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: IROA' WHERE Pilot_ID=322;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Targeted LC/MS (SB)' WHERE Pilot_ID=331;
UPDATE pilots.noSECIM SET AwardType='Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR' WHERE Pilot_ID=330;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: IROA' WHERE Pilot_ID=327;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 2: NMR' WHERE Pilot_ID=313;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=319;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Global LC/MS' WHERE Pilot_ID=323;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 3: MALDI' WHERE Pilot_ID=308;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Global LC/MS' WHERE Pilot_ID=325;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=314;
UPDATE pilots.noSECIM SET AwardType='Core 1: Targeted Sanford Burnham' WHERE Pilot_ID=302;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 3: IROA' WHERE Pilot_ID=310;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 2' WHERE Pilot_ID=299;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 3: MALDI' WHERE Pilot_ID=300;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 2' WHERE Pilot_ID=301;
UPDATE pilots.noSECIM SET AwardType='Core 3: MALDI Imaging IROA' WHERE Pilot_ID=303;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 3: IROA' WHERE Pilot_ID=304;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 2' WHERE Pilot_ID=305;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=306;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=309;
UPDATE pilots.noSECIM SET AwardType='Core 1: Targeted: Acylcarnitines NAD+' WHERE Pilot_ID=311;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted' WHERE Pilot_ID=312;
UPDATE pilots.noSECIM SET AwardType='Core 1: Lipidomics Core 3: MALDI' WHERE Pilot_ID=316;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 2: NMR' WHERE Pilot_ID=317;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 1: Targeted: Acetyl-CoAs Amino Acids Organic Acids NAD Core 3: MALDI' WHERE Pilot_ID=318;
UPDATE pilots.noSECIM SET AwardType='Core 1: Untargeted Core 1: Targeted' WHERE Pilot_ID=320;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Targeted LC/MS (UF)' WHERE Pilot_ID=321;
UPDATE pilots.noSECIM SET AwardType='Core 1: IROA Core 1: Targeted LC/MS (SB)' WHERE Pilot_ID=324;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Global LC/MS' WHERE Pilot_ID=326;
UPDATE pilots.noSECIM SET AwardType='SECIM Core 2: 13C NMR' WHERE Pilot_ID=328;
UPDATE pilots.noSECIM SET AwardType='Core 1: Lipidomics Core 1: Targeted LC-MS (SB)' WHERE Pilot_ID=329;
UPDATE pilots.noSECIM SET AwardType='SECIM C13 isotopomer Analysis' WHERE Pilot_ID=420;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS Lipidomics' WHERE Pilot_ID=421;
UPDATE pilots.noSECIM SET AwardType='SECIM IROA' WHERE Pilot_ID=422;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS Targeted LC-MS' WHERE Pilot_ID=423;
UPDATE pilots.noSECIM SET AwardType='SECIM 1H NMR' WHERE Pilot_ID=424;
UPDATE pilots.noSECIM SET AwardType='SECIM Targeted Metabolomics' WHERE Pilot_ID=425;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS Targeted LC-MS' WHERE Pilot_ID=426;
UPDATE pilots.noSECIM SET AwardType='SECIM Targeted LC-MS' WHERE Pilot_ID=427;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS NMR' WHERE Pilot_ID=428;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=432;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS Lipidomics' WHERE Pilot_ID=431;
UPDATE pilots.noSECIM SET AwardType='Global Metabolomics Lipidomics Global NMR' WHERE Pilot_ID=430;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS (lipidomics/global combo)' WHERE Pilot_ID=436;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=435;
UPDATE pilots.noSECIM SET AwardType='SECIM Targeted LC-MS' WHERE Pilot_ID=434;
UPDATE pilots.noSECIM SET AwardType='Global LC-MS Targeted LC-MS' WHERE Pilot_ID=433;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=429;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=437;
UPDATE pilots.noSECIM SET AwardType='SECIM NMR' WHERE Pilot_ID=438;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=439;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS, 1C panel, Pyrimidine and Nucleotide panel' WHERE Pilot_ID=440;
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS' WHERE Pilot_ID=441;

select distinct AwardType from pilots.noSECIM WHERE Category="SECIM";

UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR' WHERE AwardType='Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: IROA Core 1: Targeted LC/MS (SB)' WHERE AwardType='Core 1: IROA Core 1: Targeted LC/MS (SB)';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Lipidomics Core 1: Targeted LC-MS (SB)' WHERE AwardType='Core 1: Lipidomics Core 1: Targeted LC-MS (SB)';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Lipidomics Core 3: MALDI' WHERE AwardType='Core 1: Lipidomics Core 3: MALDI';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Targeted Sanford Burnham' WHERE AwardType='Core 1: Targeted Sanford Burnham';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Targeted: Acylcarnitines NAD+' WHERE AwardType='Core 1: Targeted: Acylcarnitines NAD+';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 1: Targeted' WHERE AwardType='Core 1: Untargeted Core 1: Targeted';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 1: Targeted: Acetyl-CoAs Amino Acids Organic Acids NAD Core 3: MALDI' WHERE AwardType='Core 1: Untargeted Core 1: Targeted: Acetyl-CoAs Amino Acids Organic Acids NAD Core 3: MALDI';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 2' WHERE AwardType='Core 1: Untargeted Core 2';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 2: NMR' WHERE AwardType='Core 1: Untargeted Core 2: NMR';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 3: IROA' WHERE AwardType='Core 1: Untargeted Core 3: IROA';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 1: Untargeted Core 3: MALDI' WHERE AwardType='Core 1: Untargeted Core 3: MALDI';
UPDATE pilots.noSECIM SET AwardType='SECIM Core 3: MALDI Imaging IROA' WHERE AwardType='Core 3: MALDI Imaging IROA';
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS Lipidomics' WHERE AwardType='Global LC-MS Lipidomics';
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS NMR' WHERE AwardType='Global LC-MS NMR';
UPDATE pilots.noSECIM SET AwardType='SECIM Global LC-MS Targeted LC-MS' WHERE AwardType='Global LC-MS Targeted LC-MS';
UPDATE pilots.noSECIM SET AwardType='SECIM Global Metabolomics Lipidomics Global NMR' WHERE AwardType='Global Metabolomics Lipidomics Global NMR';


DROP TABLE IF EXISTS pilots.PILOTS_MASTER;
CREATE TABLE pilots.PILOTS_MASTER AS
SELECT * from pilots.noSECIM ORDER by Pilot_ID;

drop table pilots.temp;
create table pilots.temp AS
SELECT Pilot_ID, AwardLetterDate from pilots.noSECIM
WHERE AwardLetterDate NOT IN ('0000-00-00 00:00:00');


select distinct AwardLetterDate from pilots.noSECIM;




ALTER TABLE pilots.noSECIM MODIFY COLUMN AwardLetterDate datetime NULL;
UPDATE pilots.noSECIM SET AwardLetterDate = NULL;

UPDATE pilots.noSECIM sp, pilots.temp lu
SET sp.AwardLetterDate=lu.AwardLetterDate
WHERE sp.Pilot_ID=lu.Pilot_ID;




############### REFORMAT GRANTS AND PUBS FOR SECIM

drop table pilots.temp;
create table pilots.temp as
PILOTS_PUB_MASTERselect Pilot_ID,AwardLetterDate,PI_Last,PI_First,UFID,PubYear,VerifiedPub,GrantYear,VerifiedGrant 
from pilots.old_lookup_pilots
WHERE (PubYear<>0 OR GrantYear<>0)
AND Category="SECIM";


drop table pilots.temp;
create table pilots.temp as
select * from pilots.PILOTS_PUB_MASTER;

SELECT MAX(pub_master_id)+1 from pilots.PILOTS_PUB_MASTER;


########################
drop table if exists 
create table pilots.temp as
select * from pilots.PILOTS_ROI_MASTER;



SELECT MAX(roi_master_id)+1 from pilots.PILOTS_ROI_MASTER;

drop table if exists pilots.temp;
create table pilots.temp as
SELECT 
CLK_AWD_ID,
CLK_AWD_PROJ_ID,
Year(FUNDS_ACTIVATED) AS Year_Activiated,
FUNDS_ACTIVATED AS FUNDS_ACTIVATED,
CLK_AWD_PI,
CLK_PI_UFID,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_AWD_ID,
CLK_AWD_PROJ_NAME AS Grant_Title,
DIRECT_AMOUNT,
INDIRECT_AMOUNT,
SPONSOR_AUTHORIZED_AMOUNT
FROM lookup.awards_history
WHERE CLK_AWD_PROJ_MGR like ("%ainsworth%");

where CLK_AWD_ID  like "";

'00097527'
 FROM lookup.awards_history where CLK_AWD_PROJ_ID  like "00111934";

#### UPDATE APRIL BRAXTON DATES DATES (CLINICAL)
## 

drop table if exists pilots.work_pilots_master;
create table pilots.work_pilots_master As
select * from pilots.PILOTS_MASTER;

Alter table pilots.work_pilots_master ADD ChangeCol varchar(255);



SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.work_pilots_master SET ChangeCol='';

UPDATE pilots.work_pilots_master pm, pilots.april_clinical_dtes lu
SET pm.ChangeCol=concat(pm.ChangeCol," Begin_Date")
WHERE pm.Pilot_ID=lu.Pilot_ID AND pm.Begin_Date<>lu.Begin_Date;

UPDATE pilots.work_pilots_master pm, pilots.april_clinical_dtes lu
SET pm.ChangeCol=concat(pm.ChangeCol," End_Date")
WHERE pm.Pilot_ID=lu.Pilot_ID AND pm.End_Date<>lu.End_Date;

UPDATE pilots.work_pilots_master pm, pilots.april_clinical_dtes lu
SET pm.ChangeCol=concat(pm.ChangeCol," NCE_Date")
WHERE pm.Pilot_ID=lu.Pilot_ID AND pm.NCE_Date<>lu.NCE_Date;

select Pilot_ID, Begin_Date from pilots.april_clinical_dtes 
where Pilot_ID IN (select Pilot_id from pilots.work_pilots_master where ChangeCol<>"");

UPDATE pilots.PILOTS_MASTER pm, pilots.april_clinical_dtes lu
SET pm.Begin_Date=lu.Begin_Date
WHERE pm.Pilot_ID=lu.Pilot_ID
AND pm.Pilot_ID IN (380,381,390,391,392,393,394,395);


ALTER TABLE pilots.PILOTS_MASTER
 ADD IRB_Num varchar(16),
 ADD IRB_Approval_Date datetime NULL,
 ADD IRB_Close_Date datetime NULL;
 
UPDATE pilots.PILOTS_MASTER
SET IRB_Num='',
	IRB_Approval_Date = NULL,
	IRB_Close_Date = NULL;

select distinct IRB_Approval_Date from pilots.april_clinical_dtes;

SET SQL_SAFE_UPDATES = 0;



UPDATE pilots.PILOTS_MASTER pm, pilots.april_clinical_dtes lu
SET pm.IRB_Num=lu.`IRB_No.`
WHERE pm.Pilot_ID=lu.Pilot_ID AND lu.`IRB_No.` IS NOT NULL;

UPDATE pilots.PILOTS_MASTER pm, pilots.april_clinical_dtes lu
SET pm.IRB_Approval_Date=lu.IRB_Approval_Date
WHERE pm.Pilot_ID=lu.Pilot_ID AND lu.IRB_Approval_Date IS NOT NULL;

UPDATE pilots.PILOTS_MASTER pm, pilots.april_clinical_dtes lu
SET pm.IRB_Close_Date=lu.IRB_Closure_Date
WHERE pm.Pilot_ID=lu.Pilot_ID AND lu.IRB_Closure_Date IS NOT NULL;


SET SQL_SAFE_UPDATES = 1;


select * from pilots.PILOTS_GRANT_SUMMARY where PIlot_ID=64;

CLK_AWD_ID
CLK_AWD_PROJ_ID

desc pilots.PILOTS_MASTER;
desc pilots.PILOTS_PUB_MASTER;
desc pilots.PILOTS_ROI_MASTER;
desc pilots.PILOTS_SUMMARY;
desc pilots.PILOTS_ROI_DETAIL;
desc pilots.PILOTS_GRANT_SUMMARY;

###################################
###################################
### ID CRC STUDIES
###################################

ALTER TABLE pilots.PILOTS_MASTER
ADD CRC_STUDY int(1);


SET SQL_SAFE_UPDATES = 0;



UPDATE pilots.PILOTS_MASTER
SET CRC_STUDY=0;

UPDATE pilots.PILOTS_MASTER
SET CRC_STUDY=1
WHERE Pilot_ID IN
(83, 85, 86, 87, 88, 89, 90, 91, 92, 97, 101, 102, 103, 104, 105,
108, 110, 111, 112, 113, 116, 118, 121, 122, 380, 388
);



SET SQL_SAFE_UPDATES = 1;


##############################
##############################
### ADD iCITE 
SELECT PMID,PIlot_ID from pilots.PILOTS_PUB_MASTER WHERE PMID <>"" GROUP BY PMID,PIlot_ID ;

###Use list to obtain iCite Table


SELECT * from pilots.PILOTS_PUB_MASTER WHERE Pilot_id in (69,377);
select * from pilots.PILOTS_MASTER where Pilot_id in (69,377);
select * from lookup.pilots where Pilot_id in (69,377);


select * from lookup.pilots where Pilot_id in (334,92);
SELECT * from pilots.PILOTS_PUB_MASTER WHERE Pilot_id in (92,334);




select Pilot_ID,PubYear,VerifiedPub from lookup.pilots where PubYear<>0;


select Pilot_ID,AwardLetterDate,PI_Last,PI_First from pilots.PILOTS_MASTER where Pilot_id in (92,334);


select * FROM pilots.PILOTS_PUB_MASTER WHERE Pilot_id   in (92,334);

UPDATE pilots.PILOTS_PUB_MASTER SET VivoArticle="X" where VivoArticle in ("x","");

select Pilot_ID,AwardLetterDate,PI_Last,PI_First from pilots.PILOTS_MASTER where Pilot_id in (
59,
99,
104,
135
);



select Pilot_ID,AwardLetterDate,Award_Year,PI_Last,PI_First from lookup.pilots where Pilot_ID=55;


create table pilots.pilot_pubs_backup as select * from pilots.PILOTS_PUB_MASTER;

ALTER TABLE pilots.PILOTS_PUB_MASTER Add PubDate date null;

select distinct Pubdate from pilots.PILOTS_PUB_MASTER;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,11,2012','%m,%d,%Y') WHERE pub_master_id=13;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,1,2013','%m,%d,%Y') WHERE pub_master_id=16;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,13,2013','%m,%d,%Y') WHERE pub_master_id=12;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,6,2013','%m,%d,%Y') WHERE pub_master_id=61;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('11,1,2013','%m,%d,%Y') WHERE pub_master_id=22;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,23,2014','%m,%d,%Y') WHERE pub_master_id=19;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('3,20,2014','%m,%d,%Y') WHERE pub_master_id=2;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('3,1,2014','%m,%d,%Y') WHERE pub_master_id=70;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('7,9,2014','%m,%d,%Y') WHERE pub_master_id=51;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('8,30,2014','%m,%d,%Y') WHERE pub_master_id=29;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,10,2014','%m,%d,%Y') WHERE pub_master_id=54;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('12,1,2014','%m,%d,%Y') WHERE pub_master_id=26;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('12,1,2014','%m,%d,%Y') WHERE pub_master_id=4;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,28,2015','%m,%d,%Y') WHERE pub_master_id=47;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,9,2015','%m,%d,%Y') WHERE pub_master_id=52;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,20,2015','%m,%d,%Y') WHERE pub_master_id=35;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('8,1,2015','%m,%d,%Y') WHERE pub_master_id=46;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,8,2015','%m,%d,%Y') WHERE pub_master_id=27;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,5,2015','%m,%d,%Y') WHERE pub_master_id=59;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,9,2015','%m,%d,%Y') WHERE pub_master_id=8;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,9,2015','%m,%d,%Y') WHERE pub_master_id=15;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,10,2015','%m,%d,%Y') WHERE pub_master_id=10;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,19,2015','%m,%d,%Y') WHERE pub_master_id=50;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,19,2015','%m,%d,%Y') WHERE pub_master_id=7;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,30,2015','%m,%d,%Y') WHERE pub_master_id=1;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,22,2015','%m,%d,%Y') WHERE pub_master_id=23;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('8,12,2015','%m,%d,%Y') WHERE pub_master_id=68;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,1,2015','%m,%d,%Y') WHERE pub_master_id=34;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,9,2015','%m,%d,%Y') WHERE pub_master_id=18;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,9,2015','%m,%d,%Y') WHERE pub_master_id=28;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,22,2015','%m,%d,%Y') WHERE pub_master_id=57;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,17,2016','%m,%d,%Y') WHERE pub_master_id=63;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,17,2016','%m,%d,%Y') WHERE pub_master_id=72;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,2,2016','%m,%d,%Y') WHERE pub_master_id=36;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,2,2016','%m,%d,%Y') WHERE pub_master_id=65;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,6,2016','%m,%d,%Y') WHERE pub_master_id=73;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('3,19,2016','%m,%d,%Y') WHERE pub_master_id=5;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,7,2016','%m,%d,%Y') WHERE pub_master_id=17;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,12,2016','%m,%d,%Y') WHERE pub_master_id=67;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,22,2016','%m,%d,%Y') WHERE pub_master_id=69;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,17,2016','%m,%d,%Y') WHERE pub_master_id=48;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,19,2016','%m,%d,%Y') WHERE pub_master_id=21;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('6,28,2016','%m,%d,%Y') WHERE pub_master_id=42;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,13,2016','%m,%d,%Y') WHERE pub_master_id=30;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,6,2016','%m,%d,%Y') WHERE pub_master_id=33;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,20,2016','%m,%d,%Y') WHERE pub_master_id=45;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,1,2017','%m,%d,%Y') WHERE pub_master_id=74;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,19,2017','%m,%d,%Y') WHERE pub_master_id=25;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,27,2017','%m,%d,%Y') WHERE pub_master_id=43;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,18,2017','%m,%d,%Y') WHERE pub_master_id=40;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('7,1,2017','%m,%d,%Y') WHERE pub_master_id=66;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,2,2017','%m,%d,%Y') WHERE pub_master_id=49;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('11,12,2017','%m,%d,%Y') WHERE pub_master_id=38;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,29,2018','%m,%d,%Y') WHERE pub_master_id=53;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('7,1,2016','%m,%d,%Y') WHERE pub_master_id=37;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,31,2015','%m,%d,%Y') WHERE pub_master_id=44;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,12,2014','%m,%d,%Y') WHERE pub_master_id=55;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,1,2014','%m,%d,%Y') WHERE pub_master_id=31;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('12,15,2014','%m,%d,%Y') WHERE pub_master_id=62;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('12,15,2014','%m,%d,%Y') WHERE pub_master_id=71;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,11,2015','%m,%d,%Y') WHERE pub_master_id=14;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('11,20,2015','%m,%d,%Y') WHERE pub_master_id=11;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('9,12,2014','%m,%d,%Y') WHERE pub_master_id=60;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('4,1,2017','%m,%d,%Y') WHERE pub_master_id=3;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('1,1,2014','%m,%d,%Y') WHERE pub_master_id=6;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('10,1,2017','%m,%d,%Y') WHERE pub_master_id=39;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('5,1,2018','%m,%d,%Y') WHERE pub_master_id=41;
UPDATE pilots.PILOTS_PUB_MASTER SET PubDate=str_to_date('2,1,2015','%m,%d,%Y') WHERE pub_master_id=56;

UPDATE pilots.PILOTS_PUB_MASTER SET PubYear=YEAR(PubDate);

SELECT PubDate,year(PubDate) from pilots.PILOTS_PUB_MASTER;

drop table if exists pilots.temp;  create table pilots.temp as select * from  pilots.pilots_pub_icite;


drop table pilots.Pilot_Pubs_iCite;
create table pilots.PILOT_PUBS_iCite AS SELECT * from pilots.temp;

select * from pilots.PILOT_PUBS_iCite;


Create table work.pilotspub as
select * from pilots.PILOTS_PUB_MASTER;

#################### ADD ICITE DATA TO PubMaster;
Alter table  pilots.PILOTS_PUB_MASTER
							ADD Total_Citations int(11),
							ADD Citations_per_Year decimal(65,30),
							ADD Expected_Citations_per_Year decimal(65,30),
                            ADD Field_Citation_Rate decimal(65,30),		
							ADD Relative_Citation_Ratio decimal(65,30),	
							ADD NIH_Percentile decimal(12,2);	



SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.PILOTS_PUB_MASTER pp, pilots.PILOT_PUBS_iCite lu
SET            pp.Total_Citations=lu.Total_Citations,
               pp.Citations_per_Year=lu.Citations_per_Year,
               pp.Expected_Citations_per_Year=lu.Expected_Citations_per_Year,
               pp.Field_Citation_Rate=lu.Field_Citation_Rate,
               pp.Relative_Citation_Ratio=lu.Relative_Citation_Ratio,
               pp.NIH_Percentile=lu.NIH_Percentile
WHERE pp.PMID=lu.PubMed_ID;

select * from work.pilotspub;
######################################################################################
## CREATE TABLE FOR MISSING END DATE COLLECTION
DROP TABLE IF EXISTS pilots.noenddate;
Create table pilots.noenddate AS
select 	Pilot_ID,
		Category,
		AwardLetterDate,
		Award_Amt,
		End_Date,
		concat(trim(PI_Last),", ",Trim(PI_First)) AS PI,
		Title

From pilots.PILOTS_MASTER
WHERE End_date is Null and Awarded="Awarded" AND Award_Year>=2012
ORDER BY Category, AwardLetterDate;



###################################
## ADD PHASE TO AWARDTYPE FOR TRANSLATIONAL
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=99;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=93;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=97;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=102;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=103;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=101;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=138;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=389;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 1' WHERE Pilot_ID=385;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 1' WHERE Pilot_ID=386;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=387;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=388;
UPDATE pilots.PILOTS_MASTER SET AwardType='Phase 2' WHERE Pilot_ID=419;
UPDATE pilots.PILOTS_MASTER SET AwardType='' WHERE Pilot_ID=417;
UPDATE pilots.PILOTS_MASTER SET AwardType='' WHERE Pilot_ID=418;

UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,20,2019','%m,%d,%Y') WHERE Pilot_ID=418;

##Withdrawn Comm Pilot
UPDATE pilots.PILOTS_MASTER SET Awarded='Withdrew' WHERE Pilot_ID=96;

## UPDATE END DATES
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,17,2018','%m,%d,%Y') WHERE Pilot_ID=390;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,25,2018','%m,%d,%Y') WHERE Pilot_ID=380;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('8,2,2018','%m,%d,%Y') WHERE Pilot_ID=381;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('11,17,2018','%m,%d,%Y') WHERE Pilot_ID=391;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('1,25,2019','%m,%d,%Y') WHERE Pilot_ID=392;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,10,2019','%m,%d,%Y') WHERE Pilot_ID=393;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,29,2019','%m,%d,%Y') WHERE Pilot_ID=394;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,11,2019','%m,%d,%Y') WHERE Pilot_ID=395;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,13,2016','%m,%d,%Y') WHERE Pilot_ID=94;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=95;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,1,2016','%m,%d,%Y') WHERE Pilot_ID=98;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,21,2016','%m,%d,%Y') WHERE Pilot_ID=100;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=382;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=383;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=384;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=414;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=415;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,7,2019','%m,%d,%Y') WHERE Pilot_ID=416;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,23,2014','%m,%d,%Y') WHERE Pilot_ID=376;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,23,2014','%m,%d,%Y') WHERE Pilot_ID=377;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,23,2014','%m,%d,%Y') WHERE Pilot_ID=378;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,23,2014','%m,%d,%Y') WHERE Pilot_ID=379;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('8,24,2018','%m,%d,%Y') WHERE Pilot_ID=333;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('8,24,2018','%m,%d,%Y') WHERE Pilot_ID=334;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('9,16,2018','%m,%d,%Y') WHERE Pilot_ID=335;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,18,2019','%m,%d,%Y') WHERE Pilot_ID=332;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=299;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=300;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=301;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=302;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=303;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=304;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=305;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=306;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=307;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=308;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,30,2015','%m,%d,%Y') WHERE Pilot_ID=309;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=310;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=311;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=312;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=313;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=314;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=315;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=316;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=317;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=318;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=319;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,3,2016','%m,%d,%Y') WHERE Pilot_ID=320;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=321;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=322;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=323;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=324;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=325;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=326;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=327;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=328;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=329;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=330;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,17,2017','%m,%d,%Y') WHERE Pilot_ID=331;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=420;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=421;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=422;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=424;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=426;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=427;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=428;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=429;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=430;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=431;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=432;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=433;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=434;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,18,2018','%m,%d,%Y') WHERE Pilot_ID=435;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=423;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=425;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=436;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=437;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=438;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=439;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=440;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,4,2019','%m,%d,%Y') WHERE Pilot_ID=441;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('8,18,2014','%m,%d,%Y') WHERE Pilot_ID=191;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('9,20,2014','%m,%d,%Y') WHERE Pilot_ID=67;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=338;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=339;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=340;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=341;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=351;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=352;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=365;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=366;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=368;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,4,2018','%m,%d,%Y') WHERE Pilot_ID=369;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('2,17,2019','%m,%d,%Y') WHERE Pilot_ID=396;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('3,5,2019','%m,%d,%Y') WHERE Pilot_ID=398;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,14,2019','%m,%d,%Y') WHERE Pilot_ID=397;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('1,11,2017','%m,%d,%Y') WHERE Pilot_ID=99;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('2,8,2017','%m,%d,%Y') WHERE Pilot_ID=93;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('3,2,2017','%m,%d,%Y') WHERE Pilot_ID=97;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,18,2017','%m,%d,%Y') WHERE Pilot_ID=102;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,25,2017','%m,%d,%Y') WHERE Pilot_ID=103;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('10,29,2017','%m,%d,%Y') WHERE Pilot_ID=101;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('2,23,2018','%m,%d,%Y') WHERE Pilot_ID=138;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('6,21,2018','%m,%d,%Y') WHERE Pilot_ID=389;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,17,2018','%m,%d,%Y') WHERE Pilot_ID=385;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('5,23,2018','%m,%d,%Y') WHERE Pilot_ID=386;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('9,7,2018','%m,%d,%Y') WHERE Pilot_ID=387;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('11,27,2018','%m,%d,%Y') WHERE Pilot_ID=388;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,25,2019','%m,%d,%Y') WHERE Pilot_ID=419;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,20,2019','%m,%d,%Y') WHERE Pilot_ID=417;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('4,20,2019','%m,%d,%Y') WHERE Pilot_ID=418;


UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,25,2018','%m,%d,%Y') WHERE Pilot_ID=96;

############ verify end dates
select Pilot_ID, AwardLetterDate, End_Date,PI_Last ,Category from pilots.PILOTS_MASTER where AwardLetterDate>End_Date;

UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('12,19,2013','%m,%d,%Y') WHERE Pilot_ID=66;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('7,18,2015','%m,%d,%Y') WHERE Pilot_ID=128;
UPDATE pilots.PILOTS_MASTER SET End_Date=str_to_date('8,24,2018','%m,%d,%Y') WHERE Pilot_ID=334;



#####################
Alter Table pilots.PILOTS_ROI_MASTER Add AwardLetterDate datetime null;
UPDATE pilots.PILOTS_ROI_MASTER am, pilots.PILOTS_MASTER lu
SET am.AwardLetterDate=lu.AwardLetterDate
WHERE am.Pilot_ID=lu.Pilot_ID;

drop table if exists work.fundact;
create table work.fundact as
select Pilot_ID,AggLevel,CLK_AWD_ID,CLK_AWD_PROJ_ID,min(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED from pilots.PILOTS_ROI_DETAIL 
GROUP BY Pilot_ID,AggLevel,CLK_AWD_ID,CLK_AWD_PROJ_ID;


create table work.backup_pilots_roi_master as select * from  pilots.PILOTS_ROI_MASTER;
DROP TABLE if exists pilots.PILOTS_ROI_MASTER;
CREATE TABLE pilots.PILOTS_ROI_MASTER as SELECT * from work.backup_pilots_roi_master;


UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('6,30,2015','%m,%d,%Y') WHERE roi_master_id=5;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('6,30,2015','%m,%d,%Y') WHERE roi_master_id=7;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('1,12,2016','%m,%d,%Y') WHERE roi_master_id=17;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('5,22,2017','%m,%d,%Y') WHERE roi_master_id=37;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('9,28,2012','%m,%d,%Y') WHERE roi_master_id=41;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('5,3,2013','%m,%d,%Y') WHERE roi_master_id=42;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('10,26,2016','%m,%d,%Y') WHERE roi_master_id=46;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('9,11,2014','%m,%d,%Y') WHERE roi_master_id=51;
UPDATE pilots.PILOTS_ROI_MASTER SET FUNDS_ACTIVATED=str_to_date('3,4,2016','%m,%d,%Y') WHERE roi_master_id=52;

UPDATE pilots.PILOTS_ROI_MASTER SET Year_Activiated=Year(FUNDS_ACTIVATED);

*/
## CREATE BACKUPS OF CORE TABLES

## CREATE TABLE loaddata.BACKUP_PILOTS_MASTER AS Select * from pilots.PILOTS_MASTER;

## CREATE TABLE loaddata.BACKUP_PILOTS_PUB_MASTER AS Select * from pilots.PILOTS_PUB_MASTER;

## CREATE TABLE loaddata.BACKUP_PILOTS_ROI_MASTER AS Select * from pilots.PILOTS_ROI_MASTER;


