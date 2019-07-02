/*

SELECT Affiliation,COUNT(*) from lookup.roster where STD_PROGRAM="BERD" GROUP BY Affiliation;

select YEAR,email,Department,DepartmentID,Title from lookup.roster where STD_PROGRAM="BERD" AND  Affiliation='';

update lookup.roster SET Affiliation='Non-UF' WHERE STD_PROGRAM="BERD" AND  Affiliation='' and Department<>"";





UPDATE lookup.roster
SET FacultyType='N/A',
	Faculty='Non-Faculty',
	FacType='N/A'
    WHERE Affiliation='Non-UF';


UPDATE lookup.roster SET FacultyType='Junior'  WHERE Faculty='Faculty'  AND FacType='Other Faculty';

UPDATE lookup.roster SET FacultyType='Junior'  WHERE FacultyType ='Senior'  AND FacType='Assistant Professor'  ;

SELECT FacultyType,Faculty,FacType,count(*) from lookup.roster GROUP BY FacultyType,Faculty,FacType;

select distinct factype from lookup.roster;



SELECT FacultyType,Faculty,FacType,count(distinct Person_key) from lookup.roster  where STD_PROGRAM="BERD" AND Affiliation<>"UF" group by FacultyType,Faculty,FacType;

SELECT FacultyType,Faculty,FacType,count(distinct Person_key) from lookup.roster  where STD_PROGRAM="BERD" AND Affiliation="UF" group by FacultyType,Faculty,FacType;


select * from  lookup.roster where STD_PROGRAM="BERD" AND Affiliation="UF" AND FacType="";



sELECT Year,ctsi_year,CTSA_Award,UserClass from lookup.roster group by Year,ctsi_year,CTSA_Award,UserClass;

sELECT Year,ctsi_year,CTSA_Award,UserClass from lookup.roster group by Year,ctsi_year,CTSA_Award,UserClass;

UPDATE lookup.roster SET ctsi_year='2015-2018' , CTSA_Award="Third CTSA" WHERE Year In ('2015','2016','2017','2018');

UPDATE lookup.roster SET ctsi_year='2012-2014' , CTSA_Award="Second CTSA" WHERE Year In ('2012','2013','2014');

UPDATE lookup.roster SET ctsi_year='2009-2011' , CTSA_Award="First CTSA" WHERE Year In ('2008','2009','2010','2011');

SELECT FacultyType,Faculty,FacType,UserClass from lookup.roster where UserClass="";


UPDATE lookup.roster SET FacType='Non-Faculty' WHERE FacType="N/A";



sELECT distinct Affiliation,UserClass,count(*)  from lookup.roster where UserClass="" group by Affiliation,UserClass  ;

UPDATE lookup.roster set UserClass='External Collaborators' WHERE
Affiliation NOT IN ('Florida Proton','Florida State University','FSU','FSU College of MedicineHOBI collab.','UF')
AND UserClass IS NULL ;


UPDATE lookup.roster set UserClass='FSU Faculty' WHERE
Affiliation IN ('Florida State University','FSU','FSU College of MedicineHOBI collab.')
AND UserClass IS NULL ;




sELECT FacultyType,Faculty,FacType,Affiliation,UserClass,count(*)  from lookup.roster Where (UserClass="" or UserClass is Null) group by FacultyType,Faculty,FacType,Affiliation,UserClass  ;


UPDATE lookup.roster set UserClass='UF Faculty'  WHERE Affiliation="UF" AND Faculty="Faculty" and (UserClass="" or UserClass is Null);

UPDATE lookup.roster set UserClass='UF Grad Student / Trainee'  WHERE Affiliation="UF" AND FacType='Trainee' and (UserClass="" or UserClass is Null);

UPDATE lookup.roster set UserClass='UF Research Professionals'  WHERE Affiliation="UF" AND FacType='Non-Faculty' and (UserClass="" or UserClass is Null);

UPDATE lookup.roster set UserClass='UF Research Professionals'  WHERE Affiliation='Florida Proton' AND FacType='Non-Faculty' and (UserClass="" or UserClass is Null);

UPDATE lookup.roster set UserClass='UF Grad Student / Trainee'  WHERE Affiliation IS NULL AND FacType='Trainee' and (UserClass="" or UserClass is Null);

UPDATE lookup.roster set UserClass='External Collaborators' WHERE  (UserClass="" or UserClass is Null);

select Affiliation,count(*) from lookup.roster group by Affiliation;
Update lookup.roster set Affiliation="" where Affiliation is null;

Update lookup.roster set email="" where email='1';


select rosterid,Year,email,DepartmentID,Department,Title,LastName,FirstName from lookup.roster
Where Affiliation="";


select Year,count(*) from lookup.roster
Where Affiliation="" group by Year;

UPDATE lookup.roster SET Affiliation="Non-UF" WHERE email<>"" AND Affiliation="" ;

*/
## BERD
DROP TABLE IF EXISTS work.berdrost; 
Create TABLE work.berdrost AS
SELECT * from lookup.roster WHERE STD_PROGRAM='BERD';


ALTER TABLE work.berdrost
ADD ctsi12 int(1);


UPDATE work.berdrost SET 
                     

UPDATE work.berdrost SET ctsi12=1 WHERE Year <=2014;
UPDATE work.berdrost SET ctsi12=2 WHERE Year >2014;





DROP TABLE IF EXISTS work.berdrost2; 		
Create TABLE work.berdrost2 AS		
SELECT ctsi12,FacType,Person_key,Count(distinct Year) as nYEARS		
FROM work.berdrost		
GROUP BY ctsi12,FacType,Person_key;		
		
UPDATE work.berdrost2 SET nYEARS=0 WHERE nYEARS=1;		
UPDATE work.berdrost2 SET nYEARS=1 WHERE nYEARS>1;		
		
SELECT  ctsi12,		
		FacType,
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.berdrost2		
GROUP BY ctsi12,		
		FacType;
		
		
        		
        SELECT  ctsi12,		
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.berdrost2		
GROUP BY ctsi12;		


#############

## CTSI
DROP TABLE IF EXISTS work.ctsirost; 
Create TABLE work.ctsirost AS
SELECT * from lookup.roster WHERE STD_PROGRAM NOT IN ('Simulation Center')
AND FacType<>"";




ALTER TABLE work.ctsirost
ADD ctsi12 int(1);



                     

UPDATE work.ctsirost SET ctsi12=1 WHERE Year <=2014;
UPDATE work.ctsirost SET ctsi12=2 WHERE Year >2014;





DROP TABLE IF EXISTS work.ctsirost2; 		
Create TABLE work.ctsirost2 AS		
SELECT ctsi12,FacType,Person_key,Count(distinct Year) as nYEARS		
FROM work.ctsirost	
GROUP BY ctsi12,FacType,Person_key;		
	
	

UPDATE work.ctsirost2 SET nYEARS=0 WHERE nYEARS=1;		
UPDATE work.ctsirost2 SET nYEARS=1 WHERE nYEARS>1;		
		
SELECT  ctsi12,		
		FacType,
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.ctsirost2		
GROUP BY ctsi12,		
		FacType;
		
		
        		
        SELECT  ctsi12,		
		COUNT(Distinct Person_key) AS Undup,
		SUM(nYEARS) as MultiYear
 FROM work.ctsirost2		
GROUP BY ctsi12;		


SELECT FacType,count(*) from lookup.roster group by Factype;

Select rosterid,Year,Title,LastName,FirstName,STD_PROGRAM,FacultyType,Faculty,FacType from lookup.roster where FacType="";

select Count(distinct Person_Key) from lookup.roster  WHERE STD_PROGRAM NOT IN ('Simulation Center')
AND FacType<>"" AND Year>2014;



select ORIG_PROGRAM,count(Distinct Person_key) from lookup.roster where STD_PROGRAM="Regulatory Assistance" group by ORIG_PROGRAM;

select STD_PROGRAM,COUNT(DISTINCT PERSON_KEY) from lookup.roster group by STD_PROGRAM;