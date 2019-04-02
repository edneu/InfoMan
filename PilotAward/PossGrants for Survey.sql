

drop table work.ufid_no_grant;
select * from work.ufid_no_grant;

drop table if exists work.pilotsugggrant1;
create table work.pilotsugggrant1 as
Select REPORTING_SPONSOR_NAME,REPORTING_SPONSOR_AWD_ID,CLK_AWD_PROJ_NAME, CLK_AWD_ID, CLK_PI_UFID, CLK_AWD_PI, FUNDS_ACTIVATED
from lookup.awards_history
WHERE CLK_PI_UFID IN (SELECT DISTINCT UFID from work.ufid_no_grant)
GROUP BY REPORTING_SPONSOR_NAME,REPORTING_SPONSOR_AWD_ID,CLK_AWD_PROJ_NAME, CLK_AWD_ID, CLK_PI_UFID, CLK_AWD_PI, FUNDS_ACTIVATED;

drop table if exists work.pilotsugggrant;
create table work.pilotsugggrant as 
Select  
        CLK_PI_UFID,
        ps.CLK_AWD_PI,
        CONCAT(ps.REPORTING_SPONSOR_NAME," ",
		ps.REPORTING_SPONSOR_AWD_ID," ",
        ps.CLK_AWD_PROJ_NAME," ",
        ps.CLK_AWD_PI," ",
        "AWD_ID: ",ps.CLK_AWD_ID," ",
        ps.CLK_AWD_PI) AS FMT_GRANT
from work.pilotsugggrant1 ps left join work.ufid_no_grant ng ON (ps.CLK_PI_UFID=ng.UFID AND ng.AwardDate<ps.FUNDS_ACTIVATED)
GROUP BY CLK_PI_UFID,
        ps.CLK_AWD_PI,
        CONCAT(ps.REPORTING_SPONSOR_NAME," ",
		ps.REPORTING_SPONSOR_AWD_ID," ",
        ps.CLK_AWD_PROJ_NAME," ",
        ps.CLK_AWD_PI," ",
        "AWD_ID: ",ps.CLK_AWD_ID," ",
        ps.CLK_AWD_PI)
;


