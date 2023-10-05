
USE ctsi_webcamp_pr;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.LizSQL1222;
CREATE TABLE ctsi_webcamp_adhoc.LizSQL1222 AS
SELECT 	LABTEST.LABTEST,
		PERSON.LASTNAME,
        PERSON.FIRSTNAME,
        CORESERVICE.STARTDATE,
        DEFAULTCOST,
        QUANTITY_OF_SERVICE,
        DEFAULTCOST*QUANTITY_OF_SERVICE AS AmountDue
FROM (((((	CORESERVICE INNER JOIN LABTEST ON CORESERVICE.LABTEST=LABTEST.UNIQUEFIELD)
            LEFT OUTER JOIN (SELECT MAX(UNIQUEFIELD) AS CurrUF,LABTEST FROM LABTESTCOST GROUP BY LABTEST) AS LastCostRec ON LastCostRec.LABTEST=LABTEST.UNIQUEFIELD)
            LEFT OUTER JOIN LABTESTCOST ON LABTESTCOST.UNIQUEFIELD=LastCostRec.CurrUF)
            LEFT OUTER JOIN CORESERVICE_PERSONPROVIDER ON CORESERVICE_PERSONPROVIDER.CORESERVICE=CORESERVICE.UNIQUEFIELD)
            INNER JOIN PERSON ON CORESERVICE_PERSONPROVIDER.PERSON=PERSON.UNIQUEFIELD)
WHERE concat(Year(CORESERVICE.STARTDATE),"-",lpad(month(CORESERVICE.STARTDATE),2,"0"))="2022-12"  ;  ## where clause added          
            
drop table if exists ctsi_webcamp_adhoc.recon1;
create table ctsi_webcamp_adhoc.recon1
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT LABTEST AS SERVICE
FROM ctsi_webcamp_adhoc.LizSQL1222
GROUP BY LABTEST
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
ADD TotalLiz float,
ADD TotalVRC float,
ADD DIFF float;  


drop table if exists ctsi_webcamp_adhoc.reconLiz;
create table ctsi_webcamp_adhoc.reconLiz
SELECT LABTEST AS SERVICE, SUM(AmountDue) AS TotalLiz
from ctsi_webcamp_adhoc.LizSQL1222
GROUP BY LABTEST;   

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

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconLiz lu
SET rc.TotalLiz=lu.TotalLiz
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconVRCP lu
SET rc.TotalVRC=lu.TotalVRC
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon 
SET DIFF=GREATEST(TotalInvoice,TotalLiz,TotalVRC)-LEAST(TotalInvoice,TotalLiz,TotalVRC);

DELETE FROM ctsi_webcamp_adhoc.recon
WHERE TotalInvoice IS NULL
AND TotalLiz IS NULL
AND TotalVRC IS NULL;

select * from ctsi_webcamp_adhoc.recon;

SELECT "Invoice" As Source, SUM(AmountDue) as Total  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT "Liz" As Source, SUM(AmountDue) AS Total
from ctsi_webcamp_adhoc.LizSQL1222
UNION ALL
SELECT "VRC" As Source, SUM(BillingAmt) AS Total
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12" 
AND OMIT=0
AND VisitStatus=2 
AND CoreSvcStatus=2
;


SELECT * from ctsi_webcamp_adhoc.recon
WHERE SERVICE NOT IN (SELECT DISTINCT LABTEST from LABTEST);

SELECT SUM(TotalInvoice) from ctsi_webcamp_adhoc.recon
WHERE SERVICE NOT IN (SELECT DISTINCT LABTEST from LABTEST);

######################################

drop table if exists ctsi_webcamp_adhoc.recon1;
create table ctsi_webcamp_adhoc.recon1
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT DISTINCT SERVICE
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12" ;

drop table if exists ctsi_webcamp_adhoc.recon;
create table ctsi_webcamp_adhoc.recon
SELECT DISTINCT SERVICE
FROM ctsi_webcamp_adhoc.recon1;

ALTER TABLE ctsi_webcamp_adhoc.recon
ADD TotalInvoice float,
ADD TotalVRC float,
ADD DIFF float;  


drop table if exists ctsi_webcamp_adhoc.reconVRCP;
create table ctsi_webcamp_adhoc.reconVRCP
SELECT SERVICE, SUM(BillingAmt) AS TotalVRC
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12"
GROUP BY SERVICE;   
## 14217.6249954100

drop table if exists ctsi_webcamp_adhoc.reconINV;
create table ctsi_webcamp_adhoc.reconINV
Select SERVICE, SUM(AmountDue) as TotalInvoice  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
GROUP BY SERVICE;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconINV lu
SET rc.TotalInvoice=lu.TotalInvoice
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon rc, ctsi_webcamp_adhoc.reconVRCP lu
SET rc.TotalVRC=lu.TotalVRC
WHERE rc.SERVICE=lu.SERVICE;

UPDATE ctsi_webcamp_adhoc.recon 
SET DIFF=TotalInvoice-TotalVRC;

DELETE FROM ctsi_webcamp_adhoc.recon
WHERE TotalInvoice IS NULL
AND TotalVRC IS NULL;

select * from ctsi_webcamp_adhoc.recon;

SELECT "Invoice" As Source, SUM(AmountDue) as Total  
FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
SELECT "VRC" As Source, SUM(BillingAmt) AS Total
from ctsi_webcamp_adhoc.VRCP_Master
WHERE CoreSvcMonth="2022-12";