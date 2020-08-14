


DROP TABLE IF EXISTS work.newctrbgrant;
CREATE TABLE work.newctrbgrant as
SELECT 	CLK_AWD_ID,
		CLK_AWD_PROJ_ID,
        CLK_AWD_PI,
        CLK_AWD_PROJ_MGR,
        REPORTING_SPONSOR_NAME,
        REPORTING_SPONSOR_CAT,
        FUNDS_ACTIVATED,
        DIRECT_AMOUNT,
        INDIRECT_AMOUNT,
        SPONSOR_AUTHORIZED_AMOUNT,
        CLK_AWD_PROJ_NAME,
         CLK_PI_UFID,
        CLK_AWD_PROJ_MGR_UFID
FROM lookup.awards_history
WHERE CLK_AWD_STATE='Active'
AND (CLK_PI_UFID IN 
('22754910',
'24269289',
'51890598',
'57412610',
'01319428',
'73645462',
'49379096',
'50898158',
'12987421',
'81991606',
'90560430',
'89542850',
'31432640',
'19800150',
'47621330',
'54106984',
'04789153',
'46109760'
)
OR CLK_AWD_PROJ_MGR_UFID in
('22754910',
'24269289',
'51890598',
'57412610',
'01319428',
'73645462',
'49379096',
'50898158',
'12987421',
'81991606',
'90560430',
'89542850',
'31432640',
'19800150',
'47621330',
'54106984',
'04789153',
'46109760'))
ORDER BY CLK_AWD_ID;
       
       
       
DROP TABLE IF EXISTS work.newctrbsumm1;
CREATE TABLE work.newctrbsumm1 as 
SELECT REPORTING_SPONSOR_NAME,
SUM(DIRECT_AMOUNT) AS Direct_Total,
SUM(INDIRECT_AMOUNT) AS Indirect_Total,
SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Total
from work.newctrbgrant
GROUP BY REPORTING_SPONSOR_NAME;


       
DROP TABLE IF EXISTS work.newctrbsumm2;
CREATE TABLE work.newctrbsumm2 as 
SELECT REPORTING_SPONSOR_CAT,
SUM(DIRECT_AMOUNT) AS Direct_Total,
SUM(INDIRECT_AMOUNT) AS Indirect_Total,
SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Total
from work.newctrbgrant
GROUP BY REPORTING_SPONSOR_CAT;

drop table if Exists work.newctsiawd;
create table work.newctsiawd as
SELECT CLK_AWD_ID,
	   CLK_AWD_PI,
       REPORTING_SPONSOR_NAME,
       REPORTING_SPONSOR_CAT,
       CLK_AWD_PROJ_NAME
from work.newctrbgrant
WHERE REPORTING_SPONSOR_CAT NOT IN
		(	'Federal Agencies',
			'Florida Government',
			'University of FlaFoundation',
			'University of Florida',
            'Non Profit Organizations')
group by CLK_AWD_ID,
	   CLK_AWD_PI,
       REPORTING_SPONSOR_NAME,
       REPORTING_SPONSOR_CAT,
       CLK_AWD_PROJ_NAME

         ;
#############################################################

### ADD IP DETERMINATION FROM JSON CLINE
ALTER TABLE work.newctrbgrant ADD IP_USAGE varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.newctrbgrant SET IP_USAGE="Good";

UPDATE work.newctrbgrant SET IP_USAGE="Bad"
WHERE CLK_AWD_ID IN (
						'P0047137',
						'P0082216',
						'P0139667');


#################################################################################
SET sql_mode = '';


DROP TABLE IF EXISTS work.SRMWORK_SIM;
Create table work.SRMWORK_SIM AS
SELECT * FROM lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT CLK_AWD_ID from work.newctrbgrant)
and CLK_AWD_PRJ_START_DT<=STR_TO_DATE(concat('06,30,',year(curdate())),'%m,%d,%Y')
and CLK_AWD_PRJ_END_DT>=STR_TO_DATE(concat('07,01,',year(curdate())-1),'%m,%d,%Y');

SELECT * from work.SRMWORK_SIM;


DROP TABLE IF EXISTS work.SRMWORK_SIMSUMM;
Create table work.SRMWORK_SIMSUMM AS
SELECT CLK_AWD_ID,
       CLK_AWD_PI,
       CLK_PI_UFID,
       MAX(REPORTING_SPONSOR_NAME) AS SponsorName,
	   MAX(REPORTING_SPONSOR_CUSTID) AS SponsorID,
	   MAX(REPORTING_SPONSOR_CAT) AS Prime_Sponsor_Type,
	   MAX(CLK_AWD_SPONSOR_CAT) AS Sponsor_Type,
	   MAX(CLK_AWD_FULL_TITLE) AS Title,
	   SUM(SPONSOR_AUTHORIZED_AMOUNT) as Total_Award
FROM work.SRMWORK_SIM
GROUP BY CLK_AWD_ID,
       CLK_AWD_PI,
       CLK_PI_UFID;




DROP TABLE IF EXISTS work.SIM_BONDMASTER;
Create table work.SIM_BONDMASTER AS
SELECT 9999 as bondmaster_key,
       "Contract" AS AWARD_ID_TYPE,
        sr.CLK_PI_UFID AS AWARD_INV_UFID,
        99 AS Span,
        sr.CLK_AWD_ID AS AWARD_ID_Number,
        sr.CLK_AWD_ID AS Award_ID,
		mp.LastName AS LastName,
		mp.FirstName AS FirstName,
		mp.EMAIL AS EMAIL,
		"           " AS PI_PHONE,
		"        " AS PI_DEPTID,
		mp.Department as PI_DEPT,
		sr.SponsorName,
		sr.SponsorID,
		sr.Prime_Sponsor_Type,
		sr.Sponsor_Type,
		sr.Title,	
		sr.Total_Award,
		"Good" As IP_USAGE,
		100 AS CTRB_PCT,
		0 AS CTRB_PCT_PREV,
		1 Include_Award,
		sr.Total_Award AS Research_Revenue,
		sr.Total_Award AS CTRB_Research_Revenue,
		100000000000 AS Good_Research_Revenue,
		100000000000 AS Bad_Research_Revenue,
		" " AS Staff
FROM work.SRMWORK_SIMSUMM sr LEFT JOIN space.mitch_people mp ON sr.CLK_PI_UFID=mp.UFID ;


UPDATE work.SIM_BONDMASTER bm , work.newctrbgrant lu
SET bm.IP_USAGE=lu.IP_USAGE
WHERE bm.AWARD_ID_Number=lu.CLK_AWD_ID;



