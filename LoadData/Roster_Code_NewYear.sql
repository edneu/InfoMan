
SET SQL_SAFE_UPDATES = 0;

USING THE COMBINED FILE (loaddata.roster) WITH NEW YEar (2016 in this case) Added

## UPDATE NAME ETC FROM UFID FILE
SET SQL_SAFE_UPDATES = 0;
UPDATE loaddata.roster r, lookup.ufids uf
SET LastName=UF_LAST_NM,
    FirstName=UF_FIRST_NM,
    UserName=UF_USER_NM,
    DepartmentID=UF_DEPT,
    Department=UF_DEPT_NM,
    Title=UF_WORK_TITLE,
    email=UF_EMAIL 
WHERE r.UFID=uf.UF_UFID;


## UPDATE ERACOMMONS


UPDATE loaddata.roster r, lookup.ERACommons era
SET r.EraCommons=era.ERACommons
WHERE r.email=era.Email
AND r.email<>""
AND era.email<>"";



/*
## Indetify Roster Memebers by Title
UPDATE loaddata.roster r, lookup.titles_for_roster t
SET r.Roster=t.Roster
WHERE r.Title=t.Title
AND r.Year=2016;
/*
select Roster,count(*) from loaddata.roster group by Roster;
select Title,count(*) from loaddata.roster where Roster=1 group by Title ;
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