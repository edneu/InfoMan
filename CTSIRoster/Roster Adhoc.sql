  select distinct STD_PROGRAM FROM lookup.roster WHERE Year in (2018,2019) ORDER BY STD_PROGRAM;

  select distinct ORIG_PROGRAM,STD_PROGRAM FROM lookup.roster WHERE Year in (2018,2019) ORDER BY STD_PROGRAM ;
  
  select distinct STD_PROGRAM FROM lookup.roster;
  
  select year, count(*) AS Nrec, count(distinct Person_KEY) as Undup from lookup.roster where STD_PROGRAM='One Florida' group by Year;
  
    select DISTINCT ORIG_PROGRAM,STD_PROGRAM from lookup.roster where STD_PROGRAM='One Florida';
    
    
      select ORIG_PROGRAM,STD_PROGRAM,Count(*), count(distinct Person_KEY) 
      FROM lookup.roster 
      WHERE Year in (2018,2019) 
      AND STD_PROGRAM="Implementation Science"
      GROUP BY ORIG_PROGRAM,STD_PROGRAM ORDER BY STD_PROGRAM, STD_PROGRAM;
      
UPDATE lookup.roster SET STD_PROGRAM='One Florida'
WHERE STD_PROGRAM="Implementation Science"
AND YEAR IN (2018,2019);


SELECT * FROM lookup.standard_programs
WHERE STD_PROGRAM IN ("Implementation Science",'One Florida');


    select DISTINCT ORIG_PROGRAM,STD_PROGRAM from lookup.roster where STD_PROGRAM='Ethics Consultation';
      select Year,ORIG_PROGRAM,STD_PROGRAM,Count(*), count(distinct Person_KEY) 
      FROM lookup.roster 
      WHERE Year in (2018,2019) 
      AND ORIG_PROGRAM="Data Coordinating Center"
      GROUP BY Year,ORIG_PROGRAM,STD_PROGRAM ORDER BY STD_PROGRAM, STD_PROGRAM;
      
      
UPDATE lookup.roster  SET STD_PROGRAM='Ethics Consultation' WHERE ORIG_PROGRAM='Research Participant Advocate, Ethics Consultation';
      
UPDATE lookup.roster  SET STD_PROGRAM='Recruitment Center' WHERE ORIG_PROGRAM='StudyConnect' AND Year in (2018,2019);    

  
      select * from lookup.roster where ORIG_PROGRAM='StudyConnect' AND Year in (2018,2019) ;
      
      
          select DISTINCT ORIG_PROGRAM,STD_PROGRAM from lookup.roster where STD_PROGRAM='Regulatory Assistance' AND Year in (2018,2019);
;
UPDATE 


;

#################################################
## MAP REPORTING CATEGORIES

DROP TABLE IF EXISTS work.roster201819;
Create table work.roster201819 AS
SELECT * from lookup.roster 
WHERE Year in (2018,2019) ;

Alter table work.roster201819 ADD ReportProg varchar(45);
Alter table work.roster201819 ADD ReportSEQ int(5);

UPDATE work.roster201819 SET ReportProg='';
UPDATE work.roster201819 SET ReportSEQ=0;

### ASSIGN Reporting Program Categories
UPDATE work.roster201819 SET ReportProg='BERD' WHERE STD_PROGRAM='BERD';
UPDATE work.roster201819 SET ReportProg='BioMedical Informatics' WHERE STD_PROGRAM='BioInformatics';
UPDATE work.roster201819 SET ReportProg='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center';
UPDATE work.roster201819 SET ReportProg='Research Coordinators?' WHERE STD_PROGRAM='Clinical Research Prof Advisory Council';
UPDATE work.roster201819 SET ReportProg='Translational Communicatio' WHERE STD_PROGRAM='Communications';
UPDATE work.roster201819 SET ReportProg='CTS-IT' WHERE STD_PROGRAM='CTS IT';
UPDATE work.roster201819 SET ReportProg='Ethics Consultation' WHERE STD_PROGRAM='Ethics Consultation';
UPDATE work.roster201819 SET ReportProg='HealthStreet' WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.roster201819 SET ReportProg='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE work.roster201819 SET ReportProg='Learning Health System' WHERE STD_PROGRAM='Learning Health System';
UPDATE work.roster201819 SET ReportProg='Mentor Academy' WHERE STD_PROGRAM='Mentor Academy';
UPDATE work.roster201819 SET ReportProg='SECIM' WHERE STD_PROGRAM='Metabolomics';
UPDATE work.roster201819 SET ReportProg='Network Science' WHERE STD_PROGRAM='Network Science Program';
UPDATE work.roster201819 SET ReportProg='OneFlorida' WHERE STD_PROGRAM='One Florida';
UPDATE work.roster201819 SET ReportProg='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center';
UPDATE work.roster201819 SET ReportProg='REDCap' WHERE STD_PROGRAM='REDCap';
UPDATE work.roster201819 SET ReportProg='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE work.roster201819 SET ReportProg='TRACTS' WHERE STD_PROGRAM='TRACTS';
UPDATE work.roster201819 SET ReportProg='Translational Drug Development Core' WHERE STD_PROGRAM='Translational Drug Development';
UPDATE work.roster201819 SET ReportProg='Translational Workforce Development' WHERE STD_PROGRAM='Translational Workforce Development';
UPDATE work.roster201819 SET ReportProg='Data Coordinating Center' WHERE ORIG_PROGRAM='Data Coordinating Center';
UPDATE work.roster201819 SET ReportProg='Quality Management' WHERE ORIG_PROGRAM='Quality Control';


## ASSIGN REPORTING SEQ
UPDATE work.roster201819 SET ReportSEQ=1 WHERE STD_PROGRAM='BERD';
UPDATE work.roster201819 SET ReportSEQ=3 WHERE STD_PROGRAM='BioInformatics';
UPDATE work.roster201819 SET ReportSEQ=15 WHERE STD_PROGRAM='Clinical Research Center';
UPDATE work.roster201819 SET ReportSEQ=23 WHERE STD_PROGRAM='Clinical Research Prof Advisory Council';
UPDATE work.roster201819 SET ReportSEQ=8 WHERE STD_PROGRAM='Communications';
UPDATE work.roster201819 SET ReportSEQ=4 WHERE STD_PROGRAM='CTS IT';
UPDATE work.roster201819 SET ReportSEQ=13 WHERE STD_PROGRAM='Ethics Consultation';
UPDATE work.roster201819 SET ReportSEQ=7 WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE work.roster201819 SET ReportSEQ=6 WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE work.roster201819 SET ReportSEQ=10 WHERE STD_PROGRAM='Learning Health System';
UPDATE work.roster201819 SET ReportSEQ=21 WHERE STD_PROGRAM='Mentor Academy';
UPDATE work.roster201819 SET ReportSEQ=18 WHERE STD_PROGRAM='Metabolomics';
UPDATE work.roster201819 SET ReportSEQ=9 WHERE STD_PROGRAM='Network Science Program';
UPDATE work.roster201819 SET ReportSEQ=16 WHERE STD_PROGRAM='One Florida';
UPDATE work.roster201819 SET ReportSEQ=17 WHERE STD_PROGRAM='Recruitment Center';
UPDATE work.roster201819 SET ReportSEQ=5 WHERE STD_PROGRAM='REDCap';
UPDATE work.roster201819 SET ReportSEQ=12 WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE work.roster201819 SET ReportSEQ=22 WHERE STD_PROGRAM='TRACTS';
UPDATE work.roster201819 SET ReportSEQ=19 WHERE STD_PROGRAM='Translational Drug Development';
UPDATE work.roster201819 SET ReportSEQ=20 WHERE STD_PROGRAM='Translational Workforce Development';
UPDATE work.roster201819 SET ReportSEQ=2 WHERE ORIG_PROGRAM='Data Coordinating Center';
UPDATE work.roster201819 SET ReportSEQ=14 WHERE ORIG_PROGRAM='Quality Control';


UPDATE work.roster201819 SET ReportSEQ=24, ReportProg='ClinicalTrials.gov'  WHERE  ORIG_PROGRAM='ClinicalTrials.gov';

## UNDUP BY REPORTING PROGRAM

SELECT ReportSEQ,ReportProg,Count(distinct Person_Key)
FROM work.roster201819
GROUP BY ReportSEQ,ReportProg
ORDER BY ReportSEQ;


SELECT ReportSEQ,ReportProg,Count(distinct Person_Key)
FROM work.roster201819
WHERE Faculty="Faculty"
GROUP BY ReportSEQ,ReportProg
ORDER BY ReportSEQ;

## TOTAL SERVED ALL SERVICES

SELECT Count(distinct Person_Key)
FROM work.roster201819;


SELECT Count(distinct Person_Key)
FROM work.roster201819
WHERE Faculty="Faculty"
;

## TOTAL SERVED REPORTED SERVICES ONLY

SELECT Count(distinct Person_Key)
FROM work.roster201819
WHERE ReportSEQ>0;


SELECT Count(distinct Person_Key)
FROM work.roster201819
WHERE Faculty="Faculty"
AND ReportSEQ>0;




### REGUALATORY ASSISTANCE DETAIL

SELECT ORIG_PROGRAM,STD_PROGRAM,Count(distinct Person_Key)
FROM work.roster201819
WHERE STD_PROGRAM='Regulatory Assistance'
GROUP BY ORIG_PROGRAM,STD_PROGRAM
ORDER BY ORIG_PROGRAM,STD_PROGRAM;


SELECT ORIG_PROGRAM,STD_PROGRAM,Count(distinct Person_Key)
FROM work.roster201819
WHERE Faculty="Faculty" AND STD_PROGRAM='Regulatory Assistance'
GROUP BY ORIG_PROGRAM,STD_PROGRAM
ORDER BY ORIG_PROGRAM,STD_PROGRAM;

######################


SELECT * from lookup.roster Where STD_PROGRAM LIKE "NET%";

select * from lookup.standard_programs where STD_PROGRAM LIKE "NET%";