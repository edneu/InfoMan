select distinct category from pilots.PILOTS_MASTER;




DROP TABLE IF EXISTS work.lhspilots;
CREATE TABLE work.lhspilots As

select Pilot_ID,
		Award_Year,
        Category,
        AwardType,
        AwardLetterDate,
        Award_Amt,
        Status,
        PI_Last,
        PI_First,
        Title
from pilots.PILOTS_MASTER
where Category='Translational'
	AND Awarded="Awarded"
    ORDER BY Pilot_ID;
    
