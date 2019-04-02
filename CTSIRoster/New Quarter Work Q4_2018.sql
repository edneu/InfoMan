

####  CLEAN SCRIPT FOR ALL ROSTER TASKS
## roster_id
## Faculty, factype, FacultyType
## ERA COMMONS
## Roster
## Person Key
## Roster Key

##create table brian.bu_q12_2108 as select * from work.roster_additions;

roster1_2018_id

## Create work File
     #DROP TABLE IF EXISTS work.roster_additions;
     Create Table work.roster_additions AS
     select * from work.rload where STD_PROGRAM IS NULL;


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
     select  count(*)
       from work.roster_additions
       WHERE UFID IN (""," ","0")
         AND Affiliation="" ;


####################################################################
##### ALL RECORDS ADDED 
####################################################################
##### UPDATE YEAR
     UPDATE work.roster_additions
     SET Year=2018;


/*
####################################################################
## ASSIGN ROSTER IDs WHEN ALL RECORDS ADDED

     SET SQL_SAFE_UPDATES = 0;
      UPDATE work.roster_additions SET rosterid = 0 ;
      SELECT @i:=(select max(rosterid) from lookup.roster);
      UPDATE work.roster_additions SET rosterid = @i:=@i+1;
     SET SQL_SAFE_UPDATES = 1;


#### VERIFY rosterid Assignment
     select "Max Roster ID Lookup.roster" AS Metric,max(rosterid) as val from lookup.roster
      UNION ALL
     select "Min Roster ID work.roster_additions" AS Metric, min(rosterid) as val from work.roster_additions
      UNION ALL 
     select "Max Roster ID work.roster_additions" AS Metric,max(rosterid) as val from work.roster_additions;
###################################################################
*/

### ASSIGN Roster_key
     UPDATE work.roster_additions
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.roster_additions
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="";


### Assign Person Key
alter table work.roster_additions modify Person_Key varchar(65);

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

### UPDATE FACULTY VARIABLES 

###### Verify that there are no missing titles in the lookup.roster_faculty_classify table
### TO HERE
     DROP TABLE IF EXISTS work.Roster_Need_Faculty_Data;
     CREATE TABLE work.Roster_Need_Faculty_Data As
     SELECT DISTINCT Title 
     from work.roster_additions
     WHERE Title not in (select distinct Title from lookup.roster_faculty_classify);



####### < create and append required records >


####### Find starting key value for appended records.
     Select max(roster_faculty_classify_id2)+1 from lookup.roster_faculty_classify;

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
       
       
##### ADD STD_PROGRAM       
##############################################################################
### CHECK FOR UNCLASSIFIED PROGRAMS
SELECT distinct ORIG_PROGRAM from  work.roster_additions
WHERE  ORIG_PROGRAM NOT IN (SELECT distinct Program from lookup.standard_programs);     

UPDATE work.roster_additions ra, lookup.standard_programs lu
SET ra.STD_PROGRAM=lu.STD_PROGRAM
WHERE ra.ORIG_PROGRAM=lu.Program;

################## READY TO APPEND

Create table loaddata.rosterBU20190402 As
SELECT * from lookup.roster;

drop table if exists work.roster1;
create table work.roster1 AS
select * from lookup.roster
UNION ALL
select * from work.roster_additions;


select Year,count(*),sum(roster) from work.roster1 group by Year;

select Year,Count(distinct(Person_key)) from work.roster1 group by Year;

select Year,Count(distinct(Person_key)) from work.roster1 where Roster=1 group by Year;

select STD_PROGRAM,Count(distinct(Person_key)) from work.roster1 group by STD_PROGRAM;

##DROP TABLE lookup.roster;
##CREATE table lookup.roster AS
##SELECT * from work.roster1;



###############################################################################
###############################################################################
#########################   EOF   #############################################
###############################################################################
###############################################################################

select * from work.roster_additions;

















