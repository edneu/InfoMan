


select * from ctsi_webcamp_adhoc.merged_webcamp_oncore;


desc ctsi_webcamp_pr.OPVISIT;


drop table if exists ctsi_webcamp_adhoc.protopat;
Create table ctsi_webcamp_adhoc.protopat as
select protocol,patient, count(*) AS Visits from ctsi_webcamp_pr.OPVISIT 
WHERE Protocol in (select distinct PROTOCOL FROM ctsi_webcamp_adhoc.merged_webcamp_oncore)
group by protocol,patient
UNION ALL 
select protocol,patient, count(*) AS Visits from ctsi_webcamp_pr.ADMISSIO 
WHERE Protocol in (select distinct PROTOCOL FROM ctsi_webcamp_adhoc.merged_webcamp_oncore)
group by protocol,patient
UNION ALL
select protocol,patient, count(*) AS Visits from ctsi_webcamp_pr.SBADMISSIO
WHERE Protocol in (select distinct PROTOCOL FROM ctsi_webcamp_adhoc.merged_webcamp_oncore)
group by protocol,patient;

drop table if exists ctsi_webcamp_adhoc.protopatagg ;
Create table ctsi_webcamp_adhoc.protopatagg as
SELECT protocol,Count(distinct patient) as Enrolled, SUM(Visits) as Visits
from ctsi_webcamp_adhoc.protopat
group by protocol;

ALter table ctsi_webcamp_adhoc.merged_webcamp_oncore
ADD WebcampENR int(11),
ADD WebcampVisits int(11);


SET SQL_SAFE_UPDATES = 0;

UPDATE 	ctsi_webcamp_adhoc.merged_webcamp_oncore mwc,
		ctsi_webcamp_adhoc.protopatagg lu
		SET mwc.WebcampENR=lu.Enrolled,
			mwc.WebcampVisits=lu.Visits
WHERE mwc.protocol=lu.protocol;


SET SQL_SAFE_UPDATES = 1;


SELECT * from ctsi_webcamp_adhoc.merged_webcamp_oncore;
