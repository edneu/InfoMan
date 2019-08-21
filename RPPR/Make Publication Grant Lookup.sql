
create table work.pmidctsi as
Select * from work.ctsi_grant_lookup;


select distinct Grant_number from work.pmidctsi;
SET SQL_SAFE_UPDATES = 0;	

Alter table work.pmidctsi
ADD KL2_RR029888 int(1),
ADD KL2_TR000065 int(1),
ADD KL2_TR001429 int(1),
ADD TL1_RR029889 int(1),
ADD TL1_TR000066 int(1),
ADD TL1_TR001428 int(1),
ADD UL1_RR029890 int(1),
ADD UL1_TR000064 int(1),
ADD UL1_TR001427 int(1);

UPDATE work.pmidctsi
SET KL2_RR029888=0,
KL2_TR000065=0,
KL2_TR001429=0,
TL1_RR029889=0,
TL1_TR000066=0,
TL1_TR001428=0,
UL1_RR029890=0,
UL1_TR000064=0,
UL1_TR001427=0;


UPDATE work.pmidctsi SET KL2_RR029888=1 WHERE Grant_Number='KL2 RR029888';
UPDATE work.pmidctsi SET KL2_TR000065=1 WHERE Grant_Number='KL2 TR000065';
UPDATE work.pmidctsi SET KL2_TR001429=1 WHERE Grant_Number='KL2 TR001429';
UPDATE work.pmidctsi SET TL1_RR029889=1 WHERE Grant_Number='TL1 RR029889';
UPDATE work.pmidctsi SET TL1_TR000066=1 WHERE Grant_Number='TL1 TR000066';
UPDATE work.pmidctsi SET TL1_TR001428=1 WHERE Grant_Number='TL1 TR001428';
UPDATE work.pmidctsi SET UL1_RR029890=1 WHERE Grant_Number='UL1 RR029890';
UPDATE work.pmidctsi SET UL1_TR000064=1 WHERE Grant_Number='UL1 TR000064';
UPDATE work.pmidctsi SET UL1_TR001427=1 WHERE Grant_Number='UL1 TR001427';





drop table if exists work.pmid_grant_lookup ;
Create table work.pmid_grant_lookup as
select PMID,
        Max(KL2_RR029888) AS KL2_RR029888,
        Max(KL2_TR000065) AS KL2_TR000065,
        Max(KL2_TR001429) AS KL2_TR001429,
        Max(TL1_RR029889) AS TL1_RR029889,
        Max(TL1_TR000066) AS TL1_TR000066,
        Max(TL1_TR001428) AS TL1_TR001428,
        Max(UL1_RR029890) AS UL1_RR029890,
        Max(UL1_TR000064) AS UL1_TR000064,
        Max(UL1_TR001427) AS UL1_TR001427,
        MAX(PMC_Status) AS PMC_Status
FROM work.pmidctsi
GROUP BY PMID
ORDER BY PMID;

       