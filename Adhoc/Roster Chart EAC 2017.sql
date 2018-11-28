
ALTER TABLE work.roster ADD Report_Program varchar(45);

UPDATE work.roster SET Report_Program='BERD' WHERE STD_PROGRAM='BERD';
UPDATE work.roster SET Report_Program='BioInformatics' WHERE STD_PROGRAM='BioInformatics';
UPDATE work.roster SET Report_Program='Biorepository' WHERE STD_PROGRAM='Biorepository';
UPDATE work.roster SET Report_Program='Cellular Reprogramming' WHERE STD_PROGRAM='Cellular Reprogramming';
UPDATE work.roster SET Report_Program='Clinical Research Center' WHERE STD_PROGRAM='CCTR';
UPDATE work.roster SET Report_Program='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center';
UPDATE work.roster SET Report_Program='Communications' WHERE STD_PROGRAM='Communications';
UPDATE work.roster SET Report_Program='Community Engagement' WHERE STD_PROGRAM='Community Engagement - Jacksonville';
UPDATE work.roster SET Report_Program='CTS-IT' WHERE STD_PROGRAM='CTS IT';
UPDATE work.roster SET Report_Program='HealthStreet' WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.roster SET Report_Program='HealthStreet' WHERE STD_PROGRAM='HealthStreet-Jacksonville';
UPDATE work.roster SET Report_Program='Human Imaging' WHERE STD_PROGRAM='Human Imaging';
UPDATE work.roster SET Report_Program='Implementation Science' WHERE STD_PROGRAM='Implementation Science';
UPDATE work.roster SET Report_Program='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE work.roster SET Report_Program='KL TL' WHERE STD_PROGRAM='KL TL';
UPDATE work.roster SET Report_Program='Mentor' WHERE STD_PROGRAM='Mentor';
UPDATE work.roster SET Report_Program='Metabolomics' WHERE STD_PROGRAM='Metabolomics';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Aging CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Biobehavioral';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Cancer CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Cardiovascular CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='CTRB_Investigators';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='CTSI Administration';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Dental CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Diabetes Center';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Evaluation';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='GI Liver CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Jacksonville  CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Neuromedicine CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Pain CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='PubMed Compliance';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Simulation Center';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Sleep CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Study Registry';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='Tuberculosis PH CRU';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='ClinicalTrials.GOV';
UPDATE work.roster SET Report_Program='OMIT' WHERE STD_PROGRAM='UNDEFINED';
UPDATE work.roster SET Report_Program='One Florida' WHERE STD_PROGRAM='One Florida';
UPDATE work.roster SET Report_Program='Personalized Medicine' WHERE STD_PROGRAM='Genotyping';
UPDATE work.roster SET Report_Program='Personalized Medicine' WHERE STD_PROGRAM='Personalized Medicine';
UPDATE work.roster SET Report_Program='Pilot Awards' WHERE STD_PROGRAM='Pilot Awards';
UPDATE work.roster SET Report_Program='Quality Assurance' WHERE STD_PROGRAM='Quality Assurance';
UPDATE work.roster SET Report_Program='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center';
UPDATE work.roster SET Report_Program='REDCap' WHERE STD_PROGRAM='REDCap';
UPDATE work.roster SET Report_Program='Regulatory Assistance' WHERE STD_PROGRAM='Ethics Consultation';
UPDATE work.roster SET Report_Program='Regulatory Assistance' WHERE STD_PROGRAM='RAC';
UPDATE work.roster SET Report_Program='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE work.roster SET Report_Program='Service Center' WHERE STD_PROGRAM='Service Center';
UPDATE work.roster SET Report_Program='StudyConnect' WHERE STD_PROGRAM='StudyConnect';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='Academcy for Research Excellence';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Prof Advisory Council';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Professionals Advisory Council';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='MS CTS';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='Research Coordinator Consortium';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='Research Subject Advocate';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='TPDP';
UPDATE work.roster SET Report_Program='Translational Workforce Development' WHERE STD_PROGRAM='TRACTS';

DROP TABLE IF exists work.facRoster1;
CREATE TABLE work.facRoster1 AS
SELECT Faculty,Report_Program,COUNT(DISTINCT Person_key) as Undup
from work.roster
WHERE Report_Program NOT IN ("OMIT")
group by  Faculty,Report_program;


drop table if exists results.facroster;
CREATE TABLE results.facroster AS
SELECT DISTINCT Report_Program from work.facRoster1;

ALTER TABLE results.facroster
ADD Faculty int(10),
ADD NonFaculty int(10);

UPDATE results.facroster
SET Faculty=0,
	NonFaculty=0;

UPDATE results.facroster fr, work.facRoster1 lu
SET fr.Faculty=lu.Undup
WHERE lu.Faculty='Faculty'
  AND fr.Report_Program=lu.Report_Program;


UPDATE results.facroster fr, work.facRoster1 lu
SET fr.NonFaculty=lu.Undup
WHERE lu.Faculty='Not Faculty'
  AND fr.Report_Program=lu.Report_Program;

select * from results.facroster;



select Year,count(Distinct Person_key) as Undup
from work.roster
where Faculty='Faculty'
Group by Year;

select * from work.roster where Year=2009 AND STD_PROGRAM="Clinical Research Center"
;

UPDATE work.roster
SET Title="Assistant Professor",
    Faculty="Faculty",
    FacType="Assistant Professor"
where rosterid in (47,48) ;


Select Orig_program,YEAR from work.roster where STD_PROGRAM="Regulatory Assistance" group by Orig_program,YEAR;

SELECT Faculty,count(Distinct Person_key) 
from work.roster 
where STD_PROGRAM="Biorepository" 
and Year in (2010,2011,2012,2013,2014,2015,2016,2017)
GROUP BY Faculty;
