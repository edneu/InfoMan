
create table yulia.covid as
select Pilot_ID,
Award_Year,
Category,
AwardLetterDate,
Award_Amt,
PI_Last,
PI_First,
UFID as PI_UFID,
Email as PI_EMAIL,
PI_DEPT,
PI_DEPTID,
AwardeePositionAtApp,
AwardeeCareerStage,
Title
from pilots.PILOTS_MASTER
Where Category ="COVID"
And Awarded="Awarded";