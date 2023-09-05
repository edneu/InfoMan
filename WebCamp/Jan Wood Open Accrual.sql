/*
ctsi_webcamp_pr.
ctsi_webcamp_adhoc.
*/

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.IRB_OPENACCRUAL;
Create Table ctsi_webcamp_adhoc.IRB_OPENACCRUAL AS
Select 	pt.UNIQUEFIELD as ProtocolID,
		pt.PROTOCOL as CRCNumber,
        CONCAT(pr.LASTNAME,", ",pr.FIRSTNAME) AS PI_NAME,
        pt.TITLE,
        pt.ONGOING,
        pt.IRBNUMBER,
        pt.IRBEXPIRE,
        pt.IRBRENEWL,
        pt.ALTNUMBER,
        pt.PREVNUMBER,
        pt.IRBSTATUS,
        pt.DATEFIRSTSUBJECTACCRUED,
        pt.DATECLOSEDTOACCRUAL,
        pt.CRCAPPROV,
        pt.CRCRENEWL,
        pt.PERSON as PI_PersonID
from ctsi_webcamp_pr.protocol pt Left Join ctsi_webcamp_pr.person pr on pt.PERSON=pr.UNIQUEFIELD
WHERE IRBEXPIRE>=str_to_date('06,30,2023','%m,%d,%Y')
AND DATECLOSEDTOACCRUAL IS NULL ;

DESC ctsi_webcamp_pr.protocol;

select distinct CRCTERM from ctsi_webcamp_pr.protocol;


###################################################################################
## JANET WOOD CRV

UPDATE ctsi_webcamp_adhoc.CoreSvcLU cs, ctsi_webcamp_pr.lab lu
SET cs.VisitFacility=lu.LAB
WHERE cs.LabID=lu.UNIQUEFIELD;

select distinct Lab from ctsi_webcamp_pr.lab;

SELECT UNIQUEFIELD,LAB from ctsi_webcamp_pr.lab group by UNIQUEFIELD,LAB;

Labs
'25', 'CTSI Mobile Clinic CRV1'
'27', 'CTSI Mobile Clinic CHV2'
'28', 'CTSI Mobile Clinic CHV3'
'29', 'CTSI Mobile Drivers/UF Mobile Outreach Clinic'

Need protocol and visits for the three mobile clinics (CRV1, CHV2, and CHV3) for the last FY (07/01/2022 through 06/30/2023

SELECT DROP TABLE IF EXISTS ctsi_webcamp_adhoc.IRB_OPENACCRUAL;
Create Table ctsi_webcamp_adhoc.IRB_OPENACCRUAL AS
Select 	pt.UNIQUEFIELD as ProtocolID,
		pt.PROTOCOL as CRCNumber,
        CONCAT(pr.LASTNAME,", ",pr.FIRSTNAME) AS PI_NAME,
        pt.TITLE,
        pt.CRCRENEWL,
        pt.PERSON as PI_PersonID
from ctsi_webcamp_pr.protocol pt Left Join ctsi_webcamp_pr.person pr on pt.PERSON=pr.UNIQUEFIELD
WHERE IRBEXPIRE>=str_to_date('06,30,2023','%m,%d,%Y')
AND DATECLOSEDTOACCRUAL IS NULL ;
