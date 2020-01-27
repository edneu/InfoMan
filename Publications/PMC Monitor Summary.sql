


work.PMC_2012_20


DROP TABLE IF EXISTS work.PMCMon;
CREATE TABLE work.PMCMon AS
SELECT * from work.pmc_2012_20;


Alter table work.PMCMon
ADD UL1 int(1),
ADD KL2 int(1),
ADD TL1 int(1),
ADD CTSI int(1),
ADD	PUBYEAR int(4);
    
UPDATE work.PMCMon
SET 	UL1=0,
		KL2=0,
        TL1=0,
        CTSI=0,
        PUBYEAR=YEAR(Publication_Date);
        
        
UPDATE work.PMCMon
SET 	UL1=1
WHERE Grant_Number IN  ("UL1 RR029890","UL1 TR000064","UL1 TR001427")   ;   

UPDATE work.PMCMon
SET 	KL2=1
WHERE Grant_Number IN  ("KL2 RR029888","KL2 TR000065","KL2 TR001429")   ;  
        
    
UPDATE work.PMCMon
SET 	TL1=1
WHERE Grant_Number IN  ("TL1 RR029889","TL1 TR000066","TL1 TR001428")   ;


UPDATE work.PMCMon
SET 	CTSI=1
WHERE UL1=1 OR KL2=1 OR TL1=1;
   
DROP TABLE IF EXISTS work.PMCREPT ;    
Create table work.PMCREPT AS
SELECT DISTINCT PUBYEAR as Year
FROM work.PMCMon;


ALter table work.PMCREPT
ADD UF_COMP int(10),
ADD UF_NONCOMP int(10),
ADD UF_COMP_PCT decimal(65,10),
ADD CTSI_COMP int(10),
ADD CTSI_NonCOMP int(10),
ADD CTSI_COMP_PCT decimal(65,10);


drop table if exists work.pmcsumm;
create table work.pmcsumm as
Select "CTSI" as Scope,
		PUBYEAR AS PUBYEAR,
        Status AS Status,
        COUNT(Distinct PMID) AS nPubs
from work.PMCMon
WHERE CTSI=1
GROUP BY "CTSI",PUBYEAR,Status
UNION ALL 
Select "UF" as Scope,
		PUBYEAR AS PUBYEAR,
        Status AS Status,
        COUNT(Distinct PMID) AS nPubs
from work.PMCMon
GROUP BY "UF",PUBYEAR,Status; 


UPDATE work.PMCREPT pr, work.pmcsumm lu
SET pr.UF_COMP=lu.nPubs
WHERE pr.Year=lu.PUBYEAR
  AND lu.Status="Complinat"
  AND lu.Scope="UF";
  
UPDATE work.PMCREPT pr, work.pmcsumm lu
SET pr.UF_NONCOMP=lu.nPubs
WHERE pr.Year=lu.PUBYEAR
  AND lu.Status="NonComp"
  AND lu.Scope="UF";  
  
  
UPDATE work.PMCREPT pr, work.pmcsumm lu
SET pr.CTSI_COMP=lu.nPubs
WHERE pr.Year=lu.PUBYEAR
  AND lu.Status="Complinat"
  AND lu.Scope="CTSI";
  
UPDATE work.PMCREPT pr, work.pmcsumm lu
SET pr.CTSI_NONCOMP=lu.nPubs
WHERE pr.Year=lu.PUBYEAR
  AND lu.Status="NonComp"
  AND lu.Scope="CTSI";   
  
  
DELETE FROM work.PMCREPT WHERE YEAR=2020;  
  
select * from  work.PMCREPT; 

UPDATE work.PMCREPT SET UF_COMP_PCT= ( UF_COMP / (UF_COMP+UF_NONCOMP));
UPDATE work.PMCREPT SET CTSI_COMP_PCT= ( CTSI_COMP / (CTSI_COMP+CTSI_NONCOMP));

SELECT Year,UF_COMP_PCT,CTSI_COMP_PCT from work.PMCREPT;