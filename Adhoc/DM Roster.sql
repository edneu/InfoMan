

DROP TABLE IF EXISTS work.rostertemp1;
CREATE TABLE work.rostertemp1 AS
SELECT * FROM lookup.roster
WHERE STD_PROGRAM in
	(	'BERD',
		'CTS IT',
        'REDCap',
        'Translational Drug Development',
        'Metabolomics',
        'Clinical Research Center',
        'Biorepository',
        'HealthStreet-Gainesville',
        'Recruitment Center',
        'Integrated Data Repository',
        'One Florida',
        'Quality Assurance',
        'Regulatory Assistance'
    )
    ;
    
    
ALTER TABLE work.rostertemp1 ADD ReptProg varchar(45);    

SET SQL_SAFE_UPDATES = 0;
    
UPDATE work.rostertemp1 SET ReptProg=STD_PROGRAM ;   

UPDATE work.rostertemp1 SET ReptProg='IND/IDE'
WHERE ORIG_PROGRAM IN 
(	'RKRS - Bajwa',
	'IDE, IND Submission Assistance',
    'DSMB')
    ;   
    
UPDATE work.rostertemp1 SET ReptProg='Quality Assurance'
WHERE ORIG_PROGRAM IN 
(	'Quality Assurance',
     'Internal Study Monitoring',
     'Quality Control')
    ;      
    
DELETE FROM work.rostertemp1
WHERE STD_PROGRAM='Regulatory Assistance'
AND ORIG_PROGRAM IN
	(	'Ethics Consulatation / Research Participant Advocate',
		'CT.GOV',
        'Research Participant Advocate'
    )
 ;   
    
    
select count(*), Count(Distinct Person_Key) from  work.rostertemp1  ; 

########    
/*
SELECT  Year,ReptProg,count(distinct Person_Key) from work.rostertemp1 group by Year,ReptProg;   
SELECT distinct ORIG_PROGRAM from work.rostertemp1 where STD_PROGRAM='Regulatory Assistance';   
*/    
DROP TABLE IF EXISTS work.rostrept;
Create table work.rostrept AS
SELECT 	ReptProg,
		FacType,
        Year,
        Count(Distinct Person_Key) AS UnDup
FROM work.rostertemp1 
GROUP BY ReptProg,FacType,Year
UNION ALL
SELECT 	ReptProg,
		"Undup Total" AS FacType ,
        Year,
        Count(Distinct Person_Key) AS UnDup
FROM work.rostertemp1 
GROUP BY ReptProg,"Undup Total",Year
UNION ALL 
SELECT 	ReptProg,
		FacType ,
        "All Years" as Year,
        Count(Distinct Person_Key) AS UnDup
FROM work.rostertemp1 
GROUP BY ReptProg,FacType,"All Years"
UNION ALL
SELECT 	ReptProg,
		"Undup Total" AS FacType,
        "All Years" as Year,
        Count(Distinct Person_Key) AS UnDup
FROM work.rostertemp1 
GROUP BY ReptProg,"Undup Total","All Years";



 
Alter TABLE work.rostrept
	ADD CY2009 int(6),
	ADD CY2010 int(6),
   	ADD CY2011 int(6),
   	ADD CY2012 int(6),
	ADD CY2013 int(6),
   	ADD CY2014 int(6),
   	ADD CY2015 int(6),
	ADD CY2016 int(6),
   	ADD CY2017 int(6),
   	ADD CY2018 int(6),
	ADD CY2019 int(6),
    ADD Undup_All_Years int(6)
;




UPDATE work.rostrept SET CY2009=UnDup WHERE Year='2009';
UPDATE work.rostrept SET CY2010=UnDup WHERE Year='2010';
UPDATE work.rostrept SET CY2011=UnDup WHERE Year='2011';
UPDATE work.rostrept SET CY2012=UnDup WHERE Year='2012';
UPDATE work.rostrept SET CY2013=UnDup WHERE Year='2013';
UPDATE work.rostrept SET CY2014=UnDup WHERE Year='2014';
UPDATE work.rostrept SET CY2015=UnDup WHERE Year='2015';
UPDATE work.rostrept SET CY2016=UnDup WHERE Year='2016';
UPDATE work.rostrept SET CY2017=UnDup WHERE Year='2017';
UPDATE work.rostrept SET CY2018=UnDup WHERE Year='2018';
UPDATE work.rostrept SET CY2019=UnDup WHERE Year='2019';
UPDATE work.rostrept SET Undup_All_Years=UnDup WHERE Year='All Years';




DROP TABLE IF EXISTS Adhoc.RosterRept;
CREATE TABLE Adhoc.RosterRept AS
SELECT ReptProg,
       FacType,
       SUM(CY2009) AS CY2009,
       SUM(CY2010) AS CY2010,       
       SUM(CY2011) AS CY2011,
       SUM(CY2012) AS CY2012,
       SUM(CY2013) AS CY2013,       
       SUM(CY2014) AS CY2014,   
       SUM(CY2015) AS CY2015,
       SUM(CY2016) AS CY2016,       
       SUM(CY2017) AS CY2017,
       SUM(CY2018) AS CY2018,
       SUM(CY2019) AS CY2019, 
       SUM(Undup_All_Years) AS Undup_All_Years
FROM work.rostrept
GROUP BY ReptProg, FacType
ORDER BY  ReptProg, FacType;    


Select ReptProg,
       FacType,
       Undup_All_Years
FROM Adhoc.RosterRept 
WHERE FacType<>'Undup Total';
      