

####  CLEAN SCRIPT FOR ALL ROSTER TASKS
## roster_id
## Faculty, factype, FacultyType
## ERA COMMONS
## Roster
## Person Key
## Roster Key

##create table brian.bu_q12_2108 as select * from work.roster_additions;
##create table brian.bu_q3_2108 as select * from work.roster_additions;

select count(*) from brian.bu_q12_2108;  #3903
select count(*) from brian.bu_q3_2108;   #1666

##create table work.q12backup as select * from brian.bu_q12_2108;
##create table work.q3backup as select * from brian.bu_q3_2108;



Drop table if exists work.rosterQ123_2018;
create table work.rosterQ123_2018 as
select * FROM brian.bu_q12_2108
union all
select * FROM brian.bu_q3_2108;

DESC brian.bu_q12_2108;
DESC brian.bu_q3_2108;
DESC lookup.roster;
############### create q123 table


# Standardize Fields in Q12 
UPDATE brian.bu_q12_2108 
		SET  UNDUP_ROSTER=0,
             UndupINV=0,
AllYearsUndup=0;


ALTER TABLE brian.bu_q12_2108
     MODIFY Affiliation varchar(255),
     MODIFY AllYearsUndup int(11),
     MODIFY College varchar(45),
     MODIFY Department varchar(255),
     MODIFY DepartmentID varchar(12),
     MODIFY email varchar(255),
     MODIFY EraCommons varchar(45),
     MODIFY FacType varchar(25),
     MODIFY Faculty varchar(12),
     MODIFY FacultyType varchar(12),
     MODIFY FirstName varchar(45),
     MODIFY UserName varchar(45),
     MODIFY LastName varchar(45),
     MODIFY PROGRAM varchar(255),
     MODIFY Person_key varchar(45),
     MODIFY Roster int(11),
     MODIFY Roster_Key varchar(255),
     MODIFY rosterid int(11),
     MODIFY STD_PROGRAM varchar(255),
     MODIFY Title varchar(255),
     MODIFY UFID varchar(12),
     MODIFY Undup_ROSTER int(11) NULL,
     MODIFY UndupINV int(11) NULL,
     MODIFY Year int(11) ;

UPDATE brian.bu_q12_2108 
		SET  UNDUP_ROSTER=0,
             UndupINV=0,
AllYearsUndup=0;


# Standardize Fields in Q3 
UPDATE brian.bu_q3_2108 
		SET  UNDUP_ROSTER=0,
             UndupINV=0,
             rosterid=0    ,
AllYearsUndup=0;

ALTER TABLE brian.bu_q3_2108
     MODIFY Affiliation varchar(255),
     MODIFY AllYearsUndup int(11),
     MODIFY College varchar(45),
     MODIFY Department varchar(255),
     MODIFY DepartmentID varchar(12),
     MODIFY email varchar(255),
     MODIFY EraCommons varchar(45),
     MODIFY FacType varchar(25),
     MODIFY Faculty varchar(12),
     MODIFY FacultyType varchar(12),
     MODIFY FirstName varchar(45),
     MODIFY UserName varchar(45),
     MODIFY LastName varchar(45),
     MODIFY PROGRAM varchar(255),
     MODIFY Person_Key varchar(45),
     MODIFY Roster int(11),
     MODIFY Roster_Key varchar(255),
     MODIFY rosterid int(11),
     MODIFY STD_PROGRAM varchar(255),
     MODIFY Title varchar(255),
     MODIFY UFID varchar(12),
     MODIFY Undup_ROSTER int(11),
     MODIFY UndupINV int(11),
     MODIFY Year int(11);


########## CREATE COMBIEND FILE
DROP TABLE work.q12STD;
CREATE TABLE work.q12STD AS
SELECT   0 AS rosterid,
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
         " " AS gatorlink,
         Faculty AS Faculty,
         FacType AS FacType,
         " " AS Report_Program,
         " " AS Rept_Program2,
         " " AS Rept_Program,
         " " AS Display_College
FROM brian.bu_q12_2108;

DROP TABLE work.q3STD;
CREATE TABLE work.q3STD AS
SELECT   0 AS rosterid,
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
         " " AS gatorlink,
         Faculty AS Faculty,
         FacType AS FacType,
         " " AS Report_Program,
         " " AS Rept_Program2,
         " " AS Rept_Program,
         " " AS Display_College
FROM brian.bu_q3_2108;

DROP TABLE IF EXISTS workQ123STD;
create table workQ123STD AS
select * from work.q12STD
UNION ALL
select * from work.q3STD;




## Create work File
     #DROP TABLE IF EXISTS work.roster_additions;
     Create Table work.roster_additions AS
     SELECT * from workQ123STD;


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


####### Find starting key vlaue for appended records.
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


Create table work.Q123roster AS
select * from lookup.roster
UNION ALL 
select * from work.roster_additions;
###############################################################################
###############################################################################
#########################   EOF   #############################################
###############################################################################
###############################################################################
















