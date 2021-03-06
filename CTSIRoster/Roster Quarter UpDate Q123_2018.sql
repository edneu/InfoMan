

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

### UPDATE STD_PROGRAM

SELECT distinct ORIG_PROGRAM
from work.Q123roster
WHERE Year=2018
AND ORIG_PROGRAM NOT IN (SELECT Distinct Program from lookup.standard_programs);


UPDATE work.Q123roster rs, lookup.standard_programs lu
SET rs.STD_PROGRAM=lu.STD_PROGRAM
WHERE rs.ORIG_PROGRAM=lu.Program;

/*
UPDATE lookup.standard_programs SET STD_PROGRAM="Clinical Research Center" WHERE STD_PROGRAM="CCTR";
UPDATE lookup.standard_programs SET STD_PROGRAM="Research Administration" WHERE STD_PROGRAM="RAC";
UPDATE lookup.standard_programs SET STD_PROGRAM="Translational Workforce Development" WHERE STD_PROGRAM="TPDP";

UPDATE lookup.roster SET ORIG_PROGRAM=STD_PROGRAM WHERE ORIG_PROGRAM="" AND STD_PROGRAM<>"";


SELECT ORIG_PROGRAM,STD_PROGRAM from lookup.roster where ORIG_PROGRAM not in (select distinct Program from lookup.standard_programs) GROUP BY ORIG_PROGRAM,STD_PROGRAM;  
select max(standard_programs_id2)+1 from lookup.standard_programs;
select * from work.Q123roster where ORIG_PROGRAM in ("collaborate w/ biotility worksho","collaborate w/ education");
*/






##### UPDATE COLLEGE
UPDATE work.Q123roster ra, lookup.dept_coll lu
SET ra.College=lu.College
WHERE ra.DepartmentID=lu.DepartmentID;
;

UPDATE lookup.roster ra, lookup.dept_coll lu
SET ra.College=lu.College
WHERE ra.DepartmentID=lu.DepartmentID;
;


CREATE INDEX dept ON lookup.dept_coll (Department);

UPDATE work.Q123roster ra, lookup.dept_coll lu
SET ra.College=lu.College
WHERE ra.Department=lu.Department
AND ra.Department<>"";


select * from work.Q123roster where College="" and DepartmentID <>"";


UPDATE lookup.roster
set DepartmentID=LPAD(DepartmentID,8,'0')
WHERE DepartmentID<>"";



select DepartmentID,LPAD(DepartmentID,8,'0') from work.Q123roster WHERE DepartmentID<>"" AND DepartmentID<>LPAD(DepartmentID,8,'0');

select College,VPCODE,VicePres from lookup.dept_coll group by College,VPCODE,VicePres;
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

select Year,count(DISTINCT Person_key),COunt(*)
FROM work.Q123roster
WHERE Roster=1
GROUP BY YEAR
ORDER BY YEAR;

select College,count(DISTINCT Person_key)
FROM work.Q123roster
GROUP BY College
;

select * from lookup.dept_coll where DepartmentID='16120100';

UPDATE work.Q123roster SET College="" WHere College IS NULL;


select * from work.Q123roster WHere College ='';

select count(*) from work.Q123roster;
select year,count(*) from work.Q123roster group by Year;

select distinct College from lookup.dept_coll;

select distinct Display_College from lookup.roster;

### Add Display College

ALTER TABLE lookup.dept_coll ADD Display_College varchar(45);

UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG-DEAN FOR ACADEMIC PROGRAMS';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG-DEAN FOR EXTENSION';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG-DEAN FOR RESEARCH';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG-OFFICE-SENIOR VICE PRES';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES DEPARTMENTS';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES OFF CAMPUS CENTERS';
UPDATE lookup.dept_coll SET Display_College='Agriculture and Life Sciences' WHERE College='AG/NAT RES ON CAMPUS CENTERS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='ASSOCCIATE VP-BR/IS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='ASSOCIATE VP-BS/FA/OD/SBVDR';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='ASSOCIATE VP-HR/EHS/OA/UPD';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='BC-BAUGHMAN CENTER';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='BOARD OF TRUSTEES';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='BUS & ECO DEVELOPMENT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='CATTLE ENHANCEMENT BOARD INC';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='CHIEF FINANCIAL OFFICER';
UPDATE lookup.dept_coll SET Display_College='Arts' WHERE College='COLLEGE OF THE ARTS';
UPDATE lookup.dept_coll SET Display_College='Business Administration' WHERE College='COLLEGE-BUSINESS ADMINISTRATION';
UPDATE lookup.dept_coll SET Display_College='Design, Construction and Planning' WHERE College='COLLEGE-DCP';
UPDATE lookup.dept_coll SET Display_College='Dentistry' WHERE College='COLLEGE-DENTISTRY';
UPDATE lookup.dept_coll SET Display_College='Education' WHERE College='COLLEGE-EDUCATION';
UPDATE lookup.dept_coll SET Display_College='Engineering' WHERE College='COLLEGE-ENGINEERING';
UPDATE lookup.dept_coll SET Display_College='Health and Human Performance' WHERE College='COLLEGE-HLTH/HUMAN PERFORMANCE';
UPDATE lookup.dept_coll SET Display_College='Journalism and Communications' WHERE College='COLLEGE-JOURNALISM / COMMUNICA';
UPDATE lookup.dept_coll SET Display_College='Law' WHERE College='COLLEGE-LAW';
UPDATE lookup.dept_coll SET Display_College='Liberal Arts and Sciences' WHERE College='COLLEGE-LIBERAL ARTS/SCIENCES';
UPDATE lookup.dept_coll SET Display_College='Medicine' WHERE College='COLLEGE-MEDICINE';
UPDATE lookup.dept_coll SET Display_College='Medicine - Jacksonville' WHERE College='COLLEGE-MEDICINE JACKSONVILLE';
UPDATE lookup.dept_coll SET Display_College='Nursing' WHERE College='COLLEGE-NURSING';
UPDATE lookup.dept_coll SET Display_College='Pharmacy' WHERE College='COLLEGE-PHARMACY';
UPDATE lookup.dept_coll SET Display_College='Public Health and Health Professions' WHERE College='COLLEGE-PUBL HLTH / HLTH PROFS';
UPDATE lookup.dept_coll SET Display_College='Veterinary Medicine' WHERE College='COLLEGE-VETERINARY MED';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='CONSTRUCTION / RENOVA / REPAIR';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='DIVISION-CONTINUING EDUCATION';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='DIVISION-HOUSING';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='DSO-DIRECT SUPPORT ORG';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='DV-VP DEVELOPMENT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='DW-DIGITAL WORLD';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='EM-STUDENT FINANCIAL AFFAIRS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='EMERGENCY MGMT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FACILITIES SERVICES DEPARTMENT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FACILITIES/PLANNING/CONSTRUC';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FL FOUNDATION SEED PRODUCERS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FLORIDA 4-H FOUNDATION INC';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FLORIDA MUSEUM NATURAL HISTORY';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='FLVC-FLORIDA VIRTUAL CAMPUS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='GATOR BOOSTERS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='GRADUATE SCHOOL';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='HUMAN RESOURCES';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='INFORMATION TECHNOLOGY';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='INSTITUTIONAL ACTIVITIES';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='INTERNATIONAL CENTER';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='J WAYNE REITZ UNION';
UPDATE lookup.dept_coll SET Display_College='Liberal Arts and Sciences' WHERE College='Liberal Arts and Sciences';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='MILITARY UNITS';
UPDATE lookup.dept_coll SET Display_College='Medicine' WHERE College='Medicine';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='Non-Academic';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE ENROLLMENT MANAGEMENT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE OF HEALTH AFFAIRS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE OF PROVOST';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE OF REGISTRAR';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE OF RESEARCH';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='OFFICE OF STUDENT AFFAIRS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='PC-PHILLIPS CENTER';
UPDATE lookup.dept_coll SET Display_College='' WHERE College='';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College LIKE 'PRESIDENT%S OFFICE';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='REGISTRAR STUDENTS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='SH-STUDENT HEALTH CARE CENTER';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='SHANDS TEACHING HOSPITAL';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='SMALL BUS/VENDOR DIVER RELA';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='STUDENT GOVERNMENT';
UPDATE lookup.dept_coll SET Display_College='Type One Centers' WHERE College='TYPE ONE CENTERS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='UA-UNIVERSITY AUDITORIUM';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='UF LEADERSHIP AND EDUCATION';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='UF PRIVACY OFFICE';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='UF RESEARCH FOUNDATION INC';
UPDATE lookup.dept_coll SET Display_College='Library' WHERE College='UNIVERSITY LIBRARIES';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='UNIVERSITY PRESS OF FLORIDA';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VP ADMINISTRATION';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VP-DEVELOPMENT';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VP-GENERAL COUNSEL';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VP-GOVERNMENTAL RELATIONS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VP-PUBLIC RELATIONS';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College='VPFA-VP FINANCE / ADMIN';
UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE College LIKE 'WOMEN%S ATHLETICS';
UPDATE lookup.dept_coll SET Display_College='PHHP-COM Intergrated Programs' WHERE College='PHHP-COM INTEGRATED PROGRAMS';

UPDATE lookup.dept_coll SET Display_College='Non-Academic' WHERE Display_College is null;

select * from lookup.dept_coll WHERE Display_College is null;


UPDATE work.Q123roster rs, lookup.dept_coll lu
SET rs.Display_College=lu.Display_College
WHERE rs.College=lu.College
  AND rs.Display_College="";

select display_college,count(*) from work.Q123roster group by Display_College;

/*
create table loaddata.BackupRoster2009_2017 as select * from lookup.roster;

drop table if exists lookup.roster;
create table lookup.roster as select * from work.Q123roster;

*/


###############################################################################
###############################################################################
#########################   EOF   #############################################
###############################################################################
###############################################################################
















