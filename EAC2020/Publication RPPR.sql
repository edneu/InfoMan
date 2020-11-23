


select * from Adhoc.ULKLTLPub2020;


SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
group by PubmedGrant;


SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NOT NULL
group by PubmedGrant;



SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NULL
group by PubmedGrant;



SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
;

## Preiously Submitted Publications
/*
drop table  Adhoc.RpprSub2020;
create table Adhoc.RpprSub2020 AS
select * from work.PubmedOUT ;
*/

SELECT * from Adhoc.RpprSub2020;

Alter table Adhoc.ULKLTLPub2020
ADD PrevRPPR int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE Adhoc.ULKLTLPub2020
SET PrevRPPR=0;

UPDATE Adhoc.ULKLTLPub2020
SET PrevRPPR=1
WHERE PMID IN (SELECT DISTINCT PMID FROM Adhoc.RpprSub2020);


###Overall

SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NOT NULL
;

SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NULL
;



########## NOT SUBMITTED
SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PrevRPPR=0
group by PubmedGrant;


SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NOT NULL
AND PrevRPPR=0
group by PubmedGrant;



SELECT PubmedGrant,count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NULL
AND PrevRPPR=0
group by PubmedGrant;


###Overall NEW PUBS

SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PrevRPPR=0
;



SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is NOT NULL
AND PrevRPPR=0;
;

SELECT count(distinct PMID)
from Adhoc.ULKLTLPub2020
WHERE PMCID is  NULL
AND PrevRPPR=0;
;



DROP TABLE if exists Adhoc.RPPR2020NoPMC; 
create table Adhoc.RPPR2020NoPMC AS
SELECT 	PMID,
        MAX(PMCID) as PMCID,
        MAX(Citation) as Citation,
        GROUP_CONCAT(PubmedGrant," ") as Grants
from Adhoc.ULKLTLPub2020
WHERE PMCID is  NULL
AND PrevRPPR=0
GROUP BY PMID;

select distinct PubmedGrant from Adhoc.ULKLTLPub2020;
