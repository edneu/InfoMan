
select max(FUNDS_ACTIVATED) from lookup.awards_history;

SET sql_mode = '';


drop table if exists work.pimingrant;
Create table work.pimingrant AS
SELECT UFID,min(AwardDate)
FROM pilots.pilotnogrant
GROUP BY UFID;


drop table if exists work.pilotpigrants ;
create table work.pilotpigrants AS
select * from lookup.awards_history
WHERE CLK_PI_UFID IN (SELECT DISTINCT UFID from work.pimingrant) OR
      CLK_AWD_PROJ_MGR_UFID IN (SELECT DISTINCT UFID from work.pimingrant) ; 