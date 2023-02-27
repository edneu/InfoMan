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

########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
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
########################################################################################################
########################################################################################################
########################################################################################################
################# SJR H Factor Table
################# SORUCE OF ISSNS

#####Drop table if exists  biblio.sjr_impact;
select * from biblio.sjr_impact;
select count(*) from biblio.sjr_impact;
            
            
ALTER TABLE biblio.ulpubs
ADD sjr_iSSN varchar(45),
ADD sjr_Hindex int(5),
ADD sjr_Quartile varchar(5);

SET SQL_SAFE_UPDATES = 0;

UPDATE biblio.ulpubs
SET sjr_ISSN=NULL,
	sjr_Hindex=NULL,
	sjr_Quartile=Null;
    
    
UPDATE biblio.ulpubs pb, biblio.sjr_impact lu
SET pb.sjr_ISSN=lu.Issn,
	pb.sjr_Hindex=lu.H_index,
    pb.sjr_Quartile=lu.SJR_Best_Quartile
WHERE pb.IC_Journal=lu.Title
AND pb.sjr_Hindex is null;    
    
UPDATE biblio.ulpubs pb, biblio.sjr_impact lu
SET pb.sjr_ISSN=lu.Issn,
	pb.sjr_Hindex=lu.H_index,
    pb.sjr_Quartile=lu.SJR_Best_Quartile
WHERE pb.CM_Journal=lu.Title
AND pb.sjr_Hindex is null;        

 ## Load CUrated Data
 UPDATE biblio.ulpubs pb, biblio.sjr_curate lu
SET pb.sjr_ISSN=lu.Issn,
	pb.sjr_Hindex=lu.H_index,
    pb.sjr_Quartile=lu.SJR_Best_Quartile
WHERE pb.CM_Journal=lu.CM_Journal
AND pb.sjr_Hindex is null;        

## select count(*) from biblio.ulpubs where sjr_Hindex is null; ### 18!
 
#################################################################################################
#################################################################################################
#################################################################################################
#############  ADD WOS Impact Data from Dr. Song at Cancer Center
#################################################################################################
#################################################################################################
### FORMAT ISSN FOR Merge with Impact Factor table from Cancer Center 
### Clarivate JCR

Alter Table biblio.ulpubs 
	ADD fmt_ISSN1 varchar(12),
	ADD fmt_ISSN2 varchar(12);

SET SQL_SAFE_UPDATES = 0;
UPDATE biblio.ulpubs
	SET fmt_ISSN1=NULL,
		fmt_ISSN2=NULL;

UPDATE biblio.ulpubs
	SET Fmt_ISSN1=CONCAT(SUBSTR(sjr_iSSN,1,4),"-",SUBSTR(sjr_iSSN,5,4)),
        Fmt_ISSN2=CONCAT(SUBSTR(sjr_iSSN,11,4),"-",SUBSTR(sjr_iSSN,15,4));
        
 UPDATE biblio.ulpubs
	SET Fmt_ISSN2=Null
 WHERE Fmt_ISSN2="-";       

SELECT sjr_iSSN,Fmt_ISSN1,Fmt_ISSN2 from biblio.ulpubs;

#################################################################################################
#################################################################################################
##UNDUP IMPACT Factors TABLE
DROP TABLE IF EXISTS biblio.jcr_impact_lookup;
create table biblio.jcr_impact_lookup as
SELECT 	Full_Journal_Title,
		JCR_Abbreviated_Title,
        ISSN,
        `ISSN-2`,
        Total_Cites,
        Journal_Impact_Factor,
        Impact_Factor_without_Journal_Self_Cites,
        Five_Year_Impact_Factor,
        Eigenfactor_Score,
        count(*) as nRecs
from biblio.jcr_impact_factor
GROUP BY Full_Journal_Title,
		JCR_Abbreviated_Title,
        ISSN,
        `ISSN-2`,
        Total_Cites,
        Journal_Impact_Factor,
        Impact_Factor_without_Journal_Self_Cites,
        Five_Year_Impact_Factor,
        Eigenfactor_Score;
#################################################################################################
ALTER TABLE biblio.ulpubs
    ADD jcr_Full_Journal_Title varchar(255),
    ADD jcr_JCR_Abbreviated_Title varchar(45),
    ADD jcr_ISSN varchar(12) ,
    ADD jcr_ISSN_2 varchar(12),
    ADD jcr_Total_Cites int(11) ,
    ADD jcr_Journal_Impact_Factor decimal(65,30),
    ADD jcr_Impact_Factor_without_Journal_Self_Cites decimal(65,30),
    ADD jcr_Five_Year_Impact_Factor decimal(65,30) ,
    ADD jcr_Eigenfactor_Score decimal(65,30),
    ADD jcr_Status varchar(25);

UPDATE biblio.ulpubs ul
SET ul.jcr_Full_Journal_Title=NULL,
    ul.jcr_JCR_Abbreviated_Title=NULL,
    ul.jcr_ISSN=NULL,
    ul.jcr_ISSN_2=NULL,
    ul.jcr_Total_Cites=NULL,
    ul.jcr_Journal_Impact_Factor=NULL,
    ul.jcr_Impact_Factor_without_Journal_Self_Cites=NULL,
    ul.jcr_Five_Year_Impact_Factor=NULL,
    ul.jcr_Eigenfactor_Score=NULL,
    ul.jcr_Status = "No WOS Record";



#### ISSN MATCH
SET SQL_SAFE_UPDATES = 0;
UPDATE biblio.ulpubs ul, biblio.jcr_impact_lookup lu
SET	ul.jcr_Full_Journal_Title=lu.Full_Journal_Title,
    ul.jcr_JCR_Abbreviated_Title=lu.JCR_Abbreviated_Title,
    ul.jcr_ISSN=lu.ISSN ,
    ul.jcr_ISSN_2=lu.`ISSN-2`,
    ul.jcr_Total_Cites=lu.Total_Cites ,
    ul.jcr_Journal_Impact_Factor=lu.Journal_Impact_Factor,
    ul.jcr_Impact_Factor_without_Journal_Self_Cites=lu.Impact_Factor_without_Journal_Self_Cites,
    ul.jcr_Five_Year_Impact_Factor=lu.Five_Year_Impact_Factor,
    ul.jcr_Eigenfactor_Score=lu.Eigenfactor_Score,
    ul.jcr_Status = "Has WOS Record"
WHERE (ul.fmt_ISSN1=lu.ISSN OR ul.fmt_ISSN1=lu.`ISSN-2` OR ul.fmt_ISSN2=lu.ISSN OR ul.fmt_ISSN2=lu.`ISSN-2`)
AND ul.fmt_ISSN1 IS NOT NULL ;    

## TITLE MATCH 1
UPDATE biblio.ulpubs ul, biblio.jcr_impact_lookup lu
SET	ul.jcr_Full_Journal_Title=lu.Full_Journal_Title,
    ul.jcr_JCR_Abbreviated_Title=lu.JCR_Abbreviated_Title,
    ul.jcr_ISSN=lu.ISSN ,
    ul.jcr_ISSN_2=lu.`ISSN-2`,
    ul.jcr_Total_Cites=lu.Total_Cites ,
    ul.jcr_Journal_Impact_Factor=lu.Journal_Impact_Factor,
    ul.jcr_Impact_Factor_without_Journal_Self_Cites=lu.Impact_Factor_without_Journal_Self_Cites,
    ul.jcr_Five_Year_Impact_Factor=lu.Five_Year_Impact_Factor,
    ul.jcr_Eigenfactor_Score=lu.Eigenfactor_Score,
    ul.jcr_Status = "Has WOS Record"
WHERE (ul.CM_Journal=lu.Full_Journal_Title OR ul.CM_Journal=lu.JCR_Abbreviated_Title)
AND ul.jcr_Journal_Impact_Factor IS NULL;

## TITLE MATCH 2
UPDATE biblio.ulpubs ul, biblio.jcr_impact_lookup lu
SET	ul.jcr_Full_Journal_Title=lu.Full_Journal_Title,
    ul.jcr_JCR_Abbreviated_Title=lu.JCR_Abbreviated_Title,
    ul.jcr_ISSN=lu.ISSN ,
    ul.jcr_ISSN_2=lu.`ISSN-2`,
    ul.jcr_Total_Cites=lu.Total_Cites ,
    ul.jcr_Journal_Impact_Factor=lu.Journal_Impact_Factor,
    ul.jcr_Impact_Factor_without_Journal_Self_Cites=lu.Impact_Factor_without_Journal_Self_Cites,
    ul.jcr_Five_Year_Impact_Factor=lu.Five_Year_Impact_Factor,
    ul.jcr_Eigenfactor_Score=lu.Eigenfactor_Score,
    ul.jcr_Status = "Has WOS Record"
WHERE (ul.IC_Journal=lu.Full_Journal_Title OR ul.IC_Journal=lu.JCR_Abbreviated_Title)
AND ul.jcr_Journal_Impact_Factor IS NULL;

### SET Has WOS Impact factor
UPDATE biblio.ulpubs ul 
	SET  ul.jcr_Status ="Has WOS JIF"
WHERE ul.jcr_Journal_Impact_Factor is not null;


## Classification Summary
selecT jcr_Status, COUNT(*) AS nPUBS, count(distinct CM_Journal) as nJournals
FROM biblio.ulpubs
group by jcr_Status; 


######OUTPUT TABLE
SELECT 	PM_PMID,
		PM_PMCID,
        PM_Citation,
        year(CM_Pub_Date) AS PubYear,
        IC_RCR,
        IC_Citations_Per_Year,
        IC_NIH_Percentile,
        jcr_Full_Journal_Title,
        jcr_Total_Cites,
        jcr_Journal_Impact_Factor,
        jcr_Impact_Factor_without_Journal_Self_Cites,
        jcr_Five_Year_Impact_Factor,
        jcr_Status
from biblio.ulpubs;        
        


FROM biblio.ulpubs

###create table biblio.ul_pubs_bu as select * from biblio.ulpubs;


##############################################################################################################################
##############################################################################################################################
##############################################################################################################################
### EOF
##############################################################################################################################
##############################################################################################################################
##############################################################################################################################