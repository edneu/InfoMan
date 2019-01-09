####create table brian.rosterBACKUP as select * from brian.roster1_2018;

### RESTORE ORGINAL VERSION
#drop table if exists brian.roster1_2018;
#create table brian.roster1_2018 as select * from brian.rosterBACKUP;


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



	
*/

SET SQL_SAFE_UPDATES = 0;
UPDATE brian.roster1_2018 SET Title='Account Coordinator' WHERE roster1_2018_id=758;
UPDATE brian.roster1_2018 SET Title='Affiliate Clinical Assistant Professor' WHERE roster1_2018_id=1205;
UPDATE brian.roster1_2018 SET Title='Assistant Professor' WHERE roster1_2018_id=696;
UPDATE brian.roster1_2018 SET Title='Assistant Professor' WHERE roster1_2018_id=710;
UPDATE brian.roster1_2018 SET Title='Assistant Professor' WHERE roster1_2018_id=711;
UPDATE brian.roster1_2018 SET Title='Assistant Professor' WHERE roster1_2018_id=973;
UPDATE brian.roster1_2018 SET Title='Assistant Professor Housestaff' WHERE roster1_2018_id=1538;
UPDATE brian.roster1_2018 SET Title='Associate Director' WHERE roster1_2018_id=1379;
UPDATE brian.roster1_2018 SET Title='Basic Science Team Lead' WHERE roster1_2018_id=545;
UPDATE brian.roster1_2018 SET Title='Basic Science Team Lead' WHERE roster1_2018_id=627;
UPDATE brian.roster1_2018 SET Title='Clinical Assistant Professor' WHERE roster1_2018_id=564;
UPDATE brian.roster1_2018 SET Title='Clinical Assistant Professor' WHERE roster1_2018_id=1013;
UPDATE brian.roster1_2018 SET Title='Clinical Research Coordinator' WHERE roster1_2018_id=556;
UPDATE brian.roster1_2018 SET Title='Clinical Research Coordinator ' WHERE roster1_2018_id=1467;
UPDATE brian.roster1_2018 SET Title='Clinical Research Coordinator ' WHERE roster1_2018_id=1495;
UPDATE brian.roster1_2018 SET Title='Clinical Research Manager' WHERE roster1_2018_id=587;
UPDATE brian.roster1_2018 SET Title='Clinical Research Manager' WHERE roster1_2018_id=1347;
UPDATE brian.roster1_2018 SET Title='Clinical Research Nurse Coordinator' WHERE roster1_2018_id=540;
UPDATE brian.roster1_2018 SET Title='Clinical Research Nurse Coordinator' WHERE roster1_2018_id=623;
UPDATE brian.roster1_2018 SET Title='Clinical Research Nurse Coordinator' WHERE roster1_2018_id=1346;
UPDATE brian.roster1_2018 SET Title='Clinical Specialist' WHERE roster1_2018_id=897;
UPDATE brian.roster1_2018 SET Title='Critical Care Pharmacist' WHERE roster1_2018_id=739;
UPDATE brian.roster1_2018 SET Title='Director of the FSU of Medicine Network' WHERE roster1_2018_id=609;
UPDATE brian.roster1_2018 SET Title='Director, Regulatory Affairs' WHERE roster1_2018_id=1657;
UPDATE brian.roster1_2018 SET Title='Doctor of Veterinary Medicine' WHERE roster1_2018_id=707;
UPDATE brian.roster1_2018 SET Title='Medical Student' WHERE roster1_2018_id=85;
UPDATE brian.roster1_2018 SET Title='Medical Student' WHERE roster1_2018_id=961;
UPDATE brian.roster1_2018 SET Title='Medical Student' WHERE roster1_2018_id=1085;
UPDATE brian.roster1_2018 SET Title='MPH Student' WHERE roster1_2018_id=1140;
UPDATE brian.roster1_2018 SET Title='MSRP' WHERE roster1_2018_id=89;
UPDATE brian.roster1_2018 SET Title='NICU Clinical Leader' WHERE roster1_2018_id=119;
UPDATE brian.roster1_2018 SET Title='Pharmacy Resident' WHERE roster1_2018_id=47;
UPDATE brian.roster1_2018 SET Title='PhD' WHERE roster1_2018_id=3;
UPDATE brian.roster1_2018 SET Title='PhD' WHERE roster1_2018_id=4;
UPDATE brian.roster1_2018 SET Title='PhD' WHERE roster1_2018_id=215;
UPDATE brian.roster1_2018 SET Title='PhD' WHERE roster1_2018_id=704;
UPDATE brian.roster1_2018 SET Title='PhD' WHERE roster1_2018_id=1616;
UPDATE brian.roster1_2018 SET Title='PhD  ' WHERE roster1_2018_id=504;
UPDATE brian.roster1_2018 SET Title='PhD Student' WHERE roster1_2018_id=497;
UPDATE brian.roster1_2018 SET Title='PhD Student' WHERE roster1_2018_id=183;
UPDATE brian.roster1_2018 SET Title='PhD Student' WHERE roster1_2018_id=968;
UPDATE brian.roster1_2018 SET Title='PhD Student' WHERE roster1_2018_id=719;
UPDATE brian.roster1_2018 SET Title='Physician Assistant Student' WHERE roster1_2018_id=1551;
UPDATE brian.roster1_2018 SET Title='Postdoctoral Associate' WHERE roster1_2018_id=822;
UPDATE brian.roster1_2018 SET Title='Postdoctoral Research Associate' WHERE roster1_2018_id=717;
UPDATE brian.roster1_2018 SET Title='Post-Doctoral Research Fellow' WHERE roster1_2018_id=1198;
UPDATE brian.roster1_2018 SET Title='Professor' WHERE roster1_2018_id=709;
UPDATE brian.roster1_2018 SET Title='Professor and Director' WHERE roster1_2018_id=322;
UPDATE brian.roster1_2018 SET Title='Professor and Director' WHERE roster1_2018_id=343;
UPDATE brian.roster1_2018 SET Title='Professor; Principal Research Scientist' WHERE roster1_2018_id=712;
UPDATE brian.roster1_2018 SET Title='Program Quality Coordinator' WHERE roster1_2018_id=250;
UPDATE brian.roster1_2018 SET Title='Registered Nurse' WHERE roster1_2018_id=1204;
UPDATE brian.roster1_2018 SET Title='Research Assistant' WHERE roster1_2018_id=904;
UPDATE brian.roster1_2018 SET Title='Research Coordinator' WHERE roster1_2018_id=577;
UPDATE brian.roster1_2018 SET Title='Research Coordinator' WHERE roster1_2018_id=693;
UPDATE brian.roster1_2018 SET Title='Research Coordinator' WHERE roster1_2018_id=1437;
UPDATE brian.roster1_2018 SET Title='Research Coordinator' WHERE roster1_2018_id=1042;
UPDATE brian.roster1_2018 SET Title='Research Fellow' WHERE roster1_2018_id=1177;
UPDATE brian.roster1_2018 SET Title='Research Manager' WHERE roster1_2018_id=117;
UPDATE brian.roster1_2018 SET Title='Research Manager' WHERE roster1_2018_id=1174;
UPDATE brian.roster1_2018 SET Title='Research Manager' WHERE roster1_2018_id=1391;
UPDATE brian.roster1_2018 SET Title='Research Manager III' WHERE roster1_2018_id=550;
UPDATE brian.roster1_2018 SET Title='Research Manager III' WHERE roster1_2018_id=635;
UPDATE brian.roster1_2018 SET Title='Resident' WHERE roster1_2018_id=1242;
UPDATE brian.roster1_2018 SET Title='Resident' WHERE roster1_2018_id=1089;
UPDATE brian.roster1_2018 SET Title='Resident' WHERE roster1_2018_id=1482;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=17;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=46;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=52;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=61;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=64;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=76;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=204;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=208;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=211;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=212;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=220;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=233;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=241;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=410;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=499;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=506;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=727;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=732;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=812;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=829;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=854;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=869;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=888;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=896;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=914;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=919;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=923;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=925;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=960;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=977;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1004;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1023;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1092;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1101;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1114;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1119;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1138;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1152;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1154;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1158;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1165;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1166;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1167;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1176;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1178;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1179;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1195;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1202;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1212;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1216;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1251;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1664;
UPDATE brian.roster1_2018 SET Title='Student' WHERE roster1_2018_id=1668;
UPDATE brian.roster1_2018 SET Title='Student ' WHERE roster1_2018_id=948;
UPDATE brian.roster1_2018 SET Title='Undergraduate Research Assistant' WHERE roster1_2018_id=1146;
UPDATE brian.roster1_2018 SET Title='Vice President Finance and Administration' WHERE roster1_2018_id=1650;
UPDATE brian.roster1_2018 SET Title='Vice President of UF Health Shands' WHERE roster1_2018_id=440;

UPDATE brian.roster1_2018 SET Title='Professor' WHERE roster1_2018_id=367;
UPDATE brian.roster1_2018 SET Title='PhD Student ' WHERE roster1_2018_id=708;

UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='BS';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='DNP';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='MD';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='MD, CRC';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='MS, PhD';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='MS, Sr. Biostatistician I';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='MSRP';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='PA-S1';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='PhD';
UPDATE brian.roster1_2018 SET Title='' WHERE TITLE='RN';
UPDATE brian.roster1_2018 SET Title='Clinical Research Manager' WHERE TITLE='MGR, Clinical Research';
UPDATE brian.roster1_2018 SET Title='Coordinator' WHERE TITLE='352Creates Coordinator';
UPDATE brian.roster1_2018 SET Title='Professor' WHERE TITLE='MD, MPH;  Professor';
UPDATE brian.roster1_2018 SET Title='Psychologist' WHERE TITLE='PhD Psychologist';
UPDATE brian.roster1_2018 SET Title='Research Coordinator' WHERE TITLE='RN, Research Coordinator';
UPDATE brian.roster1_2018 SET Title='Yoga Instructor' WHERE TITLE='Yoga Teacher';









##################
SELECT * from lookup.Employees where Name like ("%park%J%");
SELECT * from lookup.ufids where UF_DISPLAY_NM like  ("%park%J%");

SELECT * from lookup.ufids where UF_UFID ="57721301";


########### UPDATE ROSTER ADDITION Q3 2018
Update work.roster_additions SET UFID='43381768' WHERE roster1_2018_id=42;
Update work.roster_additions SET UFID='57004230' WHERE roster1_2018_id=203;
Update work.roster_additions SET UFID='' WHERE roster1_2018_id=367;
Update work.roster_additions SET UFID='00000010' WHERE roster1_2018_id=698;


UPDATE work.roster_additions
SET LastName='Ahmed',
FirstName='Shakeel'
where roster1_2018_id=1460;

     select  roster1_2018_id,PROGRAM,UFID,LastName,FirstName,Department
       from work.roster_additions
       WHERE UFID IN (""," ","0")
         AND Affiliation="" ;



Update work.roster_additions SET Affiliation='UAB' WHERE roster1_2018_id=20;
Update work.roster_additions SET Affiliation='Shands' WHERE roster1_2018_id=119;
Update work.roster_additions SET Affiliation='FIU' WHERE roster1_2018_id=314;
Update work.roster_additions SET Affiliation='Cleveland Clinic' WHERE roster1_2018_id=316;
Update work.roster_additions SET Affiliation='Legacy Health' WHERE roster1_2018_id=317;
Update work.roster_additions SET Affiliation='Cedars-Sinai' WHERE roster1_2018_id=319;
Update work.roster_additions SET Affiliation='NC State' WHERE roster1_2018_id=355;
Update work.roster_additions SET Affiliation='Cedars-Sinai' WHERE roster1_2018_id=356;
Update work.roster_additions SET Affiliation='Novo Nordisk' WHERE roster1_2018_id=382;
Update work.roster_additions SET Affiliation='Procura' WHERE roster1_2018_id=383;
Update work.roster_additions SET Affiliation='FSU' WHERE roster1_2018_id=513;
Update work.roster_additions SET Affiliation='Medstar Health' WHERE roster1_2018_id=1170;
Update work.roster_additions SET Affiliation='UF Proton Therapy' WHERE roster1_2018_id=1360;
Update work.roster_additions SET Affiliation='UF Proton Therapy' WHERE roster1_2018_id=1380;
Update work.roster_additions SET Affiliation='ASU' WHERE roster1_2018_id=1467;

Update work.roster_additions SET Title='Professor' WHERE Title='MD, MPH;  Professor';
Update work.roster_additions SET Title='' WHERE Title='MD, PhD';

Update work.roster_additions SET Title='Information Analyst' WHERE Title='PhD, Information Analyst';
Update work.roster_additions SET Title='Research Data & Analytics Services Manager' WHERE Title='MPH, CCDM, Research Data & Analytics Services Manager';
Update work.roster_additions SET Title='National Clilnical Informatics Executive' WHERE Title='MS, National Clilnical Informatics Executive';
Update work.roster_additions SET Title='Principal Research Scientist' WHERE Title='Professor; Principal Research Scientist';


desc lookup.roster_faculty_classify;

select max(roster_faculty_classify_id2)+1 from lookup.roster_faculty_classify;

ALTER TABLE lookup.roster_faculty_classify MODIFY Title Varchar(80);




SELECT DISTINCT TITLE FROM brian.roster1_2018;

select * from brian.roster1_2018 where Title="352Creates Coordinator";




select 41/count(*) from brian.roster1_2018;

#### SCRATCH
DROP TABLE IF EXISTS work.notitles;
create table work.notitles as 
select Program,roster1_2018_id,LastName,FirstName, email from brian.roster1_2018 where Title="" or Title is NULL;

select roster1_2018_id,count(*) from brian.roster1_2018 group by roster1_2018_id;

######