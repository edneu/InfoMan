
DROP TABLE IF EXISTS work.pmcmon;
CREATE table work.pmcmon AS
select * from pubs.uf_pmcmon;


desc work.pmcmon;
/*
CTSI GRANTS
Grant Number	Year	Grant Desc
KL2 RR029888	2009-2011	KL2 2009-2011
KL2 TR000065	2012-2015	KL2 2012-2015
KL2 TR001429	2015-2018	KL2 2015-2018
TL1 RR029889	2009-2011	TL1 2009-2011
TL1 TR000066	2012-2015	TL1 2012-2015
TL1 TR001428	2015-2018	TL1 2015-2018
UL1 RR029890	2009-2011	UL1 2009-2011
UL1 TR000064	2012-2015	UL1 2012-2015
UL1 TR001427	2015-2018	UL1 2015-2018

*/



ALTER TABLE work.pmcmon
    ADD KL2_9888 int(1),
    ADD KL2_0065 int(1),
    ADD KL2_1429 int(1),
    ADD TL1_9889 int(1),
    ADD TL1_0066 int(1),
    ADD TL1_1428 int(1),
    ADD UL1_9890 int(1),
    ADD UL1_0064 int(1),
    ADD UL1_1427 int(1);


SET SQL_SAFE_UPDATES = 0;
    
UPDATE work.pmcmon    
SET KL2_9888=0,
    KL2_0065=0,
    KL2_1429=0,
    TL1_9889=0,
    TL1_0066=0,
    TL1_1428=0,
    UL1_9890=0,
    UL1_0064=0,
    UL1_1427=0;


UPDATE work.pmcmon SET NIHMSID=NULL WHERE NIHMSID="00000000";
UPDATE work.pmcmon SET PMCID=NULL WHERE PMCID="00000000";


UPDATE work.pmcmon SET KL2_9888=1 WHERE Grant_number='KL2 RR029888';
UPDATE work.pmcmon SET KL2_0065=1 WHERE Grant_number='KL2 TR000065';
UPDATE work.pmcmon SET KL2_1429=1 WHERE Grant_number='KL2 TR001429';
UPDATE work.pmcmon SET TL1_9889=1 WHERE Grant_number='TL1 RR029889';
UPDATE work.pmcmon SET TL1_0066=1 WHERE Grant_number='TL1 TR000066';
UPDATE work.pmcmon SET TL1_1428=1 WHERE Grant_number='TL1 TR001428';
UPDATE work.pmcmon SET UL1_9890=1 WHERE Grant_number='UL1 RR029890';
UPDATE work.pmcmon SET UL1_0064=1 WHERE Grant_number='UL1 TR000064';
UPDATE work.pmcmon SET UL1_1427=1 WHERE Grant_number='UL1 TR001427';


DROP TABLE IF EXISTS pubs.PMC_MON; 
Create table pubs.PMC_MON AS
select PMID,
min(MonStatus) AS MonStatus,	
max(PMCID) AS PMCID,	
max(NIHMSID) AS NIHMSID,	
max(Publication_Date) AS Publication_Date,	
max(Article_Title) AS Article_Title,	
max(First_Author_Name) AS First_Author_Name,	
max(Journal_Title) AS Journal_Title,	
max(Journal_Publisher) AS Journal_Publisher,	
max(Method_A_Journal) AS Method_A_Journal,	
max(NIHMS_Person) AS NIHMS_Person,	
max(Initial_Actor) AS Initial_Actor,	
max(KL2_9888) AS KL2_9888,	
max(KL2_0065) AS KL2_0065,	
max(KL2_1429) AS KL2_1429,	
max(TL1_9889) AS TL1_9889,	
max(TL1_0066) AS TL1_0066,	
max(TL1_1428) AS TL1_1428,	
max(UL1_9890) AS UL1_9890,	
max(UL1_0064) AS UL1_0064,	
max(UL1_1427) AS UL1_1427
FROM work.pmcmon

WHERE 	(KL2_9888+
		KL2_0065+
		KL2_1429+
		TL1_9889+
		TL1_0066+
		TL1_1428+
		UL1_9890+
		UL1_0064+
		UL1_1427)>0

group by PMID
order by PMID;	

       
