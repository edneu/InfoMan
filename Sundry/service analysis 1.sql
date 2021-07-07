
/*
-	Service user UFID / [assign dummy ID if not available]
-	Last/First Name
-	Institutional Affiliation (UF / external)
-	UF college 
-	UF department
-	Position at the time of service (Faculty status / external position) [exclude graduate students
-	Race/ethnicity
-	Gender
-	Service used
-	Service use year


Evaluation Outputs
-	Data tables by year, ready for analysis with missing data added where feasible
-	Combined frequency counts for all services by year (column) and college/department (row)
-	Combined frequency counts and percentages for all services by year (column) and faculty position / external user.
-	Chi-square tests by service and race/gender/position to identify if differences in the proportion of served users exist
-	Frequency table for year 2009 and year 2019 by service and department, race, gender, and position
-	Top 10 frequent users
-	Narrative summary report explaining tables and user profiles/personas (Gonzales et al, 2020)
*/

DROP TABLE IF EXISTS work.SvcSumm ;
create table work.SvcSumm As
SELECT 	Year,
		Person_key,
		STD_PROGRAM as Service,
        MAX(Lastname) AS LastName,
        MAX(Firstname) as FirstName,
        Max(UFID) AS UFID,
        Max(College) as College,
        Max(Department) as Department,
        MAx(Title) as WorkTitle,
        MAX(Gender) As Gender,
        Max(FacType) as FacultyType,
        MAX(Affiliation) as Affiliation
From lookup.roster
GROUP BY 	Year,
			Person_key,
			STD_PROGRAM; 
            
            
select * from  work.SvcSumm where Service="";           
desc lookup.roster;
 
 
 select Affiliation,COUNT(*) as N from lookup.roster group by Affiliation;
 
 UPDATE lookup.roster set Affiliation="Non-UF" WHERE Affiliation in ('Not UF','N/A','Non_UF');
  UPDATE lookup.roster set Affiliation="Non-UF" WHERE Affiliation IS NULL;
select * from lookup.roster WHERE Affiliation is NULL;



ALter table lookup.roster add Gender varchar(1);
ALter table lookup.roster add DOB datetime;

SET SQL_SAFE_UPDATES = 0;
UPDATE lookup.roster rs, lookup.ufids lu
SET rs.Gender=lu.UF_GENDER_CD,  
	rs.DOB=lu.UF_BIRTH_DT
WHERE rs.UFID=lu.UF_UFID;      
	   
UPDATE lookup.roster SET STD_PROGRAM='Communications' WHERE STD_PROGRAM="COMR";
       
       select distinct Faculty from lookup.roster;
       
SELECT DISTINCT   STD_PROGRAM from lookup.roster;    

UPDATE lookup.roster SET STD_PROGRAM='Study Registry' WHERE STD_PROGRAM='StudyConnect'
AND Year>=2016;
       
       