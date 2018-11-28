drop table work.sim;
create table work.sim AS

Select *
FROM lookup.roster
WHERE Person_Key IN (select DISTINCT Person_Key from lookup.roster
						WHERE STD_PROGRAM ="Simulation Center"
						AND Year=2016
						AND Roster=1)
AND STD_PROGRAM <>"Simulation Center"
AND Year=2016
;

select distinct(STD_PROGRAM) from lookup.roster where STD_PROGRAM LIKE "SIM%";

drop table work.simall;
create table work.simall AS
select DISTINCT Person_Key from lookup.roster
    	WHERE STD_PROGRAM ="Simulation Center"
		AND Year=2016
		AND Roster=1;


## Have other than SIM
drop table if exists work.sim_other;
create table work.sim_other AS
select distinct Person_Key
from 
lookup.roster
WHERE Year=2016
And Roster=1
AND Person_key in (select Person_Key from work.simall)
AND STD_PROGRAM <>"Simulation Center";


drop table if exists work.simonly;
Create table work.simonly as
Select Person_key from work.simall
WHERE Person_Key not in (select distinct Person_key from work.sim_other);

drop table work.rostersimonly;
create table work.rostersimonly
select * from 
lookup.roster
where Person_Key in (select distinct Person_key from work.simonly)
AND Year=2016
AND Roster=1;


select Person_Key,min(STD_PROGRAM)
FROM lookup.roster
WHERE STD_PROGRAM NOT IN ("Simulation Center","Service Center","Pilot Awards","Research Participant Advocate","Tuberculosis PH CRU","TPDP","PubMed Compliance")
AND Person_Key in (select distinct Person_key from  work.rostersimonly  )
group by Person_Key;



UPDATE lookup.roster SET STD_PROGRAM="Integrated Data Repository" WHERE STD_PROGRAM="Intergrated Data Repository";


select "Unduplicated SIM Center Users" AS Measure, count(distinct Person_Key) AS MeasureValue from lookup.roster WHERE Year=2016 AND STD_PROGRAM="Simulation Center" 
UNION ALL 
select "Unduplicated SIM Center Roster Users" AS Measure, count(distinct Person_Key) AS MeasureValue from lookup.roster WHERE Year=2016 AND STD_PROGRAM="Simulation Center" AND Roster=1
UNION ALL 
select "Unduplicated SIM Center Roster Users with no other service" AS Measure, count(distinct Person_Key) AS MeasureValue from lookup.roster 
        WHERE Year=2016 
        AND STD_PROGRAM<>"Simulation Center" 
        AND Roster=1 
        AND Person_Key IN (SELECT DISTINCT Person_Key from lookup.roster WHERE Year=2016 AND STD_PROGRAM="Simulation Center");
