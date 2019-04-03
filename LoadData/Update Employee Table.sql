## EMPLOYEES TABLE UPDATED WITH MOST RECENT INFO FROM ACTIVE_EMP + Keeps inactive employees

## CREATE WORKING COPY OF Employees Table

DROP TABLE IF EXISTS work.Employees;
CREATE TABLE work.Employees AS
SELECT * from lookup.Employees;



## CREATE WORKING COPY OF ActiveEmployee table

DROP TABLE IF EXISTS work.activeemp;
CREATE TABLE work.activeemp AS
select * from loaddata.active_emp_20190403;


## Replace Active Employee File in Lookup
## DROP TABLE IF EXISTS lookup.active_emp;
CREATE TABLE ookup.active_emp AS
select * from work.activeemp;




DROP TABLE IF EXISTS work.EmployeeUpdate;
Create table work.EmployeeUpdate AS
SELECT Department,
		Department_Code,
		Employee_ID,
		FTE,
		Job_Code,
		Job_Code_Code,
		Name,
		Salary_Plan,
		Salary_Plan_Code
FROM work.activeemp
UNION ALL
SELECT Department,
		Department_Code,
		Employee_ID,
		FTE,
		Job_Code,
		Job_Code_Code,
		Name,
		Salary_Plan,
		Salary_Plan_Code
FROM work.Employees
WHERE Employee_ID NOT IN (SELECT DISTINCT Employee_ID from work.activeemp);
        


#####################################################################################
#####################################################################################
#####################################################################################


###################################################################



SET SQL_SAFE_UPDATES = 0;

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

	# CREATE INDEX factitle ON lookup.roster_faculty_classify (Title);


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



select * from work.EmployeeUpdate;


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
SELECT * FROM work.EmployeeUpdate;
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





