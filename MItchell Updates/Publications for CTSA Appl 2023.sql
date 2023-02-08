#### Publication analysis for CTSA application 2023

/*
**** Query Pubmed for all UL1 Grant published 2018 - 2/2/2023

(UL1 TR001427[Grant Number]) AND (("2017/12/31"[Date - Publication] : "3000"[Date - Publication]))
626 results
Save as Summary Text

Export to Text file - Convert multi line citation to singleline
		Replace \r with <CR>
        Replace <CR><CR> with \r
        Replace <CR> with ' '
        
Load FIle to mySQl server filename work.pubmed_raw        
Process resulting file using: 
https://github.com/edneu/InfoMan/blob/master/Publications/PubMed%20Raw%20Record%20Cleaner.sql
Code embedded in this file below. 

*/

Alter table work.pubmed_raw
ADD Citation Text,
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
select * from work.pubmed_raw;

##### MAKE Pubmed Output file
DROP TABLE IF EXISTS work.PubmedOUT;
create table work.PubmedOUT as
select
	PMID,
	PMCID,
	Citation 
from work.pubmed_raw
order by PMID;

##############
/* 
## LOAD output TABLE (work.PubmedOUT) TO xlsx

### Query NCBI Open Access Compliance monitor to supplement citation with Date of Publication, Publication Name, etc
### Compliance Monitor is located here : https://www.ncbi.nlm.nih.gov/pmc/utils/pacm/s
### Match Pubmed Citation to Complinace monitor data using PMID (varchar)  - Add Publication Date, Journal, Publisher

### Query iCITE using PMID set from excel table
### Add iCIte Data As worksheet

*/ 
USE biblio;

## Create workfile

drop table if exists biblio.ulpubs;
Create table biblio.ulpubs as 
Select * from biblio.pubmed_ul1_20230203;

## check for duplicates
select count(*) as nREC, count(distinct PM_PMID) as UniquePMID from biblio.ulpubs;

## # Pubs by year check for date issues
select 	year(CM_Pub_Date) as PubdateYear,
		IC_Year ,
        count(distinct PM_PMID) 
   from biblio.ulpubs 
   group by year(CM_Pub_Date), IC_Year ;
   
/*  
# PubdateYear	IC_Year	count(distinct PM_PMID)
2018	2018	157
2019	2019	95
2020	2019	1
2020	2020	130
2021	2020	2
2021	2021	134
2022	0		1
2022	2021	2
2022	2022	93
2023	2023	4


There are discrepenbcies between the 
	Year of the Publication Date and the Publication Year in iCITE.
    The Icite Date has Missing Vlaes as well, So we will proceed using 
    the Compliance Monitor Pubdate Year as the reference year for the analysis.

*/
select 	year(CM_Pub_Date) as PubdateYear,
		count(distinct PM_PMID) 
   from biblio.ulpubs 
   group by year(CM_Pub_Date);

/*
# PubdateYear	count(distinct PM_PMID)
2018	157
2019	95
2020	131
2021	136
2022	96
2023	4

*/

select 	year(CM_Pub_Date) as PubdateYear,
		count(distinct PM_PMID) 
        
   from biblio.ulpubs 
   group by year(CM_Pub_Date);



##Select Unique list of Publishers and Journals
select 	CM_Publisher AS Publisher,
		CM_Journal as Journal,
        count(*) as nRECs
   from biblio.ulpubs 
   group by CM_Publisher, CM_Journal;
## n=388

## Use iCITE Journal
select 	IC_Journal as Journal,
        count(*) as nRECs
   from biblio.ulpubs 
   group by IC_Journal;
## 385

## Check Match CM_Journal, iCITE Journal
select 	IC_Journal,
		CM_Journal,
        count(*) as nRECs
   from biblio.ulpubs 
   group by IC_Journal,
			CM_Journal;
        
#387            
### CHECK THE NON MATCH
select 	IC_Journal,
		CM_Journal,
        count(*) as nRECs
   from biblio.ulpubs 
   WHERE IC_Journal <> 	CM_Journal
   group by IC_Journal,
			CM_Journal;
## Looks like the CM_Journal is more complete
################
################
####  DROP TABLE IF EXISTS biblio.impact1;
#### Test Matching with Impact File
################
ALTER TABLE biblio.ulpubs
ADD impactID int(5),
ADD im_journal varchar(255),
ADD im_jcr_abbr varchar(25);

SET SQL_SAFE_UPDATES = 0;

UPDATE biblio.ulpubs 
SET impactID=NULL,
	im_journal=NULL,
	im_jcr_abbr=NULL;
    
UPDATE biblio.ulpubs pb, biblio.impact1 im
SET pb.impactID =im.impact1_id,
	pb.im_journal=im.Journal_name,
	pb.im_jcr_abbr=JCR_Abbreviation
WHERE pb.CM_Journal=im.Journal_name
AND pb.impactID IS NULL;

UPDATE biblio.ulpubs pb, biblio.impact1 im
SET pb.impactID =im.impact1_id,
	pb.im_journal=im.Journal_name,
	pb.im_jcr_abbr=JCR_Abbreviation
WHERE pb.CM_Journal=im.JCR_Abbreviation
AND pb.impactID IS NULL;

UPDATE biblio.ulpubs pb, biblio.impact1 im
SET pb.impactID =im.impact1_id,
	pb.im_journal=im.Journal_name,
	pb.im_jcr_abbr=JCR_Abbreviation
WHERE pb.IC_Journal=im.Journal_name
AND pb.impactID IS NULL;

UPDATE biblio.ulpubs pb, biblio.impact1 im
SET pb.impactID =im.impact1_id,
	pb.im_journal=im.Journal_name,
	pb.im_jcr_abbr=JCR_Abbreviation
WHERE pb.IC_Journal=im.JCR_Abbreviation
AND pb.impactID IS NULL;

Select * from biblio.ulpubs ORDER BY impactid DESC;


drop table if exists  biblio.curate_im;
create table biblio.curate_im AS
Select IC_Journal,
	   CM_Journal,
       impactID,
       im_journal,
       im_jcr_abbr,
       COunt(*) as nPubs
from biblio.ulpubs
WHERE impactID IS NOT NULL
GROUP BY IC_Journal,
	   CM_Journal,
       impactID,
       im_journal,
       im_jcr_abbr
       ORDER BY CM_Journal;


;





            