

## Calculate UF AND CTSI COmpliance Rates from PMC Compliance Monitor Data
## Create working table

drop table if exists work.pubmon;
create table work.pubmon AS
select * from pubs.compmon1219;



ALTER TABLE  work.pubmon
ADD PubYear int(4),
ADD CTSIGrant int(1),
ADD ULGrant int(1),
ADD KLGrant int(1),
ADD TLGrant int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.pubmon SET PubYear=Year(Publication_Date);


UPDATE work.pubmon SET 	ULGrant=0,
						KLGrant=0,
                        TLGrant=0,
                        CTSIGrant=0;


UPDATE work.pubmon SET ULGrant=1
WHERE Grant_number IN
	(	'UL1 TR000064',
		'UL1 RR029890',
		'UL1 RR029890-3',
		'UL1 TR001427');
        

UPDATE work.pubmon SET KLGrant=1
WHERE Grant_number IN
	(	'KL2 RR029888-3',
		'KL2 RR029888',
		'KL2 TR000065',
		'KL2 TR001429');
        

UPDATE work.pubmon SET TLGrant=1
WHERE Grant_number IN
	(	'TL1 TR000066',
		'TL1 RR029889',
		'TL1 TR001428');
        

UPDATE work.pubmon SET CTSIGrant=1
WHERE ULGrant+
      KLGrant+
      TLGrant   >0;

DROP TABLE IF EXISTS work.PMCompYear;
create table work.PMCompYear AS
SELECT DISTINCT PubYear from work.pubmon;


Alter TABLE work.PMCompYear
	ADD UF_Comp int(12),
	ADD UF_NonComp int(12),
	ADD UF_CompRate decimal(65,10),
	ADD CTSI_Comp int(12),
	ADD CTSI_NonComp int(12),
	ADD CTSI_CompRate decimal(65,10);

drop table if exists work.uf_comp;    
Create table work.uf_comp as    
Select PubYear,count(distinct PMID) AS UF_Comp from work.pubmon WHERE Status="Comp"
GROUP by PubYear;
    
drop table if exists work.uf_noncomp;    
Create table work.uf_noncomp as    
Select PubYear,count(distinct PMID) AS UF_NonComp from work.pubmon WHERE Status="NonComp"
GROUP by PubYear;    


drop table if exists work.ctsi_comp;    
Create table work.ctsi_comp as    
Select PubYear,count(distinct PMID) AS CTSI_Comp from work.pubmon WHERE Status="Comp" AND CTSIGrant=1 
GROUP by PubYear;
    
drop table if exists work.ctsi_noncomp;    
Create table work.ctsi_noncomp as    
Select PubYear,count(distinct PMID) AS CTSI_NonComp from work.pubmon WHERE Status="NonComp" AND CTSIGrant=1
GROUP by PubYear;   


select * from work.PMCompYear;

UPDATE work.PMCompYear py,  work.uf_comp lu 	SET py.UF_Comp=lu.UF_Comp where py.PubYear=lu.PubYear;
UPDATE work.PMCompYear py,  work.uf_noncomp lu 	SET py.UF_NonComp=lu.UF_NonComp where py.PubYear=lu.PubYear;

UPDATE work.PMCompYear py,  work.ctsi_comp lu 	SET py.CTSI_Comp=lu.CTSI_Comp where py.PubYear=lu.PubYear;
UPDATE work.PMCompYear py,  work.ctsi_noncomp lu 	SET py.CTSI_NonComp=lu.CTSI_NonComp where py.PubYear=lu.PubYear;


UPDATE work.PMCompYear
SET UF_CompRate=UF_Comp/(UF_NonComp+UF_Comp),
	CTSI_CompRate=CTSI_Comp/(CTSI_NonComp+CTSI_Comp);

select * from work.PMCompYear;


/*
Grant Number	Year	Grant Desc
KL2 RR029888	2009-2011	KL2 2009-2011
KL2 TR000065	2012-2015	KL2 2012-2015
KL2 TR001429	2015-2018	KL2 2015-2018
TL1 RR029889	2009-2011	TL1 2009-2011
TL1 TR000066	2012-2015	TL1 2012-2015
TL1 TR001428	2015-2018	TL1 2015-2018
UL1 RR029890    2009-2011	UL1 2009-2011
UL1 TR000064	2012-2015	UL1 2012-2015
UL1 TR001427	2015-2018	UL1 2015-2018


select 
*/
drop table if exists work.temp;
create table work.temp as 
Select PMID,
       max(Publication_Date) as PubDate,
       max(Article_Title) as Title,
       max(First_Author_Name) FirstAuth
       from work.pubmon
where CTSIGrant=1
AND STatus='NonComp'
GROUP BY PMID;

desc work.temp;

select distinct PMID 
from work.pubmon
where CTSIGrant=1
AND STatus='NonComp'
GROUP BY PMID;



/*
ALTER TABLE work.PubmedOUT
ADD Pubdate datetime,
ADD FirstAuth varchar(255);


UPDATE work.PubmedOUT po, work.temp lu
SET po.Pubdate=lu.Pubdate,
	po.FirstAuth=lu.FirstAuth
WHERE po.PMID=lu.PMID;
*/

select * from work.PubmedOUT;