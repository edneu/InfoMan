

select Category,count(distinct Pilot_ID) as nPILOTS 
from pilots.PILOTS_MASTER
WHERE Award_Year>=2008
AND Awarded="Awarded"
group by Category;

select Award_Year,count(distinct Pilot_ID) as nPILOTS 
from pilots.PILOTS_MASTER
WHERE Award_Year>=2008
AND Awarded="Awarded"
group by Award_Year;

SELECT count(DISTINCT Person_key) as nSERVED
FROM lookup.roster
WHERE Affiliation="UF";

select distinct ufid from lookup.roster;
select min(ufid),max(ufid) from lookup.roster;

UPDATE lookup.roster set Affiliation="UF" where ufid is not null;


create table loaddata.rostertemp as select * from lookup.roster;

update lookup.roster set UFID=NULL where UFID in ('','000Baker');