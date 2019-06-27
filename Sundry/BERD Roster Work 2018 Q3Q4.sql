

DROP TABLE IF EXISTS  work.BERDLOOKUP;
CREATE TABLE work.BERDLOOKUP AS
SELECT 	UF_LAST_NM,
		UF_FIRST_NM,
        UF_UFID,
        UF_EMAIL,
        UF_DEPT_NM
        FROM lookup.ufids
WHERE  
(UF_LAST_NM='Gyang' AND UF_FIRST_NM LIKE 'Tiri%') OR
(UF_LAST_NM='Sengul' AND UF_FIRST_NM LIKE 'Buse%') OR
(UF_LAST_NM='Zori' AND UF_FIRST_NM LIKE 'Gaia%') OR
(UF_LAST_NM='Eisinger' AND UF_FIRST_NM LIKE 'Robe%') OR
(UF_LAST_NM='Cernera' AND UF_FIRST_NM LIKE 'Step%') OR
(UF_LAST_NM='Carlson' AND UF_FIRST_NM LIKE 'Aaro%') OR
(UF_LAST_NM='Tadros' AND UF_FIRST_NM LIKE 'John%') OR
(UF_LAST_NM='Angell' AND UF_FIRST_NM LIKE 'Ambe%') OR
(UF_LAST_NM='Richards' AND UF_FIRST_NM LIKE 'Mich%') OR
(UF_LAST_NM='Singh' AND UF_FIRST_NM LIKE 'Veda%') OR
(UF_LAST_NM='Robinson' AND UF_FIRST_NM LIKE 'Chri%') OR
(UF_LAST_NM='Spinelli' AND UF_FIRST_NM LIKE 'Step%') OR
(UF_LAST_NM='Knapp' AND UF_FIRST_NM LIKE 'Raym%') OR
(UF_LAST_NM='Perez' AND UF_FIRST_NM LIKE 'Jose%') OR
(UF_LAST_NM='Carlan' AND UF_FIRST_NM LIKE 'Step%') OR
(UF_LAST_NM='Abomoelak' AND UF_FIRST_NM LIKE 'Bass%') OR
(UF_LAST_NM='Tarulli' AND UF_FIRST_NM LIKE 'Kath%') OR
(UF_LAST_NM='Allen' AND UF_FIRST_NM LIKE 'Mely%') OR
(UF_LAST_NM='Chen' AND UF_FIRST_NM LIKE 'Jene%') OR
(UF_LAST_NM='Moon' AND UF_FIRST_NM LIKE 'Rena%') OR
(UF_LAST_NM='Rivera-Nieves' AND UF_FIRST_NM LIKE 'Desi%') OR
(UF_LAST_NM='Miller' AND UF_FIRST_NM LIKE 'Harr%') OR
(UF_LAST_NM='Boer' AND UF_FIRST_NM LIKE 'J.De%') OR
(UF_LAST_NM='Subnaik' AND UF_FIRST_NM LIKE 'Patr%') OR
(UF_LAST_NM='Smadi' AND UF_FIRST_NM LIKE 'Yame%') OR
(UF_LAST_NM='DeCampli' AND UF_FIRST_NM LIKE 'Will%') OR
(UF_LAST_NM='Emtiazjoo' AND UF_FIRST_NM LIKE 'Amir%') OR
(UF_LAST_NM='Brantly' AND UF_FIRST_NM LIKE 'Mark%') OR
(UF_LAST_NM='Singh' AND UF_FIRST_NM LIKE 'Nahk%') OR
(UF_LAST_NM='Debenedetto' AND UF_FIRST_NM LIKE 'Anna%') OR
(UF_LAST_NM='Pozzi' AND UF_FIRST_NM LIKE 'Fede%') OR
(UF_LAST_NM='O’Kell' AND UF_FIRST_NM LIKE 'Alli%') OR
(UF_LAST_NM='Lester' AND UF_FIRST_NM LIKE 'Mary%') OR
(UF_LAST_NM='Kelley' AND UF_FIRST_NM LIKE 'Rach%') OR
(UF_LAST_NM='Stacpoole' AND UF_FIRST_NM LIKE 'Pete%') OR
(UF_LAST_NM='Motaparthi' AND UF_FIRST_NM LIKE 'Kira%') OR
(UF_LAST_NM='Bruce' AND UF_FIRST_NM LIKE 'Carl%') OR
(UF_LAST_NM='Beal' AND UF_FIRST_NM LIKE 'Case%') OR
(UF_LAST_NM='Lyer' AND UF_FIRST_NM LIKE 'Siva%') OR
(UF_LAST_NM='Fang' AND UF_FIRST_NM LIKE 'Ruog%') OR
(UF_LAST_NM='Rose' AND UF_FIRST_NM LIKE 'Dori%') OR
(UF_LAST_NM='Hill' AND UF_FIRST_NM LIKE 'Rich%') OR
(UF_LAST_NM='Grajo' AND UF_FIRST_NM LIKE 'Jose%') OR
(UF_LAST_NM='Roe' AND UF_FIRST_NM LIKE 'Char%') OR
(UF_LAST_NM='Frohe' AND UF_FIRST_NM LIKE 'Tess%') OR
(UF_LAST_NM='Cheong' AND UF_FIRST_NM LIKE 'Jeew%') OR
(UF_LAST_NM='Nagaraja' AND UF_FIRST_NM LIKE 'Nand%') OR
(UF_LAST_NM='Smith' AND UF_FIRST_NM LIKE 'Stac%') OR
(UF_LAST_NM='Weyh' AND UF_FIRST_NM LIKE 'Ashl%') OR
(UF_LAST_NM='Khan' AND UF_FIRST_NM LIKE 'Tabb%') OR
(UF_LAST_NM='Amaoutakis' AND UF_FIRST_NM LIKE 'Kons%') OR
(UF_LAST_NM='Judge' AND UF_FIRST_NM LIKE 'Sara%') OR
(UF_LAST_NM='Trevino' AND UF_FIRST_NM LIKE 'Jose%') OR
(UF_LAST_NM='Souza' AND UF_FIRST_NM LIKE 'Carl%') OR
(UF_LAST_NM='Milner' AND UF_FIRST_NM LIKE 'Rowa%') OR
(UF_LAST_NM='Valentine' AND UF_FIRST_NM LIKE 'Mari%') OR
(UF_LAST_NM='Neyroud' AND UF_FIRST_NM LIKE 'Dari%') OR
(UF_LAST_NM='Black' AND UF_FIRST_NM LIKE 'Laur%') OR
(UF_LAST_NM='Nguyen' AND UF_FIRST_NM LIKE 'Cuon%') OR
(UF_LAST_NM='DeGennaro' AND UF_FIRST_NM LIKE 'Vinc%') OR
(UF_LAST_NM='Rodrigues Perim' AND UF_FIRST_NM LIKE 'Raph%') OR
(UF_LAST_NM='Heilman' AND UF_FIRST_NM LIKE 'Kenn%') OR
(UF_LAST_NM='Ryan' AND UF_FIRST_NM LIKE 'Holl%') OR
(UF_LAST_NM='Harmel' AND UF_FIRST_NM LIKE 'Alli%') OR
(UF_LAST_NM='Lampotang' AND UF_FIRST_NM LIKE 'Sams%') OR
(UF_LAST_NM='Tighe' AND UF_FIRST_NM LIKE 'Patr%') OR
(UF_LAST_NM='Sutor' AND UF_FIRST_NM LIKE 'Thom%') OR
(UF_LAST_NM='Cogle' AND UF_FIRST_NM LIKE 'Chri%') OR
(UF_LAST_NM='Keeley' AND UF_FIRST_NM LIKE 'Elle%') OR
(UF_LAST_NM='Leey' AND UF_FIRST_NM LIKE 'Juli%') OR
(UF_LAST_NM='Smith' AND UF_FIRST_NM LIKE 'Barb%') OR
(UF_LAST_NM='Guirgis' AND UF_FIRST_NM LIKE 'Fahe%') OR
(UF_LAST_NM='Lampotang' AND UF_FIRST_NM LIKE 'Sams%') OR
(UF_LAST_NM='Pertzborn' AND UF_FIRST_NM LIKE 'Matt%') OR
(UF_LAST_NM='Hendeles' AND UF_FIRST_NM LIKE 'Lesl%') OR
(UF_LAST_NM='Byrne' AND UF_FIRST_NM LIKE 'Barr%') OR
(UF_LAST_NM='Corti' AND UF_FIRST_NM LIKE 'Manu%') OR
(UF_LAST_NM='Farhadfar' AND UF_FIRST_NM LIKE 'Nosh%') OR
(UF_LAST_NM='Chen' AND UF_FIRST_NM LIKE 'Mong%') OR
(UF_LAST_NM='Zayas' AND UF_FIRST_NM LIKE 'Cili%') OR
(UF_LAST_NM='Chen' AND UF_FIRST_NM LIKE 'Guan%') OR
(UF_LAST_NM='Patel' AND UF_FIRST_NM LIKE 'Adit%') OR
(UF_LAST_NM='Quittner' AND UF_FIRST_NM LIKE 'Alex%') OR
(UF_LAST_NM='Fishe' AND UF_FIRST_NM LIKE 'Jenn%') OR
(UF_LAST_NM='Guo' AND UF_FIRST_NM LIKE 'Yi%') OR
(UF_LAST_NM='Taylor' AND UF_FIRST_NM LIKE 'Thom%') OR
(UF_LAST_NM='Ferrara' AND UF_FIRST_NM LIKE 'Matt%') OR
(UF_LAST_NM='Blanton' AND UF_FIRST_NM LIKE 'Jimm%') OR
(UF_LAST_NM='Salloum' AND UF_FIRST_NM LIKE 'Ramz%') OR
(UF_LAST_NM='Xu' AND UF_FIRST_NM LIKE 'Hong%') OR
(UF_LAST_NM='Guo' AND UF_FIRST_NM LIKE 'Ning%') OR
(UF_LAST_NM='Sun' AND UF_FIRST_NM LIKE 'Yiju%') OR
(UF_LAST_NM='Huo' AND UF_FIRST_NM LIKE 'Tian%') OR
(UF_LAST_NM='Young' AND UF_FIRST_NM LIKE 'Alys%') OR
(UF_LAST_NM='Maldonado-Molina' AND UF_FIRST_NM LIKE 'Mild%') OR
(UF_LAST_NM='Morris' AND UF_FIRST_NM LIKE 'Heat%') OR
(UF_LAST_NM='Theis' AND UF_FIRST_NM LIKE 'Ryan%') OR
(UF_LAST_NM='Cunningham' AND UF_FIRST_NM LIKE 'Nick%') OR
(UF_LAST_NM='Genco' AND UF_FIRST_NM LIKE 'Fran%') OR
(UF_LAST_NM='Ranka' AND UF_FIRST_NM LIKE 'Deep%') OR
(UF_LAST_NM='Girson' AND UF_FIRST_NM LIKE 'Mark%') OR
(UF_LAST_NM='Kinsell' AND UF_FIRST_NM LIKE 'Heid%') OR
(UF_LAST_NM='Bondoc' AND UF_FIRST_NM LIKE 'Irin%') OR
(UF_LAST_NM='Goodman' AND UF_FIRST_NM LIKE 'Davi%') OR
(UF_LAST_NM='Guariglia' AND UF_FIRST_NM LIKE 'Ceci%') OR
(UF_LAST_NM='Whitehead' AND UF_FIRST_NM LIKE 'Nick%') OR
(UF_LAST_NM='Wang' AND UF_FIRST_NM LIKE 'Kai%') OR
(UF_LAST_NM='Lopez' AND UF_FIRST_NM LIKE 'Jane%') OR
(UF_LAST_NM='Joseph' AND UF_FIRST_NM LIKE 'Verl%') OR
(UF_LAST_NM='Warren' AND UF_FIRST_NM LIKE 'Curt%') OR
(UF_LAST_NM='Setum' AND UF_FIRST_NM LIKE 'Kath%') OR
(UF_LAST_NM='Iqbal' AND UF_FIRST_NM LIKE 'Atif%') OR
(UF_LAST_NM='Khan' AND UF_FIRST_NM LIKE 'Aima%') OR
(UF_LAST_NM='Gregg' AND UF_FIRST_NM LIKE 'Aust%') OR
(UF_LAST_NM='Carson' AND UF_FIRST_NM LIKE 'Josh%') OR
(UF_LAST_NM='Andreoni' AND UF_FIRST_NM LIKE 'Kenn%') OR
(UF_LAST_NM='Swarts' AND UF_FIRST_NM LIKE 'Stev%') OR
(UF_LAST_NM='Okunnieff' AND UF_FIRST_NM LIKE 'Paul%') OR
(UF_LAST_NM='Thigpin' AND UF_FIRST_NM LIKE 'Tera%') OR
(UF_LAST_NM='Freeman' AND UF_FIRST_NM LIKE 'Will%') OR
(UF_LAST_NM='Ross' AND UF_FIRST_NM LIKE 'Kat%') OR
(UF_LAST_NM='Sherrilene' AND UF_FIRST_NM LIKE 'Clas%') OR
(UF_LAST_NM='Manini' AND UF_FIRST_NM LIKE 'Todd%') OR
(UF_LAST_NM='Booker' AND UF_FIRST_NM LIKE 'Staj%') OR
(UF_LAST_NM='Burman' AND UF_FIRST_NM LIKE 'Jona%') OR
(UF_LAST_NM='Chatterjee' AND UF_FIRST_NM LIKE 'Sude%') OR
(UF_LAST_NM='Corbett' AND UF_FIRST_NM LIKE 'Duan%') OR
(UF_LAST_NM='Gardner' AND UF_FIRST_NM LIKE 'Anna%') OR
(UF_LAST_NM='Hupfield' AND UF_FIRST_NM LIKE 'Kath%') OR
(UF_LAST_NM='Maciel' AND UF_FIRST_NM LIKE 'Caro%') OR
(UF_LAST_NM='Mardini' AND UF_FIRST_NM LIKE 'Mamo%') OR
(UF_LAST_NM='McQuail' AND UF_FIRST_NM LIKE 'Jose%') OR
(UF_LAST_NM='Vouri' AND UF_FIRST_NM LIKE 'Scot%') OR
(UF_LAST_NM='Mankowski' AND UF_FIRST_NM LIKE 'Robe%') OR
(UF_LAST_NM='Booker' AND UF_FIRST_NM LIKE 'Staj%') OR
(UF_LAST_NM='Ikramuddin' AND UF_FIRST_NM LIKE 'Aukh%') OR
(UF_LAST_NM='Rang' AND UF_FIRST_NM LIKE 'Ruog%') OR
(UF_LAST_NM='Pruitt' AND UF_FIRST_NM LIKE 'J. C%') OR
(UF_LAST_NM='O’Dell' AND UF_FIRST_NM LIKE 'Walt%') OR
(UF_LAST_NM='Dolganiuc' AND UF_FIRST_NM LIKE 'Ange%') OR
(UF_LAST_NM='Tadros' AND UF_FIRST_NM LIKE 'Hann%') OR
(UF_LAST_NM='Lele' AND UF_FIRST_NM LIKE 'Tanm%') OR
(UF_LAST_NM='Seungbum' AND UF_FIRST_NM LIKE 'Kim%') OR
(UF_LAST_NM='Stoppel' AND UF_FIRST_NM LIKE 'Whit%')
ORDER BY UF_LAST_NM, UF_FIRST_NM ;

select count(distinct Person_Key), count(*) from lookup.roster
WHERE Year=2018 and STD_PROGRAM="BERD"; 

select min(rosterid), MAx(rosterid) from lookup.roster
WHERE Year=2018 and STD_PROGRAM="BERD"; 

select max(rosterid) from  lookup.roster;

select * from lookup.roster where rosterid=33690;

DROP TABLE IF EXISTS loaddata.roster;
CREATE TABLE loaddata.roster
SELECT rosterid AS rosterid,
       Roster_Key AS Roster_Key,
       Year AS Year,
       STD_PROGRAM AS STD_PROGRAM,
       UFID AS UFID,
       LastName AS LastName,
       FirstName AS FirstName,
       email AS email,
       UserName AS UserName,
       EraCommons AS EraCommons,
       DepartmentID AS DepartmentID,
       Department AS Department,
       Title AS Title,
       Affiliation AS Affiliation,
       Roster AS Roster,
       Undup_ROSTER AS Undup_ROSTER,
       Person_key AS Person_key,
       UndupINV AS UndupINV,
       PROGRAM AS ORIG_PROGRAM,
       AllYearsUndup AS AllYearsUndup,
       College AS College,
       FacultyType AS FacultyType,
       0 AS NIH_PI,
       0 AS UNDUP_NIH_PI,
       0 AS ALLYEARS_UNDUP_NIH_PI,
       0 AS NewRoster,
       "" AS gatorlink,
       Faculty AS Faculty,
       FacType AS FacType,
       "BERD" AS Report_Program,
       "BERD" AS Rept_Program2,
       "" AS Rept_Program,
       "" AS Display_College,
       "" AS ctsi_year,
       "" AS CTSA_Award,
       "" AS UserClass
from loaddata.berdq342018;
###############################################################################################################

SELECT * FROm 




*/
## Unduplicated Roster Indicator


drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Roster_Key,min(rosterid) AS UndupRec
FROM loaddata.roster
WHERE Roster=1
GROUP BY Roster_Key;




UPDATE loaddata.roster SET Undup_ROSTER=0;

UPDATE loaddata.roster SET Undup_ROSTER=1
WHERE rosterid in (select UndupRec from work.undup_temp);

drop table if exists work.undup_temp;
### drop table if exists loaddata.roster;

## AllServed Unduplicated Roster Indicator

##ALTER TABLE loaddata.roster ADD AllYearsUndup integer;

drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Person_key,min(rosterid) AS UndupRec
FROM loaddata.roster
WHERE Roster=1
GROUP BY Person_key; 

UPDATE loaddata.roster SET AllYearsUndup=0;

UPDATE loaddata.roster SET AllYearsUndup=1
WHERE rosterid in (select UndupRec from work.undup_temp);


##SELECT sum(AllYearsUndup) from loaddata.roster;
## SELECT YEAR,sum(Undup_ROSTER) from  lookup.roster group by year order by year;
## SELECT EraCommons,count(*) as NumRec from loaddata.roster group by EraCommons;
## SELECT EraCommons,count(*) as NumRec from lookup.roster group by EraCommons;

##STANDARD PROGRAM
##ALTER TABLE loaddata.roster ADD ORIG_PROGRAM varchar(255);
            
SELECT STD_PROGRAM,count(*) from loaddata.roster group by STD_PROGRAM;

/*
UPDATE loaddata.roster r, lookup.standard_programs s
SET r.PROGRAM=s.STD_PROGRAM
WHERE r.ORIG_PROGRAM=s.Program;
*/

## STANDARDIZE PROGRAM NAMES (CLEAN UP)
UPDATE loaddata.roster SET STD_PROGRAM='Ethics Consultation' WHERE STD_PROGRAM='Ethics';
UPDATE loaddata.roster SET STD_PROGRAM='Human Imaging' WHERE STD_PROGRAM='Human Imaging Core';
UPDATE loaddata.roster SET STD_PROGRAM='PubMed Compliance' WHERE STD_PROGRAM='Pubmed_Comp';
UPDATE loaddata.roster SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='Service Core';
UPDATE loaddata.roster SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='ServiceCore';
UPDATE loaddata.roster SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='Service_Center_Core';

UPDATE lookup.standard_programs SET STD_PROGRAM='Ethics Consultation' WHERE STD_PROGRAM='Ethics';
UPDATE lookup.standard_programs SET STD_PROGRAM='Human Imaging' WHERE STD_PROGRAM='Human Imaging Core';
UPDATE lookup.standard_programs SET STD_PROGRAM='PubMed Compliance' WHERE STD_PROGRAM='Pubmed_Comp';
UPDATE lookup.standard_programs SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='Service Core';
UPDATE lookup.standard_programs SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='ServiceCore';
UPDATE lookup.standard_programs SET STD_PROGRAM='Service Center' WHERE STD_PROGRAM='Service_Center_Core';



UPDATE lookup.roster SET STD_PROGRAM='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Unit';
UPDATE loaddata.roster SET STD_PROGRAM='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Unit';
UPDATE lookup.standard_programs SET STD_PROGRAM='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Unit';


UPDATE lookup.roster
SET SeniorFac=0;

UPDATE lookup.roster ro, work.ud_seniorfac lu
SET ro.SeniorFac=lu.SeniorFac
WHERE ro.Title=lu.Title;


SELECT YEAR,SUM(Undup_ROSTER) AS Count
FROM loaddata.roster
group by Year
order by year;



## END OF STANDARD PROGRAM

/*
## Move to Master
DROP TABLE IF EXISTS lookup.roster2016;
CREATE TABLE lookup.roster2016 AS
SELECT * from loaddata.roster;





drop table work.temp;
create table work.temp as
select * from lookup.roster where Year=2018 Limit 10;

select max(rosterid)+1 from lookup.roster;


DESC lookup.roster;
