########################################################################
##  THIS QUERY UPDATES THE IP_USAGE  BASED ON DSP DETERMINATION
##  CODE TO GENERATE THE FILE FOR DSP IS IN RedZoneReport.SQL
##
########################################################################

select distinct IP_USAGE from space.bondmaster;


## UPLOAD RESULTS FROM ANTHE as ( space.SafeHarbor2016 )SafeHarbor2016


SET SQL_SAFE_UPDATES = 0;

create table loaddata.backupbondmaster2019 AS select * from space.bondmaster;

UPDATE space.bondmaster bm, space.safeharbor_2019 sh
SET bm.IP_USAGE=sh.IP_USAGE
WHERE bm.bondmaster_key=sh.bondmaster_key;

select IP_USAGE,count(*) from space.bondmaster group by IP_USAGE;



/*
## Check span match
select sp.bondmaster_key,sp.Span,sh.bondmaster_key,sh.Span
from space.bondmaster sp left join space.safeharbor_2019 sh
on sp.bondmaster_key=sh.bondmaster_key
Where sp.Span<>sh.Span ; 

*/