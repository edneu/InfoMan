
### Verify New Active Employee Table (from Employee Daily Listing)
      SELECT * from loaddata.active_emp_2018_12_14;
### Change key field name
Alter table loaddata.active_emp_2018_12_14 CHANGE COLUMN `active_emp_2018_12_14_id` `active_emp_id` int(11);



####Replace old Active Employee Table
      DROP TABLE IF Exists lookup.active_emp;
      CREATE TABLE lookup.active_emp AS
      SELECT * from loaddata.active_emp_2018_12_14;


### EXTRACT RECORDS NOT IN Current lookup.Employees table
      DROP TABLE IF EXISTS work.addtoemp;
      CREATE TABLE work.addtoemp AS
      SELECT  *
        from lookup.active_emp
      WHERE Employee_ID NOT IN (SELECT DISTINCT Employee_ID from lookup.Employees); 

select * from work.addtoemp;;

### ASSIGN KEY FIELD VALUES
     SET SQL_SAFE_UPDATES = 0;
      UPDATE work.addtoemp SET active_emp_id = 0 ;
      SELECT @i:=(select max(active_emp_id) from lookup.Employees);
      UPDATE work.addtoemp SET active_emp_id = @i:=@i+1;
     SET SQL_SAFE_UPDATES = 1;


#### VERIFY active_emp_id Assignment
      select "Max active_emp_id Lookup.Employees" AS Metric,max(active_emp_id) as val from lookup.Employees
    UNION ALL
      select "Min active_emp_id work.addtoemp" AS Metric, min(active_emp_id) as val from work.addtoemp
    UNION ALL
      select "Max active_emp_id work.addtoemp" AS Metric,max(active_emp_id) as val from work.addtoemp;
###################################################################

### APPEND TABLES to temporary table
    DROP TABLE IF EXISTS work.EmployeeUpdate;
    create table work.EmployeeUpdate AS
    select * from lookup.Employees
   UNION ALL
    SELECT * from work.addtoemp;


#### ADD EMAIL FROM EMPLOYEE EMAIL LIAD
      ALTER TABLE work.EmployeeUpdate ADD EMAIL varchar(255);

      CREATE INDEX emailtemp ON work.EmployeeUpdate (Name);

      UPDATE work.EmployeeUpdate SET email=null;

      SET SQL_SAFE_UPDATES = 0; 
        UPDATE work.EmployeeUpdate eu, lookup.employee_email lu
        SET eu.email=lu.email
        WHERE eu.NAME=lu.NAME
        AND eu.Department_Code=lu.Department_Code
        AND eu.Job_Code_Code=lu.Job_Code;

#### FILL IN MISSING EMAIL FROM UFID FILE
      SET SQL_SAFE_UPDATES = 0; 
        UPDATE work.EmployeeUpdate eu, lookup.ufids lu
        SET eu.email=lu.UF_EMAIL
        WHERE eu.Employee_ID=UF_UFID
        AND eu.email is NULL
        AND lu.UF_EMAIL<>' ';



##### ADD ERACOMMONS
     ALTER TABLE work.EmployeeUpdate ADD ERACommons varchar(25);

     CREATE INDEX emailtemp2 ON work.EmployeeUpdate (email);
     CREATE INDEX ERACommEmail ON lookup.ERACommons (Email);

     UPDATE work.EmployeeUpdate SET EraCommons=NULL;

     UPDATE work.EmployeeUpdate r, lookup.ERACommons era
     SET r.EraCommons=era.ERACommons
     WHERE r.email=era.Email
     AND r.email<>""
     AND era.email<>"";

#####ADD FACULTY INDFICATORS
     ALTER TABLE work.EmployeeUpdate 
       ADD Faculty varchar(12),
       ADD FacType varchar(25),
       ADD FacultyType varchar(12);



    SET SQL_SAFE_UPDATES = 0;

	 CREATE INDEX factitle ON lookup.roster_faculty_classify (Title);


     UPDATE work.EmployeeUpdate eu ,
                 lookup.roster_faculty_classify lu
       SET eu.FacultyType=lu.FacultyType,
           eu.FacType=lu.FacType,
            eu.Faculty=lu.Faculty
       WHERE eu.Job_Code=lu.Title
       AND eu.Job_Code<>" ";

    SET SQL_SAFE_UPDATES = 1;

############  ASSIGN Roster Value based on Faculty

     ALTER TABLE work.EmployeeUpdate Add Roster int(1);

     SET SQL_SAFE_UPDATES = 0;
       UPDATE work.EmployeeUpdate SET Roster=0;
     
       UPDATE work.EmployeeUpdate 
          SET Roster=1
       WHERE Faculty="Faculty";

desc work.EmployeeUpdate;




######################################################
######################################################
######################################################
/*
DROP TABLE IF EXISTS lookup.Employees;
CREATE TABLE lookup.Employees AS
SELECT * FROM work.EmployeeUpdate
ORDER BY active_emp_id;
*/
select * from lookup.Employees;


############################
### ADD LAST NAME AND FIRST NAME
ALTER TABLE work.EmployeeUpdate 
ADD LastName varchar(45),
ADD FirstName varchar(45);

    SET SQL_SAFE_UPDATES = 0;

UPDATE  work.EmployeeUpdate  eu, 
        lookup.ufids lu   
SET eu.LastName=lu.UF_LAST_NM,
    eu.FirstName=lu.UF_FIRST_NM
WHERE eu.Employee_ID=lu.UF_UFID;

select NAME, LastName,FirstName from work.EmployeeUpdate
WHERE substr(NAME,1,2)<>substr(Lastname,1,2);

#######################################################################
########## USERNAMES
ALTER TABLE work.EmployeeUpdate 
ADD UserName varchar(45);


UPDATE work.EmployeeUpdate
SET UserName=substr(email,1,locate("@",email)-1) 
WHERE email IS NOT NULL ;

UPDATE work.EmployeeUpdate eu, lookup.ufids lu
SET eu.UserName=lu.UF_USER_NM
WHERE eu.Employee_ID=lu.UF_UFID
AND eu.UserName<>lu.UF_USER_NM
AND lu.UF_USER_NM<>' ';


######################################################
######################################################
######################################################
/*
DROP TABLE IF EXISTS lookup.Employees;
CREATE TABLE lookup.Employees AS
SELECT * FROM work.EmployeeUpdate
ORDER BY active_emp_id;
*/
select * from lookup.Employees;
###########################
SELECT 
		Employee_ID AS UFID,
		LastName,
		FirstName,
		EMAIL,
		UserName,
		ERACommons,
		Department_Code AS DeptID,
		Department,
		Job_Code AS Title,
		"UF" AS Affiliation,
		Roster,
		0 AS Undup_ROSTER,
		Employee_ID AS PersonKey,
		0 AS UndupINV,
		0 AS AllYearsUndup,
		"" AS College,   ### UPDATE METHOD FOR COLLEGE
		FacultyType,
		Faculty,
		FacType
FROM lookup.Employees
WHERE LAstname in ("neu","fischbach");

desc lookup.roster;




select * from lookup.ufids where UF_LAST_NM="Chiles";
