####### PUBME#D Table Compliance
SET sql_mode = '';



ALTER TABLE loaddata.pubmedcompsept2017
ADD CTSI_RELATED int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE loaddata.pubmedcompsept2017
SET CTSI_RELATED=0;

UPDATE loaddata.pubmedcompsept2017
SET CTSI_RELATED=1
WHERE Grant_number in 
('KL2 RR029888',
'KL2 TR000065',
'KL2 TR001429',
'TL1 RR029889',
'TL1 TR000066',
'TL1 TR001428',
'UL1 RR029890',
'UL1 TR000064',
'UL1 TR001427');


Select PubYear,count(DISTINCT PMID) from loaddata.pubmedcompsept2017 group by PubYear;
Select PubYear,count(DISTINCT PMID) from loaddata.pubmedcompsept2017 WHERE PMCID<>"" group by PubYear;

Select PubYear,count(DISTINCT PMID) from loaddata.pubmedcompsept2017 WHERE CTSI_RELATED=1 group by PubYear;
Select PubYear,count(DISTINCT PMID) from loaddata.pubmedcompsept2017 WHERE CTSI_RELATED=1 AND PMCID<>"" group by PubYear;

