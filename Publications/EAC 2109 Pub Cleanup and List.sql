
select PMID from pubs.PUB_CORE WHERE PMID IN (Select Distinct PMID from work.PubmedOUT);

select max(pubmaster_id2)+1 from pubs.PUB_CORE;


Alter Table pubs.PUB_CORE ADD PrimaryCat varchar(45);
Alter Table pubs.PUB_CORE ADD Pubmed_CTSI int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE pubs.PUB_CORE pc, pubs.PUB_PROGRAM_ASSIGN lu
SET pc.PrimaryCat=lu.PrimaryCat
WHERE pc.pubmaster_id2=lu.pubmaster_id2;

SET SQL_SAFE_UPDATES = 1;

#### CREATE BACKUP OF PUB_CORE

CREATE TABLE pubs.pub_core_Backup AS
SELECT * from pubs.PUB_CORE;

desc pubs.PUB_CORE;

SET SQL_SAFE_UPDATES = 0;
UPDATE pubs.PUB_CORE pc, work.update_category lu
SET pc.PrimaryCat=lu.PrimaryCat
where pc.pubmaster_id2=lu.pubmaster_id2;



SELECT PrimaryCat,count(*)
from pubs.PUB_CORE
WHERE pubmaster_id2 in (select distinct pubmaster_id2 from work.chk_primarycat)
group by PrimaryCat;

select pubdate,count(*) from pubs.PUB_CORE group by pubdate;

create table work.addpubdate as
select * from pubs.PUB_CORE where pubdate is Null;


UPDATE pubs.PUB_CORE
SET Citation='Wan, Y., Datta, S., Lee, J. J., and Kong, M. (2017) Monotonic single-index models to assess drug interactions. Statist. Med., 36: 655–670. doi: 10.1002/sim.7158. PMID: 27804146. PMCID: PMC5217167.'
WHERE pubmaster_id2=602;


###### ADD MISSING PUBDATES
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('11,8,2018','%m,%d,%Y') WHERE pubmaster_id2=1023;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('9,15,2018','%m,%d,%Y') WHERE pubmaster_id2=908;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('9,14,2018','%m,%d,%Y') WHERE pubmaster_id2=914;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('9,12,2018','%m,%d,%Y') WHERE pubmaster_id2=919;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('9,4,2018','%m,%d,%Y') WHERE pubmaster_id2=918;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('8,17,2018','%m,%d,%Y') WHERE pubmaster_id2=910;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('8,3,2018','%m,%d,%Y') WHERE pubmaster_id2=913;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('8,1,2018','%m,%d,%Y') WHERE pubmaster_id2=898;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('8,1,2018','%m,%d,%Y') WHERE pubmaster_id2=917;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('7,24,2018','%m,%d,%Y') WHERE pubmaster_id2=922;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('7,23,2018','%m,%d,%Y') WHERE pubmaster_id2=903;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('7,23,2018','%m,%d,%Y') WHERE pubmaster_id2=902;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,30,2018','%m,%d,%Y') WHERE pubmaster_id2=899;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,15,2018','%m,%d,%Y') WHERE pubmaster_id2=895;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,9,2018','%m,%d,%Y') WHERE pubmaster_id2=885;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,8,2018','%m,%d,%Y') WHERE pubmaster_id2=906;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,8,2018','%m,%d,%Y') WHERE pubmaster_id2=887;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,5,2018','%m,%d,%Y') WHERE pubmaster_id2=891;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,5,2018','%m,%d,%Y') WHERE pubmaster_id2=892;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,5,2018','%m,%d,%Y') WHERE pubmaster_id2=884;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('5,30,2018','%m,%d,%Y') WHERE pubmaster_id2=881;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('5,22,2018','%m,%d,%Y') WHERE pubmaster_id2=879;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('5,21,2018','%m,%d,%Y') WHERE pubmaster_id2=893;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,21,2018','%m,%d,%Y') WHERE pubmaster_id2=866;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,21,2018','%m,%d,%Y') WHERE pubmaster_id2=867;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,12,2018','%m,%d,%Y') WHERE pubmaster_id2=714;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,11,2018','%m,%d,%Y') WHERE pubmaster_id2=713;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,9,2018','%m,%d,%Y') WHERE pubmaster_id2=876;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,9,2018','%m,%d,%Y') WHERE pubmaster_id2=877;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,3,2018','%m,%d,%Y') WHERE pubmaster_id2=712;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,3,2018','%m,%d,%Y') WHERE pubmaster_id2=868;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,1,2018','%m,%d,%Y') WHERE pubmaster_id2=716;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,21,2018','%m,%d,%Y') WHERE pubmaster_id2=709;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,9,2018','%m,%d,%Y') WHERE pubmaster_id2=873;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,9,2018','%m,%d,%Y') WHERE pubmaster_id2=874;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,1,2018','%m,%d,%Y') WHERE pubmaster_id2=869;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,27,2018','%m,%d,%Y') WHERE pubmaster_id2=862;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,23,2018','%m,%d,%Y') WHERE pubmaster_id2=859;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,16,2018','%m,%d,%Y') WHERE pubmaster_id2=696;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,13,2018','%m,%d,%Y') WHERE pubmaster_id2=693;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,10,2018','%m,%d,%Y') WHERE pubmaster_id2=863;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('1,30,2018','%m,%d,%Y') WHERE pubmaster_id2=694;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('1,24,2018','%m,%d,%Y') WHERE pubmaster_id2=854;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('12,29,2017','%m,%d,%Y') WHERE pubmaster_id2=886;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('12,15,2017','%m,%d,%Y') WHERE pubmaster_id2=853;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('12,4,2017','%m,%d,%Y') WHERE pubmaster_id2=527;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('11,22,2017','%m,%d,%Y') WHERE pubmaster_id2=675;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('11,8,2017','%m,%d,%Y') WHERE pubmaster_id2=848;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('10,26,2017','%m,%d,%Y') WHERE pubmaster_id2=847;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('10,11,2017','%m,%d,%Y') WHERE pubmaster_id2=844;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('9,21,2017','%m,%d,%Y') WHERE pubmaster_id2=841;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('7,25,2017','%m,%d,%Y') WHERE pubmaster_id2=658;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('7,12,2017','%m,%d,%Y') WHERE pubmaster_id2=880;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,28,2017','%m,%d,%Y') WHERE pubmaster_id2=836;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('6,20,2017','%m,%d,%Y') WHERE pubmaster_id2=638;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,19,2017','%m,%d,%Y') WHERE pubmaster_id2=490;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,15,2017','%m,%d,%Y') WHERE pubmaster_id2=646;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,5,2017','%m,%d,%Y') WHERE pubmaster_id2=653;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,31,2017','%m,%d,%Y') WHERE pubmaster_id2=655;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,20,2017','%m,%d,%Y') WHERE pubmaster_id2=176;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,20,2017','%m,%d,%Y') WHERE pubmaster_id2=602;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('2,2,2017','%m,%d,%Y') WHERE pubmaster_id2=645;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('1,26,2017','%m,%d,%Y') WHERE pubmaster_id2=649;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('1,15,2017','%m,%d,%Y') WHERE pubmaster_id2=543;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('12,20,2016','%m,%d,%Y') WHERE pubmaster_id2=677;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('8,4,2016','%m,%d,%Y') WHERE pubmaster_id2=644;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('3,15,2016','%m,%d,%Y') WHERE pubmaster_id2=304;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('4,21,2015','%m,%d,%Y') WHERE pubmaster_id2=99;


########### DEAL WITH DUPS
create table work.dups AS
SELECT * FROM pubs.PUB_CORE
WHERE pubmaster_id2
IN (785,932,956,615,762,798,855,861,
865,867,874,877,883,892,915,923,960,621,763,741,617,727,735,
735,761,797,856,860,864,866,873,876,882,891,916,950,951,870);



CREATE TABLE pubs.PUBCOREBACKUP AS Select * from pubs.PUB_CORE;

DELETE FROM pubs.PUB_CORE
WHERE pubmaster_id2 IN
(615,735,785,891,950,960,861,798,
877,874,865,883,867,856,915
);


## FIND AND FIX MISSING PriMAry Category
select * from pubs.PUB_CORE where PrimaryCat="" or PrimaryCat is Null;

UPDATE pubs.PUB_CORE SET PrimaryCat='Research Methods' WHERE pubmaster_id2=855;
UPDATE pubs.PUB_CORE SET PrimaryCat='TWD / Team Science' WHERE pubmaster_id2=892;
UPDATE pubs.PUB_CORE SET PrimaryCat='TWD / Team Science' WHERE pubmaster_id2=762;
UPDATE pubs.PUB_CORE SET PrimaryCat='Translational' WHERE pubmaster_id2=763;
UPDATE pubs.PUB_CORE SET PrimaryCat='TWD/ Team Science' WHERE pubmaster_id2=923;
UPDATE pubs.PUB_CORE SET PrimaryCat='Research Methods' WHERE pubmaster_id2=932;
UPDATE pubs.PUB_CORE SET PrimaryCat='TWD / Team Science' WHERE pubmaster_id2=956;
UPDATE pubs.PUB_CORE SET PrimaryCat='Translational' WHERE pubmaster_id2=741;


#### SET EXCUDE FOR DUP PILOT FLAG
UPDATE pubs.PUB_CORE SET Exclude=1 WHERE pubmaster_id2=762;



Alter table pubs.PUB_CORE ADD Exclude int(1);
UPDATE pubs.PUB_CORE SET Exclude=0;

UPDATE pubs.PUB_CORE SET Exclude=1 WHERE pubmaster_id2 IN (762,763,741);  # Pilot Dup
UPDATE pubs.PUB_CORE SET Exclude=1 WHERE PubDate<str_to_date('08,15,2015','%m,%d,%Y');   ## BEFORE CURRENT GRANT -135


763
741


UPDATE pubs.PUB_CORE SET PrimaryCat="Hub / Network Capacity" Where PrimaryCat="Hub/ Network Capacity";
UPDATE pubs.PUB_CORE SET PrimaryCat="TWD / Team Science" Where PrimaryCat="TWD/ Team Science";





Select count(*)
FROM pubs.PUB_CORE
WHERE Exclude=0;

DROP TABLE IF EXISTS pubs.EAC_PUBS_2019;
CREATE TABLE pubs.EAC_PUBS_2019 AS
SELECT PrimaryCat,
	   Citation	
FROM pubs.PUB_CORE
WHERE Exclude=0
ORDER BY PrimaryCat,
	   Citation;

## SUMMARY TABLE
DROP TABLE IF EXISTS pubs.eac_pub_summary;
CREATE TABLE pubs.eac_pub_summary AS
SELECT DISTINCT PrimaryCat FROM pubs.PUB_CORE;

ALTER TABLE pubs.eac_pub_summary
ADD CY2015 int(10),
ADD CY2016 int(10),
ADD CY2017 int(10),
ADD CY2018 int(10),
ADD CY2019 int(10);


drop table if exists work.pubsumm;
create table work.pubsumm as
SELECT YEAR(PubDate) AS cyYear,
       PrimaryCat AS PrimaryCat,
       COUNT(*) AS numPubs
FROM pubs.PUB_CORE
WHERE Exclude=0
GROUP BY YEAR(PubDate),
       PrimaryCat;

UPDATE pubs.eac_pub_summary ps, work.pubsumm lu
SET ps.CY2015=numPubs
WHERE ps.PrimaryCat=lu.PrimaryCat
AND cyYear=2015;

UPDATE pubs.eac_pub_summary ps, work.pubsumm lu
SET ps.CY2016=numPubs
WHERE ps.PrimaryCat=lu.PrimaryCat
AND cyYear=2016;

UPDATE pubs.eac_pub_summary ps, work.pubsumm lu
SET ps.CY2017=numPubs
WHERE ps.PrimaryCat=lu.PrimaryCat
AND cyYear=2017;


UPDATE pubs.eac_pub_summary ps, work.pubsumm lu
SET ps.CY2018=numPubs
WHERE ps.PrimaryCat=lu.PrimaryCat
AND cyYear=2018;

UPDATE pubs.eac_pub_summary ps, work.pubsumm lu
SET ps.CY2019=numPubs
WHERE ps.PrimaryCat=lu.PrimaryCat
AND cyYear=2019;

SELECT * from pubs.eac_pub_summary;

select * from pubs.PUB_CORE WHERE pubmaster_id2 IN (763,741);


SELECT DISTINCT PMID from pubs.PUB_CORE WHERE Exclude=0;


