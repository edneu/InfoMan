drop table if exists work.temp;
create table work.temp AS
select Pilot_ID,PI_Last,PI_First,Email,Title,Category,AwardLetterDate,Award_Amt
from pilots.PILOTS_MASTER
WHERE Category="Translational"
AND Awarded="Awarded";


drop table if exists work.temp2;
create table work.temp2 AS
select Pilot_ID,PubYear,PMID,PMCID,Citation,PubDate,Total_Citations,Citations_per_Year,Expected_Citations_per_Year,Field_Citation_Rate,Relative_Citation_Ratio,NIH_Percentile
from pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID in (select Pilot_ID from work.temp)  ;

drop table if exists work.temp3;
create table work.temp3 AS
select Pilot_ID,Grant_Title,Year_Activiated,Grant_Sponsor,Grant_Sponsor_ID,Direct,Indirect,Total
from pilots.PILOTS_GRANT_SUMMARY
WHERE Pilot_ID in (select Pilot_ID from work.temp)  ;