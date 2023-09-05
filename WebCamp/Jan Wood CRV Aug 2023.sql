###################################################################################
## JANET WOOD CRV
##############################
/*
Need protocol and visits for the three mobile clinics (CRV1, CHV2, and CHV3) for the last FY (07/01/2022 through 06/30/2023
Labs
'25', 'CTSI Mobile Clinic CRV1'
'27', 'CTSI Mobile Clinic CHV2'
'28', 'CTSI Mobile Clinic CHV3'
'29', 'CTSI Mobile Drivers/UF Mobile Outreach Clinic'
*/


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRVVisit;
Create table ctsi_webcamp_adhoc.CRVVisit as
SELECT vt.PROTOCOL,vt.LAB,lu.LAB AS FACILITY,COUNT(DISTINCT vt.UNIQUEFIELD) AS nVISITS
from ctsi_webcamp_pr.opvisit vt LEFT JOIN ctsi_webcamp_pr.LAB lu ON vt.LAB=lu.UNIQUEFIELD
WHERE VISITDATE between str_to_date('07,01,2022','%m,%d,%Y') and str_to_date('06,30,2023','%m,%d,%Y')
AND vt.LAB IN (25,27,28,29)
GROUP BY vt.PROTOCOL,vt.LAB,lu.LAB;   



DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRVProto;
Create table ctsi_webcamp_adhoc.CRVProto as
SELECT 
	pt.UNIQUEFIELD as ProtocolNum,
	pt.PROTOCOL as CRCNum,
	pt.U_OCRNO as OCR_Num,
    CONCAT(ps.LASTNAME,", ",ps.FIRSTNAME) as PI_NAME,
	pt.TITLE as ProtocolName
FROM ctsi_webcamp_pr.protocol pt 
	LEFT JOIN ctsi_webcamp_pr.person ps 
    ON pt.PERSON=ps.UNIQUEFIELD 
WHERE pt.UNIQUEFIELD IN (SELECT DISTINCT PROTOCOL FROM ctsi_webcamp_adhoc.CRVVisit);


ALTER TABLE ctsi_webcamp_adhoc.CRVVisit
ADD CRCNum varchar(25),
ADD PI_NAME Varchar(82),
ADD ProtocolName VARCHAR(90);


update ctsi_webcamp_adhoc.CRVVisit vt, ctsi_webcamp_adhoc.CRVProto lu
SET vt.CRCNum=lu.CRCNum,
	vt.PI_NAME=lu.PI_NAME,
    vt.ProtocolName=lu.ProtocolName
WHERE vt.PROTOCOL=lu.ProtocolNum   ; 



DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CRVProtoVisit;
Create table ctsi_webcamp_adhoc.CRVProtoVisit as
SELECT 	Protocol as ProtcolID,
		CRCNum,
        PI_NAME,
        ProtocolName,
        Facility,
        nVISITS
FROM ctsi_webcamp_adhoc.CRVVisit;      