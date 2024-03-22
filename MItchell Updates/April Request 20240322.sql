
#  Publication by Award
select AWARD, COUNT(DISTINCT PMID) as nPUBS, SUM(TotalCitations) as nCite
from work.pubs2024
WHERE Year>=2018
Group by AWARD;

# Unduplicated 

drop table if exists work.temp;
create table work.temp as
Select PMID,MAX(TotalCitations) as nCite
from work.pubs2024
WHERE Year>=2018
GROUP BY PMID;

Select COUNT(DISTINCT PMID) as nPUBS, SUM(nCite) as nCite
from work.temp;


#### Roster Customers since 2018 for selected Servces
Select 	STD_PROGRAM, Count(distinct Person_key) as nCustomers
from lookup.roster
Where Year>=2018
AND STD_PROGRAM IN ('BERD','REDCap','Recruitment Center')
GROUP BY STD_PROGRAM;		

