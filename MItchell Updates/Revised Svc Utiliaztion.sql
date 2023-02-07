#############  2019-2022
DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program,UserClass;





select max(length(UserClass)) from work.userprogram;


DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Distinct Rept_Program as Rept_Program
FROM work.userprogram;

DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program;

ALTER TABLE work.ProgUsersOut
ADD UF_Faculty int(10),
ADD UF_Trainees int(10),
ADD UF_OtherReschPro int(10),
ADD Undup int(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.ProgUsersOut
SET UF_Faculty=0,
	UF_Trainees=0,
	UF_OtherReschPro=0,
    Undup=0;
	

UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Faculty=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Trainees=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_OtherReschPro=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals';

UPDATE work.ProgUsersOut po, work.ProgUsersUndup lu SET po.UNDUP=lu.nUNDUP where po.Rept_Program=lu.Rept_Program ;

drop table if Exists work.proguserout;
create table work.proguserout as 
SELECT * from work.ProgUsersOut ORDER BY Undup DESC;
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## BY YEar 2019-2022

###   Create lookup table by Year
DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Year,Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Year,Rept_Program,UserClass;

## Initializae Master Report Table
DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Distinct Rept_Program as Rept_Program
FROM work.userprogram;

# Create Undup counts by service and Year
DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Year,Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Year,Rept_Program;

ALTER TABLE work.ProgUsersOut
ADD UF_Faculty_19 int(10),
ADD UF_Trainees_19 int(10),
ADD UF_OtherReschPro_19 int(10),

ADD UF_Faculty_20 int(10),
ADD UF_Trainees_20 int(10),
ADD UF_OtherReschPro_20 int(10),

ADD UF_Faculty_21 int(10),
ADD UF_Trainees_21 int(10),
ADD UF_OtherReschPro_21 int(10),

ADD UF_Faculty_22 int(10),
ADD UF_Trainees_22 int(10),
ADD UF_OtherReschPro_22 int(10),

ADD Undup int(10);

SET SQL_SAFE_UPDATES = 0;




UPDATE work.ProgUsersOut
SET  UF_Faculty_19=0,
     UF_Trainees_19=0,
     UF_OtherReschPro_19=0,

     UF_Faculty_20=0,
     UF_Trainees_20=0,
     UF_OtherReschPro_20=0,

     UF_Faculty_21=0,
     UF_Trainees_21=0,
     UF_OtherReschPro_21=0,

     UF_Faculty_22=0,
     UF_Trainees_22=0,
     UF_OtherReschPro_22=0,
	 Undup=0	;
	

UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Faculty_19=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty' AND lu.Year=2019;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Trainees_19=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee' AND lu.Year=2019;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_OtherReschPro_19=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals' AND lu.Year=2019;

UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Faculty_20=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty' AND lu.Year=2020;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Trainees_20=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee' AND lu.Year=2020;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_OtherReschPro_20=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals' AND lu.Year=2020;

UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Faculty_21=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty' AND lu.Year=2021;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Trainees_21=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee' AND lu.Year=2021;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_OtherReschPro_21=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals' AND lu.Year=2021;

UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Faculty_22=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty' AND lu.Year=2022;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Trainees_22=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee' AND lu.Year=2022;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_OtherReschPro_22=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals' AND lu.Year=2022;




UPDATE work.ProgUsersOut po, work.ProgUsersUndup lu SET po.UNDUP=lu.nUNDUP where po.Rept_Program=lu.Rept_Program ;

drop table if Exists work.proguserout;
create table work.proguserout as 
SELECT * from work.ProgUsersOut ORDER BY Undup DESC;
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
## BY YEar 2019-2022  Witgh YEar Column Format


###   Create lookup table by Year
DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Year,Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Year,Rept_Program,UserClass;

## Initializae Master Report Table
DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Year, Rept_Program 
FROM work.userprogram
GROUP BY Year, Rept_Program;

# Create Undup counts by service and Year
DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE Year>=2019
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program;

ALTER TABLE work.ProgUsersOut
ADD UF_Faculty int(10),
ADD UF_Trainees int(10),
ADD UF_OtherReschPro int(10),

ADD Undup int(10);

SET SQL_SAFE_UPDATES = 0;




UPDATE work.ProgUsersOut
SET  UF_Faculty=0,
     UF_Trainees=0,
     UF_OtherReschPro=0,
	 Undup=0	;
	

UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Faculty=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty' AND po.Year=lu.Year;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_Trainees=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee' AND po.Year=lu.Year;
UPDATE work.ProgUsersOut po, work.userprogram lu SET UF_OtherReschPro=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals' AND po.Year=lu.Year;





UPDATE work.ProgUsersOut po, work.ProgUsersUndup lu SET po.UNDUP=lu.nUNDUP where po.Rept_Program=lu.Rept_Program ;

drop table if Exists work.proguserout_FMT2;
create table work.proguserout_FMT2 as 
SELECT * from work.ProgUsersOut ORDER BY Undup DESC, Year ;
#######################################################################################
#######################################################################################




