### EAC Infor Graph

## Faculty
Select count(distinct Person_Key)
from lookup.roster
Where year>=2015
and Faculty="Faculty";

Select count(distinct Person_Key)
from lookup.roster
Where year>=2018
and Faculty="Faculty";

## NON faculty
Select count(distinct Person_Key)
from lookup.roster
Where year>=2015
and Faculty<>"Faculty";

Select count(distinct Person_Key)
from lookup.roster
Where year>=2018
and Faculty<>"Faculty";

## Total Customers
Select count(distinct Person_Key)
from lookup.roster
Where year>=2015;

Select count(distinct Person_Key)
from lookup.roster
Where year>=2018;
####################################

## Pilots

SELECT count(Pilot_ID) as nPilots, SUM(Award_Amt) as AMt
from pilots.PILOTS_MASTER
WHERE Award_Year>=2015
and Awarded="Awarded";

SELECT count(Pilot_ID) as nPilots, SUM(Award_Amt) as AMt
from pilots.PILOTS_MASTER
WHERE Award_Year>=2018
and Awarded="Awarded";


### Publications
KL2 TR001429
TL1 TR001428	
UL1 TR001427



########## Awards.

Select 	Count(distinct CLK_AWD_ID) as nAWD,
		Sum(SPONSOR_AUTHORIZED_AMOUNT) as Amt
from lookup.awards_history
WHERE 	(Roster2015=1 and Year(FUNDS_ACTIVATED)=2015) OR
        (Roster2016=1 and Year(FUNDS_ACTIVATED)=2016) OR
        (Roster2017=1 and Year(FUNDS_ACTIVATED)=2017) OR
        (Roster2018=1 and Year(FUNDS_ACTIVATED)=2018) OR
        (Roster2019=1 and Year(FUNDS_ACTIVATED)=2019) OR
        (Roster2020=1 and Year(FUNDS_ACTIVATED)=2020) OR
        (Roster2021=1 and Year(FUNDS_ACTIVATED)=2021) OR
        (Roster2022=1 and Year(FUNDS_ACTIVATED)=2022) OR
        (Roster2023=1 and Year(FUNDS_ACTIVATED)=2023) 
        ;



Select 	Count(distinct CLK_AWD_ID) as nAWD,
		Sum(SPONSOR_AUTHORIZED_AMOUNT) as Amt
from lookup.awards_history
WHERE 	(Roster2018=1 and Year(FUNDS_ACTIVATED)=2018) OR
        (Roster2019=1 and Year(FUNDS_ACTIVATED)=2019) OR
        (Roster2020=1 and Year(FUNDS_ACTIVATED)=2020) OR
        (Roster2021=1 and Year(FUNDS_ACTIVATED)=2021) OR
        (Roster2022=1 and Year(FUNDS_ACTIVATED)=2022) OR
        (Roster2023=1 and Year(FUNDS_ACTIVATED)=2023) 
        ;
        
###NIH
Select 	Count(distinct CLK_AWD_ID) as nAWD,
		Sum(SPONSOR_AUTHORIZED_AMOUNT) as Amt
from lookup.awards_history
WHERE 	REPORTING_SPONSOR_NAME like 'NATL INST OF HLTH%' AND
	(
		(Roster2015=1 and Year(FUNDS_ACTIVATED)=2015) OR
        (Roster2016=1 and Year(FUNDS_ACTIVATED)=2016) OR
        (Roster2017=1 and Year(FUNDS_ACTIVATED)=2017) OR
        (Roster2018=1 and Year(FUNDS_ACTIVATED)=2018) OR
        (Roster2019=1 and Year(FUNDS_ACTIVATED)=2019) OR
        (Roster2020=1 and Year(FUNDS_ACTIVATED)=2020) OR
        (Roster2021=1 and Year(FUNDS_ACTIVATED)=2021) OR
        (Roster2022=1 and Year(FUNDS_ACTIVATED)=2022) OR
        (Roster2023=1 and Year(FUNDS_ACTIVATED)=2023) 
	)
        ;



Select 	Count(distinct CLK_AWD_ID) as nAWD,
		Sum(SPONSOR_AUTHORIZED_AMOUNT) as Amt
from lookup.awards_history
WHERE 	REPORTING_SPONSOR_NAME like 'NATL INST OF HLTH%' AND
	(
		(Roster2018=1 and Year(FUNDS_ACTIVATED)=2018) OR
        (Roster2019=1 and Year(FUNDS_ACTIVATED)=2019) OR
        (Roster2020=1 and Year(FUNDS_ACTIVATED)=2020) OR
        (Roster2021=1 and Year(FUNDS_ACTIVATED)=2021) OR
        (Roster2022=1 and Year(FUNDS_ACTIVATED)=2022) OR
        (Roster2023=1 and Year(FUNDS_ACTIVATED)=2023) 
	)
        ; 
        
select distinct REPORTING_SPONSOR_NAME from lookup.awards_history where REPORTING_SPONSOR_NAME like "N%";        
        