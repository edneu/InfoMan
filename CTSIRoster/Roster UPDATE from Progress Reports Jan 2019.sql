
drop table if exists work.rosterseg;
create table work.rosterseg as
SELECT * from work.roster_analysis
WHERE Rosterid>=31726
  AND Rosterid<=31864;



########## ERA COMMONS
     UPDATE work.rosterseg r, lookup.ERACommons era
     SET r.EraCommons=era.ERACommons
     WHERE r.email=era.Email
     AND r.email<>""
     AND era.email<>"";

UPDATE work.rosterseg set EraCommons=Null where EraCommons="AS Don't Need";

select * from work.rosterseg;


##############
## STD PROGRAM
SELECT distinct ORIG_PROGRAM
from work.rosterseg
WHERE ORIG_PROGRAM NOT IN (SELECT Distinct Program from lookup.standard_programs);


UPDATE work.rosterseg rs, lookup.standard_programs lu
SET rs.STD_PROGRAM=lu.STD_PROGRAM
WHERE rs.ORIG_PROGRAM=lu.Program;


############
## College
UPDATE work.rosterseg ra, lookup.dept_coll lu
SET ra.College=lu.College,
    ra.Display_College=lu.Display_College
WHERE ra.DepartmentID=lu.DepartmentID;
;
####################
####### Faculty Classify

	UPDATE work.rosterseg rs, lookup.Employees lu
    SET rs.Title=lu.Job_Code
    WHERE rs.UFID=lu.Employee_ID;


     SELECT DISTINCT Title 
     from work.rosterseg ra
     WHERE Title not in (select distinct Title from lookup.roster_faculty_classify);


    SET SQL_SAFE_UPDATES = 0;
       UPDATE work.rosterseg rs, lookup.roster_faculty_classify lu
       SET rs.FacultyType=lu.FacultyType,
           rs.FacType=lu.FacType,
            rs.Faculty=lu.Faculty
       WHERE rs.Title=lu.Title
       AND rs.Title<>" ";
    SET SQL_SAFE_UPDATES = 1;


    SET SQL_SAFE_UPDATES = 0;
       UPDATE work.rosterseg SET Roster=0;
 
       Update work.rosterseg SET Roster=1 WHERE Faculty="Faculty";

       SET rs.FacultyType=lu.FacultyType,
           rs.FacType=lu.FacType,
            rs.Faculty=lu.Faculty
       WHERE rs.Title=lu.Title
       AND rs.Title<>" ";
    SET SQL_SAFE_UPDATES = 1;


select count(*) from work.roster_analysis;
########### ADD THIS IN 
/*
create TABLE work.newrost as
SELECT * from work.roster_analysis
WHERE rosterid <31726
UNION ALL
select * from work.rosterseg;


DROP TABLE IF EXISTS work.roster_analysis;
CREATE TABLE work.roster_analysis as
select * from work.newrost;

create table loaddata.backuproster20190117 as select * from lookup.roster;

drop table if exists lookup.roster;
create table lookup.roster as select * from work.roster_analysis;
*/