

drop table if exists work.rc_cust;
CREATE TABLE work.rc_cust as
SELECT 
EMAIL,
Employee_ID,
Department,
FacultyType,
Job_Code,
LastName,
FirstName
from lookup.Employees
WHERE email in (select distinct email from work.rc_emails);

drop table if exists work.rc_cust;
CREATE TABLE work.rc_cust as
SELECT 
UF_EMAIL,
UF_UFID,
UF_DEPT_NM,
"" AS Faculty_Type,
UF_WORK_TITLE,
UF_LAST_NM,
UF_FIRST_NM

from lookup.ufids
WHERE UF_EMAIL in (select distinct email from work.rc_emails)
AND UF_EMAIL<>""
ORDER BY UF_EMAIL;

drop table if exists work.rc_cust;
CREATE TABLE work.rc_cust as
SELECT 
UF_USER_NM,
UF_EMAIL,
UF_UFID,
UF_DEPT_NM,
"" AS Faculty_Type,
UF_WORK_TITLE,
UF_LAST_NM,
UF_FIRST_NM

from lookup.ufids
WHERE UF_USER_NM<>""
AND UF_USER_NM IN (
'tingyuan.cheng',
'adrienne.royster',
'alissaol',
'amy.mobley',
'aoshea',
'Ashutosh.Shukla',
'bberey',
'blomax',
'cmcnally33414',
'dfedele',
'dfedele',
'dlcooke',
'edith.kaan',
'Eileen.Handberg',
'HARMSL',
'iaukhil',
'Janette.Bostick',
'Janette.Bostick',
'Janette.Bostick',
'Janette.Bostick',
'jboissoneault',
'jbraddy',
'Jessica.Cobb',
'JMarks',
'jmaye',
'Joshua.Yarrow',
'jsonke',
'jwersal',
'KEllison',
'Kimberly.Wollard',
'kramerj',
'maria.a.aguirre',
'melanie.bentley',
'melanie.bentley',
'Melissa.Lingis',
'parthur',
'Rebecca.Dettorre',
'Rebecca.Dettorre',
'Rebecca.Dettorre',
'Rebecca.Dettorre',
'RFillingim',
'rsweenie',
'Sally.Walker',
'SBooker',
'Sherry.Brown',
'Sylvie.Naar',
'Yvette.Trahan');




UNION ALL
SELECT email,
"" AS Employee_ID,
"" AS Department,
"" AS LastName,
"" AS FirstName,
"" AS Faculty,
"" AS FacultyType,
"" Job_Code
FROM work.rc_emails
WHERE email not in (select distinct email from lookup.Employees)
AND email<>"";


select count(distinct email) from work.rc_emails;

drop table if exists work.rc_cust;
CREATE TABLE work.rc_cust as
SELECT 
EMAIL,
Employee_ID,
Department,
FacultyType,;


drop table if exists work.rc_cust;
CREATE TABLE work.rc_cust as
SELECT 
UFID,
Department,
FacultyType,
Title,
LastName,
FirstName
from lookup.roster
WHERE 
(Lastname='Bentley');


AND ) OR
(Lastname='Bostick' AND FirstName LIKE 'N%' ) OR
(Lastname='Bostick' AND FirstName LIKE 'N%' ) OR
(Lastname='Bostick' AND FirstName LIKE 'N%' ) OR
(Lastname='Cobb' AND FirstName LIKE 'J%' ) OR
(Lastname='Yarrow' AND FirstName LIKE 'J%' ) OR
(Lastname='Wollard' AND FirstName LIKE 'K%' ) OR
(Lastname='Kramer' AND FirstName LIKE 'J%' ) OR
(Lastname='Bentley' AND FirstName LIKE 'M%' ) OR
(Lastname='Bentley' AND FirstName LIKE 'M%' ) OR
(Lastname='Lingis' AND FirstName LIKE 'M%' ) OR
(Lastname='Dettorre' AND FirstName LIKE 'R%' ) OR
(Lastname='Dettorre' AND FirstName LIKE 'R%' ) OR
(Lastname='Dettorre' AND FirstName LIKE 'R%' ) OR
(Lastname='Dettorre' AND FirstName LIKE 'R%' ) OR
(Lastname='Fillingim' AND FirstName LIKE 'R%' ) OR
(Lastname='Walker' AND FirstName LIKE 'S%' ) OR
(Lastname='Brown' AND FirstName LIKE 'S%' ) OR
(Lastname='Naar' AND FirstName LIKE 'S%' ) OR
(Lastname='Trahan' AND FirstName LIKE 'Y%' ) OR
(Lastname='Askins' AND FirstName LIKE 'N%' )
GROUP BY UFID,
Department,
FacultyType,
Title,
LastName,
FirstName ;



#######################
drop table if exists work.irb_lu;
create table work.irb_lu as
SELECT 	ID,
        Committee,
		Review_Type,
		Date_IRB_Received,
		Date_Originally_Approved,
		Expiration_Date,
		Current_Status,
		Project_Title,
		NCT_Number,
		PI_First_Name,
		PI_Last_Name,
		PI_UFID,
		Date_First_Subject_Signed_ICF,
		Actual_Enrollment_Number,
		Approved_Number_Of_Subjects,
		Recruitment_Method_
from loaddata.myirb_2019_02;


ALTER TABLE work.rc_irb ADD irb varchar(45);

SET SQL_SAFE_UPDATES = 0;
UPDATE work.rc_irb SET IRB=concat('IRB',trim(RAWIRB));

UPDATE work.rc_irb SET irb='IRB201500943' WHERE RAWIRB='20150943';
UPDATE work.rc_irb SET irb='IRB201710046' WHERE RAWIRB='20171046';
UPDATE work.rc_irb SET irb='IRB201710063' WHERE RAWIRB='20171063';
UPDATE work.rc_irb SET irb='IRB201701323' WHERE RAWIRB='20171323';

UPDATE work.rc_irb SET irb='IRB200600153' WHERE RAWIRB='2006-153';
UPDATE work.rc_irb SET irb='IRB201500524' WHERE RAWIRB='2015-U-0542';
UPDATE work.rc_irb SET irb='IRB201501350' WHERE RAWIRB='2015-U-1350';
UPDATE work.rc_irb SET irb='IRB201600033' WHERE RAWIRB='2016-x-033';
UPDATE work.rc_irb SET irb='IRB201700009' WHERE RAWIRB='2017-x-009';



select * from work.rc_irb ;

select count(*) from work.rc_irb where irb in (select distinct ID from loaddata.myirb_2019_02);


drop table if exists work.irb_lu2;
create table work.irb_lu2 as
SELECT 	space(25) AS rawirb,
        ID,
        Committee,
		Review_Type,
		Date_IRB_Received,
		Date_Originally_Approved,
		Expiration_Date,
		Current_Status,
		Project_Title,
		NCT_Number,
		PI_First_Name,
		PI_Last_Name,
		PI_UFID,
		Date_First_Subject_Signed_ICF,
		Actual_Enrollment_Number,
		Approved_Number_Of_Subjects,
		Recruitment_Method_
from loaddata.myirb_2019_02
where ID in (select distinct irb from work.rc_irb);

UPDATE work.irb_lu2 ib, work.rc_irb lu
SET ib.rawirb=lu.RAWIRB
WHERE ib.ID=lu.irb; 

SELECT * from work.irb_lu2;

select Year,count(*) from lookup.roster group by year;

desc loaddata.myirb_2019_02;

select Brief_Description from loaddata.myirb_2019_02 ;


