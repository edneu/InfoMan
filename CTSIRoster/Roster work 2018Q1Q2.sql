


create table brian.backup_q1q22018 as
select * from work.roster2018q1q2;


select * from work.roster2018q1q2;

select count(distinct UFID) from work.roster2018q1q2;

select count(*) from work.roster2018q1q2 WHERE UFID IN (""," ","0");


select distinct UFID from work.roster2018q1q2;


SET SQL_SAFE_UPDATES = 0;

CREATE INDEX rt1 ON work.roster2018q1q2 (UFID);
CREATE INDEX ea1 ON loaddata.EmpAccrued (Employee_ID);

UPDATE work.roster2018q1q2 rt, loaddata.EmpAccrued lu
SET rt.Title=lu.Job_Code,
    rt.DepartmentID=lu.Department_Code,
    rt.Department=lu.Department
WHERE rt.UFID=lu.Employee_ID;


UPDATE work.roster2018q1q2 SET Roster=0;

UPDATE work.roster2018q1q2 rt, loaddata.EmpAccrued lu
SET Roster=1
WHERE rt.UFID=lu.Employee_ID
  AND lu.Salary_Plan IN ('OPS Faculty - 12 Month',
						 'OPS Faculty - 9 Month',
						 'OPS Faculty - Summer',
						 'Courtesy Faculty Appointments',
						 'Salaried Faculty - 10 Month',
						 'Salaried Faculty - 12 Month',
						 'Salaried Faculty - 9 Month',
						 'Salaried Faculty - Summer',
						 'COM Clinical Faculty 12');




UPDATE work.roster2018q1q2 
SET Lastname=ltrim(rtrim(Lastname)),
	Firstname=ltrim(rtrim(Firstname)),
	email=ltrim(rtrim(email)),
	EraCommons=ltrim(rtrim(EraCommons)),
	UserName=ltrim(rtrim(UserName));



UPDATE work.roster2018q1q2 SET Affiliation='BCM' WHERE EMAIL='echiao@bcm.edu';
UPDATE work.roster2018q1q2 SET Affiliation='BONDCHC' WHERE EMAIL='trobinson@bondchc.com';
UPDATE work.roster2018q1q2 SET Affiliation='CSHS' WHERE EMAIL='Michael.Elliot@cshs.org';
UPDATE work.roster2018q1q2 SET Affiliation='CSHS' WHERE EMAIL='Michael.Elliott@cshs.org';
UPDATE work.roster2018q1q2 SET Affiliation='FAU' WHERE EMAIL='jkrasnoff@health.fau.edu';
UPDATE work.roster2018q1q2 SET Affiliation='FIU' WHERE EMAIL='adjouadi@fiu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='HEALTH' WHERE EMAIL='crodrig3@health.usf.edu';
UPDATE work.roster2018q1q2 SET Affiliation='HIMSS' WHERE EMAIL='aculbertson@himss.org';
UPDATE work.roster2018q1q2 SET Affiliation='JHU' WHERE EMAIL='ahackman@jhu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='KUMC' WHERE EMAIL='shunt@kumc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='MSMC' WHERE EMAIL='Barbara.Mcmanus@msmc.com';
UPDATE work.roster2018q1q2 SET Affiliation='MSMC' WHERE EMAIL='Barbara.Mcmanus@msmc.com';
UPDATE work.roster2018q1q2 SET Affiliation='MSMC' WHERE EMAIL='andrea.ollarves@msmc.com';
UPDATE work.roster2018q1q2 SET Affiliation='MSMC' WHERE EMAIL='Mike.Plitnikas@msmc.com';
UPDATE work.roster2018q1q2 SET Affiliation='NCSU' WHERE EMAIL='jlgaskin@ncsu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='NORTHWESTERN' WHERE EMAIL='courtney.scherr@northwestern.edu';
UPDATE work.roster2018q1q2 SET Affiliation='NYU' WHERE EMAIL='jaym01@med.nyu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='NYU' WHERE EMAIL='joneyw@shands.ufl.edu';
UPDATE work.roster2018q1q2 SET Affiliation='NYUMC' WHERE EMAIL='LauraBalcer@nyumc.org';
UPDATE work.roster2018q1q2 SET Affiliation='ODU' WHERE EMAIL='kypark@odu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='RUTGERS' WHERE EMAIL='egill@rci.rutgers.edu';
UPDATE work.roster2018q1q2 SET Affiliation='RUTGERS' WHERE EMAIL='agunduz@bme.ufl.edu';
UPDATE work.roster2018q1q2 SET Affiliation='SHANDS' WHERE EMAIL='PARKAT@shands.ufl.edu';
UPDATE work.roster2018q1q2 SET Affiliation='SINOPEC' WHERE EMAIL='zoub.qday@sinopec.com';
UPDATE work.roster2018q1q2 SET Affiliation='UABMC' WHERE EMAIL='twbuford@uabmc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UAMS' WHERE EMAIL='perrytamarat@uams.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UCDENVER' WHERE EMAIL='Linda.Carlin@ucdenver.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UFL' WHERE EMAIL='mperri@ufl.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UGA' WHERE EMAIL='folate@uga.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UMCES' WHERE EMAIL='kkline@umces.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UMK' WHERE EMAIL='joanna.sikora@cm.umk.pl';
UPDATE work.roster2018q1q2 SET Affiliation='UMN' WHERE EMAIL='abegnaud@umn.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='ccha0005@shands.ufl.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='gfay@email.unc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='leahf@unc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='mfried@med.unc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='USF' WHERE EMAIL='andre.rogatko@cshs.org';
UPDATE work.roster2018q1q2 SET Affiliation='USF' WHERE EMAIL='mrowe1@health.usf.edu';
UPDATE work.roster2018q1q2 SET Affiliation='VA' WHERE EMAIL='christine.conover@va.gov';
UPDATE work.roster2018q1q2 SET Affiliation='VANDERBILT' WHERE EMAIL='brenda.l.minor@Vanderbilt.Edu';
UPDATE work.roster2018q1q2 SET Affiliation='VSU' WHERE EMAIL='LKeen@vsu.edu';
UPDATE work.roster2018q1q2 SET Affiliation='VUMC' WHERE EMAIL='brenda.l.minor@vumc.org';

UPDATE work.roster2018q1q2 SET Affiliation='Miami' WHERE EMAIL='mcampos1@umail.miami.edu';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='1988cai@163.com';
UPDATE work.roster2018q1q2 SET Affiliation='UNC' WHERE EMAIL='paulrich@neurology.unc.edu';
UPDATE work.roster2018q1q2 SET Affiliation='VUMC' WHERE EMAIL='laura.mcleod@vumc.org';



UPDATE work.roster2018q1q2 SET Year=2018;




select 	LastName,
		FirstName,
		email,
		Title,
		Affiliation
from work.roster2018q1q2
WHERE UFID IN (""," ","0")
GROUP BY LastName,
		FirstName,
		email,
		Title,
		Affiliation;

drop table work.affcheck;
create table work.affcheck AS
select  LastName,
		FirstName,
		email,
		Title,
		Affiliation
from work.roster2018q1q2
WHERE UFID IN (""," ","0")
  AND Affiliation="" 
GROUP BY LastName,
		FirstName,
		email,
		Title,
		Affiliation;

drop table work.affcheck;
create table work.affcheck AS
select  *
from work.roster2018q1q2
WHERE UFID IN (""," ","0")
  AND Affiliation="" ;


create table brian.roster2018q1q2 AS
SELECT * from work.roster2018q1q2
WHERE roster2018q1q2_id in (3458,
3648,
3658,
3702);





select Year,count(distinct Person_key) from lookup.roster where STD_Program="RedCap" group by Year
UNION ALL
select Year,count(distinct UFID) from work.roster2018q1q2 where STD_Program="RedCap" group by Year;


select STD_PROGRAM,count(*) from work.roster2018q1q2 group by STD_PROGRAM;

select STD_PROGRAM,count(DISTINCT PERSON_KEY) from lookup.roster where YEar=2017 group by STD_PROGRAM;

select * from work.roster2018q1q2 where UFID="";

SET SQL_SAFE_UPDATES = 0;
UPDATE work.roster2018q1q2 SET UFID='86306684' where roster2018q1q2_id=150;
SET SQL_SAFE_UPDATES = 1;

select roster1_2018_id,count(*) from work.roster2018q1q2 group by roster1_2018_id;

ALTER TABLE work.roster2018q1q2 DROP COLUMN roster1_2018_id;


drop table work.affcheck;
create table work.affcheck AS
select  *
from work.roster2018q1q2
WHERE UFID IN (""," ","0")
  AND Affiliation="" ;


UPDATE work.roster2018q1q2 SET FirstName='Kris', email='kris.kowdley@swedish.org', Affiliation='Swedish Medical Group' WHERE roster2018q1q2_id=29;
UPDATE work.roster2018q1q2 SET FirstName='Lynn', email='LASIMPSON@PARTNERS.ORG', Affiliation='The Harvard Clilnical and Translational Science Center' WHERE roster2018q1q2_id=76;
UPDATE work.roster2018q1q2 SET FirstName='Lynn', email='LASIMPSON@PARTNERS.ORG', Affiliation='The Harvard Clilnical and Translational Science Center' WHERE roster2018q1q2_id=108;
UPDATE work.roster2018q1q2 SET FirstName='Pamela', email='speakingofpamela@gmail.com', Affiliation='All Wellness Network' WHERE roster2018q1q2_id=1278;
UPDATE work.roster2018q1q2 SET FirstName='Janelle', email='janelle.allen@cchmc.org', Affiliation='' WHERE roster2018q1q2_id=3392;
UPDATE work.roster2018q1q2 SET FirstName='Shawn', email='Discoverypathwaysprogram@ufl.edu', Affiliation='' WHERE roster2018q1q2_id=3413;
UPDATE work.roster2018q1q2 SET FirstName='Theresa', email='theresa.jasion@duke.edu', Affiliation='Duke University' WHERE roster2018q1q2_id=3415;
UPDATE work.roster2018q1q2 SET FirstName='Emery', email='', Affiliation='Self Regional Healthcare; Greenwood SC' WHERE roster2018q1q2_id=3420;
UPDATE work.roster2018q1q2 SET FirstName='Andrew', email='', Affiliation='Cleveland Clinic Foundation' WHERE roster2018q1q2_id=3422;
UPDATE work.roster2018q1q2 SET FirstName='Mary', email='mary.larkin@open.ac.uk', Affiliation='The Open University' WHERE roster2018q1q2_id=3454;
UPDATE work.roster2018q1q2 SET FirstName='Jesse', email='jesse.hickerson@duke.edu', Affiliation='Duke University' WHERE roster2018q1q2_id=3455;


UPDATE work.roster2018q1q2 SET Affiliation='Non-UF' WHERE roster2018q1q2_id=2120;
UPDATE work.roster2018q1q2 SET Affiliation='Non-UF' WHERE roster2018q1q2_id=2128;
UPDATE work.roster2018q1q2 SET Affiliation='Non-UF' WHERE roster2018q1q2_id=2129;
UPDATE work.roster2018q1q2 SET Affiliation='Non-UF' WHERE roster2018q1q2_id=3212;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=489;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=636;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=688;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=691;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=710;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=1757;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=1758;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=1759;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2698;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2715;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2753;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2756;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2871;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2872;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=2876;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3180;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3413;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3456;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3648;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3658;
UPDATE work.roster2018q1q2 SET Affiliation='UF' WHERE roster2018q1q2_id=3702;

UPDATE work.roster2018q1q2 SET Affiliation='Howes Academy' WHERE roster2018q1q2_id=3388;
UPDATE work.roster2018q1q2 SET Affiliation='IACTC - Pediatric Clinical Trials' WHERE roster2018q1q2_id=3392;
UPDATE work.roster2018q1q2 SET Affiliation='Cmed Research' WHERE roster2018q1q2_id=3404;
UPDATE work.roster2018q1q2 SET Affiliation='Thermofisher' WHERE roster2018q1q2_id=3407;
UPDATE work.roster2018q1q2 SET Affiliation='Cosmed' WHERE roster2018q1q2_id=3411;
UPDATE work.roster2018q1q2 SET Affiliation='Biofrontera' WHERE roster2018q1q2_id=3438;
UPDATE work.roster2018q1q2 SET Affiliation='Marketing Systems Group' WHERE roster2018q1q2_id=3446;
UPDATE work.roster2018q1q2 SET Affiliation='Cato' WHERE roster2018q1q2_id=3458;

