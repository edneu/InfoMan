
### PUBLICATIONS
SELECT count(*) from pubs.PUB_CORE where May18Grant=1 and NIHMS_Status<>'PMC Compliant';

select NIHMS_Status,count(*) from pubs.PUB_CORE where May18Grant=1 Group by NIHMS_Status;

###############################################################################
###ROSTER
DROP TABLE IF exists work.roster_analysis;
CREATE TABLE work.roster_analysis AS
select * from lookup.roster;

Alter table work.roster_analysis 	ADD ctsi_year varchar(24),
									ADD CTSA_Award varchar(24);

 Alter table work.roster_analysis    ADD UserClass varchar(45);
##  SET SQL_SAFE_UPDATES = 0;

UPDATE work.roster_analysis SET ctsi_year="2009-2011" WHERE Year in (2009,2010,2011);
UPDATE work.roster_analysis SET ctsi_year="2012-2014" WHERE Year in (2012,2013,2014);
UPDATE work.roster_analysis SET ctsi_year="2015-2018" WHERE Year in (2015,2016,2017,2018);


UPDATE work.roster_analysis SET CTSA_Award="First CTSA" WHERE Year in (2009,2010,2011,2012,2013,2014,2015);
UPDATE work.roster_analysis SET CTSA_Award="Second CTSA" WHERE Year in (2016,2017,2018);

UPDATE work.roster_analysis SET UserClass="UF Faculty" WHERE Affiliation="UF" and Faculty="Faculty";
UPDATE work.roster_analysis SET UserClass="UF Grad Student / Trainee" WHERE Affiliation="UF" and FacType='Trainee';
UPDATE work.roster_analysis SET UserClass="UF Research Professionals" WHERE Affiliation="UF" and FacType='Non-Faculty';
UPDATE work.roster_analysis SET UserClass="FSU Faculty" WHERE Affiliation="FSU" ;
UPDATE work.roster_analysis SET UserClass="External Collaborators" WHERE Affiliation not in ("FSU","UF") ;


Select CTSA_Award,
       UserClass,
       count(distinct Person_key) as Undup
from  work.roster_analysis
group by CTSA_Award, UserClass;

select 



#######################################################

ALTER TABLE  work.rank_table
ADD AssProf decimal(20.5),
ADD AsoProf decimal(20.5),
ADD Prof decimal(20.5);

drop table if exists work.undup ; 
create table work.undup as
SELECT FacType,Year,max(ctsi_year) as ctsi_year, COUNT(DISTINCT Person_Key) as Undup
from work.roster_analysis
group by FacType,Year;

drop table if exists work.undup2 ; 
create table work.undup2 as
SELECT FacType,
       ctsi_year,
       avg(Undup) as Undup
from work.undup
group by FacType,ctsi_year;

UPDATE work.rank_table rt, work.undup2 lu
SET rt.AssProf=lu.Undup
WHERE rt.ctsi_year=lu.ctsi_year 
AND FacType='Assistant Professor';
                
UPDATE work.rank_table rt, work.undup2 lu
SET rt.AsoProf=lu.Undup
WHERE rt.ctsi_year=lu.ctsi_year 
AND FacType='Associate Professor';

UPDATE work.rank_table rt, work.undup2 lu
SET rt.Prof=lu.Undup
WHERE rt.ctsi_year=lu.ctsi_year 
AND FacType='Professor';


select distinct facType from work.roster_analysis;

SELECT * from work.rank_table;
################################################

 





###



###
s
/*
##################################################################################################
################ BEGIN UPDATE BLOCK






SELECT Faculty,Affiliation,count(*) from work.roster_analysis group by Faculty, Affiliation ; ;


select distinct Affiliation from work.roster_analysis;
select distinct UFID from work.roster_analysis;

UPDATE work.roster_analysis SET Affiliation="UF" Where UFID<>'';
UPDATE work.roster_analysis SET Affiliation="UF" Where Affiliation IN ('Research Coordinator','UF Proton Therapy','UFL');

UPDATE work.roster_analysis SET Affiliation="FSU" 
Where Affiliation IN ("FSU","FSU Communications","FSU Partner","Florida State University");

UPDATE work.roster_analysis 
SET Faculty='Non-Faculty',
	FacType='Trainee',
	FacultyType='N/A'
WHERE rosterid=31125;

UPDATE work.roster_analysis SET Faculty='', FacType='', FacultyType='' WHERE Faculty is NULL;

SELECT * from work.roster_analysis where Faculty="" and Affiliation="UF";

SELECT Faculty,FacType,FacultyType,count(*) from work.roster_analysis group by Faculty,FacType,FacultyType ;

select * from work.roster_analysis where Faculty="Faculty" and FacType="";

select * from lookup.Employees where Name LIKE 'Tsuboi%';

drop table if exists work.temp;
CREATE TABLE work.temp
SELECT rosterid,Year,STD_PROGRAM,UFID,LastName,FirstName,email,UserName,Department,Title,Affiliation,Faculty,FacType,FacultyType
FROM work.roster_analysis WHERE Faculty='' ;

SELECT Department,count(*) FROM work.roster_analysis WHERE Faculty='' AND Affiliation="UF" group by Department;

drop table if exists tempufid;
create table tempufid as
SELECT DISTINCT UFID from work.roster_analysis WHERE Faculty='' AND Affiliation="UF";

SELECT Employee_ID,Job_Code,Faculty,FacType,FacultyType from lookup.Employees 
WHERE Employee_ID in (SELECT DISTINCT UFID from work.roster_analysis WHERE Faculty='' AND Affiliation="UF");

UPDATE work.roster_analysis 
SET Faculty='Non-Faculty',
	FacType='Trainee',
	FacultyType='N/A'
WHERE Faculty=''
AND Department IN (
'DN-PERIODONTICS RESIDENT',
'MD-GRADUATE STUDENT PROGRAMS',
'DC-PRINT BASED DISTANCE EDUCA',
'PH-OFFICE-EXPERIENTAL TRAIN',
'DN-ENDODONTICS RESIDENT',
'PH-DISTANCE CAMPUS JAX',
'PH-DISTANCE CAMPUS-JAX');

UPDATE work.roster_analysis 
SET Faculty='Non-Faculty',
	FacType='N/A',
	FacultyType='N/A'
WHERE Department IN (
'DSO-SHANDS JAX CLINICAL PRACT');


UPDATE work.roster_analysis 
SET Faculty='Non-Faculty',
	FacType='Trainee',
	FacultyType='N/A'
WHERE Faculty=''
AND Department='REGISTRAR STUDENTS';

UPDATE work.roster_analysis 
SET Faculty='Faculty',
	FacType='Professor',
	FacultyType='Senior',
    Affiliation='FSU'
WHERE UFID="39472441";


UPDATE work.roster_analysis 
SET Faculty='Faculty',
	FacType='Assistant Professor',
	FacultyType='Senior',
    Affiliation='Junior'
WHERE UFID="62120834";


Alter table work.ufidlist
ADD Title varchar(255),
ADD Job_Code varchar(255),
ADD Faculty varchar(12),
ADD FacType varchar(25),
ADD FacultyType varchar(12);


UPDATE work.ufidlist ul, lookup.Employees lu
SET ul.Job_Code=lu.Job_Code 
WHERE ul.UFID=lu.Employee_ID;

UPDATE work.ufidlist ul, lookup.ufids lu
SET ul.Title=lu.UF_WORK_TITLE 
WHERE ul.UFID=lu.UF_UFID;

UPDATE work.roster_analysis  ul, work.lu_tit_2018 lu
SET ul.Title=lu.Title,
	ul.FacultyType=lu.FacultyType,
    ul.Faculty=lu.Faculty,
	ul.FacType=lu.FacType
WHERE ul.UFID=lu.UFID
AND ul.Year=2018;

select Year,count(DISTINCT Person_key),COunt(*)
FROM work.roster_analysis
WHERE Roster=1
GROUP BY YEAR
ORDER BY YEAR;

UPDATE work.roster_analysis set Roster=1 where Faculty="Faculty";

################################## END OF UPDATE BLOCK ##############
#####################################################################

