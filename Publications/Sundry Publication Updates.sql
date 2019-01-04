select year(PubDate),count(*) from pubs.PUB_CORE where PMC="" group by year(PubDate);
select NIHMS_Status,count(*) from pubs.PUB_CORE group by NIHMS_Status;


select * from pubs.PUB_CORE where PubDate IS NULL AND PMC="";

SET SQL_SAFE_UPDATES = 0;
UPDATE pubs.PUB_CORE SET PubDate=str_to_date('11,24,2017','%m,%d,%Y') where pubmaster_id2=786;


UPDATE pubs.PUB_CORE 
SET Citation="Goodman, J. R., Duke, L. L., Theis, R. P., & Shenkman, E. A. (2018). “The problem is people don’t know how to talk to you:” How Medicaid recipients understand and use health plan report cards and instruction sheets. Health Marketing Quarterly, 1-18." ,
    PubDate=str_to_date('12,27,2018','%m,%d,%Y'),
ProgRLead_LAST="Shenkman",
ProgRLead_FIRST="Elizibeth",
ProgRLead_EMAIL="eshenkman@ufl.edu",
OnlineLink="https://www.tandfonline.com/doi/abs/10.1080/07359683.2018.1514736",
Grant_Numbers="Texas EQRO/Evaluating Healthcare Quality in Texas Medicaid and CHIP [529-07-0093-00001]",
CTSI_GRANT=0,
Excluded=0,
May18Grant=0,
PilotPub=0,
ProgOct2018=0,
PMID="30588874",
NIHMS_Status='Not IN NIHMS'
where pubmaster_id2=729;

select distinct NIHMS_Status from pubs.PUB_CORE;

select * from pubs.PUB_CORE where pubmaster_id2=729;