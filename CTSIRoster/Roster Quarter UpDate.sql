####create table brian.rosterBACKUP as select * from brian.roster1_2018;

### RESTORE ORGINAL VERSION
drop table if exists brian.roster1_2018;
create table brian.roster1_2018 as select * from brian.rosterBACKUP;


SET SQL_SAFE_UPDATES = 0;

CREATE INDEX empemail ON lookup.Employees (email);
CREATE INDEX empID ON lookup.Employees (Employee_ID);
CREATE INDEX ufidemail ON lookup.ufids (UF_EMAIL);

update brian.roster1_2018 r, lookup.Employees e	
	set r.UFID=e.Employee_ID
    where r.email=e.EMAIL AND r.email="";	
    	
update brian.roster1_2018 r, lookup.ufids e	
	set r.UFID=e.UF_UFID
    where r.email=e.UF_EMAIL AND r.email="";	


update brian.roster1_2018 r, lookup.Employees e	
	set r.LastName=e.LastName,
		r.FirstName=e.FirstName,
        r.email=e.EMAIL,
        r.UserName=e.UserName,
	    r.EraCommons=e.ERACommons,
        r.DepartmentID=e.Department_Code,
        r.Department=e.Department,
	    r.Title=e.Job_Code,
	    r.Affiliation="UF",
	    r.Roster=e.Roster,
	    r.Person_key=e.Employee_ID,
	    r.UndupINV=0,
	    r.AllYearsUndup=0,
	    r.FacultyType=e.FacultyType,
	    r.Faculty=e.Faculty,
	    r.FacType=e.FacType
  WHERE r.UFID=e.Employee_ID;	


update brian.roster1_2018 r, lookup.ufids e	
	set r.LastName=e.UF_LAST_NM,
		r.FirstName=e.UF_FIRST_NM,
        r.email=e.UF_EMAIL,
        r.UserName=e.UF_USER_NM,
	    r.DepartmentID=e.UF_DEPT,
        r.Department=e.UF_DEPT_NM,
	    r.Title=e.UF_WORK_TITLE,
	    r.Affiliation="UF",
	    r.Person_key=e.UF_UFID,
	    r.UndupINV=0,
	    r.AllYearsUndup=0
  WHERE r.UFID=e.UF_UFID
    AND r.Affiliation is NULL;




select *, char_length('') from brian.roster1_2018 where Affiliation is NULL;

SELECT * FROM lookup.ufids
WHERE UF_UFID IN (select DISTINCT UFID from brian.roster1_2018 WHERE Affiliation is NULL); 


select count(DISTINCT UFID) from brian.roster1_2018 WHERE Affiliation is NULL;
/*	
update brian.roster1_2018 r, lookup.Employees e	
	set r.FirstName=e.FirstName
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	set r.email=e.EMAIL
    where r.UFID=e.Employee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.UserName=e.UserName
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	set r.EraCommons=e.ERACommons
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	set r.DepartmentID=e.Department_Code
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	set r.Department=e.Department
    where r.UFID=e.Employee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.Title=e.Job_Code
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	set r.Affiliation="UF";
    	
update brian.roster_2018, lookup.Employees e	
	set r.Roster=e.Roster
    where r.UFID=e.Employee_ID;	
    	
update brian.roster_2018 r, lookup.Employees e	
	#set r.Undup_ROSTER=e.Employee_ID
    where r.UFID=e.Employee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.Person_key=e.Employee_ID
    where r.UFID=e.Employee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set UndupINV=0;
    	
update brian.roster1_2018 r, lookup.Employees e	
	set AllYearsUndup=0;
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.College="";
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.FacultyType=e.FacutlyType
    where r.UFID=e.Employee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.Faculty=e.Faculty
    where r.UFID=e.Emploee_ID;	
    	
update brian.roster1_2018 r, lookup.Employees e	
	set r.FacType=e.FacType
    where r.UFID=e.Employee_ID;	
