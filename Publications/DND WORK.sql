


select count(*) from work.pmid_dnd;
select count(DISTINCT pmid) from work.pmid_dnd;


ALTER TABLE work.pmid_dnd ADD inPubCore int(1);

select * from work.pmid_dnd;

desc work.pmid_dnd;

UPDATE work.pmid_dnd SET inPubCore =0;

UPDATE work.pmid_dnd SET inPubCore =1
WHERE PMID in (SELECT DISTINCT PMID from pubs.PUB_CORE);


ALTER TABLE pubs.PUB_CORE ADD inDND int(1);
UPDATE pubs.PUB_CORE SET inDND =0;

UPDATE pubs.PUB_CORE SET inDND =1
WHERE PMID in (SELECT DISTINCT PMID from work.pmid_dnd);

create table work.pmidDNDout
SELECT PMID,max(inPubCore) as inPubCore
from work.pmid_dnd
group by PMID
order by PMID;

DELETE FROM work.pmidDNDout WHERE inPubCore=0;

select * from work.pmidDNDout;

select * from pubs.PUB_CORE where 
pubmaster_id2 in
(616,719,722,619,622,721,507,508,509,510);


select * from pubs.PUB_CORE where citation like "McQuaid%";

select * from pubs.PUB_CORE limit 10;

desc pubs.PUB_CORE;

select max(pubmaster_id2)+1 from pubs.PUB_CORE;

SELECT distinct PMID from work.pmidcheck;
select * from pubs.PUB_CORE where PMID in (SELECT distinct PMID from work.pmidcheck);

####create table loaddata.backup_pub_core as select * from pubs.PUB_CORE;

select * from pubs.PUB_CORE where pubmaster_id2>=1032;





select Citation from pubs.PUB_CORE WHERE
(Citation like '% When Trust Is Not Enough%');

;




select * from work. pmid_checked
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE);

select * from work. pmid_checked
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE);



select distinct PMID from work.pubmeduktnc
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE);

select * from pubs.PUB_CORE where PMID ="29146455";





select distinct PMID from work.need_pmc
WHERE PMID NOT IN (SELECT DISTINCT PMID FROM pubs.PUB_CORE);

drop table if exists work.temp;
create table work.temp
select * from pubs.PUB_CORE limit 10;

select max(pubmaster_id2)+1 from pubs.PUB_CORE;

select  NIHMS_Status,count(*) from pubs.PUB_CORE group by NIHMS_Status;


desc pubs.PUB_CORE;


select count(*) from work.dndchk;
select count(distinct PMID) from work.dndchk;

select count(distinct PMID) from work.dndchk
WHERE PMID NOT IN (SELECT DISTINCT PMID from pubs.PUB_CORE);


select distinct PMID from pubs.PUB_CORE
WHERE PMID in (SELECT DISTINCT PMID from work.dndchk);


select Citation from pubs.PUB_CORE WHERE
(Citation like '%Seay%') ;

select * from pubs.PUB_CORE WHERE PMID="329478354";
5/8/2019



OR 
(Citation like '%Hicks%') 
  ;

DISTINCT test_score
                      ORDER BY test_score DESC SEPARATOR ' '
select * from work.finaldnd;

SELECT PMID,
       group_concat(Grant_Number SEPARATOR ', ') AS Grant_Number,
       Min(Publication_Date) as PubDate
FROM work.finaldnd
GROUP BY PMID; 


select  NIHMS_Status,count(*) from pubs.PUB_CORE group by NIHMS_Status;


select * from pubs.PUB_CORE where trim(PMC)=""
AND NIHMS_Status NOT IN ('Conference Presentation','Book Chapter');


select  PMID, pubmaster_id2, NIHMS_Status from pubs.PUB_CORE where trim(PMC)=""
AND NIHMS_Status NOT IN ('Conference Presentation','Book Chapter');

select * from pubs.PUB_CORE where pmid='30111190';

'Spratt S, Stewart M, Paige SR, Stellefson M. A Review of the Hepatitis B Foundation Website. Health Promot Pract. 2018 Nov;19(6):811-814. doi: 10.1177/1524839918790938. Epub 2018 Aug 15. PubMed PMID: 30111190'