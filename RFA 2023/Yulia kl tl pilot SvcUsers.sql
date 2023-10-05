### GET PILOT DATA
### KL and TL Data provided by April Braxton
### Note the KL and Tl Files are as provided 
### except the UFIDs were converted to varchar - TEXT(XX,"00000000")

DROP TABLE IF EXISTS work.pilots2018;
Create table work.pilots2018
SELECT 
UFID,
PI_Last,
PI_First,
Category,
AwardType,
AwardLetterDate,
Award_Amt,
Email,
Title
from pilots.PILOTS_MASTER
Where Award_Year>=2018
And Awarded="Awarded";

### Create an unduplicated working file BY UFID
### Group concat Source, to contraol for a UFID appearing in multiple catagories.alter
DROP TABLE IF EXISTS work.pilot_kl_tl_undup ;
Create table work.pilot_kl_tl_undup
SELECT  UFID,
		max(PI_Last) as LastName,
        max(PI_First) as FirstName,
        group_concat(Source) as Sources
From work.pilot_kl_tl  
group by UFID;

#### ID SERVICE SET
select distinct STD_PROGRAM from lookup.roster 
WHERE Year >=2018
AND UFID IN (SELECT DISTINCT UFID FROM work.pilot_kl_tl_undup);

###########

Alter TABLE work.pilot_kl_tl_undup
       ADD BERD int(5),
       ADD BioInformatics int(5),
       ADD Biorepository int(5),
       ADD Cellular_Reprograming int(5),
       ADD Clinical_Research_Center int(5),
       ADD Research_Prof_Council int(5),
       ADD ClinicalTrials_GOV int(5),
       ADD Communications int(5),
       ADD COVID19_SRCWG int(5),
       ADD CTS_IT int(5),
       ADD CTSI_Administration int(5),
       ADD Ethics_Consul int(5),
       ADD HealthStreet int(5),
       ADD Human_Imaging int(5),
       ADD Imp_Science int(5),
       ADD Integrated_Data_Repository int(5),
       ADD KL_TL int(5),
       ADD Learning_Health_System int(5),
       ADD Mentor_Academy int(5),
       ADD Metabolomics int(5),
       ADD MS_CTS int(5),
       ADD OneFlorida int(5),
       ADD Personalized_Med int(5),
       ADD Pilots int(5),
       ADD PubMed_Comp int(5),
       ADD Recruitment_Ctr int(5),
       ADD REDCap int(5),
       ADD Reg_Assistance int(5),
       ADD Research_Subject_Adv int(5),
       ADD Service_Center int(5),
       ADD StudyConnect int(5),
       ADD TRACTS int(5),
       ADD Translational_Drug_Dev int(5),
       ADD Vouchers int(5);
  
  
###### Initialize Service Columns   
SET SQL_SAFE_UPDATES = 0;

UPDATE work.pilot_kl_tl_undup
     SET   BERD=0,
           BioInformatics=0,
           Biorepository=0,
           Cellular_Reprograming=0,
           Clinical_Research_Center=0,
           Research_Prof_Council=0,
           ClinicalTrials_GOV=0,
           Communications=0,
           COVID19_SRCWG=0,
           CTS_IT=0,
           CTSI_Administration=0,
           Ethics_Consul=0,
           HealthStreet=0,
           Human_Imaging=0,
           Imp_Science=0,
           Integrated_Data_Repository=0,
           KL_TL=0,
           Learning_Health_System=0,
           Mentor_Academy=0,
           Metabolomics=0,
           MS_CTS=0,
           OneFlorida=0,
           Personalized_Med=0,
           Pilots=0,
           PubMed_Comp=0,
           Recruitment_Ctr=0,
           REDCap=0,
           Reg_Assistance=0,
           Research_Subject_Adv=0,
           Service_Center=0,
           StudyConnect=0,
           TRACTS=0,
           Translational_Drug_Dev=0,
           Vouchers=0;
    
##### Create Service use Summary Table
DROP TABLE IF EXISTS work.pilot_kl_tl_SvcSum ;
Create table work.pilot_kl_tl_SvcSum AS
SELECT UFID,
	   STD_PROGRAM,
       COUNT(*) as nRECs
from lookup.roster 
WHERE Year >=2018
AND UFID IN (SELECT DISTINCT UFID FROM work.pilot_kl_tl_undup)
GROUP BY UFID, STD_PROGRAM;

### Update Service Use columns
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET BERD=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='BERD';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET BioInformatics=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='BioInformatics';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Biorepository=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Biorepository';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Cellular_Reprograming=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Cellular Reprograming';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Clinical_Research_Center=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Clinical Research Center';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Research_Prof_Council=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Clinical Research Prof Advisory Council';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET ClinicalTrials_GOV=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='ClinicalTrials.GOV';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Communications=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Communications';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET COVID19_SRCWG=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='COVID-19 SRCWG';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET CTS_IT=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='CTS IT';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET CTSI_Administration=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='CTSI Administration';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Ethics_Consul=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Ethics Consultation';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET HealthStreet=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Human_Imaging=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Human Imaging';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Imp_Science=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Implementation Science';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Integrated_Data_Repository=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Integrated Data Repository';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET KL_TL=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='KL TL';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Learning_Health_System=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Learning Health System';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Mentor_Academy=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Mentor Academy';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Metabolomics=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Metabolomics';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET MS_CTS=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='MS CTS';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET OneFlorida=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='OneFlorida+';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Personalized_Med=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Personalized Medicine';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Pilots=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Pilot Awards';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET PubMed_Comp=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='PubMed Compliance';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Recruitment_Ctr=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Recruitment Center';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET REDCap=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='REDCap';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Reg_Assistance=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Regulatory Assistance';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Research_Subject_Adv=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Research Subject Advocate';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Service_Center=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Service Center';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET StudyConnect=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='StudyConnect';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET TRACTS=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='TRACTS';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Translational_Drug_Dev=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Translational Drug Development';
UPDATE work.pilot_kl_tl_undup ud, work.pilot_kl_tl_SvcSum lu SET Vouchers=lu.nRecs WHERE ud.UFID=lu.UFID and lu.STD_PROGRAM='Vouchers';

Select * from work.pilot_kl_tl_undup;

SELECT UF_UFID, UF_DISPLAY_NM, UF_EMAIL
FROM lookup.ufids
WHERE UF_UFID IN (Select DISTINCT UFID from work.pilot_kl_tl_undup);

Select * from pilots.PILOTS_MASTER WHERE PI_Last LIKE "Rashidi";