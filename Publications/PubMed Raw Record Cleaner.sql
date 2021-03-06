#### PARSE PUBMED SUMMARY OUTPUT
##
## drop table work.from_pubmed;
drop table work.pubmed_raw;



## CREATE TABLE work.pubmed_raw AS select * from work.rppr_raw;

############################################
##########  ADD COLUMNS TO RAW PUBMED OUTPUT
#############################################


Alter table work.pubmed_raw
ADD Citation varchar(4000),
ADD PMID varchar(12),
ADD PMCID varchar(12);

SET SQL_SAFE_UPDATES = 0;

## REMOVE LEADING NUMBER FROM PUBMED OUTPUT
UPDATE work.pubmed_raw
SET Citation=SUBSTR(Raw, LOCATE(":",RAW)+2, CHAR_LENGTH(Raw)-(LOCATE(":",RAW)+2));
#SET Citation=trim(RAW);

## EXTRACT PMID
UPDATE work.pubmed_raw
SET PMID=SUBSTR(Raw, LOCATE("PMID:",RAW)+6, 8)
WHERE substr(raw,LOCATE("PMID:",RAW)+6,1)<>" ";

## To handle cases with 2 spaces after PMID:
UPDATE work.pubmed_raw
SET PMID=SUBSTR(Raw, LOCATE("PMID:",RAW)+7, 8)
WHERE substr(raw,LOCATE("PMID:",RAW)+6,1)=" ";



## EXTRACT PMCID
UPDATE work.pubmed_raw
SET PMCID=SUBSTR(Raw, LOCATE("PMCID:",RAW)+7, 10)
WHERE LOCATE("PMCID:",RAW)>0;

SET SQL_SAFE_UPDATES = 1;


##### MAKE Pubmed Output file
DROP TABLE IF EXISTS work.PubmedOUT;
create table work.PubmedOUT as
select 
PMID,PMCID,Citation from 
work.pubmed_raw
order by PMID;



DROP TABLE IF EXISTS work.FSU_COVID_PUBS;
create table work.FSU_COVID_PUBS as
SELECT "FSU" AS Affiliation,
        PMID,
        PMCID,
        CITATION 
 FROM work.PubmedOUT
WHERE LOCATE("COVID",CITATION)<>0;



/*
DROP TABLE IF EXISTS work.UF_COVID_PUBS;
create table work.UF_COVID_PUBS as
SELECT "UF " AS Affiliation,
        PMID,
        PMCID,
        CITATION 
 FROM work.PubmedOUT
WHERE LOCATE("COVID",CITATION)<>0;


create table Adhoc.ULKLTLPub2020 AS
select * from work.PubmedOUT ;
*/

/*
##############################
### UPDATE Pub_CORE



SET SQL_SAFE_UPDATES = 0;
UPDATE pubs.PUB_CORE pc, work.PubmedOUT lu
SET pc.PMC=lu.PMCID,
    pc.NIHMS_Status='PMC Compliant'
WHERE pc.PMID=lu.PMID
AND lu.PMCID IS NOT NULL;
SET SQL_SAFE_UPDATES = 0;


###########################################
############# END OF FILE #################
###########################################
###########################################

*/