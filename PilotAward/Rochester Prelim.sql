drop table if exists work.pilotaward;
create table work.pilotaward as
Select *
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


select count(*) from work.pilotaward;

select count(*) from work.pilotaward WHERE Category not in ("SECIM");

Select min(AwardLetterDate), max(AwardLetterDate)
from work.pilotaward;
 
SELECT Award_Amt,count(*) from work.pilotaward group by Award_Amt  ORDER by Award_Amt DESC;

select count(*) from work.pilotaward WHERE Award_Amt>=50000;
select count(*) from work.pilotaward WHERE Category not in ("SECIM") AND Award_Amt>=50000;
