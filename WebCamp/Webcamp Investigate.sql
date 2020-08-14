DESC ctsi_webcamp_pr.activity;

SELECT MAX(MODIFIED) from ctsi_webcamp_pr.opvisit;


SELECT MAX(MODIFIED) from ctsi_webcamp_pr.rategroup;

SELECT * from ctsi_webcamp_pr.sacapp_procedures;

SELECT MAX(MODIFIED) from ctsi_webcamp_pr.coreservice_dateoptions;

SELECT * from ctsi_webcamp_pr.databasestructuredescriptions;

SELECT * from  ctsi_webcamp_pr.PROJUSAG;

select * FROM ctsi_webcamp_pr.invoice;

SELECT MAX(MODIFIED)  from ctsi_webcamp_pr.invoice;

select * FROM ctsi_webcamp_pr.invoice WHERE YEAR(MODIFIED)=2020;




select * FROM ctsi_webcamp_pr.invoicedetail;

SELECT MAX(MODIFIED)  from ctsi_webcamp_pr.invoicedetail;

select * FROM ctsi_webcamp_pr.invoicedetail WHERE YEAR(MODIFIED)=2020;




select * FROM ctsi_webcamp_pr.lab;

SELECT MAX(MODIFIED)  from ctsi_webcamp_pr.lab;

select * FROM ctsi_webcamp_pr.lab WHERE YEAR(MODIFIED)=2020;


select * FROM ctsi_webcamp_pr.coreservice;

SELECT MAX(MODIFIED)  from ctsi_webcamp_pr.coreservice;

select * FROM ctsi_webcamp_pr.coreservice WHERE YEAR(MODIFIED)=2020;

coreservice	
CORESERVICE_DATEOPTIONS , CORESERVICE_PERSONPROVIDER , CORESERVICE_PERSONRECIPIENT , CORESERVICE_PTINFO , CORESERVICE_QUANTITYDETAIL , CORESERVICE_REQUESTINFO , CORESERVICENOTES , CORESERVICESKILL , INVOICEDETAIL , REQUESTFORM , REQUESTFORM_CORESERVICE



select * FROM ctsi_webcamp_pr.invoicedetail;

SELECT MAX(MODIFIED)  from ctsi_webcamp_pr.invoicedetail;

select * FROM ctsi_webcamp_pr.invoicedetail WHERE YEAR(MODIFIED)=2020;

SELECT MAX(SERVICESTARTDATE)  from ctsi_webcamp_pr.invoicedetail;



SELECT max(VISITDATE) from ctsi_webcamp_pr.opvisit;

SELECT DISTINCT STATUS from ctsi_webcamp_pr.opvisit;


SELECT CONCAT(Year(VISITDATE),"-",LPAD(MONTH(VISITDATE),2,"0")) AS VisitMonth

from ctsi_webcamp_pr.opvisit;
WHERE VISITDATE