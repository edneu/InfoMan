

create table loaddata.backuproster20190627 as select * from lookup.roster;

###################################################  2013
drop table if exists work.addto2013;
create table work.addto2013 as
select * from lookup.roster
WHERE STD_PROGRAM="BERD"
AND YEAR IN (2014,2012)
AND UFID NOT IN (select distinct UFID from lookup.roster
                   WHERE STD_PROGRAM="BERD" AND YEAR=2013)
AND UFID<>""
AND Faculty="Faculty"
ORDER BY UFID
;



UPDATE work.addto2013 SET Year=2013;

  SET SQL_SAFE_UPDATES = 0;
     UPDATE work.addto2013
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.addto2013
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;

select max(rosterid) from lookup.roster;

## ASSIGN ROSTER IDs WHEN ALL RECORDS ADDED

     SET SQL_SAFE_UPDATES = 0;
      UPDATE work.addto2013 SET rosterid = 0 ;
      SELECT @i:=(select max(rosterid) from lookup.roster);
      UPDATE work.addto2013 SET rosterid = @i:=@i+1;
     SET SQL_SAFE_UPDATES = 1;

select * from work.addto2013;

#### VERIFY rosterid Assignment
     select "Max Roster ID Lookup.roster" AS Metric,max(rosterid) as val from lookup.roster
      UNION ALL
     select "Min Roster ID work.addto2013" AS Metric, min(rosterid) as val from work.addto2013
      UNION ALL 
     select "Max Roster ID work.addto2013" AS Metric,max(rosterid) as val from work.addto2013;
     
     
     
########################################################################
######## 2016 ################################################################

drop table if exists work.addto2016;
create table work.addto2016 as
select * from lookup.roster
WHERE STD_PROGRAM="BERD"
AND YEAR IN (2015,2017)
AND UFID NOT IN (select distinct UFID from lookup.roster
                   WHERE STD_PROGRAM="BERD" AND YEAR=2016)
AND UFID<>""
AND Faculty="Faculty"
ORDER BY UFID
;
;

  SET SQL_SAFE_UPDATES = 0;
UPDATE work.addto2016 SET Year=2016;

  SET SQL_SAFE_UPDATES = 0;
     UPDATE work.addto2016
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.addto2016
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;


## ASSIGN ROSTER IDs WHEN ALL RECORDS ADDED

select max(rosterid)+1 from lookup.roster;

     SET SQL_SAFE_UPDATES = 0;
      UPDATE work.addto2016 SET rosterid = 0 ;
      SELECT @i:=(select max(rosterid) from lookup.roster);
      UPDATE work.addto2016 SET rosterid = @i:=@i+1;


select * from work.addto2016;

#### VERIFY rosterid Assignment
     select "Max Roster ID Lookup.roster" AS Metric,max(rosterid) as val from lookup.roster
      UNION ALL
     select "Min Roster ID work.addto2016" AS Metric, min(rosterid) as val from work.addto2016
      UNION ALL 
     select "Max Roster ID work.addto2016" AS Metric,max(rosterid) as val from work.addto2016;
     
     
     
########################################################################
############### 2017 ##################################################
drop table if exists work.addto2017;
create table work.addto2017 as
select * from lookup.roster
WHERE STD_PROGRAM="BERD"
AND YEAR IN (2016,2018)
AND UFID NOT IN (select distinct UFID from lookup.roster
                   WHERE STD_PROGRAM="BERD" AND YEAR=2017)
AND UFID<>""
AND Faculty="Faculty"
ORDER BY UFID
;
;

  SET SQL_SAFE_UPDATES = 0;
UPDATE work.addto2017 SET Year=2017;

  SET SQL_SAFE_UPDATES = 0;
     UPDATE work.addto2017
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.addto2017
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;


select max(rosterid)+1 from lookup.roster;

########################################################################
SELECT Year,Count(distinct Person_key) as nPerson  from lookup.roster WHERE STD_PROGRAM="BERD" and Faculty="Faculty" group by year;

drop table if exists work.del210415 ;
create table work.del210415
Select * from lookup.roster WHERE Year=2014 and STD_PROGRAM="BERD" AND Faculty="Faculty"
UNION
Select * from lookup.roster WHERE Year=2015 and STD_PROGRAM="BERD" AND Faculty="Faculty";


create table loaddata.del201412015roster as
select * from lookup.roster
where rosterid in 
(7000,9375,9104,9017,7163,8757,6650,7278,7595,8458,7512,8614,8791,5420,6584,7195, 
13442,19863,19882,13456,13645,13349,13337,19881,13363,14247,19911,13339,13377);

DELETE FROM lookup.roster 
where rosterid in 
(7000,9375,9104,9017,7163,8757,6650,7278,7595,8458,7512,8614,8791,5420,6584,7195, 
13442,19863,19882,13456,13645,13349,13337,19881,13363,14247,19911,13339,13377,
9393,7682,5814);


create table loaddata.del2014_15roster as

Select * from  loaddata.del201412015roster 
UNION ALL
SELECT * from lookup.roster 
where rosterid in 
(9393,7682,5814);

drop table if exists work.del2104 ;
create table work.del2104
Select * from lookup.roster WHERE Year=2014 and STD_PROGRAM="BERD" AND Faculty="Faculty"
;

select * from work.del2104 ;



#################################################################
############### 2017 ##################################################
drop table if exists work.addto2012;
create table work.addto2012 as
select * from lookup.roster
WHERE STD_PROGRAM="BERD"
AND YEAR IN (2011,2013)
AND UFID NOT IN (select distinct UFID from lookup.roster
                   WHERE STD_PROGRAM="BERD" AND YEAR=2012)
AND UFID<>""
AND Faculty="Faculty"
ORDER BY UFID
;
;

  SET SQL_SAFE_UPDATES = 0;
UPDATE work.addto2012 SET Year=2012;

  SET SQL_SAFE_UPDATES = 0;
     UPDATE work.addto2012
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.addto2012
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;


select max(rosterid)+1 from lookup.roster;

########################################################################
#################################################################
############### 2018 ##################################################
drop table if exists work.addto2018;
create table work.addto2018 as
select * from lookup.roster
WHERE STD_PROGRAM="BERD"
AND YEAR IN (2017,2019)
AND UFID NOT IN (select distinct UFID from lookup.roster
                   WHERE STD_PROGRAM="BERD" AND YEAR=2018)
AND UFID<>""
AND Faculty="Faculty"
ORDER BY UFID
;
;

  SET SQL_SAFE_UPDATES = 0;
UPDATE work.addto2018 SET Year=2018;

  SET SQL_SAFE_UPDATES = 0;
     UPDATE work.addto2018
     SET Roster_Key=CONCAT(Year,"-",UFID)
     WHERE UFID<>"";

     UPDATE work.addto2018
     SET Roster_Key=CONCAT(Year,"-",LastName)
     WHERE UFID="" ;


select max(rosterid)+1 from lookup.roster;

########################################################################



SELECT Year,Count(distinct Person_key) as nPerson  from lookup.roster WHERE STD_PROGRAM="BERD" and Faculty="Faculty" group by year;
