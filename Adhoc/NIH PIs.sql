DROP TABLE IF EXISTS work.NIHPI1;
create table work.NIHPI1 AS
SELECT CLK_PI_UFID AS UFID
FROM lookup.awards_history
WHERE REPORTING_SPONSOR_NAME LIKE "NATL INST OF HLTH%"
GROUP BY CLK_PI_UFID
UNION ALL
SELECT CLK_AWD_PROJ_MGR_UFID AS UFID
FROM lookup.awards_history
WHERE REPORTING_SPONSOR_NAME LIKE "NATL INST OF HLTH%"
GROUP BY CLK_AWD_PROJ_MGR_UFID;

DROP TABLE IF EXISTS lookup.NIHPIs;
create table lookup.NIHPIs AS
SELECT DISTINCT UFID
FROM work.NIHPI1;


select count(DISTINCT UFID)
from lookup.roster
WHERE UFID IN (select UFID from lookup.NIHPIs);


drop table if exists work.roster;
create table work.roster as
select * from lookup.roster;


ALTER TABLE work.roster ADD NIH_PI int(1),
                        ADD UNDUP_NIH_PI int(1),
                        ADD ALLYEARS_UNDUP_NIH_PI int(1);


SET SQL_SAFE_UPDATES = 0;
UPDATE work.roster SET NIH_PI=0;

UPDATE work.roster
SET NIH_PI=1
WHERE UFID IN (select UFID from lookup.NIHPIs);

#######################################################################################################################
##  COMPUTE    Unduplicated NIH_PI Roster Indicator
#######################################################################################################################
SET SQL_SAFE_UPDATES = 0;

drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Roster_Key,min(rosterid) AS UndupRec
FROM work.roster
WHERE NIH_PI=1
GROUP BY Roster_Key;


UPDATE work.roster SET UNDUP_NIH_PI=0;

UPDATE work.roster SET UNDUP_NIH_PI=1
  WHERE rosterid in (select UndupRec from work.undup_temp);


#######################################################################################################################
##  COMPUTE   AllServed Unduplicated NIH_PI Roster Indicator
#######################################################################################################################

drop table if exists work.undup_temp;


drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Person_key,min(rosterid) AS UndupRec
FROM work.roster
WHERE NIH_PI=1
GROUP BY Person_key; 

UPDATE work.roster SET ALLYEARS_UNDUP_NIH_PI=0;

UPDATE work.roster SET ALLYEARS_UNDUP_NIH_PI=1
  WHERE rosterid in (select UndupRec from work.undup_temp);

################################################################################################################

SELECT YEAR,sum(Undup_ROSTER),sum(UNDUP_NIH_PI) from work.roster group by YEAR;

SELECT sum(ALLYEARS_UNDUP_NIH_PI) from work.roster;


SET SQL_SAFE_UPDATES = 1;


/*
create table loaddata.RosterBackup20170609 AS select * from lookup.roster;
drop table lookup.roster;
create table lookup.roster as select * from work.roster;
*/
