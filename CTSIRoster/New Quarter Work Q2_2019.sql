create table work.rosterstr as 
Select * from lookup.roster where year in (2017,2018) limit 10;

###drop table loaddata.roster_q2_2019;
select * from loaddata.roster_q2_2019;

####  CLEAN SCRIPT FOR ALL ROSTER TASKS
## roster_id
## Faculty, factype, FacultyType
## ERA COMMONS
## Roster
## Person Key
## Roster Key

##create table brian.bu_q12_2108 as select * from work.roster_additions;
#######################################################################################################
DROP TABLE IF EXISTS loaddata.roster;
CREATE TABLE loaddata.roster
SELECT rosterid AS rosterid,
       Space(1) AS Roster_Key,
       Year AS Year,
       "" AS STD_PROGRAM,
       UFID AS UFID,
       LastName AS LastName,
       FirstName AS FirstName,
       email AS email,
       UserName AS UserName,
       Space(25) AS EraCommons,
       DepartmentID AS DepartmentID,
       Department AS Department,
       Title AS Title,
       Affiliation AS Affiliation,
       0 AS Roster,
       0 AS Undup_ROSTER,
       "" AS Person_key,
       0 AS UndupINV,
       PROGRAM AS ORIG_PROGRAM,
       0 AS AllYearsUndup,
       "" AS College,
       FacultyType AS FacultyType,
       0 AS NIH_PI,
       0 AS UNDUP_NIH_PI,
       0 AS ALLYEARS_UNDUP_NIH_PI,
       0 AS NewRoster,
       "" AS gatorlink,
       Faculty AS Faculty,
       FacType AS FacType,
       "" AS Report_Program,
       "" AS Rept_Program2,
       "" AS Rept_Program,
       space(255) as Display_College,
       "" AS ctsi_year,
       "" AS CTSA_Award,
       "" AS UserClass
from loaddata.roster_q2_2019;





########################################################################################################

## Create work File
     DROP TABLE IF EXISTS work.roster_additions;
     Create Table work.roster_additions AS
     SELECT * from loaddata.roster;


CREATE INDEX rosteraddufid ON work.roster_additions (UFID);


### FIX UFIDs and DepartmentID the need leading zeros (thanks Excel)

SET SQL_SAFE_UPDATES = 0;

UPDATE work.roster_additions
SET UFID=lpad(UFID,8,"0")
WHERE UFID IS NOT NULL
   OR UFID <>"";
   
UPDATE work.roster_additions
SET DepartmentID=lpad(DepartmentID,8,"0")
WHERE DepartmentID IS NOT NULL
   OR DepartmentID <>"";

SET SQL_SAFE_UPDATES = 1;

## Check Validity of UFID / Name Pairings
     DROP TABLE IF EXISTS work.VerifyRosterNames;
     CREATE TABLE work.VerifyRosterNames AS
     SELECT ra.rosterid,
            ra.UFID,
            ra.LastName,
            ra.FirstName,
            lu.UF_LAST_NM,
            lu.UF_FIRST_NM 
     FROM work.roster_additions ra LEFT JOIN 
     (SELECT * from lookup.ufids WHERE UF_UFID IN (SELECT UFID FROM work.roster_additions)) AS lu
     ON ra.UFID=lu.UF_UFID
     WHERE substr(ra.LastName,1,3)<>substr(lu.UF_LAST_NM,1,3);

     ALter TABLE work.VerifyRosterNames
     ADD EmpName varchar(120);


     SET SQL_SAFE_UPDATES = 0;

     UPDATE work.VerifyRosterNames vn, lookup.Employees lu
     SET vn.EmpName=lu.Name
     WHERE vn.UFID=lu.Employee_ID;

     SET SQL_SAFE_UPDATES = 1;

     select * from  work.VerifyRosterNames ORDER BY UFID;
     



############ VERIFY COMPLETENESS OF UFID - AFFILIATIONS

UPDATE work.roster_additions SET Affiliation="UF"
WHERE (Affiliation="" OR Affiliation IS NULL)
AND (UFID IS NOT NULL OR UFID <>"" );

     select  count(*)
       from work.roster_additions
       WHERE (UFID IN (""," ","0") OR UFID IS NULL)
         AND (Affiliation="" OR Affiliation IS NULL);
   
select * from  work.roster_additions where Affiliation is null;   




UPDATE work.roster_additions SET Affiliation="Non-UF" where Affiliation is NULL;

####################################################################
##### ALL RECORDS ADDED 
####################################################################
##### UPDATE YEAR
     UPDATE work.roster_additions
     SET Year=2019;



####################################################################
## ASSIGN ROSTER IDs WHEN ALL RECORDS ADDED

select max(rosterid) from lookup.roster;

     SET SQL_SAFE_UPDATES = 0;
      UPDATE work.roster_additions SET rosterid = 0 ;
      SELECT @i:=(select max(rosterid) from lookup.roster);
      UPDATE work.roster_additions SET rosterid = @i:=@i+1;
     SET SQL_SAFE_UPDATES = 1;

select * from work.roster_additions;

#### VERIFY rosterid Assignment
     select "Max Roster ID Lookup.roster" AS Metric,max(rosterid) as val from lookup.roster
      UNION ALL
     select "Min Roster ID work.roster_additions" AS Metric, min(rosterid) as val from work.roster_additions
      UNION ALL 
     select "Max Roster ID work.roster_additions" AS Metric,max(rosterid) as val from work.roster_additions;
###################################################################

    SET SQL_SAFE_UPDATES = 0;
    
    UPDATE work.roster_additions SET UFID="" WHERE UFID IS NULL;
    ALTER TABLE work.roster_additions Modify column Roster_key varchar(255);
    ALTER TABLE work.roster_additions Modify column Person_Key varchar(255);   
    ALTER TABLE work.roster_additions Modify column EraCommons varchar(255); 
    ALTER TABLE work.roster_additions Modify column STD_PROGRAM varchar(255); 
        ALTER TABLE work.roster_additions Modify column College varchar(255); 
    
### ASSIGN Roster_key
     UPDATE work.roster_additions
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.roster_additions
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;


### Assign Person Key
     UPDATE work.roster_additions
     SET Person_Key=UFID
     WHERE UFID<>"";

     UPDATE work.roster_additions
     SET Person_Key=(LastName)
     WHERE UFID="";


### ASSIGN ERA COMMONS
     UPDATE work.roster_additions r, lookup.ERACommons era
     SET r.EraCommons=era.ERACommons
     WHERE r.email=era.Email
     AND r.email<>""
     AND era.email<>"";


### UPDATE STANDARD PROGRAM

SELECT distinct ORIG_PROGRAM
from work.roster_additions
WHERE ORIG_PROGRAM NOT IN (SELECT Distinct Program from lookup.standard_programs);




UPDATE work.roster_additions rs, lookup.standard_programs lu
SET rs.STD_PROGRAM=lu.STD_PROGRAM
WHERE rs.ORIG_PROGRAM=lu.Program;


### UPDATE COLLEGE
##### UPDATE COLLEGE
UPDATE work.roster_additions ra, lookup.dept_coll lu
SET ra.College=lu.College,
    ra.Display_College=lu.Display_College
WHERE ra.DepartmentID=lu.DepartmentID;
;

UPDATE work.roster_additions ra, lookup.dept_coll lu
SET ra.College=lu.College,
    ra.Display_College=lu.Display_College
WHERE ra.Department=lu.Department
AND ra.College="";



### UPDATE FACULTY VARIABLES 

###### Verify that there are no missing titles in the lookup.roster_faculty_classify table
###############################################################################################################################FIX FACULTY TABLE
     DROP TABLE IF EXISTS work.Roster_Need_Faculty_Data;
     CREATE TABLE work.Roster_Need_Faculty_Data As
     SELECT * 
     from work.roster_additions
     WHERE Title not in (select distinct Title from lookup.roster_faculty_classify);


select distinct FacType from work.roster_additions;
select distinct Faculty from work.roster_additions;
select distinct FacultyType from work.roster_additions;

select * from work.roster_additions where FacultyType is null;







/*
UPDATE work.roster_additions SET  FacultyType = "N/A" where FacType is Null;
UPDATE work.roster_additions SET  FacultyType = "N/A" where FacultyType is Null;
UPDATE work.roster_additions SET  Faculty = 'Non-Faculty' where FacType is Null;
UPDATE work.roster_additions SET  FacType = 'N/A' where FacType is Null;
*/

####### < create and append required records >




###########  UPDATE FACULTY CLASSIFICATION VARIABLES
#     ALTER TABLE work.roster_additions
#       ADD FacType varchar(25),
#       ADD Faculty varchar(25),
#       ADD FacultyType varchar(25);

#     UPDATE work.roster_additions 
#        SET FacType = Null,
#            Faculty = Null,
#            FacultyType = Null;


    SET SQL_SAFE_UPDATES = 0;
       UPDATE work.roster_additions rs, lookup.roster_faculty_classify lu
       SET rs.FacultyType=lu.FacultyType,
           rs.FacType=lu.FacType,
            rs.Faculty=lu.Faculty
       WHERE rs.Title=lu.Title
       AND rs.Title<>" ";
    SET SQL_SAFE_UPDATES = 1;

############  ASSIGN Roster Value based on Faculty

     SET SQL_SAFE_UPDATES = 0;
       UPDATE work.roster_additions SET Roster=0;
     
       UPDATE work.roster_additions 
          SET Roster=1
       WHERE Faculty="Faculty";


###############################################################################
###############################################################################
#########################   EOF   #############################################
###############################################################################
###############################################################################

/*
create table loaddata.rosterBU20190912 AS select * from lookup.roster;


DROP TABLE IF EXISTS loaddata.newroster;
CREATE table loaddata.newroster AS
SELECT * FROM lookup.roster
UNION ALL
SELECT * FROM  work.roster_additions ;

select max(rosterid) from loaddata.newroster;
*/
#### VERIFY rosterid Assignment
     select "Max Roster ID Lookup.roster" AS Metric,max(rosterid) as val from lookup.roster
      UNION ALL
     select "Min Roster ID work.roster_additions" AS Metric, min(rosterid) as val from work.roster_additions
      UNION ALL 
     select "Max Roster ID work.roster_additions" AS Metric,max(rosterid) as val from work.roster_additions
      union ALL
     select "MIN Roster IDloaddata.newroster" AS Metric,MIN(rosterid) as val from loaddata.newroster
      union all
     select "Max Roster IDloaddata.newroster" AS Metric,max(rosterid) as val from loaddata.newroster; 
     
/*
drop table lookup.roster; 
create table lookup.roster as
SELECT * from loaddata.newroster;
*/

SELECT Year,Count(distinct Person_key) as nPerson  from lookup.roster WHERE STD_PROGRAM="BERD" group by year;

SELECT Year,Count(distinct Person_key) as nPerson  from lookup.roster WHERE STD_PROGRAM="BERD" and Faculty="Faculty" group by year;

SELECT Year,Count(distinct Person_key) as nPerson  from lookup.roster  where STD_PROGRAM="BERD" and Roster=1 group by year;


select * from lookup.roster where Year=2017 and STD_PROGRAM="BERD" group by Faculty;








