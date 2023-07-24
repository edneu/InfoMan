## DEC 2022 Reconcile


### Testing

SET SQL_SAFE_UPDATES = 0;
Delete from ctsi_webcamp_adhoc.visitroomcore
WHERE Service IN 
('CRD: Mileage ALL OF US',
'CRD: Research Assistant Services (Cristina) ALL OF US',
'CRD: Research Assistant Services (Jeremy) ALL OF US',
'CTRB: Staff Salaries and Fringe'
);
###



Select 	Service,
		Sum(Amount) as Amount,
        count(distinct ProtocolID) as nProtocolsInt,
        Count(distinct CRCNumber) as nProtoIDvc
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE CoreSvcMonth="2022-12"
AND VisitStatus=2
AND CoreSvcStatus=2
AND DONOTBILL=0
GROUP BY Service
ORDER BY SERVICE;

SELECT "Invoice" AS Source, Sum(AmountDue) as AmountDue
 	FROM ctsi_webcamp_adhoc.dec_2022_invoice
UNION ALL
Select "VisitRoomCore" AS Source, Sum(Amount) as Amount 
	FROM ctsi_webcamp_adhoc.visitroomcore
	WHERE Month="2022-12"
	AND VisitStatus=2
    AND CoreSvcStatus=2;
##############################################################################    
DROP TABLE if Exists ctsi_webcamp_adhoc.vrcdec22;
CREATE TABLE ctsi_webcamp_adhoc.vrcdec22 as
SELECT * from  ctsi_webcamp_adhoc.visitroomcore
WHERE Month="2022-12"
AND VisitStatus=2
AND CoreSvcStatus=2
AND DONOTBILL=0;
    
    
    
#################################################################################
#################################################################################
#################################################################################
#################################################################################
SET SQL_SAFE_UPDATES = 0;

DROP TABLE if Exists ctsi_webcamp_adhoc.rec1;
CREATE TABLE ctsi_webcamp_adhoc.rec1 as
Select 	"Invoice" as Source,
		Service,
		Sum(AmountDue) as Amount,
        count(distinct CTSI_Study_ID) as nProtocols
FROM ctsi_webcamp_adhoc.dec_2022_invoice
Group By "Invoice",Service
UNION ALL
Select 	"VisitRoomCore" as Source,
		Service,
		Sum(Amount) as Amount,
        count(distinct ProtocolID) as nProtocols
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE Month="2022-12"
AND VisitStatus=2
AND CoreSvcStatus=2
AND DONOTBILL=0
GROUP BY "VisitRoomCore",Service;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.RecDec2022;
Create table ctsi_webcamp_adhoc.RecDec2022 as 
Select Distinct Service from ctsi_webcamp_adhoc.rec1;

Alter table ctsi_webcamp_adhoc.RecDec2022
	ADD InvoiceAmt decimal(65,10),
	ADD Invoice_nProto int(5),
	ADD OnInvoice int(1),
    ADD VRCAmt decimal(65,10),
    ADD VRC_nProto int(5),
    ADD OnVRC int(1),
    ADD AMT_DIFF decimal(65,10),
    ADD PCT_DIFF decimal(65,10);
    
 UPDATE ctsi_webcamp_adhoc.RecDec2022
 SET 	OnInvoice=0,
		OnVRC=0;
    
UPDATE ctsi_webcamp_adhoc.RecDec2022 rc, ctsi_webcamp_adhoc.rec1 lu
		SET rc.InvoiceAmt=lu.Amount,
			rc.Invoice_nProto=lu.nProtocols,
            rc.OnInvoice=1
        WHERE rc.Service=lu.Service
          AND lu.Source="Invoice";

UPDATE ctsi_webcamp_adhoc.RecDec2022 rc, ctsi_webcamp_adhoc.rec1 lu
		SET rc.VRCAmt=lu.Amount,
			rc.VRC_nProto=lu.nProtocols,
            rc.OnVRC=1
        WHERE rc.Service=lu.Service
          AND lu.Source="VisitRoomCore";
          
UPDATE ctsi_webcamp_adhoc.RecDec2022 
		SET AMT_DIFF=InvoiceAmt-VRCAmt,
			PCT_DIFF=((InvoiceAmt-VRCAmt)/InvoiceAmt);


Drop Table if Exists ctsi_webcamp_adhoc.AARecOut;
Create table ctsi_webcamp_adhoc.AARecOut as
Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, AMT_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022;

###ON Both Invoice and VRC
Drop Table if Exists ctsi_webcamp_adhoc.AARecOut;
Create table ctsi_webcamp_adhoc.AARecOut as
Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, AMT_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022
WHERE OnInvoice=1 AND OnVRC=1;

### On Invoice not on VRC
Drop Table if Exists ctsi_webcamp_adhoc.AARecOut;
Create table ctsi_webcamp_adhoc.AARecOut as
Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, AMT_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022
WHERE OnInvoice=1 AND OnVRC=0;

### On VRC and not on Invoice
Drop Table if Exists ctsi_webcamp_adhoc.AARecOut;
Create table ctsi_webcamp_adhoc.AARecOut as
Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, AMT_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022
WHERE OnInvoice=0 AND OnVRC=1;

Select 	Sum(InvoiceAmt) as Invoice,
		Sum(VRCAmt) as VRC,
        Sum(InvoiceAmt)-Sum(VRCAmt) as Difference
        from ctsi_webcamp_adhoc.RecDec2022;

#############
SELECT * FROM ctsi_webcamp_adhoc.visitroomcore;

##########################################################################################################################
##########################################################################################################################
##########################################################################################################################
###SFY SUMMARY
## Using the ALL VISITS Visits File.

### Summary of Completed Visits by SFY;
DROP TABLE if exists ctsi_webcamp_adhoc.Comp_SFY_SUMM;
Create table ctsi_webcamp_adhoc.Comp_SFY_SUMM AS
SELECT 	SFY,
		count(distinct ProtocolID) as nProtocols,
        count(distinct VisitID) as nVisits,
        count(distinct PatientID) as nPatients,
        Sum(amount) as TotalAmt
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus =2 ## Completed
AND CoreSvcStatus=2
group by SFY;

### Summary of SCHEDULED Completed Visits by SFY;
DROP TABLE if exists ctsi_webcamp_adhoc.SCHED_SFY_SUMM;
Create table ctsi_webcamp_adhoc.SCHED_SFY_SUMM AS
SELECT 	SFY,
		count(distinct ProtocolID) as nProtocols,
        count(distinct VisitID) as nVisits,
        count(distinct PatientID) as nPatients,
        Sum(amount) as TotalAmt
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus =1 ## Scheduled
group by SFY;


###################################################
/*
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc_1007_1785;
Create table ctsi_webcamp_adhoc.vrc_1007_1785 as
Select  CRCNumber,
		VisitID,
        VisitStatus,
		Month,
		VisitStart,
        VisitEnd,
        ParticipantID,
        PatientName,
		Service,  ## LABTEST
        CoreSvcID,
        CoreSvcStatus,
        CoreSvcStart,
        CoreSvcEnd,
        SvcUnitCost,
        CoreSvcQuant,
        CoreSvcLenDurMin,
        CoreSvcLenDurMin/60 AS CoreSvcLenDurHRS,
        ProtoSpecRate,
        UnitOfService,
        BillingUnitSrvc,
        Amount
 from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber IN ('1785','1007')
AND VisitStart>=str_to_date('01,01,2020','%m,%d,%Y')
AND VisitStatus=2
AND CoreSvcStatus=2
ORDER BY CRCNumber, PatientName, VisitStart;



Select  CRCNumber,
		VisitID,
        VisitStatus,
		Month,
		VisitStart,
        VisitEnd,
        ParticipantID,
        PatientName,
		Service,  ## LABTEST
        CoreSvcID,
        CoreSvcStatus,
        CoreSvcStart,
        CoreSvcEnd,
        SvcUnitCost,
        CoreSvcQuant,
        CoreSvcLenDurMin,
        CoreSvcLenDurMin/60 AS CoreSvcLenDurHRS,
        ProtoSpecRate,
        UnitOfService,
        BillingUnitSrvc,
        Amount
 from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber IN ('1785','1007')
AND VisitStart>=str_to_date('10,18,2022','%m,%d,%Y')
AND VisitStatus=2
AND CoreSvcStatus=2
ORDER BY CRCNumber, PatientName, VisitStart;
