SET SQL_SAFE_UPDATES = 0;

create table work.roster as Select * from lookup.roster;

select Distinct STD_program from work.roster WHERE Rept_Program2='';


UPDATE work.roster SET Rept_Program2='' ;
UPDATE work.roster SET Rept_Program2='Office of Clinical Research' WHERE STD_PROGRAM='Office of Clinical Research';
UPDATE work.roster SET Rept_Program2='Office of Clinical Research' WHERE STD_PROGRAM='Research Administration';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Biobehavioral';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Simulation Center';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Biorepository';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Cellular Reprogramming';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Cellular Reprograming';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Genotyping';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Human Imaging';
UPDATE work.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Translational Drug Development';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='CCTR';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Cardiovascular CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='GI Liver CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Sleep CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Aging CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Cancer CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Dental CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Diabetes Center';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Jacksonville  CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Jacksonville  CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Neuromedicine CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Pain CRU';
UPDATE work.roster SET Rept_Program2='CRUs' WHERE STD_PROGRAM='Tuberculosis PH CRU';
UPDATE work.roster SET Rept_Program2='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.roster SET Rept_Program2='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Jacksonville';
UPDATE work.roster SET Rept_Program2= 'Translational Workforce Development' WHERE STD_PROGRAM='BioInformatics';
UPDATE work.roster SET Rept_Program2='CTS IT' WHERE STD_PROGRAM='CTS IT';
UPDATE work.roster SET Rept_Program2='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE work.roster SET Rept_Program2='Integrated Data Repository' WHERE STD_PROGRAM='Intergrated Data Repository';
UPDATE work.roster SET Rept_Program2='REDCap' WHERE STD_PROGRAM='REDCap';
UPDATE work.roster SET Rept_Program2='Multisite' WHERE STD_PROGRAM='Multisite-TIN';
UPDATE work.roster SET Rept_Program2='Multisite' WHERE STD_PROGRAM='One Florida';
UPDATE work.roster SET Rept_Program2='Multisite' WHERE STD_PROGRAM='Learning Health System';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='CTRB_Investigators';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='CTSI Administration';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='ClinicalTrials.GOV';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Evaluation';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='PubMed Compliance';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Study Registry';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='StudyConnect';
UPDATE work.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Ethics Consultation';
UPDATE work.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Quality Assurance';
UPDATE work.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='RAC';
UPDATE work.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Research Subject Advocate';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Academcy for Research Excellence';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Professionals Advisory Council';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='K College';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='KL TL';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='MS CTS';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Mentor';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Mentor Academy';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Research Coordinator Consortium';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='TPDP';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='TRACTS';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Educational Scholarship Program';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Prof Advisory Council';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Network Science Program';
UPDATE work.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Translational Workforce Development';
UPDATE work.roster SET Rept_Program2='Metabolomics' WHERE STD_PROGRAM='Metabolomics';
UPDATE work.roster SET Rept_Program2='Florida State University' WHERE STD_PROGRAM='Florida State University';
UPDATE work.roster SET Rept_Program2='Florida State University' WHERE STD_PROGRAM='FSU';
UPDATE work.roster SET Rept_Program2='Network Science' WHERE STD_PROGRAM='Network Science';
UPDATE work.roster SET Rept_Program2='BERD' WHERE STD_PROGRAM='BERD';
UPDATE work.roster SET Rept_Program2='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center';
UPDATE work.roster SET Rept_Program2='Communications' WHERE STD_PROGRAM='Communications';
UPDATE work.roster SET Rept_Program2='Communications' WHERE STD_PROGRAM='COMR';
UPDATE work.roster SET Rept_Program2='Community Engagement - Jacksonville' WHERE STD_PROGRAM='Community Engagement - Jacksonville';
UPDATE work.roster SET Rept_Program2='UF Health Jacksonville' WHERE STD_PROGRAM='Jacksonville Research?';
UPDATE work.roster SET Rept_Program2='UF Health Jacksonville' WHERE STD_PROGRAM='UF Health Jacksonville';
UPDATE work.roster SET Rept_Program2='Implementation Science' WHERE STD_PROGRAM='Implementation Science';
UPDATE work.roster SET Rept_Program2='Personalized Medicine' WHERE STD_PROGRAM='Personalized Medicine';
UPDATE work.roster SET Rept_Program2='Pilot Awards' WHERE STD_PROGRAM='Pilot Awards';
UPDATE work.roster SET Rept_Program2='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center';
UPDATE work.roster SET Rept_Program2='Service Center' WHERE STD_PROGRAM='Service Center';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='UNDEFINED';
UPDATE work.roster SET Rept_Program2='OMIT' WHERE Rept_Program2='CRUs';

######################
### PROGRAM SUMMARY TABLE CONSOLIDATED SERVICES
Select Distinct Rept_program
From work.roster
Where Year>=2009
;

Select Distinct Rept_program2
From work.roster
Where Year>=2009
AND Rept_Program2<>"OMIT"
ORDER BY  Rept_program2;

############################################################
######### PROGRAM USE REPORT FOR CHART ALL YEARS 209-2017


drop table if exists results.ProgUseRept;
create table results.ProgUseRept As
SELECT DISTINCT Rept_program2 from work.roster
WHERE Rept_program2<>"OMIT";

Alter table results.ProgUseRept
ADD UF_Faculty int(8),
ADD UF_Trainee int(8),
Add OtherUsers int(8),
ADD TotalUndup int(8);

DROP TABLE IF EXISTS work.uffac;
Create table work.uffac as 
SELECT "UF_Faculty" AS Usertype,
       Rept_program2, 
       COUNT(DISTINCT PERSON_KEY) AS Undup
from work.roster
WHERE FacType IN ('Associate Professor','Professor','Assistant Professor','Other Faculty')
AND  Rept_program2 <> "OMIT"
GROUP BY "UF_Faculty",Rept_program2 ;

DROP TABLE IF EXISTS work.uftrain;
Create table work.uftrain as 
SELECT "UF_Trainee" AS Usertype,
       Rept_program2, 
       COUNT(DISTINCT PERSON_KEY) AS Undup
from work.roster
WHERE FacType IN ('Trainee')
AND  Rept_program2 <> "OMIT"
GROUP BY "UF_Trainee",Rept_program2 ;

DROP TABLE IF EXISTS work.ufother;
Create table work.ufother as 
SELECT "OtherUsers" AS Usertype,
       Rept_program2, 
       COUNT(DISTINCT PERSON_KEY) AS Undup
from work.roster
WHERE  Rept_program2 <> "OMIT"
GROUP BY "OtherUsers",Rept_program2 ;

DROP TABLE IF EXISTS work.ufother;
Create table work.ufother as 
SELECT "OtherUsers" AS Usertype,
       Rept_program2, 
       COUNT(DISTINCT PERSON_KEY) AS Undup
from work.roster
WHERE FacType IN ('Non-Faculty')
AND  Rept_program2 <> "OMIT"
GROUP BY "OtherUsers",Rept_program2 ;

DROP TABLE IF EXISTS work.uftotal;
Create table work.uftotal as 
SELECT "TotalUsers" AS Usertype,
       Rept_program2, 
       COUNT(DISTINCT PERSON_KEY) AS Undup
from work.roster
WHERE  Rept_program2 <> "OMIT"
GROUP BY "TotalUsers",Rept_program2 ;

UPDATE results.ProgUseRept
SET UF_Faculty=0, 
	UF_Trainee=0,
	OtherUsers=0,
	TotalUndup=0;

drop table if exists lookup.roster;
create table lookup.roster as select * from work.roster;


UPDATE results.ProgUseRept ur, work.uffac lu
SET ur.UF_Faculty=lu.UNDUP
WHERE ur.Rept_program2=lu.Rept_program2;

UPDATE results.ProgUseRept ur, work.uftrain lu
SET ur.UF_Trainee=lu.UNDUP
WHERE ur.Rept_program2=lu.Rept_program2;

UPDATE results.ProgUseRept ur, work.ufother lu
SET ur.OtherUsers=lu.UNDUP
WHERE ur.Rept_program2=lu.Rept_program2;

UPDATE results.ProgUseRept ur, work.uftotal lu
SET ur.TotalUndup=lu.UNDUP
WHERE ur.Rept_program2=lu.Rept_program2;

select * from results.ProgUseRept order by TotalUndup desc;


#####################
Delete from 
work.roster
WHERE STD_PROGRAM="Simulation Center"
  AND FacType <>"Trainee"
  AND Faculty<>"Faculty";
;


SELECT YEAR,Faculty,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 AND Faculty="Faculty"
group by YEAR,Faculty;

SELECT YEAR,Faculty,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 AND Faculty="Faculty"
group by YEAR,Faculty;

SELECT YEAR,FacType,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 AND FacType="Trainee"
group by YEAR,FacType;

SELECT YEAR,FacType,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 AND FacType="Non-Faculty"
group by YEAR,FacType;

SELECT YEAR,FacType,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2016 AND FacType="Non-Faculty"
AND STD_PROGRAM<>"Simulation Center"
group by YEAR,FacType;

SELECT YEAR,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 Group BY YEar;


select distinct FacType from work.roster;

SELECT YEAR,FacultyType,Count(Distinct Person_Key) from work.roster 
WHERE YEAR>=2012 
group by YEAR,FacultyType;