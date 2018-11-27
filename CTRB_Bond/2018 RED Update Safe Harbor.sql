########################################################################
##  THIS QUERY UPDATES THE IP_USAGE  BASED ON DSP DETERMINATION
##  CODE TO GENERATE THE FILE FOR DSP IS IN RedZoneReport.SQL
##
########################################################################

select distinct IP_USAGE from space.bondmaster;


## UPLOAD RESULTS FROM ANTHE as ( space.SafeHarbor2016 )SafeHarbor2016


SET SQL_SAFE_UPDATES = 0;

create table loaddata.backupbondmaster2017 AS select * from space.bondmaster;

UPDATE space.bondmaster bm, space.safeharbor_2017 sh
SET bm.IP_USAGE=sh.IP_USAGE
WHERE bm.Award_ID_Number=sh.CLK_AWD_ID;

select IP_USAGE,count(*) from space.bondmaster group by IP_USAGE;

select AWARD_ID_Number, AWARD_ID_TYPE, LastName, Title from bondmaster where IP_USAGE is NULL;





