## EMPLOYEES TABLE UPDATED WITH MOST RECENT INFO FROM ACTIVE_EMP + Keeps inactive employees

## CREATE WORKING COPY OF Employees Table

DROP TABLE IF EXISTS work.Employees;
CREATE TABLE work.Employees AS
SELECT * from lookup.Employees;



## CREATE WORKING COPY OF ActiveEmployee table

DROP TABLE IF EXISTS work.activeemp;
CREATE TABLE work.activeemp AS
select * from lookup.active_emp_20200831;


## Replace Active Employee File in Lookup
## DROP TABLE IF EXISTS lookup.active_emp;
CREATE TABLE lookup.active_emp AS
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
        
#################################################################################
#################################################################################
#################################################################################
#################################################################################
#################################################################################
## EMPLOYEE EMAIL FILE UPDATE

DROP TABLE IF EXISTS work.EmpEmail;
CREATE TABLE work.EmpEmail AS
SELECT * from loaddata.empemail20200831;



DROP TABLE IF EXISTS work.EmpEmailUpdate;
Create table work.EmpEmailUpdate AS
SELECT  Name,
		Department_Code,
		Department,
		Job_Code,
		Job_Title,
		Email_Address as email
FROM work.EmpEmail
UNION ALL
SELECT 	Name,
		Department_Code,
		Department,
		Job_Code,
		Job_Title,
		email
FROM lookup.employee_email
WHERE email NOT IN (SELECT DISTINCT Email_Address from work.EmpEmail);


## Check Rec Nums
SELECT "Old File" as Measure, Count(distinct email) as nEMAIL, Count(*) as nRECs from lookup.employee_email
UNION ALL
SELECT "New File" as Measure, Count(distinct email) as nEMAIL, Count(*) as nRECs  from work.EmpEmailUpdate;


DROP TABLE IF EXISTS loaddata.EMP_EMAIL_BU;
CREATE TABLE loaddata.EMP_EMAIL_BU As select * from lookup.employee_email;

DROP TABLE IF EXISTS lookup.employee_email;
CREATE TABLE lookup.employee_email AS
SELECT * from work.EmpEmailUpdate;


#####################################################################################
#####################################################################################
#####################################################################################


###################################################################



SET SQL_SAFE_UPDATES = 0;

##### ADD EMAIL FROM PERVIOUS Employere File



#### ADD EMAIL FROM EMPLOYEE EMAIL LIAD
      ALTER TABLE work.EmployeeUpdate ADD EMAIL varchar(255);

      CREATE INDEX emailtemp ON work.EmployeeUpdate (Name);

      UPDATE work.EmployeeUpdate SET email=null;
      
      
##### ADD EMAIL FROM PERVIOUS Employere File
     UPDATE work.EmployeeUpdate eu, lookup.Employees lu
        SET eu.email=lu.EMAIL
        WHERE eu.Employee_ID=lu.Employee_ID;

      

      SET SQL_SAFE_UPDATES = 0; 
        UPDATE work.EmployeeUpdate eu, lookup.employee_email lu
        SET eu.email=lu.email
        WHERE (eu.email IS Null or eu.email="")
        AND eu.NAME=lu.NAME
        AND eu.Department_Code=lu.Department_Code
        AND eu.Job_Code_Code=lu.Job_Code;

#### FILL IN MISSING EMAIL FROM UFID FILE
      SET SQL_SAFE_UPDATES = 0; 
        UPDATE work.EmployeeUpdate eu, lookup.ufids lu
        SET eu.email=lu.UF_EMAIL
        WHERE (eu.email IS Null or eu.email="")
          AND eu.Employee_ID=UF_UFID
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

#####ADD FACULTY INDICATORS
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

select count(*) from work.EmployeeUpdate;
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





