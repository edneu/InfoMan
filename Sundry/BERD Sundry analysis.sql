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


SELECT Employee_ID,Name,Job_Code,Department
from lookup.Employees
WHERE 
(Name='Aggarwal%Mo%' OR 
Name='Ghosh%Su%' OR 
Name='Montuno%Mi%' OR 
Name='Youn%Te%' OR 
Name='Schoch%Je%' OR 
Name='Gupta%Sw%' OR 
Name='Yaghjyan%Lu%' OR 
Name='Jacobs%Ne%' OR 
Name='McGetrick%Mo%' OR 
Name='Horwitz%Na%' OR 
Name='Pertzborn%Ma%' OR 
Name='Reddy%Ra%' OR 
Name='Ferdous%Sh%' OR 
Name='Motaparthi%Ki%' OR 
Name='Beal%Ca%' OR 
Name='Davis%Jo%' OR 
Name='Batich%Ch%' OR 
Name='Munoz-Parjea%Je%' OR 
Name='Singh%Ve%' OR 
Name='DeBenedetto%An%' OR 
Name='Leey%Ju%' OR 
Name='DeGennaro%Vi%' OR 
Name='Okell%Al%' OR 
Name='Brantly%Ma%' OR 
Name='Angell%Am%' OR 
Name='Richards%Mi%' OR 
Name='Tadros%Ha%' OR 
Name='Cacho%Ni%' OR 
Name='Motoparthi%Ki%' 
 );

select distinct name from lookup.Employees;


SELECT Employee_ID,Name,Job_Code,Department
from lookup.Employees
WHERE 
(Name LIKE 'Aggarwal%Monica' OR 
Name LIKE 'Ghosh%Suman' OR 
Name LIKE 'Montuno%Michael' OR 
Name LIKE 'Youn%Teddy' OR 
Name LIKE 'Schoch%Jennifer' OR 
Name LIKE 'Gupta%Swati' OR 
Name LIKE 'Yaghjyan%Lusine' OR 
Name LIKE 'Jacobs%Nekaiya' OR 
Name LIKE 'McGetrick%Molly' OR 
Name LIKE 'Horwitz%Nathan' OR 
Name LIKE 'Pertzborn%Matthew' OR 
Name LIKE 'Reddy%Raju' OR 
Name LIKE 'Ferdous%Shazia' OR 
Name LIKE 'Motaparthi%Kiran' OR 
Name LIKE 'Beal%Casey' OR 
Name LIKE 'Davis%John' OR 
Name LIKE 'Batich%Christopher' OR 
Name LIKE 'Munoz-Parjea%Jennifer' OR 
Name LIKE 'Singh%Vedant' OR 
Name LIKE 'DeBenedetto%Ana' OR 
Name LIKE 'Leey%Julio' OR 
Name LIKE 'DeGennaro%Vincent' OR 
Name LIKE 'Okell%Allison' OR 
Name LIKE 'Brantly%Mark' OR 
Name LIKE 'Angell%Amber' OR 
Name LIKE 'Richards%Michele' OR 
Name LIKE 'Tadros%Hanna' OR 
Name LIKE 'Cacho%Nicole' OR 
Name LIKE 'Motoparthi%Kiran'  )
ORDER BY NAME;




SELECT Employee_ID,Name,Job_Code,Department
from lookup.Employees
WHERE 
(Name LIKE 'Beal%' OR
Name LIKE 'Brantly%' OR
Name LIKE 'Cacho%' OR
Name LIKE 'Davis%' OR
Name LIKE 'DeBenedetto%' OR
Name LIKE 'Horwitz%' OR
Name LIKE 'Leey%' OR
Name LIKE 'McGetrick%' OR
Name LIKE 'Montuno%' OR
Name LIKE 'Munoz-Parjea%' OR
Name LIKE 'Okell%' OR
Name LIKE 'Richards%' OR
Name LIKE 'Schoch%' OR
Name LIKE 'Singh%' OR
Name LIKE 'Tadros%' OR
Name LIKE 'Youn%' )

ORDER BY NAME;

select UF_FIRST_NM, UF_UFID,concat(UF_LAST_NM,",",UF_FIRST_NM) As NAME, UF_WORK_TITLE,UF_DEPT_NM
from lookup.ufids
WHERE UF_LAST_NM LIKE "%O%Kell%";




SELECT 

(UF_LAST_NM = 'Batich' AND UF_FIRST_NM LIKE  'Chri%') OR 
(UF_LAST_NM = 'Beal' AND UF_FIRST_NM LIKE  'Case%') OR 
(UF_LAST_NM = 'Brantly' AND UF_FIRST_NM LIKE  'Mark%') OR 
(UF_LAST_NM = 'Cacho' AND UF_FIRST_NM LIKE  'Nico%') OR 
(UF_LAST_NM = 'Davis' AND UF_FIRST_NM LIKE  'John%') OR 
(UF_LAST_NM = 'DeBenedetto' AND UF_FIRST_NM LIKE  'Ana%') OR 
(UF_LAST_NM = 'Horwitz' AND UF_FIRST_NM LIKE  'Nath%') OR 
(UF_LAST_NM = 'Leey' AND UF_FIRST_NM LIKE  'Juli%') OR 
(UF_LAST_NM = 'McGetrick' AND UF_FIRST_NM LIKE  'Moll%') OR 
(UF_LAST_NM = 'Montuno' AND UF_FIRST_NM LIKE  'Mich%') OR 
(UF_LAST_NM = 'Munoz-Parjea' AND UF_FIRST_NM LIKE  'Jenn%') OR 
(UF_LAST_NM = 'Okell' AND UF_FIRST_NM LIKE  'Alli%') OR 
(UF_LAST_NM = 'Richards' AND UF_FIRST_NM LIKE  'Mich%') OR 
(UF_LAST_NM = 'Schoch' AND UF_FIRST_NM LIKE  'Jenn%') OR 
(UF_LAST_NM = 'Singh' AND UF_FIRST_NM LIKE  'Veda%') OR 
(UF_LAST_NM = 'Tadros' AND UF_FIRST_NM LIKE  'Hann%') OR 
(UF_LAST_NM = 'Youn' AND UF_FIRST_NM LIKE  'Tedd%') OR 

;

SELECT Employee_ID,Name,Job_Code,Department
from lookup.Employees
WHERE Employee_ID IN ('15391680','14061388','13911974','81112363','97484680','99989609');



(Name LIKE 'Beal%' OR
Name LIKE 'Brantly%' OR
Name LIKE 'Cacho%' OR
Name LIKE 'Davis%' OR
Name LIKE 'DeBenedetto%' OR
Name LIKE 'Horwitz%' OR
Name LIKE 'Leey%' OR
Name LIKE 'McGetrick%' OR
Name LIKE 'Montuno%' OR
Name LIKE 'Munoz-Parjea%' OR
Name LIKE 'Okell%' OR
Name LIKE 'Richards%' OR
Name LIKE 'Schoch%' OR
Name LIKE 'Singh%' OR
Name LIKE 'Tadros%' OR
Name LIKE 'Youn%' )

select * from lookup.dept_coll where department like "VM%";


SELECT COUNT(DISTINCT Person_KEY) from lookup.roster
WHERE Faculty="Faculty" 
AND STD_PROGRAM="BERD" and Year='2018';

SELECT COUNT(DISTINCT Person_KEY) from lookup.roster
WHERE STD_PROGRAM="BERD" and Year='2018';

SELECT COUNT(DISTINCT Person_KEY) from lookup.roster
WHERE STD_PROGRAM="BERD" and Year in ('2017','2018');


SELECT COUNT(DISTINCT Person_KEY) from lookup.roster
WHERE STD_PROGRAM="BERD" and Year in ('2017','2018') AND Faculty="Faculty" ;


#################################################  7/9/2019
drop table if exists work.roster1;
create table work.roster1 as select * from lookup.roster;
select distinct CTSA_Award from work.roster1;


SET SQL_SAFE_UPDATES = 0;
Update work.roster1 set CTSA_Award="CTSI 1.0" WHERE Year in ("2008","2009","2010","2011","2012","2013","2014");




###############

#################################################  7/9/2019
drop table if exists work.roster1BERD;
create table work.roster1BERD as select * from lookup.roster;
#where STD_PROGRAM="BERD";


select distinct CTSA_Award from work.roster1
;


SET SQL_SAFE_UPDATES = 0;
Update work.roster1BERD set CTSA_Award="CTSI 1.0" WHERE Year in ("2008","2009","2010","2011","2012","2013","2014");

SET SQL_SAFE_UPDATES = 0;
Update work.roster1BERD set CTSA_Award="CTSI 2.0" WHERE Year in ("2015","2016","2017","2018","2019");

DROP TABLE IF EXISTS work.NumFacTypeBERD;
CREATE TABLE work.NumFacTypeBERD AS
SELECT CTSA_Award,Person_KEY,count(distinct FacType) as NumFacType
from work.roster1BERD 
group by CTSA_Award,Person_KEY
;

drop table if exists work.changefacBERD;
create table work.changefacBERD as
SeLect  Year,STD_PROGRAM,CTSA_Award,Person_KEY,Title,Affiliation,FacType 
from work.roster1BERD
WHERE Person_KEY in (SELECT DISTINCT Person_key from work.NumFacType WHERE NumFacType>1)
ORDER BY Person_Key,Year;

drop table if exists work.changefac2BERD;
create table work.changefac2BERD as
SELECT Person_KEY,FacType
FROM work.changefacBERD
GROUP BY Person_KEY,FacType;

drop table if exists work.changefac3BERD;
create table work.changefac3BERD as
SELECT Person_key, Group_Concat(FacType Separator ', ') AS Changes from work.changefac2BERD group by Person_key;

SELECT COUNT(DIStinct Person_key) from work.changefac3BERD;

Select distinct Changes,count(distinct Person_key) as Num from work.changefac3berd group by Changes order by Num desc;

##########################

SET SQL_SAFE_UPDATES = 0;
Update work.roster1 set CTSA_Award="CTSI 2.0" WHERE Year in ("2015","2016","2017","2018","2019");

DROP TABLE IF EXISTS work.NumFacType;
CREATE TABLE work.NumFacType AS
SELECT CTSA_Award,Person_KEY,count(distinct FacType) as NumFacType
from work.roster1 
group by CTSA_Award,Person_KEY
;

drop table if exists work.changefac;
create table work.changefac as
SeLect  Year,STD_PROGRAM,CTSA_Award,Person_KEY,Title,Affiliation,FacType 
from work.roster1
WHERE Person_KEY in (SELECT DISTINCT Person_key from work.NumFacType WHERE NumFacType>1)
ORDER BY Person_Key,Year;

drop table if exists work.changefac2;
create table work.changefac2 as
SELECT Person_KEY,FacType
FROM work.changefac
GROUP BY Person_KEY,FacType;

drop table if exists work.changefac3;
create table work.changefac3 as
SELECT Person_key, Group_Concat(FacType Separator ', ') AS Changes from work.changefac2 group by Person_key;

Select distinct Changes,count(distinct Person_key) as Num from work.changefac3 group by Changes order by Num desc;

################


select STD_PROGRAM,CTSA_Award,Count(Distinct Person_key) as nTrainees  from work.roster WHERE facType="Trainee" group by STD_PROGRAM,CTSA_Award;

select STD_PROGRAM,CTSA_Award,Count(Distinct Person_key) as nStaff  from work.roster WHERE facType='Non-Faculty' group by STD_PROGRAM,CTSA_Award;


Integrated Data Repository
Intergrated Data Repository
Intergrated Data Repository

UPDATE work.roster1 SET STD_PROGRAM='Integrated Data Repository' WHERE STD_PROGRAM='Intergrated Data Repository';


select Factype,count(distinct Person_key) from work.roster group by FacType;

select count(*) from work.roster1 where STD_PROGRAM='Integrated Data Repository';



