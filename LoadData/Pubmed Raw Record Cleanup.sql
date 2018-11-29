#### PARSE PUBMED SUMMARY OUTPUT
##DROP table work.pubmed_raw;
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
select PMID,PMCID,Citation from 
work.pubmed_raw
order by PMID;

###########################################
############# END OF FILE #################
###########################################
###########################################

SELECT 
substr(raw,LOCATE("PMID:",RAW)+6,1),
count(*)
from work.pubmed_raw
GROUP BY substr(raw,LOCATE("PMID:",RAW)+6,1);


select * from work.pubmed_raw;


desc pilots.PILOTS_PUB_MASTER;

