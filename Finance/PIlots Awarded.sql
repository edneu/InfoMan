
create table work.lhs as
Select  
Pilot_ID,
Category,
AwardLetterDate,
PI_First,
PI_Last,
Title,
Award_Amt
from pilots.PILOTS_MASTER
WHERE Category in ('Translational','LHS')
AND Awarded='Awarded'
order by AwardLetterDate;

drop table if exists work.lhs;
create table work.lhs as
Select  * 
from pilots.PILOTS_MASTER
WHERE Category in ('Translational','LHS')
AND Awarded='Awarded'
order by AwardLetterDate;

select max(pilot_id)+1 from pilots.PILOTS_MASTER;

select * from lookup.ufids where UF_LAST_NM like "HArle";

select * from lookup.active_emp WHERE Employee_ID='41117580';

DROP TABLE IF EXISTS pilots.PILOTS_MASTER;
Create table pilots.PILOTS_MASTER
select * from pilots.new_pilot_master;


DROP TABLE IF EXISTS finance.Pilots202122;
Create table finance.Pilots202122 AS
SELECT Pilot_ID,
       "SFY 2020-2021" as SFY,
	   AwardLetterDate,
       Category,
       PI_Last,
       PI_First,
       UFID,
       Award_Amt
from pilots.PILOTS_MASTER   
WHERE AwardLetterDate BETWEEN '2020-07-01 00:00:00' AND '2021-06-30'
AND Awarded='Awarded'
UNION ALL
SELECT Pilot_ID,
       "SFY 2021-2022" as SFY,
	   AwardLetterDate,
       Category,
       PI_Last,
       PI_First,
       UFID,
       Award_Amt
from pilots.PILOTS_MASTER   
WHERE AwardLetterDate BETWEEN '2021-07-01 00:00:00' AND '2022-06-30'
AND Awarded='Awarded';
       


DROP TABLE IF EXISTS finance.lhs;
Create table finance.lhs AS
Select Pilot_ID,Category,AwardLetterDate,Award_Amt,PI_First,PI_Last,Title
from pilots.PILOTS_MASTER
where Category="LHS";