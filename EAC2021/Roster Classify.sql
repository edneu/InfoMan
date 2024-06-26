####################################################################################################################
####################################################################################################################
####################################################################################################################
####################################################################################################################
### ASSIGN REPT_PROGRAM

SET SQL_SAFE_UPDATES = 0;


UPDATE lookup.roster SET Rept_Program=NULL; 

UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Academcy for Research Excellence';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Coordinator Development';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Aging CRU';
UPDATE lookup.roster SET Rept_Program='BERD' WHERE STD_PROGRAM='BERD';  
UPDATE lookup.roster SET Rept_Program='BioInformatics' WHERE STD_PROGRAM='BioInformatics';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Biobehavioral';
UPDATE lookup.roster SET Rept_Program='Biorepository' WHERE STD_PROGRAM='Biorepository';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CCTR';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CTRB_Investigators';
UPDATE lookup.roster SET Rept_Program='CTS IT' WHERE STD_PROGRAM='CTS IT';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CTSI Administration';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Cancer CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Cardiovascular CRU';
UPDATE lookup.roster SET Rept_Program='Cellular Reprogramming' WHERE STD_PROGRAM='Cellular Reprogramming';
UPDATE lookup.roster SET Rept_Program='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Clinical Research Professionals Advisory Council';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='ClinicalTrials.GOV';
UPDATE lookup.roster SET Rept_Program='Communications' WHERE STD_PROGRAM='Communications';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='Community Engagement - Jacksonville';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Dental CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Diabetes Center';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Ethics Consultation';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Evaluation';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='GI Liver CRU';
UPDATE lookup.roster SET Rept_Program='Personalized Medicine' WHERE STD_PROGRAM='Genotyping';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Jacksonville';
UPDATE lookup.roster SET Rept_Program='Human Imaging' WHERE STD_PROGRAM='Human Imaging';
UPDATE lookup.roster SET Rept_Program='Implementation Science' WHERE STD_PROGRAM='Implementation Science';
UPDATE lookup.roster SET Rept_Program='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Jacksonville  CRU';
UPDATE lookup.roster SET Rept_Program='K College' WHERE STD_PROGRAM='K College';
UPDATE lookup.roster SET Rept_Program='KL TL' WHERE STD_PROGRAM='KL TL';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='MS CTS';
UPDATE lookup.roster SET Rept_Program='Mentor Academy' WHERE STD_PROGRAM='Mentor Academy';
UPDATE lookup.roster SET Rept_Program='Mentor Academy' WHERE STD_PROGRAM='Mentor';
UPDATE lookup.roster SET Rept_Program='Metabolomics' WHERE STD_PROGRAM='Metabolomics';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Neuromedicine CRU';
UPDATE lookup.roster SET Rept_Program='One Florida' WHERE STD_PROGRAM='One Florida';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Pain CRU';
UPDATE lookup.roster SET Rept_Program='Personalized Medicine' WHERE STD_PROGRAM='Personalized Medicine';
UPDATE lookup.roster SET Rept_Program='Pilot Awards' WHERE STD_PROGRAM='Pilot Awards';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='PubMed Compliance';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Quality Assurance';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='RAC';
UPDATE lookup.roster SET Rept_Program='REDCap' WHERE STD_PROGRAM='REDCap';
UPDATE lookup.roster SET Rept_Program='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Research Coordinator Consortium';
UPDATE lookup.roster SET Rept_Program='Research Subject Advocate' WHERE STD_PROGRAM='Research Subject Advocate';
UPDATE lookup.roster SET Rept_Program='Clinical Research Center' WHERE STD_PROGRAM='Service Center';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Simulation Center';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Sleep CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Study Registry';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='StudyConnect';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='TPDP';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='TRACTS';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Tuberculosis PH CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='UNDEFINED';
UPDATE lookup.roster SET Rept_Program='Research Administration' WHERE STD_PROGRAM='Research Administration';
UPDATE lookup.roster SET Rept_Program='Translational Drug Development' WHERE STD_PROGRAM='Translational Drug Development';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='Translational Workforce Development';
UPDATE lookup.roster SET Rept_Program='FSU' WHERE STD_PROGRAM='FSU';
UPDATE lookup.roster SET Rept_Program='Learning Health System' WHERE STD_PROGRAM='Learning Health System';
UPDATE lookup.roster SET Rept_Program='Network Science' WHERE STD_PROGRAM='Network Science Program';
UPDATE lookup.roster SET Rept_Program='Research Administration' WHERE STD_PROGRAM='Office of Clinical Research';
UPDATE lookup.roster SET Rept_Program='UF Health Jacksonville' WHERE STD_PROGRAM='UF Health Jacksonville';
UPDATE lookup.roster SET Rept_Program='Cellular Reprogramming'  WHERE STD_PROGRAM='Cellular Reprograming';
UPDATE lookup.roster SET Rept_Program='Communications'  WHERE STD_PROGRAM='COMR';
UPDATE lookup.roster SET Rept_Program='COVID-19 SRCWG' WHERE STD_PROGRAM='COVID-19 SRCWG';
UPDATE lookup.roster SET Rept_Program='Integrated Data Repository' WHERE STD_PROGRAM='Intergrated Data Repository';

## Verify
select STD_PROGRAM,COUNT(*) from lookup.roster
WHERE Rept_Program IS NULL
GROUP BY  STD_PROGRAM; 

SELECT DISTINCT Rept_Program  from lookup.roster;

#############
##### SET UserClass

UPDATE lookup.roster SET UserClass='UF Faculty' WHERE Faculty='Faculty' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='UF Research Professtionals' WHERE Factype='Non-Faculty' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='UF Grad Student / Trainee' WHERE Factype='Trainee' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='FSU Faculty' WHERE Faculty='Faculty' and Affiliation IN ('Florida State University','FSU');
UPDATE lookup.roster SET UserClass='External Collaborators' WHERE Affiliation NOT IN ('Florida State University','FSU','UF');
UPDATE lookup.roster SET UserClass='FSU Research Professtionals' WHERE Factype='Non-Faculty' AND Affiliation IN ('Florida State University','FSU');

select distinct UserClass from lookup.roster;

####################################################################################################################
####################################################################################################################
####################################################################################################################
####################################################################################################################

#  PROGRAM UTILIZATION LIST

DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2012
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program,UserClass;

select max(length(UserClass)) from work.userprogram;


DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Distinct Rept_Program as Rept_Program
FROM work.userprogram;

DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE Year>=2012
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program;

ALTER TABLE work.ProgUsersOut
ADD UF_Faculty int(10),
ADD UF_Trainees int(10),
ADD UF_OtherReschPro int(10),
ADD Undup int(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.ProgUsersOut
SET UF_Faculty=0,
	UF_Trainees=0,
	UF_OtherReschPro=0,
    Undup=0;
	

UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Faculty=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Trainees=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_OtherReschPro=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals';

UPDATE work.ProgUsersOut po, work.ProgUsersUndup lu SET po.UNDUP=lu.nUNDUP where po.Rept_Program=lu.Rept_Program ;

drop table if Exists work.proguserout;
create table work.proguserout as 
SELECT * from work.ProgUsersOut ORDER BY Undup DESC;


#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################

#######################################################################################