drop table if exists ctsi_webcamp_adhoc.recon1;
create table ctsi_webcamp_adhoc.recon1
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT DISTINCT SERVICE
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12"
AND VisitStatus=2 
AND CoreSvcStatus=2;


drop table if exists ctsi_webcamp_adhoc.recon;
create table ctsi_webcamp_adhoc.recon
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.recon1;

ALTER TABLE ctsi_webcamp_adhoc.recon
ADD TotalInvoice float,
ADD TotalVRC float,
ADD DIFF float;  


drop table if exists ctsi_webcamp_adhoc.reconINV;
create table ctsi_webcamp_adhoc.reconINV
Select SERVICE, SUM(AmountDue) as TotalInvoice  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
GROUP BY SERVICE;

drop table if exists ctsi_webcamp_adhoc.reconVRCP;
create table ctsi_webcamp_adhoc.reconVRCP
SELECT SERVICE, SUM(BillingAmt) AS TotalVRC
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12"
AND VisitStatus=2 
AND CoreSvcStatus=2
GROUP BY SERVICE;  

SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconINV lu
SET rc.TotalInvoice=lu.TotalInvoice
WHERE rc.SERVICE=lu.SERVICE;


UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconVRCP lu
SET rc.TotalVRC=lu.TotalVRC
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon 
SET DIFF=ABS(TotalInvoice-TotalVRC);

DELETE FROM ctsi_webcamp_adhoc.recon
WHERE TotalInvoice IS NULL
AND TotalVRC IS NULL;

select * from ctsi_webcamp_adhoc.recon;

SELECT "Invoice" As Source, SUM(AmountDue) as Total  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT "VRC" As Source, SUM(BillingAmt) AS Total
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12" 
AND OMIT=0
AND VisitStatus=2 
AND CoreSvcStatus=2
;
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.aaaout;
create table ctsi_webcamp_adhoc.aaaout as
#select * from ctsi_webcamp_adhoc.VRCP_Master where service="Literature Search" AND CoreSvcMonth="2022-12";
#select * from ctsi_webcamp_adhoc.dec_2022_invoice where service="Literature Search";

select LabtestID, SERVICE,count(*)  from ctsi_webcamp_adhoc.VRCP_Master where ProtocolID IS NULL AND CoreSvcStatus=2 AND OMIT=0 GROUP BY LabtestID,SERVICE;

select count(*) from ctsi_webcamp_adhoc.VRCP_Master WHERE CoreSvcStatus=2 AND Pro;
### PROTOCOL ID IS MISSING


SELECT DISTINCT CRCNumber from ctsi_webcamp_adhoc.VRCP_Master WHERE Service='CTRB:  Outpatient visit (budgeted)' AND CoreSvcMonth="2022-12" 
AND OMIT=0
AND VisitStatus=2 
AND CoreSvcStatus=2;


select * from ctsi_webcamp_pr.labtestcost  where labtest =95;




SELECT * from ctsi_webcamp_adhoc.VRCP_Master WHERE Service='CTRB:  Outpatient visit (budgeted)' AND CoreSvcMonth="2022-12" 
AND OMIT=0
AND VisitStatus=2 
AND CoreSvcStatus=2
AND CRCNumber IN 
('342',
'809',
'1036',
'1325',
'1571',
'1718'
);


SELECT distinct Protocol_ID FROM ctsi_webcamp_adhoc.dec_2022_invoice
WHERE Service ='CTRB:  Outpatient visit (budgeted)';