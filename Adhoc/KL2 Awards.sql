SET sql_mode = '';

DROP TABLE IF EXISTS yulia.KL2awardsRaw;
Create table yulia.KL2awardsRaw as
Select 
awards_history_id as recid,
CLK_PI_UFID as ScholarID,
"Contract" as AwardLevel,
CLK_AWD_ID,
REPORTING_SPONSOR_AWD_ID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_CAT,
DIRECT_AMOUNT,
INDIRECT_AMOUNT,
SPONSOR_AUTHORIZED_AMOUNT,
FUNDS_ACTIVATED,
CLK_AWD_SPONSOR_NAME,
CLK_AWD_SPONSOR_CAT,
CLK_AWD_PRIME_SPONSOR_NAME,
CLK_AWD_PRIME_SPONSOR_CAT,
CLK_AWD_PI,
CLK_PI_UFID,
CLK_AWD_PI_DEPT,
CLK_AWD_OVERALL_START_DATE,
CLK_AWD_OVERALL_END_DATE,
CLK_AWD_PROJ_ID,	
CLK_AWD_PROJ_NAME,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
CLK_AWD_PROJ_DEPT,
CLK_AWD_PURPOSE
From lookup.awards_history
WHERE CLK_PI_UFID IN (SELECT DISTINCT UFID FROM yulia.kl2_scholars)
UNION ALL
Select 
awards_history_id as recid,
CLK_AWD_PROJ_MGR_UFID as ScholarID,
"Project" as AwardLevel,
CLK_AWD_ID,
REPORTING_SPONSOR_AWD_ID,
REPORTING_SPONSOR_NAME,
REPORTING_SPONSOR_CAT,
DIRECT_AMOUNT,
INDIRECT_AMOUNT,
SPONSOR_AUTHORIZED_AMOUNT,
FUNDS_ACTIVATED,
CLK_AWD_SPONSOR_NAME,
CLK_AWD_SPONSOR_CAT,
CLK_AWD_PRIME_SPONSOR_NAME,
CLK_AWD_PRIME_SPONSOR_CAT,
CLK_AWD_PI,
CLK_PI_UFID,
CLK_AWD_PI_DEPT,
CLK_AWD_OVERALL_START_DATE,
CLK_AWD_OVERALL_END_DATE,	
CLK_AWD_PROJ_ID,
CLK_AWD_PROJ_NAME,
CLK_AWD_PROJ_MGR,
CLK_AWD_PROJ_MGR_UFID,
CLK_AWD_PROJ_DEPT,
CLK_AWD_PURPOSE
From lookup.awards_history
WHERE CLK_AWD_PROJ_MGR_UFID IN (SELECT DISTINCT UFID FROM yulia.kl2_scholars);

#####

DROP TABLE IF EXISTS yulia.KL2awardsDup;
Create table yulia.KL2awardsDup as
SELECT
yr.recid,
ks.Name as ScholarName,
yr.ScholarID,
yr.AwardLevel,
yr.CLK_AWD_ID,
yr.REPORTING_SPONSOR_AWD_ID,
yr.REPORTING_SPONSOR_NAME,
yr.REPORTING_SPONSOR_CAT,
yr.DIRECT_AMOUNT,
yr.INDIRECT_AMOUNT,
yr.SPONSOR_AUTHORIZED_AMOUNT,
yr.FUNDS_ACTIVATED,
yr.CLK_AWD_SPONSOR_NAME,
yr.CLK_AWD_SPONSOR_CAT,
yr.CLK_AWD_PRIME_SPONSOR_NAME,
yr.CLK_AWD_PRIME_SPONSOR_CAT,
yr.CLK_AWD_PI,
yr.CLK_PI_UFID,
yr.CLK_AWD_PI_DEPT,
yr.CLK_AWD_OVERALL_START_DATE,
yr.CLK_AWD_OVERALL_END_DATE,
yr.CLK_AWD_PROJ_ID,
yr.CLK_AWD_PROJ_NAME,
yr.CLK_AWD_PROJ_MGR,
yr.CLK_AWD_PROJ_MGR_UFID,
yr.CLK_AWD_PROJ_DEPT,
yr.CLK_AWD_PURPOSE,
"UNKNOWN INVOLVEMENT" As RecordClass
From yulia.KL2awardsRaw yr LEFT JOIN yulia.kl2_scholars ks ON yr.ScholarID=ks.UFID;

SET SQL_SAFE_UPDATES = 0;
UPDATE yulia.KL2awardsDup SET RecordClass="PI PM"
		WHERE ScholarID=CLK_PI_UFID AND ScholarID=CLK_AWD_PROJ_MGR_UFID;
        
UPDATE yulia.KL2awardsDup SET RecordClass="PM"
		WHERE ScholarID<>CLK_PI_UFID AND ScholarID=CLK_AWD_PROJ_MGR_UFID;   
        
UPDATE yulia.KL2awardsDup SET RecordClass="PI"
		WHERE ScholarID=CLK_PI_UFID AND ScholarID<>CLK_AWD_PROJ_MGR_UFID;      

DELETE FROM yulia.KL2awardsDup
WHERE AwardLevel='Project' AND RecordClass='PI PM';
###########################

    
#SELECT AwardLevel,RecordClass, COUNT(*) from yulia.KL2awardsDup group by AwardLevel,RecordClass;        

DROP TABLE IF EXISTS yulia.KL2awardsAGG;
Create table yulia.KL2awardsAGG as
SELECT
ScholarName,
ScholarID,
AwardLevel,
CLK_AWD_ID,
    MAX(REPORTING_SPONSOR_NAME) AS REPORTING_SPONSOR_NAME,
    MAX(REPORTING_SPONSOR_AWD_ID) as REPORTING_SPONSOR_AWD_ID,
    MAX(REPORTING_SPONSOR_CAT) AS REPORTING_SPONSOR_CAT,
    MAX(CLK_AWD_PROJ_NAME) AS CLK_AWD_PROJ_NAME,
    SUM(DIRECT_AMOUNT) AS DIRECT_AMOUNT,
    SUM(INDIRECT_AMOUNT) AS INDIRECT_AMOUNT,
    SUM(SPONSOR_AUTHORIZED_AMOUNT) AS SPONSOR_AUTHORIZED_AMOUNT,
    MIN(FUNDS_ACTIVATED) AS FUNDS_ACTIVATED,
    MAX(CLK_AWD_SPONSOR_NAME) AS CLK_AWD_SPONSOR_NAME,
    MAX(CLK_AWD_SPONSOR_CAT) AS CLK_AWD_SPONSOR_CAT,
    MAX(CLK_AWD_PRIME_SPONSOR_NAME) AS CLK_AWD_PRIME_SPONSOR_NAME,
    MAX(CLK_AWD_PRIME_SPONSOR_CAT) AS CLK_AWD_PRIME_SPONSOR_CAT,
    MAX(CLK_AWD_PI) AS CLK_AWD_PI,
    MAX(CLK_PI_UFID) AS CLK_PI_UFID,
    MAX(CLK_AWD_PI_DEPT) AS CLK_AWD_PI_DEPT,
    MAX(CLK_AWD_OVERALL_START_DATE) AS CLK_AWD_OVERALL_START_DATE,
    MAX(CLK_AWD_OVERALL_END_DATE) AS CLK_AWD_OVERALL_END_DATE,
    MAX(CLK_AWD_PROJ_ID) AS CLK_AWD_PROJ_ID,
    MAX(CLK_AWD_PROJ_MGR) AS CLK_AWD_PROJ_MGR,
    MAX(CLK_AWD_PROJ_MGR_UFID) AS CLK_AWD_PROJ_MGR_UFID,
    MAX(CLK_AWD_PROJ_DEPT) AS CLK_AWD_PROJ_DEPT,
    MAX(CLK_AWD_PURPOSE) AS CLK_AWD_PURPOSE,
    MAX(RecordClass) AS RecordClass
From yulia.KL2awardsDup
GROUP BY 
ScholarName,
ScholarID,
AwardLevel,
CLK_AWD_ID;

ALTER table yulia.KL2awardsAGG
ADD KL2_awd INT(1),
ADD NIH INT(1),
ADD OTHER_K INT(1),
ADD NON_NIH INT(1);

UPDATE yulia.KL2awardsAGG
SET KL2_awd=0,
	NIH=0,
    OTHER_K=0,
	NON_NIH=0;
    
 UPDATE yulia.KL2awardsAGG
 SET KL2_awd=1
 WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
 AND REPORTING_SPONSOR_AWD_ID like 'KL2%';

 UPDATE yulia.KL2awardsAGG
 SET NIH=1
 WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%';

UPDATE yulia.KL2awardsAGG
 SET OTHER_K=1
 WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
 AND REPORTING_SPONSOR_AWD_ID like 'K%'
 AND KL2_awd=0;
 
 UPDATE yulia.KL2awardsAGG
 SET NON_NIH=1
 WHERE REPORTING_SPONSOR_NAME not LIKE 'NATL INST OF HLTH%'
 AND  KL2_awd=0;

 
 DROP TABLE IF EXISTS yulia.kl2Summary;
 Create table yulia.kl2Summary AS
 SELECT ScholarName,
		ScholarID,
        SUM(OTHER_K) as nOTHER_K,
        SUM(NIH) as mNIH,
        SUM(NON_NIH) as nNON_NIH
from yulia.KL2awardsAGG
GROUP BY 	ScholarName,
			ScholarID
ORDER BY  ScholarName  ;