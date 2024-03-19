

select distinct STD_PROGRAM from lookup.roster 
WHERE Year IN (2022,2023);


#####create table loaddata.roosterBU20230828 as select * from lookup.roster;


DROP TABLE IF EXISTS work.usersLU;
create table work.usersLU as 
SELECT UFID,
	   STD_PROGRAM,
       Count(*) as nRECs
FROM lookup.roster
WHERE UFID IS NOT NULL
AND Year in (2022,2023)
GROUP BY UFID,
	   STD_PROGRAM;




DROP TABLE IF EXISTS work.userslist;
create table work.userslist AS
SELECT UFID,
       max(LastName) as LastName,
       max(FirstName) as FirstName,
       max(email) as email,
       max(facType) as FacType
FROM lookup.roster
WHERE UFID IS NOT NULL
AND Year in (2022,2023)
GROUP BY UFID; 


ALTER TABLE work.userslist
  ADD BERD int(5),
 ADD Biorepository int(5),
 ADD Cellular_Reprograming int(5),
 ADD Clinical_Research_Center int(5),
 ADD ClinicalTrialsGOV int(5),
 ADD HealthStreetGainesville int(5),
 ADD Human_Imaging int(5),
 ADD Implementation_Science int(5),
 ADD Integrated_Data_Repository int(5),
 ADD KL_TL int(5),
 ADD Mentor_Academy int(5),
 ADD Metabolomics int(5),
 ADD OneFlorida int(5),
 ADD Personalized_Medicine int(5),
 ADD Pilot_Awards int(5),
 ADD PubMed_Compliance int(5),
 ADD Quality_Assurance int(5),
 ADD Recruitment_Center int(5),
 ADD REDCap int(5),
 ADD Regulatory_Assistance int(5),
 ADD Research_Subject_Advocate int(5),
 ADD TRACTS int(5),
 ADD Translational_Drug_Development int(5),
 ADD Vouchers int(5);

UPDATE work.userslist
SET BERD=0,
   Biorepository=0,
   Cellular_Reprograming=0,
   Clinical_Research_Center=0,
   ClinicalTrialsGOV=0,
   HealthStreetGainesville=0,
   Human_Imaging=0,
   Implementation_Science=0,
   Integrated_Data_Repository=0,
   KL_TL=0,
   Mentor_Academy=0,
   Metabolomics=0,
   OneFlorida=0,
   Personalized_Medicine=0,
   Pilot_Awards=0,
   PubMed_Compliance=0,
   Quality_Assurance=0,
   Recruitment_Center=0,
   REDCap=0,
   Regulatory_Assistance=0,
   Research_Subject_Advocate=0,
   TRACTS=0,
   Translational_Drug_Development=0,
   Vouchers=0;





UPDATE work.userslist ul, work.usersLU lu SET ul.BERD=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='BERD';
UPDATE work.userslist ul, work.usersLU lu SET ul.Biorepository=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Biorepository';
UPDATE work.userslist ul, work.usersLU lu SET ul.Cellular_Reprograming=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Cellular Reprograming';
UPDATE work.userslist ul, work.usersLU lu SET ul.Clinical_Research_Center=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Clinical Research Center';
UPDATE work.userslist ul, work.usersLU lu SET ul.ClinicalTrialsGOV=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='ClinicalTrials.GOV';
UPDATE work.userslist ul, work.usersLU lu SET ul.HealthStreetGainesville=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.userslist ul, work.usersLU lu SET ul.Human_Imaging=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Human Imaging';
UPDATE work.userslist ul, work.usersLU lu SET ul.Implementation_Science=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Implementation Science';
UPDATE work.userslist ul, work.usersLU lu SET ul.Integrated_Data_Repository=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Integrated Data Repository';
UPDATE work.userslist ul, work.usersLU lu SET ul.KL_TL=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='KL TL';
UPDATE work.userslist ul, work.usersLU lu SET ul.Mentor_Academy=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Mentor Academy';
UPDATE work.userslist ul, work.usersLU lu SET ul.Metabolomics=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Metabolomics';
UPDATE work.userslist ul, work.usersLU lu SET ul.OneFlorida=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='OneFlorida+';
UPDATE work.userslist ul, work.usersLU lu SET ul.Personalized_Medicine=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Personalized Medicine';
UPDATE work.userslist ul, work.usersLU lu SET ul.Pilot_Awards=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Pilot Awards';
UPDATE work.userslist ul, work.usersLU lu SET ul.PubMed_Compliance=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='PubMed Compliance';
UPDATE work.userslist ul, work.usersLU lu SET ul.Quality_Assurance=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Quality Assurance';
UPDATE work.userslist ul, work.usersLU lu SET ul.Recruitment_Center=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Recruitment Center';
UPDATE work.userslist ul, work.usersLU lu SET ul.REDCap=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='REDCap';
UPDATE work.userslist ul, work.usersLU lu SET ul.Regulatory_Assistance=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Regulatory Assistance';
UPDATE work.userslist ul, work.usersLU lu SET ul.Research_Subject_Advocate=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Research Subject Advocate';
UPDATE work.userslist ul, work.usersLU lu SET ul.TRACTS=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='TRACTS';
UPDATE work.userslist ul, work.usersLU lu SET ul.Translational_Drug_Development=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Translational Drug Development';
UPDATE work.userslist ul, work.usersLU lu SET ul.Vouchers=lu.nRECS WHERE ul.UFID=lu.UFID and lu.STD_PROGRAM='Vouchers';


select * from work.userslist;
