

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.InvoiceDtlWork;
CREATE TABLE ctsi_webcamp_adhoc.InvoiceDtlWork AS
select 
	id.INVOICE AS Invoice_ID,
	id.CORESERVICE AS Coreservice_ID,
	id.LABTESTNAME AS Service,
	id.SERVICESTARTDATE,
	id.SERVICEENDDATE,
	id.QUANTITY,
	id.USUALRATE,
	id.PROJECTRATE,
	id.CREDITBALANCE,
	id.AMOUNTDUE,
    pp.PERSON AS ProvPersonID
FROM ctsi_webcamp_pr.invoicedetail id
LEFT JOIN ctsi_webcamp_pr.coreservice_personprovider pp
ON id.CORESERVICE = pp.CORESERVICE 
WHERE id.SERVICESTARTDATE>=str_to_date('01,01,2021','%m,%d,%Y') ;




select * FROM ctsi_webcamp_pr.invoice where Uniquefield=3242;
select min(DATEBILLED) from ctsi_webcamp_pr.invoice;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.InvoiceWork;
CREATE TABLE ctsi_webcamp_adhoc.InvoiceWork AS
select
	PROTOCOL AS Protocol_ID,
	UNIQUEFIELD AS Invoice_ID,
    DATEBILLED,
    concat(Year(DATEBILLED),"-",lpad(month(DATEBILLED),2,"0")) AS BilledMonth, 
    AMOUNTBILLED,
    ACCOUNTNUMBER,
	PILASTNAME,
	PIFIRSTNAME,
	PIEMAIL,
	PIPHONE,
	BILLINGCONTACTLASTNAME,
	BILLINGCONTACTFIRSTNAME,
	BILLINGCONTACTEMAIL,
	BILLINGCONTACTPHONE
FROM ctsi_webcamp_pr.invoice
WHERE UNIQUEFIELD IN (SELECT DISTINCT Invoice_ID FROM ctsi_webcamp_adhoc.InvoiceDtlWork)  ;



DROP TABLE IF EXISTS ctsi_webcamp_adhoc.ProtocolWork;
CREATE TABLE ctsi_webcamp_adhoc.ProtocolWork AS
select 
	UNIQUEFIELD As Protocol_ID,
	LONGTITLE AS Title,
    PROTOCOL AS CRC_ID,
    IRBNUMBER,
    IACUCNUMBER
FROM ctsi_webcamp_pr.protocol    
WHERE UNIQUEFIELD IN (SELECT DISTINCT Protocol_ID from ctsi_webcamp_adhoc.InvoiceWork);  
    






DROP TABLE IF EXISTS ctsi_webcamp_adhoc.InvoiceAllWork;
CREATE TABLE ctsi_webcamp_adhoc.InvoiceAllWork AS
Select * from ctsi_webcamp_adhoc.InvoiceDtlWork;

ALTER TABLE ctsi_webcamp_adhoc.InvoiceAllWork
	## INVOICE
    ADD Protocol_ID bigint(20),
	ADD Title varchar(255),
	ADD CRC_ID char(25),
	ADD IRBNUMBER char(25),
	ADD IACUCNUMBER char(25),
    ## PROTOCOL
	ADD DATEBILLED datetime,
	ADD BilledMonth varchar(7),
	ADD AMOUNTBILLED float,
	ADD ACCOUNTNUMBER char(30),
	ADD PILASTNAME char(30),
	ADD PIFIRSTNAME char(30),
	ADD PIEMAIL text,
	ADD PIPHONE char(50),
	ADD BILLINGCONTACTLASTNAME char(30),
	ADD BILLINGCONTACTFIRSTNAME char(30),
	ADD BILLINGCONTACTEMAIL text,
	ADD BILLINGCONTACTPHONE char(50),
    ADD ProvPersonName varchar(100);


CREATE INDEX InAllWorkInv ON ctsi_webcamp_adhoc.InvoiceAllWork (Invoice_ID);
CREATE INDEX InAllWorkPro ON ctsi_webcamp_adhoc.InvoiceAllWork (Protocol_ID);
CREATE INDEX InInvWork ON ctsi_webcamp_adhoc.InvoiceWork (Invoice_ID);
CREATE INDEX InProWork ON ctsi_webcamp_adhoc.ProtocolWork (Protocol_ID);

SET SQL_SAFE_UPDATES = 0;   
 
UPDATE ctsi_webcamp_adhoc.InvoiceAllWork aw, ctsi_webcamp_adhoc.InvoiceWork lu
SET aw.Protocol_ID=lu.Protocol_ID,
	aw.DATEBILLED=lu.DATEBILLED,
	aw.BilledMonth=lu.BilledMonth,
	aw.AMOUNTBILLED=lu.AMOUNTBILLED,
	aw.ACCOUNTNUMBER=lu.ACCOUNTNUMBER,
	aw.PILASTNAME=lu.PILASTNAME,
	aw.PIFIRSTNAME=lu.PIFIRSTNAME,
	aw.PIEMAIL=lu.PIEMAIL,
	aw.PIPHONE=lu.PIPHONE,
	aw.BILLINGCONTACTLASTNAME=lu.BILLINGCONTACTLASTNAME,
	aw.BILLINGCONTACTFIRSTNAME=lu.BILLINGCONTACTFIRSTNAME,
	aw.BILLINGCONTACTEMAIL=lu.BILLINGCONTACTEMAIL,
	aw.BILLINGCONTACTPHONE=lu.BILLINGCONTACTPHONE
WHERE 	aw.Invoice_ID=lu.Invoice_ID;


UPDATE ctsi_webcamp_adhoc.InvoiceAllWork aw, ctsi_webcamp_adhoc.ProtocolWork lu
SET	aw.Title=substr(lu.Title,1,254),
	aw.CRC_ID=lu.CRC_ID,
	aw.IRBNUMBER=lu.IRBNUMBER,
	aw.IACUCNUMBER=lu.IACUCNUMBER
WHERE aw.Protocol_ID=lu.Protocol_ID;    




UPDATE ctsi_webcamp_adhoc.InvoiceAllWork aw, ctsi_webcamp_pr.person lu
SET aw.ProvPersonName =CONCAT(trim(LASTNAME),", ",TRIM(FIRSTNAME))
WHERE aw.ProvPersonID=lu.UNIQUEFIELD;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.InvoiceFormat;
CREATE TABLE ctsi_webcamp_adhoc.InvoiceFormat AS
SELECT    Invoice_ID,
          BilledMonth,
          DATEBILLED,
          Protocol_ID,
          CRC_ID,
          Title,
          IRBNUMBER,
          IACUCNUMBER,
          PILASTNAME,
          PIFIRSTNAME,
          PIEMAIL,
          PIPHONE,
          BILLINGCONTACTLASTNAME,
          BILLINGCONTACTFIRSTNAME,
          BILLINGCONTACTEMAIL,
          BILLINGCONTACTPHONE,
          ACCOUNTNUMBER,
          SERVICESTARTDATE,
          SERVICEENDDATE,
          Service,
          QUANTITY,
          USUALRATE,
          PROJECTRATE,
          CREDITBALANCE,
          AMOUNTDUE,
          AMOUNTBILLED,
          Coreservice_ID,
          ProvPersonID,
          ProvPersonName 
from ctsi_webcamp_adhoc.InvoiceAllWork
ORDER BY BilledMonth,
		 CRC_ID	;


drop table if exists ctsi_webcamp_adhoc.invoicestats;
create table ctsi_webcamp_adhoc.invoicestats As
select "Webcamp - Invoice Date Billed" as Metric, min(DATEBILLED) as MinDate, max(DATEBILLED) AS MaxDate FROM ctsi_webcamp_pr.invoice
UNION ALL
select "Webcamp - Invoice Detail Service Start" as Metric, min(SERVICESTARTDATE) as MinDate, max(SERVICESTARTDATE) AS MaxDate FROM ctsi_webcamp_pr.invoicedetail
UNION ALL
select "Webcamp - IInvoice Detail Service End" as Metric, min(SERVICEENDDATE) as MinDate, max(SERVICEENDDATE) AS MaxDate FROM ctsi_webcamp_pr.invoicedetail
UNION ALL
select "Extract - Invoice Date Billed" as Metric, min(DATEBILLED) as MinDate, max(DATEBILLED) AS MaxDate FROM ctsi_webcamp_adhoc.InvoiceWork
UNION ALL
select "Extract - Invoice Detail Service Start" as Metric, min(SERVICESTARTDATE) as MinDate, max(SERVICESTARTDATE) AS MaxDate FROM ctsi_webcamp_adhoc.InvoiceDtlWork
UNION ALL
select "Extract - Invoice Detail Service End" as Metric, min(SERVICEENDDATE) as MinDate, max(SERVICEENDDATE) AS MaxDate FROM ctsi_webcamp_adhoc.InvoiceDtlWork;





SERVICESTARTDATE,
	id.SERVICEENDDATE,



DESC ctsi_webcamp_adhoc.InvoiceAllWork;
DESC ctsi_webcamp_adhoc.InvoiceWork;
DESC ctsi_webcamp_adhoc.ProtocolWork;
XX Protocol ID
XX IRB Number
XX IACUC Number
XX Principal Investigator Last Name
XX  Principal Investigator First Name
XX Principal Investigator E-mail
XX Principal Investigator Phone
XX Billing Contact Last Name
XX Billing Contact First Name
XX Billing Contact E-Mail
XX Billing Contact Phone
XX Account Number
Service Provider
XX Service/Resource Start Date
XX Service/Resource Completion Date
XX Specific Resource or Service
XX Quantity Provided
XX Standard Unit Cost
XX Unit Cost for This Project
XX Current Credit Balance
XX Billable Quantity
Amount Subsidized
XX Amount Due
Participant ID (if applicable)
Alt Participant ID (if applicable)
Study-Specific Participant ID
Alt Protocol ID (if applicable)
Service/Resource Code (if applicable)



######
## TEST 

DROP TABLE ctsi_webcamp_adhoc.invoicetemp;
DROP TABLE ctsi_webcamp_adhoc.invoicedtltemp;
DROP TABLE  ctsi_webcamp_adhoc.invoiceOUTtemp ;


create table ctsi_webcamp_adhoc.invoicetemp As
Select * from ctsi_webcamp_pr.invoice where UNIQUEFIELD=3901;

create table ctsi_webcamp_adhoc.invoicedtltemp As
Select * from ctsi_webcamp_pr.invoicedetail where INVOICE=3901;

create table ctsi_webcamp_adhoc.invoiceOUTtemp As
Select * from ctsi_webcamp_adhoc.InvoiceFormat  where INVOICE_ID=3901;



3901