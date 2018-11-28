#######################################################################################################################
##  COMPUTE   Unduplicated Roster Indicator
#######

SET SQL_SAFE_UPDATES = 0;

drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Roster_Key,min(rosterid) AS UndupRec
FROM lookup.roster
WHERE Roster=1
GROUP BY Roster_Key;


UPDATE lookup.roster SET Undup_ROSTER=0;

UPDATE lookup.roster SET Undup_ROSTER=1
WHERE rosterid in (select UndupRec from work.undup_temp);


#######################################################################################################################
##  COMPUTE   AllServed Unduplicated Roster Indicator
#######################################################################################################################

drop table if exists work.undup_temp;


drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Person_key,min(rosterid) AS UndupRec
FROM lookup.roster
WHERE Roster=1
GROUP BY Person_key; 

UPDATE loaddata.roster SET AllYearsUndup=0;
################################################################################################################
## CHECK FILES BEING USED
#######################################################################################################################

UPDATE loaddata.roster SET AllYearsUndup=1
WHERE rosterid in (select UndupRec from work.undup_temp);



#*/
#################################################################################
#### VERIFY 
#################################################################################

SELECT YEAR,SUM(Undup_ROSTER) AS Count
FROM loaddata.roster
group by Year
order by year;

/*
DROP TABLE IF EXISTS lookup.roster;
CREATE TABLE lookup.roster as 
SELECT * from loaddata.roster;
*/

################ create table loaddata.backupRoster20170323 AS SELECT * From lookup.roster;


SELECT YEAR,SUM(Undup_ROSTER) AS Count
FROM lookup.roster
group by Year
order by year;


#################################################################################
#### CREATE ROSTER SUMMARY
#################################################################################


DROP TABLE IF EXISTS results.RosterSummary;
Create table results.RosterSummary AS
SELECT YEAR,
       SUM(Undup_ROSTER) AS RosterUsers,
       SUM(0) AS AllUsers
FROM lookup.roster
group by Year
order by year;

DROP TABLE IF EXISTS work.AllUsers;
Create table work.AllUsers AS
SELECT YEAR,
       COUNT(DISTINCT Person_Key) AS AllUsers
FROM lookup.roster
group by Year
order by year;

SET SQL_SAFE_UPDATES = 0;
UPDATE results.RosterSummary rs, work.AllUsers lu
SET rs.AllUsers=lu.AllUsers
WHERE rs.Year=lu.Year;

select * from results.RosterSummary;

#################################################################################
#### CREATE PROGRAM REPORT
#################################################################################

drop table if Exists work.ProgTable;
CREATE TABLE work.ProgTable AS
SELECT DISTINCT STD_PROGRAM AS Program
FROM lookup.roster;

ALTER TABLE work.ProgTable
ADD Users_2009 integer(5),
ADD Users_2010 integer(5),
ADD Users_2011 integer(5),
ADD Users_2012 integer(5),
ADD Users_2013 integer(5),
ADD Users_2014 integer(5),
ADD Users_2015 integer(5),
ADD Users_2016 integer(5),
ADD Roster_Users_2009 integer(5),
ADD Roster_Users_2010 integer(5),
ADD Roster_Users_2011 integer(5),
ADD Roster_Users_2012 integer(5),
ADD Roster_Users_2013 integer(5),
ADD Roster_Users_2014 integer(5),
ADD Roster_Users_2015 integer(5),
ADD Roster_Users_2016 integer(5);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.ProgTable
SET Users_2009=0,
    Users_2010=0,
    Users_2011=0,
    Users_2012=0,
    Users_2013=0,
    Users_2014=0,
    Users_2015=0,
    Users_2016=0,
    Roster_Users_2009=0,
    Roster_Users_2010=0,
    Roster_Users_2011=0,
    Roster_Users_2012=0,
    Roster_Users_2013=0,
    Roster_Users_2014=0,
    Roster_Users_2015=0,
    Roster_Users_2016=0;


DROP TABLE IF EXISTS work.progusers;
create table work.progusers AS
select Year,STD_PROGRAM,count(distinct Person_key) AS UndupUsers
from lookup.roster
group by Year,STD_PROGRAM;

DROP TABLE IF EXISTS work.progroster;
create table work.progroster AS
select Year,STD_PROGRAM,count(distinct Person_key) AS UndupRoster
from lookup.roster
where Roster=1
group by Year,STD_PROGRAM;


UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2009=UndupUsers WHERE lu.Year=2009 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2010=UndupUsers WHERE lu.Year=2010 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2011=UndupUsers WHERE lu.Year=2011 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2012=UndupUsers WHERE lu.Year=2012 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2013=UndupUsers WHERE lu.Year=2013 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2014=UndupUsers WHERE lu.Year=2014 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2015=UndupUsers WHERE lu.Year=2015 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progusers lu SET pt.Users_2016=UndupUsers WHERE lu.Year=2016 AND pt.Program=lu.STD_PROGRAM;


UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2009=UndupRoster WHERE lu.Year=2009 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2010=UndupRoster WHERE lu.Year=2010 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2011=UndupRoster WHERE lu.Year=2011 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2012=UndupRoster WHERE lu.Year=2012 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2013=UndupRoster WHERE lu.Year=2013 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2014=UndupRoster WHERE lu.Year=2014 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2015=UndupRoster WHERE lu.Year=2015 AND pt.Program=lu.STD_PROGRAM;
UPDATE work.ProgTable pt, work.progroster lu SET pt.Roster_Users_2016=UndupRoster WHERE lu.Year=2016 AND pt.Program=lu.STD_PROGRAM;


select * from work.ProgTable;

Drop table if exists results.RosterProgramTable;
CREATE Table results.RosterProgramTable AS
select * from work.ProgTable;

SELECT Program,
Roster_Users_2009,
Roster_Users_2010,
Roster_Users_2011,
Roster_Users_2012,
Roster_Users_2013,
Roster_Users_2014,
Roster_Users_2015,
Roster_Users_2016
from  work.ProgTable;


#################################################################################
#### CREATE Pubmed Usage Report
#################################################################################


drop table if exists results.rosterPubmed;
create table results.rosterPubmed as
select Year,
       count(*) AS Total_Records,
	   count(distinct Person_key) AS Num_People
from  lookup.roster
group by Year;

ALTER TABLE results.rosterPubmed ADD Num_Roster integer(10),
                                 ADD Num_Pubmed_Records integer(10),
					             ADD Num_Pubmed_People integer(10),
                                 ADD Num_People_pubmed_only integer(10);


DROP TABLE IF EXISTS work.t25;
create table work.t25 AS
select Year,sum(Undup_ROSTER) AS UndupRosterSum    
from lookup.roster
where Roster=1
group by Year;


UPDATE results.rosterPubmed pm, work.t25 lu
SET pm.Num_Roster=lu.UndupRosterSum  
WHERE pm.Year=lu.Year;


drop table if exists work.t2;
create table work.t2 AS
select Year,
       count(*) AS Num_Pubmed_Records
FROM lookup.roster
where STD_PROGRAM="PubMed Compliance"
group by Year;

drop table if exists work.t3;
create table work.t3 AS
select Year,
       count(DISTINCT Person_key) AS Num_Pubmed_People 
FROM lookup.roster
where STD_PROGRAM="PubMed Compliance"
group by Year;



drop table if exists work.t4;
create table work.t4 as
select 2008 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2008
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2008 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2009 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2009
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2009 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2010 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2010
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2010 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2011 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2011
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2011 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2012 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2012
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2012 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2013 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2013
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2013 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2014 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2014
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2014 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2015 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2015
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2015 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2016 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2016
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2016 AND STD_PROGRAM<>"PubMed Compliance");

select * from  work.t4;







UPDATE results.rosterPubmed rp, work.t2 lu
SET rp.Num_Pubmed_Records=lu.Num_Pubmed_Records
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t3 lu
SET rp.Num_Pubmed_People=lu.Num_Pubmed_People
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t3 lu
SET rp.Num_Pubmed_People=lu.Num_Pubmed_People
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t4 lu
SET rp.Num_People_pubmed_only=lu.Num_People_pubmed_only
WHERE rp.Year=lu.Year;


select * from results.rosterPubmed order by Year;
#############################################################################
SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) FROM lookup.roster where Roster=1 and Year>2014 group by STD_PROGRAM;

SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) FROM lookup.roster where Year>2014 group by STD_PROGRAM;


#################################################################################
#### ALL YEARS PROGRAM SUMMARY
#################################################################################  ALL YEARS PROGRAM SUMMARY

drop table if Exists work.roster_all_undup;
Create table work.roster_all_undup  AS
SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) AS Other_Users FROM lookup.roster Where Roster= 0 group by STD_PROGRAM;


drop table if Exists work.roster_user_summ;
Create table work.roster_user_summ AS
SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) AS Roster_Users FROM lookup.roster Where Roster=1 group by STD_PROGRAM;



ALTER TABLE work.roster_user_summ ADD Other_Users bigint(21);

UPDATE work.roster_user_summ us, work.roster_all_undup lu
SET us.Other_Users=lu.Other_Users
WHERE us.STD_PROGRAM=lu.STD_Program;

SELECT * from work.roster_user_summ;


#################################################################################
#### 2015-2016 Program Summary
#################################################################################

#
drop table if Exists work.roster_all_undup;
Create table work.roster_all_undup  AS
SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) AS Other_Users FROM lookup.roster Where Roster= 0 AND Year in (2015,2016) group by STD_PROGRAM;


drop table if Exists work.roster_user_summ;
Create table work.roster_user_summ AS
SELECT STD_PROGRAM, COUNT(DISTINCT Person_Key) AS Roster_Users FROM lookup.roster Where Roster=1 AND Year in (2015,2016) group by STD_PROGRAM;



ALTER TABLE work.roster_user_summ ADD Other_Users bigint(21);

UPDATE work.roster_user_summ us, work.roster_all_undup lu
SET us.Other_Users=lu.Other_Users
WHERE us.STD_PROGRAM=lu.STD_Program;

SELECT * from work.roster_user_summ;

#######################################################################################################################
######### UNDEFINED PROGRAMS
#######################################################################################################################

select Year,STD_PROGRAM,ORIG_PROGRAM,count(*) from lookup.roster where STD_PROGRAM="UNDEFINED" group by Year,STD_PROGRAM,ORIG_PROGRAM ;

#######################################################################################################################
######### TOP SERVICES
#######################################################################################################################

drop table if exists work.topSVC ;
create table work.topSVC AS
Select * from lookup.roster
WHERE STD_PROGRAM IN 
('PubMed Compliance',
'Regulatory Assistance',
'BERD',
'Intergrated Data Repository',
'REDCap',
'Clinical Research Center',
'One Florida',
'Biorepository',
'Metabolomics');



drop table if exists work.topsvclist;
create table work.topsvclist as
SELECT Year,
       STD_PROGRAM,
       COUNT(DISTINCT Person_key) AS UNDUP
FROM work.topSVC
WHERE Roster=1
GROUP BY Year, STD_PROGRAM; 


DROP TABLE IF EXISTS results.roster_top_programs;
CREATE table results.roster_top_programs AS
SELECT Distinct STD_PROGRAM AS PROGRAM 
FROM work.topSVC;

ALTER TABLE results.roster_top_programs
ADD CY2009 int(10),
ADD CY2010 int(10),
ADD CY2011 int(10),
ADD CY2012 int(10),
ADD CY2013 int(10),
ADD CY2014 int(10),
ADD CY2015 int(10),
ADD CY2016 int(10);

UPDATE results.roster_top_programs
SET CY2009=0,
    CY2010=0,
    CY2011=0,
    CY2012=0,
    CY2013=0,
    CY2014=0,
    CY2015=0,
    CY2016=0;




UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2009=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2009;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2010=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2010;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2011=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2011;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2012=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2012;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2013=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2013;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2014=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2014;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2015=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2015;
UPDATE results.roster_top_programs tp, work.topsvclist lu SET tp.CY2016=lu.UNDUP WHERE tp.PROGRAM=lu.STD_PROGRAM AND lu.Year=2016;

select * from results.roster_top_programs;



#######################################################################################################################
######### Program USERS
#######################################################################################################################


drop table if exists results.ProgramUsers;
create table results.ProgramUsers
SELECT Person_key,LastName,FirstName
from lookup.roster
WHERE STD_PROGRAM='Clinical Research Center'
group by Person_key,LastName,FirstName;




ALTER TABLE results.ProgramUsers
ADD CY2009 int(10),
ADD CY2010 int(10),
ADD CY2011 int(10),
ADD CY2012 int(10),
ADD CY2013 int(10),
ADD CY2014 int(10),
ADD CY2015 int(10),
ADD CY2016 int(10);

UPDATE results.ProgramUsers
SET CY2009=0,
    CY2010=0,
    CY2011=0,
    CY2012=0,
    CY2013=0,
    CY2014=0,
    CY2015=0,
    CY2016=0;

UPDATE results.ProgramUsers SET CY2009=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2009 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2010=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2010 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2011=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2011 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2012=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2012 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2013=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2013 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2014=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2014 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2015=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2015 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2016=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2016 AND STD_PROGRAM='Clinical Research Center');


select * from results.ProgramUsers;


###########################################################################################################################
###########################################################################################################################
## PROGRAM INVESTIGATORS

drop table if exists work.program_use;
create table work.program_use AS
SELECT DISTINCT STD_PROGRAM FROM lookup.roster;

ALTER TABLE work.program_use
ADD Inv2009 int(10),
ADD Inv2010 int(10),
ADD Inv2011 int(10),
ADD Inv2012 int(10),
ADD Inv2013 int(10),
ADD Inv2014 int(10),
ADD Inv2015 int(10),
ADD Inv2016 int(10),
ADD Inv2017 int(10);

drop table if exists work.program_count;
create table work.program_count AS
SELECT Year,
       STD_PROGRAM,
	   Count(Distinct Person_Key) AS UNDUP
from lookup.roster
WHERE Roster=1
GROUP BY Year, STD_PROGRAM;

SET SQL_SAFE_UPDATES = 0;


UPDATE work.program_use pu, work.program_count lu SET pu.Inv2009=lu.UNDUP WHERE lu.Year=2009 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2010=lu.UNDUP WHERE lu.Year=2010 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2011=lu.UNDUP WHERE lu.Year=2011 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2012=lu.UNDUP WHERE lu.Year=2012 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2013=lu.UNDUP WHERE lu.Year=2013 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2014=lu.UNDUP WHERE lu.Year=2014 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2015=lu.UNDUP WHERE lu.Year=2015 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2016=lu.UNDUP WHERE lu.Year=2016 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
UPDATE work.program_use pu, work.program_count lu SET pu.Inv2017=lu.UNDUP WHERE lu.Year=2017 AND pu.STD_PROGRAM=lu.STD_PROGRAM;
 

SET SQL_SAFE_UPDATES = 1;

select * from work.program_use;


##################################################################################
##################################################################################
##################################################################################
######################### SCRATCH AREA BELOW
##################################################################################
##################################################################################
##################################################################################

/*
## drop table loaddata.roster;
## create table loaddata.roster as
## select * from lookup.roster;
*/




Select count(DISTINCT Person_key) 
from lookup.roster
where roster=0
AND Person_Key in (select distinct Person_key from lookup.roster where roster=1);


Select Year,count(DISTINCT Person_key) 
from lookup.roster
where roster=0
AND Person_Key in (select distinct Person_key from lookup.roster where roster=1)
AND Affiliation<>"Staff"
GROUP BY Year;

Select * 
from lookup.roster
where roster=0
AND Person_Key in (select distinct Person_key from lookup.roster where roster=1)
GROUP BY Year;


create table work.rostercheck1516 AS
Select count(*)
from lookup.roster
where roster=0
AND Person_Key in (select distinct Person_key from lookup.roster where roster=1)
AND Affiliation<>"Staff"
AND Year in (2015,2016);
;


select distinct Title from lookup.titles_for_roster where Roster=0;


UPDATE lookup.roster SET Roster=0 Where rosterid IN (Select distinct rosterid from work.xxxadj2015);

UPDATE loaddata.roster SET Roster=0 Where rosterid IN (Select distinct rosterid from work.xxxadj2015);

##################create table loaddata.rosterloadbu20170324 AS select * from loaddata.roster;


### drop table if exists loaddata.roster;
###create table loaddata.roster as select * from lookup.roster;
###

############### CRC?

SELECT Year,COUNT(DISTINCT Person_key) 
from lookup.roster
Where STD_PROGRAM='Clinical Research Center'
AND Roster=0
group by Year;


select *
from lookup.roster
where STD_PROGRAM='Clinical Research Center'
  AND Year=2015
  AND Person_key not in (select distinct Person_key 
                         from lookup.roster 
                          where STD_PROGRAM='Clinical Research Center'
                          AND Year=2016); 

select count(distinct Person_key) 
from lookup.roster
where STD_PROGRAM='Clinical Research Center'
  AND Year=2014
  AND Person_key not in (select distinct Person_key 
                         from lookup.roster 
                          where STD_PROGRAM='Clinical Research Center'
                          AND Year=2015); 



#######################################################################################################################
######### Program USERS
#######################################################################################################################


drop table if exists results.ProgramUsers;
create table results.ProgramUsers
SELECT Person_key,LastName,FirstName
from lookup.roster
WHERE STD_PROGRAM='Clinical Research Center'
group by Person_key,LastName,FirstName;




ALTER TABLE results.ProgramUsers
ADD CY2009 int(10),
ADD CY2010 int(10),
ADD CY2011 int(10),
ADD CY2012 int(10),
ADD CY2013 int(10),
ADD CY2014 int(10),
ADD CY2015 int(10),
ADD CY2016 int(10);

UPDATE results.ProgramUsers
SET CY2009=0,
    CY2010=0,
    CY2011=0,
    CY2012=0,
    CY2013=0,
    CY2014=0,
    CY2015=0,
    CY2016=0;

UPDATE results.ProgramUsers SET CY2009=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2009 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2010=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2010 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2011=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2011 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2012=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2012 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2013=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2013 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2014=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2014 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2015=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2015 AND STD_PROGRAM='Clinical Research Center');
UPDATE results.ProgramUsers SET CY2016=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2016 AND STD_PROGRAM='Clinical Research Center');


select * from results.ProgramUsers;

####################################################################
############  ROSTER CODING
####################################################################
drop table if exists results.Roster_coding;
create table results.Roster_coding AS
SELECT Person_key,max(LastName) AS LastName,MAx(FirstName) As First
from lookup.roster
group by Person_key;


ALTER TABLE results.Roster_coding
ADD CY2009 int(10),
ADD CY2010 int(10),
ADD CY2011 int(10),
ADD CY2012 int(10),
ADD CY2013 int(10),
ADD CY2014 int(10),
ADD CY2015 int(10),
ADD CY2016 int(10);


SET SQL_SAFE_UPDATES = 0;
/*
UPDATE results.Roster_coding
SET CY2009=0,
    CY2010=0,
    CY2011=0,
    CY2012=0,
    CY2013=0,
    CY2014=0,
    CY2015=0,
    CY2016=0;
*/

##CREATE INDEX Person_key ON lookup.roster (Person_key);

UPDATE results.Roster_coding SET CY2009=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2009);
UPDATE results.Roster_coding SET CY2010=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2010);
UPDATE results.Roster_coding SET CY2011=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2011);
UPDATE results.Roster_coding SET CY2012=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2012);
UPDATE results.Roster_coding SET CY2013=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2013);
UPDATE results.Roster_coding SET CY2014=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2014);
UPDATE results.Roster_coding SET CY2015=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2015);
UPDATE results.Roster_coding SET CY2016=0 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2016);




UPDATE results.Roster_coding SET CY2009=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2009 AND Roster=1);
UPDATE results.Roster_coding SET CY2010=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2010 AND Roster=1);
UPDATE results.Roster_coding SET CY2011=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2011 AND Roster=1);
UPDATE results.Roster_coding SET CY2012=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2012 AND Roster=1);
UPDATE results.Roster_coding SET CY2013=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2013 AND Roster=1);
UPDATE results.Roster_coding SET CY2014=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2014 AND Roster=1);
UPDATE results.Roster_coding SET CY2015=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2015 AND Roster=1);
UPDATE results.Roster_coding SET CY2016=1 WHERE Person_key IN (Select Distinct Person_key from lookup.roster where Year= 2016 AND Roster=1);



##############################################################
###### SCRATCH
##############################################################

drop table if Exists work.temp;
create table work.temp AS
Select Distinct Person_key from loaddata.roster
Where Year=2016
and roster=0
and Person_key in (select distinct Person_key from loaddata.roster where Year=2015 and Roster=1);


UPDATE loaddata.roster Set Roster=1
WHERE Year=2016
AND Roster=0
AND Person_key IN (select distinct Person_key from work.temp);


drop table if Exists work.temp;
create table work.temp AS
Select Distinct Person_key from loaddata.roster
Where Year=2015
and roster=0
and Person_key in (select distinct Person_key from loaddata.roster where Year=2016 and Roster=1);

select Person_key,STD_PROGRAM,LastName,FirstName,Title,max(Roster) 
from loaddata.roster
WHERE Year=2015
AND roster=0
AND Person_key IN (select distinct Person_key from work.temp)
GROUP BY Person_key,STD_PROGRAM,LastName,FirstName,Title;


drop table if exists work.test;
create table test 
(Program varchar (255) NOT NULL,
 Year int(4) NOT NULL)
; 

INSERT INTO work.test
       (Program,Year)
VALUES
       ("Program1",2001),
       ("Program2",2002),
       ("Program3",2003);

SELECT * from work.test;

select tablespace_name, table_name from all_tables;