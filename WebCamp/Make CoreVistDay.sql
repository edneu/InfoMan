#### Jan WooD
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.CoreVisitDay;
CREATE TABLE ctsi_webcamp_adhoc.CoreVisitDay AS
SELECT * FROM ctsi_webcamp_adhoc.CoreVisit
WHERE CoreSvcStart=str_to_date('08,21,2023','%m,%d,%Y') OR CoreSvcEnd=str_to_date('08,21,2023','%m,%d,%Y');

DESC ctsi_webcamp_adhoc.CoreVisitDay;

ALTER TABLE ctsi_webcamp_adhoc.CoreVisitDay
ADD CRCNumber VarChar(25),
ADD PI_NAME VarChar(65),
ADD Title varchar(100),
ADD CoreSvcStatusDesc varchar(30),
ADD VisitStatusDesc varchar(30);

UPDATE ctsi_webcamp_adhoc.CoreVisitDay pr, ctsi_webcamp_pr.person lu
SET pr.PI_NAME=CONCAT(lu.LASTNAME,", ",lu.FIRSTNAME)
WHERE pr.PIPersonID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreVisitDay pr, ctsi_webcamp_pr.protocol lu
SET pr.CRCNumber=lu.protocol,
	pr.Title=lu.TITLE
WHERE pr.ProtocolID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreVisitDay pr, ctsi_webcamp_pr.Labtest lu
SET pr.Service=lu.LABTEST
WHERE pr.LabTestID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='not entered' WHERE CoreSvcStatus='null';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='not entered' WHERE CoreSvcStatus='0';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Scheduled' WHERE CoreSvcStatus='1';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Completed' WHERE CoreSvcStatus='2';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Begun' WHERE CoreSvcStatus='3';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='No-show' WHERE CoreSvcStatus='4';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Request cancelled' WHERE CoreSvcStatus='5';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Requested' WHERE CoreSvcStatus='6';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Request denied' WHERE CoreSvcStatus='7';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Stopped prematurely' WHERE CoreSvcStatus='8';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET CoreSvcStatusDesc='Re-scheduling requested' WHERE CoreSvcStatus='9';


UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='not entered' WHERE VisitStatus='null';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='not entered' WHERE VisitStatus='0';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Scheduled' WHERE VisitStatus='1';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Completed' WHERE VisitStatus='2';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Begun' WHERE VisitStatus='3';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='No-show' WHERE VisitStatus='4';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Request cancelled' WHERE VisitStatus='5';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Requested' WHERE VisitStatus='6';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Request denied' WHERE VisitStatus='7';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Stopped prematurely' WHERE VisitStatus='8';
UPDATE ctsi_webcamp_adhoc.CoreVisitDay SET VisitStatusDesc='Re-scheduling requested' WHERE VisitStatus='9';

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.JW_AUG21;
CREATE TABLE ctsi_webcamp_adhoc.JW_AUG21 AS
SELECT 	CRCNumber,
		ProtocolID,
		Title,
        PI_NAME,
        VisitType,
        VisitStatusDesc,
        VisitStart,
        VisitEnd,
		Service,
        CoreSvcStatusDesc,
        CoreSvcStart,
        CoreSvcEnd
FROM ctsi_webcamp_adhoc.CoreVisitDay  ;      
         