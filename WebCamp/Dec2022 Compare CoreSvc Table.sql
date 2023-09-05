################################################################################
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
FROM ctsi_webcamp_adhoc.CoreRoot
WHERE CoreSvcMonth="2022-12"
##AND VisitStatus=2
AND CoreSvcStatus=2
AND OMIT=0
GROUP BY "VisitRoomCore",Service;

select * from ctsi_webcamp_adhoc.rec1 where Service Like "%Budgeted%";
select * from ctsi_webcamp_adhoc.CoreRoot where Service Like "%Budgeted%" AND CoreSvcMonth="2022-12";


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

Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, ABS(AMT_DIFF) AS ABS_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022 WHERE AMT_DIFF <>0 OR AMT_DIFF IS NULL ;

###ON Both Invoice and VRC
Drop Table if Exists ctsi_webcamp_adhoc.AARecOut;
Create table ctsi_webcamp_adhoc.AARecOut as
Select  Service, InvoiceAmt,OnInvoice, VRCAmt, OnVRC, AMT_DIFF, PCT_DIFF from ctsi_webcamp_adhoc.RecDec2022
WHERE OnInvoice=1 AND OnVRC=1;

############
/*
Select * from ctsi_webcamp_adhoc.CoreRoot Where Service='CTRB: Outpatient Visit (Instance)';
Select * from ctsi_webcamp_adhoc.CoreRoot Where Service='NUR: Specimen collection /Blood draw';


Select * from ctsi_webcamp_adhoc.dec_2022_invoice Where Service='NUR: Specimen collection /Blood draw';
Select * from  ctsi_webcamp_pr.coreservice Where LABTEST=50 AND ;

Select *  from ctsi_webcamp_pr.coreservice 
Where LABTEST=50
and Year(STARTDATE)=2022 and Month(STARTDATE)=12
 and Status=2;
 
 Select * from ctsi_webcamp_adhoc.CoreRoot Where Service='NUR: Specimen collection /Blood draw'
 AND CoreSvcMonth="2022-12" 
 AND CoreSvcStatus=2;
;
 

Select * from ctsi_webcamp_adhoc.dec_2022_invoice Where Service='CTRB:  Outpatient visit (budgeted)';
Select * from ctsi_webcamp_adhoc.CoreRoot Where Service='CTRB:  Outpatient visit (budgeted)';
*/
###########
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


select * from ctsi_webcamp_pr.labtest WHERE LABTEST LIKE 'CTRB: Outpatient Visit (Instance)';

select * from ctsi_webcamp_adhoc.CoreRoot Where Service like 'CTRB: Outpatient Visit (Instance)' AND CoreSvcMonth="2022-11";

select * from ctsi_webcamp_pr.coreservice where Labtest=200;
##########################################################################################################################
##########################################################################################################################

SELECT CoreSvcSFY, SUM(Amount) as TotalAmt
from ctsi_webcamp_adhoc.CoreRoot
WHERE  CoreSvcStatus=2 AND OMIT=0
GROUP BY CoreSvcSFY;
