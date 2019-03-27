
drop table if exists work.pubmed_raw;
create table work.pubmed_raw AS
select * from pubs.pubmed_grant_result;

### <RUN PUBMED RECORD CLEANER SCRIPTS HERE>

DROP TABLE IF EXISTS work.PubmedOUT;
create table work.PubmedOUT as
select pubmaster_id2,PMID,PMCID,Citation from 
work.pubmed_raw
order by PMID;


select * from work.PubmedOUT;

update work.PubmedOUT
SET PMCID="" WHERE PMCID IS NULL;

update pubs.PUB_CORE
SET PMC="PMC6410634" WHERE pubmaster_id2=456;



SET SQL_SAFE_UPDATES = 0;

UPDATE pubs.PUB_CORE pc, work.PubmedOUT lu
SET pc.PMID=lu.PMID,
    pc.PMC=PMCID,
    pc.Citation=lu.Citation
WHERE pc.pubmaster_id2=lu.pubmaster_id2;

select * from work.PubmedOUT;


select pubmaster_id2,PMID,PMC,Citation from pubs.PUB_CORE
WHERE pubmaster_id2 in 
(
730,
507
)
ORDER BY pubmaster_id2 ;

select * from pubs.PUB_CORE
WHERE pubmaster_id2 in 
(
730,
507
)
ORDER BY pubmaster_id2 ;

PMC5836499


SET SQL_SAFE_UPDATES = 0;

SELECT * FROM work.PubmedOUT;

ALTER TABLE work.PubmedOUT
ADD CorePMCID varchar(12),
ADD CoreCite varchar(4000);

UPDATE work.PubmedOUT po, pubs.PUB_CORE lu
SET po.CorePMCID=lu.PMC,
    po.CoreCite=lu.Citation
    WHERE po.PMID=lu.PMID;


select * from work.PubmedOUT WHERE CorePMCID<>PMCID;

select * from work.PubmedOUT WHERE CorePMCID<>PMCID;

drop table if exists work.temp;
create table work.temp as
select * from work.PubmedOUT WHERE substr(CoreCite,1,20)<>substr(Citation,1,20);

UPDATE work.temp SET PMCID="" WHERE PMCID IS NULL;


UPDATE pubs.PUB_CORE pc, work.temp lu
SET pc.PMC=lu.PMCID,
    pc.Citation=lu.Citation
WHERE pc.PMID=lu.PMID;
AND pc.PMID<>29165691;






####create table loaddata.pubcoreBACKUP032719 AS select * from pubs.PUB_CORE;

drop table if exists pubs.PubmedUKT;
create table pubs.PubmedUKT as
select * from work.PubmedOUT;



select GrantType,count(distinct PMID) from pubs.PubmedUKT group by GrantType;

select GrantType,count(distinct PMID) from pubs.PubmedUKT
WHERE PMCID IS NULL
 group by GrantType;
 
 select GrantType,count(*) from pubs.PubmedUKT
WHERE PMID IS NULL
 group by GrantType;
 
 select * from pubs.PubmedUKT where GrantType="App";
 
 drop table  work.noncompPMC;
 create table work.noncompPMC as
 select *
 from pubs.PubmedUKT
WHERE PMCID IS NULL;




select distinct PMCID from pubs.PubmedUKT;

select distinct PMC from  pubs.PUB_CORE; 


select count(distinct Citation) from pubs.PUB_CORE
Where May18Grant=1
AND PMC<>"" ;

select count(distinct Citation) from pubs.PUB_CORE
Where May18Grant=1
AND PMC="" ;

select count(distinct Citation) from pubs.PUB_CORE
Where May18Grant=1
AND PMC="" AND PMID<>""
 ;

select count(*) from pubs.PUB_CORE
Where May18Grant=1
AND PMID="" AND PMC="";



###################################
###################################
DROP TABLE if EXISTS work.pubcoreref;
create table work.pubcoreref AS
SELECT pubmaster_id2,PMID,PMC,CITATION from pubs.PUB_CORE;

select distinct PMID from work.pubcoreref;

SELECT * from pubs.PUB_CORE WHERE PMID="29165692";

drop table if exists work.temp;
create table work.temp as
SELECT * from pubs.PUB_CORE WHERE Citation Like "%Prognostic%Value%";

select max(pubmaster_id2)+1 from pubs.PUB_CORE;


select * from pubs.PUB_CORE where pubmaster_id2=1031;

SELECT * from pubs.PUB_CORE WHERE PMID IN (

UPDATE pubs.PUB_CORE SET NIHMS_Status='PMC Compliant' WHERE PMC<>'';

UPDATE pubs.PUB_CORE SET NIHMS_Status='Not IN NIHMS' WHERE NIHMS_Status='XXX';

SELECT * from  pubs.PUB_CORE WHERE NIHMS_Status='XXX';

select * from pubs.PUB_CORE where pubmaster_id2=507;

select distinct PMC from pubs.PUB_CORE;




select pa.pubmaster_id2 AS pubmaster_id2_PA,
       pa.PMID AS PMID_PA,
       pa.PMC AS PMC_PA,
       pc.pubmaster_id2,
       pc.PMID,
       pc.PMC
FROM pubs.PUB_PROGRAM_ASSIGN pa LEFT JOIN
     pubs.PUB_CORE pc ON pa.pubmaster_id2=pc.pubmaster_id2
WHERE pa.PMID<>pc.PMID;     ;



select pa.pubmaster_id2 AS pubmaster_id2_PA,
       pa.PMID AS PMID_PA,
       pa.PMC AS PMC_PA,
       pa.Citation as Cite_PA,
       pc.pubmaster_id2,
       pc.PMID,
       pc.PMC,
       pa.Citation
FROM pubs.PUBCOREBACKUP pa LEFT JOIN
     pubs.PUB_CORE pc ON pa.pubmaster_id2=pc.pubmaster_id2
WHERE ;  


select pubmaster_id2 from pubs.pmc_comp_mail
WHERE pubmaster_id2 NOT IN (SELECT 



######################################################
######################################################

select pa.pubmaster_id2 AS pubmaster_id2_PA,
       pa.PMID AS PMID_PA,
       pa.Citation as Cite_PA,
       pc.pubmaster_id2,
       pc.PMID,
       pc.PMC,
       pa.Citation
FROM pubs.pmc_comp_mail pa LEFT JOIN
     pubs.PUB_CORE pc ON pa.pubmaster_id2=pc.pubmaster_id2
    
WHERE pa.PMID<>pc.PMID;  
