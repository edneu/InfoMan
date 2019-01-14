UPDATE work.ssq3 ra, lookup.dept_coll lu
SET ra.College=lu.College,
    ra.Display_College=lu.Display_College
WHERE ra.DepartmentID=lu.DepartmentID;
;

UPDATE work.ssq3 ra, lookup.dept_coll lu
SET ra.College=lu.College,
    ra.Display_College=lu.Display_College
WHERE ra.Department=lu.Department
AND ra.College="";

     UPDATE work.ssq3 r, lookup.ERACommons era
     SET r.EraCommons=era.ERACommons
     WHERE r.email=era.Email
     AND r.email<>""
     AND era.email<>"";



SELECT distinct ORIG_PROGRAM
from work.ssq3
WHERE Year=2018
AND ORIG_PROGRAM NOT IN (SELECT Distinct Program from lookup.standard_programs);


UPDATE work.ssq3 rs, lookup.standard_programs lu
SET rs.STD_PROGRAM=lu.STD_PROGRAM
WHERE rs.ORIG_PROGRAM=lu.Program;



UPDATE work.ssq3 SET UserClass="UF Faculty" WHERE Affiliation="UF" and Faculty="Faculty";
UPDATE work.ssq3 SET UserClass="UF Grad Student / Trainee" WHERE Affiliation="UF" and FacType='Trainee';
UPDATE work.ssq3 SET UserClass="UF Research Professionals" WHERE Affiliation="UF" and FacType='Non-Faculty';
UPDATE work.ssq3 SET UserClass="FSU Faculty" WHERE Affiliation="FSU" ;
UPDATE work.ssq3 SET UserClass="External Collaborators" WHERE Affiliation not in ("FSU","UF") ;

SELECT UserClass,count(*) from work.ssq3 group by UserClass;


create table work.ranal2 as
select * from work.roster_analysis
UNION ALL
SELECT * from work.ssq3;

create table loaddata.bu_rosteranalysis as select * from work.roster_analysis;

Drop table if exists work.roster_analysis;
create table work.roster_analysis as
select * from work.ranal2;