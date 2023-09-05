
## Create work file.
DROP TABLE IF EXISTS biblio.BibWork;
Create table biblio.BibWork as
select * from biblio.biblio;        ### 2018+ UL KL TL icite, Altmetrics, JIF 

##DROP TABLE biblio.biblio;

Desc biblio.BibWork;

## By Grant Attribution
select count(Distinct PMID) as nPubs
from biblio.BibWork; 


##  Total Unduplicated
select Grants,count(Distinct PMID) as nPubs
from biblio.BibWork 
GROUP BY Grants;

DROP TABLE IF EXISTS biblio.OutTemp;
create table biblio.OutTemp AS
Select  "UL1" as Award,
        count(*) as nPUBS,
		min(RCR_iCITE) as min_RCR,
		avg(RCR_iCITE) as avg_RCR,
        max(RCR_iCITE) as max_RCR,
        min(NIH_Percentile_iCITE) as min_NIHPCT,
		avg(NIH_Percentile_iCITE) as avg_NIHPCT,
        max(NIH_Percentile_iCITE) as max_NIHPCT,
        min(Total_Citations) as min_TotCite,
		avg(Total_Citations) as avg_TotCite,
        max(Total_Citations) as max_TotCite,
        min(JIF_latest) as min_JIF,
		avg(JIF_latest) as avg_JIF,
        max(JIF_latest) as max_JIF
from biblio.BibWork
WHERE Grants LIKE "%UL1%"
UNION ALL
Select  "KL2" as Award,
        count(*) as nPUBS,
		min(RCR_iCITE) as min_RCR,
		avg(RCR_iCITE) as avg_RCR,
        max(RCR_iCITE) as max_RCR,
        min(NIH_Percentile_iCITE) as min_NIHPCT,
		avg(NIH_Percentile_iCITE) as avg_NIHPCT,
        max(NIH_Percentile_iCITE) as max_NIHPCT,
        min(Total_Citations) as min_TotCite,
		avg(Total_Citations) as avg_TotCite,
        max(Total_Citations) as max_TotCite,
        min(JIF_latest) as min_JIF,
		avg(JIF_latest) as avg_JIF,
        max(JIF_latest) as max_JIF
from biblio.BibWork
WHERE Grants LIKE "%KL2%"
UNION ALL
Select  "TL1" as Award,
        count(*) as nPUBS,
		min(RCR_iCITE) as min_RCR,
		avg(RCR_iCITE) as avg_RCR,
        max(RCR_iCITE) as max_RCR,
        min(NIH_Percentile_iCITE) as min_NIHPCT,
		avg(NIH_Percentile_iCITE) as avg_NIHPCT,
        max(NIH_Percentile_iCITE) as max_NIHPCT,
        min(Total_Citations) as min_TotCite,
		avg(Total_Citations) as avg_TotCite,
        max(Total_Citations) as max_TotCite,
        min(JIF_latest) as min_JIF,
		avg(JIF_latest) as avg_JIF,
        max(JIF_latest) as max_JIF
from biblio.BibWork
WHERE Grants LIKE "%TL1%";

################################################################################
#### RCR
## By Grant Attribution
select count(Distinct PMID) as nPubs
from biblio.BibWork
WHERE PMID_Icite IS NOT NULL; 


##  Total Unduplicated
select Grants,count(Distinct PMID) as nPubs
from biblio.BibWork 
WHERE PMID_Icite IS NOT NULL
GROUP BY Grants ORDER BY Grants;

#####
## Journal Impact Factor
Select distinct JIF_latest from biblio.BibWork ;

## By Grant Attribution
select count(Distinct PMID) as nPubs
from biblio.BibWork
WHERE JIF_latest IS NOT NULL; 


##  Total Unduplicated
select Grants,count(Distinct PMID) as nPubs
from biblio.BibWork 
WHERE JIF_latest IS NOT NULL
GROUP BY Grants ORDER BY Grants;

Alter table  biblio.BibWork 
ADD JIFGroup varchar(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE biblio.BibWork SET JIFGroup="A. JIF <1" Where JIF_latest<1;
UPDATE biblio.BibWork SET JIFGroup="B. JIF 1-2.99" Where JIF_latest>=1 AND JIF_latest<3;
UPDATE biblio.BibWork SET JIFGroup="C. JIF 3-4.99" Where JIF_latest>=3 AND JIF_latest<5;
UPDATE biblio.BibWork SET JIFGroup="D. JIF 5-9.99" Where JIF_latest>=5 AND JIF_latest<10;
UPDATE biblio.BibWork SET JIFGroup="E. JIF 10-14.99" Where JIF_latest>=10 AND JIF_latest<15;
UPDATE biblio.BibWork SET JIFGroup="F. JIF 15-19.99" Where JIF_latest>=15 AND JIF_latest<20;
UPDATE biblio.BibWork SET JIFGroup="G. JIF 20-49.99" Where JIF_latest>=20 AND JIF_latest<50;
UPDATE biblio.BibWork SET JIFGroup="H. JIF 50-99.99" Where JIF_latest>=50 AND JIF_latest<100;
UPDATE biblio.BibWork SET JIFGroup="I. JIF >=100" Where JIF_latest>=100 ;

SELECT JIFGroup,count(Distinct PMID) as nPUBS
FROM biblio.BibWork
GROUP BY JIFGroup;

SELECT JIFGroup,count(Distinct PMID) as nPUBS
FROM biblio.BibWork
WHERE Grants LIKE "%UL1%"
GROUP BY JIFGroup
;

###################################################################################################################
select * From biblio.BibWork; 
DESC biblio.BibWork;

################################################################################       
## ALTMETRICS
## By Grant Attribution
select count(Distinct PMID) as nPubs
from biblio.BibWork
WHERE PMID_AM IS NOT NULL; 

##  Total Unduplicated
select Grants,count(Distinct PMID) as nPubs
from biblio.BibWork 
WHERE PMID_AM IS NOT NULL
GROUP BY Grants ORDER BY Grants;





      
DROP TABLE IF EXISTS biblio.AltOutTemp;
create table biblio.AltOutTemp AS
Select  "ALL" as Award,
        count(*) as nPUBS,
		min(Altmetric_Attention_Score_AM) as minAltAtt,
        avg(Altmetric_Attention_Score_AM) as avgAltAtt,
        max(Altmetric_Attention_Score_AM) as maxAltAtt,
		Sum(Twitter_mentions_AM) as TotTwitter,
        Avg(Twitter_mentions_AM) as AvgTwitter,
        Max(Twitter_mentions_AM) as MaxTwitter,
        Sum(Facebook_mentions_AM) as TotFaceB,
        Avg(Facebook_mentions_AM) as AvgFaceB,
        Max(Facebook_mentions_AM) as MaxFaceB,
		Sum(News_mentions_AM) as TotNews,
        Avg(News_mentions_AM) as AvgNews,
        Max(News_mentions_AM) as MaxNews,
        Sum(Policy_mentions_AM) as TotPolicy,
        Avg(Policy_mentions_AM) as AvgPolicy,
        Max(Policy_mentions_AM) as MaxPolicy
from biblio.BibWork
WHERE  PMID_AM IS NOT NULL
UNION ALL
SELECT  "UL1" as Award,
        count(*) as nPUBS,
		min(Altmetric_Attention_Score_AM) as minAltAtt,
        avg(Altmetric_Attention_Score_AM) as avgAltAtt,
        max(Altmetric_Attention_Score_AM) as maxAltAtt,
		Sum(Twitter_mentions_AM) as TotTwitter,
        Avg(Twitter_mentions_AM) as AvgTwitter,
        Max(Twitter_mentions_AM) as MaxTwitter,
        Sum(Facebook_mentions_AM) as TotFaceB,
        Avg(Facebook_mentions_AM) as AvgFaceB,
        Max(Facebook_mentions_AM) as MaxFaceB,
		Sum(News_mentions_AM) as TotNews,
        Avg(News_mentions_AM) as AvgNews,
        Max(News_mentions_AM) as MaxNews,
        Sum(Policy_mentions_AM) as TotPolicy,
        Avg(Policy_mentions_AM) as AvgPolicy,
        Max(Policy_mentions_AM) as MaxPolicy
from biblio.BibWork
WHERE Grants Like "%UL1%" AND PMID_AM IS NOT NULL
UNION ALL
SELECT  "KL2" as Award,
        count(*) as nPUBS,
		min(Altmetric_Attention_Score_AM) as minAltAtt,
        avg(Altmetric_Attention_Score_AM) as avgAltAtt,
        max(Altmetric_Attention_Score_AM) as maxAltAtt,
		Sum(Twitter_mentions_AM) as TotTwitter,
        Avg(Twitter_mentions_AM) as AvgTwitter,
        Max(Twitter_mentions_AM) as MaxTwitter,
        Sum(Facebook_mentions_AM) as TotFaceB,
        Avg(Facebook_mentions_AM) as AvgFaceB,
        Max(Facebook_mentions_AM) as MaxFaceB,
		Sum(News_mentions_AM) as TotNews,
        Avg(News_mentions_AM) as AvgNews,
        Max(News_mentions_AM) as MaxNews,
        Sum(Policy_mentions_AM) as TotPolicy,
        Avg(Policy_mentions_AM) as AvgPolicy,
        Max(Policy_mentions_AM) as MaxPolicy
from biblio.BibWork
WHERE Grants Like "%KL2" AND PMID_AM IS NOT NULL
UNION ALL
SELECT  "TL1" as Award,
        count(*) as nPUBS,
		min(Altmetric_Attention_Score_AM) as minAltAtt,
        avg(Altmetric_Attention_Score_AM) as avgAltAtt,
        max(Altmetric_Attention_Score_AM) as maxAltAtt,
		Sum(Twitter_mentions_AM) as TotTwitter,
        Avg(Twitter_mentions_AM) as AvgTwitter,
        Max(Twitter_mentions_AM) as MaxTwitter,
        Sum(Facebook_mentions_AM) as TotFaceB,
        Avg(Facebook_mentions_AM) as AvgFaceB,
        Max(Facebook_mentions_AM) as MaxFaceB,
		Sum(News_mentions_AM) as TotNews,
        Avg(News_mentions_AM) as AvgNews,
        Max(News_mentions_AM) as MaxNews,
        Sum(Policy_mentions_AM) as TotPolicy,
        Avg(Policy_mentions_AM) as AvgPolicy,
        Max(Policy_mentions_AM) as MaxPolicy
from biblio.BibWork
WHERE Grants Like "%Tl1" AND PMID_AM IS NOT NULL;

select * from biblio.BibWork;

Select count(*) as nPUB, Sum(Total_Citations) totcite from biblio.BibWork where Grants LIKE "%UL1%";



select * From biblio.BibWork; 
DESC biblio.BibWork;