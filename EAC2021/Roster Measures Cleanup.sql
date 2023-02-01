## backup lookup.roster Table
create table loaddata.rosterBU20210106 AS select * from lookup.roster;
##

##Verify and Update Roster Service reporting Programs

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
UPDATE lookup.roster SET Rept_Program='Cellular Reprogramming' WHERE STD_PROGRAM='Cellular Reprograming';
UPDATE lookup.roster SET Rept_Program='COVID-19 SRC' WHERE STD_PROGRAM='COVID-19 SRCWG';
UPDATE lookup.roster SET Rept_Program='Integrated Data Repository' WHERE STD_PROGRAM='Intergrated Data Repository';
UPDATE lookup.roster SET Rept_Program='Communications'  WHERE STD_PROGRAM='COMR';







Select Rept_Program,count(*) from lookup.roster group by Rept_Program;
SELECT  STD_PROGRAM,count(*) from lookup.roster where Rept_Program IS NULL group by STD_PROGRAM ;

select Distinct Rept_program from lookup.roster;
 

select count(*) from lookup.roster;

select count(*) from lookup.roster where Rept_Program is Null;

select Report_Program,STD_PROGRAM,count(*) from lookup.roster WHERE STD_PROGRAM='BERD' group by Report_Program,STD_PROGRAM; 



SELECT STD_PROGRAM,count(*) from lookup.roster WHERE  Rept_Program is Null
 group by STD_PROGRAM ;
 

#############################################################################################################################
### Verify and update Disp_college

SELECT Display_College,College,count(*) from lookup.roster group by Display_College,College;


SELECT Affiliation,Department from lookup.roster WHERE Display_College IS NULL group by Affiliation,Department;

SELECT distinct Department from lookup.roster WHERE Display_College IS NULL AND Affiliation="UF";

select * from lookup.roster WHERE Display_College IS NULL and year=2020;

select * from lookup.roster WHERE Display_College IS NULL;

select Display_College,Department  from lookup.roster where Display_College like "%PHHP%" group by Display_College,Department ;


Update lookup.roster SET Display_College='Dentistry' WHERE Department='DN-ORTHODONTICS GENERAL' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-Academic' WHERE Department='IT-ICT INFRA/COMM TECHNOLOGY' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='JX-COMMUNITY MEDICINE-JAX' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-CTSI-SERVICE CENTER' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-GRADUATE STUDENT PROGRAMS' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-INTERNAL MEDICINE-OTHER' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-NEUROLOGY-MOVEMENT DISORDER' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-PEDS-PULMONARY' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-PHD PROGRAM' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-SCHOOL OF PA STUDIES - GEN' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-SURGONC-PBS' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='MD-SURGERY-TCV-CARDIOVASC' AND Display_College IS Null;
Update lookup.roster SET Display_College='Medicine' WHERE Department='OneFlorida Clinical Research Consortium' AND Display_College IS Null;
Update lookup.roster SET Display_College='Office of Research' WHERE Department='OR-TECHNOLOGY LICENSING' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-Academic' WHERE Department='SA-DISABILITY RESOURCE CENTER' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-Academic' WHERE Department='SH-RESEARCH OFFICE' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-Academic' WHERE Department='ST010000' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-Academic' WHERE Faculty='Non-Faculty' AND Display_College IS Null;
Update lookup.roster SET Display_College='Non-UF' WHERE Affiliation NOT in ("UF","FSU");
Update lookup.roster SET Display_College='Florida State University' WHERE Affiliation in ("FSU");


Update lookup.roster SET Display_College='PHHP-COM Intergrated Programs' WHERE Department IN ('PHHP-COM BIOSTATISTICS','PHHP-COM EPIDEMIOLOGY');

Update lookup.roster SET Display_College='Florida State University' WHERE Affiliation in ("FSU");
Update lookup.roster SET Display_College='Medicine - Jacksonville' WHERE Department='JX-COMMUNITY MEDICINE-JAX';

#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
######################################################################################### 
##Grouped YEar
select distinct ctsi_year from lookup.roster;


UPDATE lookup.roster SET ctsi_year='2009-2011' Where Year in (2009,2010,2011);
UPDATE lookup.roster SET ctsi_year='2012-2014' Where Year in (2012,2013,2014);
UPDATE lookup.roster SET ctsi_year='2015-2017' Where Year in (2015,2016,2017);
UPDATE lookup.roster SET ctsi_year='2018-2020' Where Year in (2018,2019,2020);

UPDATE lookup.roster SET FacType="N/A" Where FacType IS Null;

Select Distinct FacType from lookup.roster;


Select 

createtable 
Select 	ctsi_year,
		FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Associate Professor','Professor','Assistant Professor')

#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
######################################################################################### 



