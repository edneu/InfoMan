

DESC loaddata.pmcmonitorraw;

drop table if exists loaddata.pmcmonitor;
Create table loaddata.pmcmonitor as
SELECT * from  loaddata.pmcmonitorraw;


Alter Table loaddata.pmcmonitor
ADD CTSI_GRANT int(1);

Alter Table loaddata.pmcmonitor
ADD PUBYEAR int(4);

UPDATE loaddata.pmcmonitor set PUBYEAR=YEAR(Publication_Date);


UPDATE loaddata.pmcmonitor set CTSI_GRANT=0;

UPDATE loaddata.pmcmonitor
SET CTSI_GRANT=1
WHERE Grant_number IN (
'KL2 RR029888',
'KL2 TR000065',
'KL2 TR001429',
'TL1 RR029889',
'TL1 TR000066',
'TL1 TR001428',
'UL1 RR029890',
'UL1 TR000064',
'UL1 TR001427');

SELECT PUBYEAR,COUNT(DISTINCT PMID)
FROM loaddata.pmcmonitor
WHERE CTSI_GRANT=1
group by PUBYEAR
ORDER BY PUBYEAR;

SELECT PUBYEAR,COUNT(DISTINCT PMID)
FROM loaddata.pmcmonitor
WHERE CTSI_GRANT=1
AND PMCid=""
group by PUBYEAR
ORDER BY PUBYEAR;

select distinct Grant_number  from loaddata.pmcmonitor where CTSI_GRANT=1;


##############
#  MAKE AGGREATEGED FILE BY PMID
#
##############
DESC loaddata.pmcmonitor;

DROP TABLE IF EXISTS plan.PMCompMonitor;
create table plan.PMCompMonitor AS
select PMID,
   max(PMCID) AS PMCID,
   max(PMCIDNum) AS PMCIDNum,
   max(NIHMS_STATUS) AS NIHMS_STATUS,
   max(NIHMSID) AS NIHMSID,
   group_concat(Grant_number) AS Grant_numbers,
   max(PI_Name) AS PI_Name,
   max(Publication_Date) AS Publication_Date,
   max(NIHMS_file_deposited) AS NIHMS_file_deposited,
   max(NIHMS_initial_approval) AS NIHMS_initial_approval,
   max(NIHMS_tagging_complete) AS NIHMS_tagging_complete,
   max(NIHMS_final_approval) AS NIHMS_final_approval,
   max(Article_Title) AS Article_Title,
   max(First_Author_Name) AS First_Author_Name,
   max(Journal_Title) AS Journal_Title,
   max(Journal_Publisher) AS Journal_Publisher,
   max(Method_A_Journal) AS Method_A_Journal,
   max(NIHMS_Person) AS NIHMS_Person,
   max(Initial_Actor) AS Initial_Actor,
   max(CTSI_GRANT) AS CTSI_GRANT,
   min(PUBYEAR) AS PUBYEAR
FROM loaddata.pmcmonitor
GROUP BY PMID
ORDER BY PMID;

CREATE INDEX PMID_PMCMon ON plan.PMCompMonitor (PMID);
