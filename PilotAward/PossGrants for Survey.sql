
##########drop table work.ufid_no_grant;

s



select * from work.ufid_no_grant;

drop table if exists work.possgrant1;
create table work.possgrant1 AS
SELECT * from lookup.awards_history where CLK_PI_UFID in (select DISTINCT UFID FROM work.ufid_no_grant);

ALTER TABLE work.possgrant1 ADD possgrant integer(1);

UPDATE work.possgrant1 SET possgrant=0;

UPDATE work.possgrant1 pg , work.ufid_no_grant lu
SET possgrant=1
WHERE pg.CLK_PI_UFID=lu.UFID
AND pg.FUNDS_ACTIVATED>lu.AwardLetterDate;





\


drop table if exists work.pilotsugggrant;
create table work.pilotsugggrant as 
Select  
        CLK_PI_UFID,
        CLK_AWD_PI,
        CONCAT(REPORTING_SPONSOR_NAME," ",
		REPORTING_SPONSOR_AWD_ID," ",
        CLK_AWD_PROJ_NAME," ",
        "AWD_ID: ",CLK_AWD_ID,"   PI: ",
        CLK_AWD_PI) AS FMT_GRANT
from work.possgrant1
WHERE possgrant=1
GROUP BY CLK_PI_UFID,
        CLK_AWD_PI,
        CONCAT(REPORTING_SPONSOR_NAME," ",
		REPORTING_SPONSOR_AWD_ID," ",
        CLK_AWD_PROJ_NAME," ",
        "AWD_ID: ",CLK_AWD_ID," ",
        CLK_AWD_PI) 
;



Select * from lookup.ufids where UF_LAST_NM="Wing";




