####  

SELECT 	count(distinct Pilot_ID) as nPilots,
		Sum(Award_Amt) as TotAmt
from pilots.PILOTS_MASTER
Where Awarded='Awarded'
AND Year(AwardLetterDate)>=2008;        

Select Count(distinct Person_key) from lookup.roster;


drop table if Exists work.temp;
create table  work.temp as
Select CLK_AWD_ID, min(Year(FUNDS_ACTIVATED))as InitYear
from lookup.awards_history
WHere  ClinRrch=1
GROUP BY CLK_AWD_ID;

select 	InitYear, 
		count(distinct CLK_AWD_ID) 
        from work.temp
        GROUP BY InitYear;



drop table if Exists work.temp;
create table  work.temp as
Select CLK_AWD_ID, Year(FUNDS_ACTIVATED) as InitYear
from lookup.awards_history
WHere  ClinRrch=1
GROUP BY CLK_AWD_ID, Year(FUNDS_ACTIVATED);

select 	InitYear, 
		count(distinct CLK_AWD_ID) 
        from work.temp
        GROUP BY InitYear;