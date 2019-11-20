



SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) from lookup.awards_history
WHERE CLK_PI_UFID='75371720' OR CLK_AWD_PROJ_MGR_UFID='75371720';

drop table if exists work.earn;
create table work.earn as
SELECT CLK_AWD_PI,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TOTAL
from lookup.awards_history
WHERE YEAR(FUNDS_ACTIVATED)>=2015
AND UNIVERSITY_REPORTABLE="YES"
Group by CLK_AWD_PI
ORDER BY Total DESC ;




drop table if exists work.earnnih;
create table work.earnnih as
SELECT CLK_AWD_PI,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TOTAL
from lookup.awards_history
WHERE YEAR(FUNDS_ACTIVATED)>=2015
AND REPORTING_SPONSOR_CUSTID IN  (SELECT DISTINCT SponsorID from lookup.nih_sponser_ids)
AND UNIVERSITY_REPORTABLE="YES"
Group by CLK_AWD_PI
ORDER BY Total DESC ;
