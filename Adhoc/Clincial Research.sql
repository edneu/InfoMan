############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################


## USE CLINCAL RESEARCH FLAG TO DEVELOP CRITERIA

SET SQL_SAFE_UPDATES = 0;

UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";

UPDATE lookup.awards_history SET ClinRrch=1
where REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR 
CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST';

UPDATE lookup.awards_history SET ClinRrch=1
where CLK_AWD_HUMAN_SUBJ="YES";

UPDATE lookup.awards_history SET ClinRrch=1
WHERE CLK_AWD_PROJ_TYPE IN
	('Clinical Trial',
     'Clinical Trial Operating',
     'Human Sub/Clinical Resear');

UPDATE lookup.awards_history SET ClinRrch=0
WHERE REPORTING_SPONSOR_NAME='US DEPT OF EDUCATION';


##******************
SELECT 	ctsi_FFY,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY
ORDER BY ctsi_FFY;
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################

####################################################################
####################################################################
####################################################################
####################################################################
####################################################################






################### CALENDAR YEAR TABLE BY SPONSOR TYPE
### REPORT TABLE BY SPONSOR TYPE
DROP TABLE if EXISTS work.SpTyYR;
CREATE TABLE work.SpTyYR as
SELECT DISTINCT REPORTING_SPONSOR_CAT
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND ClinRrch=1;





ALTER TABLE  work.SpTyYR 
ADD CY2016 decimal(65,10),
ADD CY2017 decimal(65,10),
ADD CY2018 decimal(65,10),
ADD CY2019 decimal(65,10),
ADD CY2020 decimal(65,10),
ADD CY2021 decimal(65,10),
ADD CY2022 decimal(65,10);



DROP TABLE if EXISTS work.SpTyYRlu;
CREATE TABLE work.SpTyYRlu as
SELECT 	Year(FUNDS_ACTIVATED) as Year,
REPORTING_SPONSOR_CAT,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND ClinRrch=1
GROUP BY Year(FUNDS_ACTIVATED),
REPORTING_SPONSOR_CAT
ORDER BY Year(FUNDS_ACTIVATED) ;

UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2016=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2016;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2017=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2017;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2018=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2018;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2019=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2019;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2020=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2020;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2021=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2021;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2022=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2022;

select * from work.SpTyYR;

###########################################################################################################
###########################################################################################################
###################################################################################################

################### CALENDAR YEAR Federal BY SPONSOR
### REPORT TABLE BY SPONSOR TYPE


##ALter table lookup.awards_history 
##ADD REPORTING_SPONSOR_NAME_CLEAN varchar(45);

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN=REPORTING_SPONSOR_NAME; 

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN="NATL INST OF HLTH"
WHERE REPORTING_SPONSOR_NAME LIKE ("NATL INST OF HLTH%");

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US DEPT OF DEFENSE'
WHERE REPORTING_SPONSOR_NAME LIKE ("US DEPT OF DEFENSE%");

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US DEPT OF AG'
WHERE REPORTING_SPONSOR_NAME LIKE ("US DEPT OF AG%");


UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='NASA'
WHERE REPORTING_SPONSOR_NAME LIKE ("NASA%");


UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US AIR FORCE'
WHERE REPORTING_SPONSOR_NAME LIKE ("US AIR FORCE%");

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US ARMY'
WHERE REPORTING_SPONSOR_NAME LIKE ("US ARMY%");

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US DEPT OF VETERANS AFFAIRS'
WHERE REPORTING_SPONSOR_NAME LIKE ("US DEPT OF VET%");


UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US HLTH RESOURCES AND SERV ADMN'
WHERE REPORTING_SPONSOR_NAME LIKE ("US HLTH RESOURCES AND SERV ADMN%");

UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US NAVY'
WHERE REPORTING_SPONSOR_NAME LIKE ("US NAVY%");


UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='CTRS FOR DISEASE CONTROL AND PREVENTION'
WHERE REPORTING_SPONSOR_NAME LIKE ("CTRS FOR DIS%");


UPDATE lookup.awards_history
SET REPORTING_SPONSOR_NAME_CLEAN='US DEPT OF COMMERCE'
WHERE REPORTING_SPONSOR_NAME LIKE ("US DEPT OF COMM%");



##################################################################################


DROP TABLE if EXISTS work.FedSponsorYR;
CREATE TABLE work.FedSponsorYR as
SELECT DISTINCT REPORTING_SPONSOR_NAME_CLEAN
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND REPORTING_SPONSOR_CAT='Federal Agencies'
AND ClinRrch=1;

SELECT *
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND REPORTING_SPONSOR_CAT='Federal Agencies'
AND REPORTING_SPONSOR_NAME_CLEAN='US DEPT OF EDUCATION'
AND ClinRrch=1;



ALTER TABLE  work.FedSponsorYR
ADD CY2016 decimal(65,10),
ADD CY2017 decimal(65,10),
ADD CY2018 decimal(65,10),
ADD CY2019 decimal(65,10),
ADD CY2020 decimal(65,10),
ADD CY2021 decimal(65,10),
ADD CY2022 decimal(65,10);



DROP TABLE if EXISTS work.SpTyYRlu;
CREATE TABLE work.SpTyYRlu as
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		REPORTING_SPONSOR_NAME_CLEAN ,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND REPORTING_SPONSOR_CAT='Federal Agencies'
AND ClinRrch=1
GROUP BY Year(FUNDS_ACTIVATED), REPORTING_SPONSOR_NAME_CLEAN 
ORDER BY Year(FUNDS_ACTIVATED) ;

UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2016=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2016;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2017=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2017;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2018=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2018;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2019=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2019;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2020=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2020;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2021=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2021;
UPDATE work.FedSponsorYR st, work.SpTyYRlu lu SET st.CY2022=lu.TotalAmt WHERE st.REPORTING_SPONSOR_NAME_CLEAN=lu.REPORTING_SPONSOR_NAME_CLEAN AND lu.Year=2022;

select * from work.FedSponsorYR;

#############################################
#############################################
#############################################
#############################################
#############################################
DROP TABLE if EXISTS work.SpTyYRlu;
CREATE TABLE work.SpTyYRlu as
SELECT 	Year(FUNDS_ACTIVATED) as Year,
REPORTING_SPONSOR_CAT,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND ClinRrch=1
GROUP BY Year(FUNDS_ACTIVATED),
REPORTING_SPONSOR_CAT
ORDER BY Year(FUNDS_ACTIVATED) ;

UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2016=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2016;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2017=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2017;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2018=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2018;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2019=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2019;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2020=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2020;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2021=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2021;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2022=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND lu.Year=2022;



### ALL SPONSORS

DROP TABLE IF EXISTS work.ClinRsch_AmtYR;
Create table work.ClinRsch_AmtYR AS
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ClinRrch=1
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;

## NIH ONLY
DROP TABLE IF EXISTS work.ClinRsch_AmtYR;
Create table work.ClinRsch_AmtYR AS
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ClinRrch=1
AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;

################

#############################################
#############################################
### FLORIDA GOVERNMENT BREAKDOWN for MAtt 2022/01/10
DROP TABLE if EXISTS work.SpTyYR;
CREATE TABLE work.SpTyYR as
SELECT REPORTING_SPONSOR_CAT, REPORTING_SPONSOR_NAME
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND REPORTING_SPONSOR_CAT IN ('Florida Government','Florida Regional Government')
AND ClinRrch=1
GROUP BY REPORTING_SPONSOR_CAT, REPORTING_SPONSOR_NAME
ORDER BY REPORTING_SPONSOR_CAT, REPORTING_SPONSOR_NAME;


ALTER TABLE  work.SpTyYR 
ADD CY2016 decimal(65,10),
ADD CY2017 decimal(65,10),
ADD CY2018 decimal(65,10),
ADD CY2019 decimal(65,10),
ADD CY2020 decimal(65,10),
ADD CY2021 decimal(65,10),
ADD CY2022 decimal(65,10);




DROP TABLE if EXISTS work.SpTyYRlu;
CREATE TABLE work.SpTyYRlu as
SELECT 	Year(FUNDS_ACTIVATED) as Year,
        REPORTING_SPONSOR_CAT,
        REPORTING_SPONSOR_NAME,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND ClinRrch=1
AND REPORTING_SPONSOR_CAT IN ('Florida Government','Florida Regional Government')
GROUP BY Year(FUNDS_ACTIVATED),
              REPORTING_SPONSOR_CAT,
              REPORTING_SPONSOR_NAME
ORDER BY Year(FUNDS_ACTIVATED) ;

SET SQL_SAFE_UPDATES = 0;

UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2016=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2016;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2017=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2017;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2018=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2018;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2019=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2019;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2020=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2020;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2021=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2021;
UPDATE work.SpTyYR st, work.SpTyYRlu lu SET st.CY2022=lu.TotalAmt WHERE st.REPORTING_SPONSOR_CAT=lu.REPORTING_SPONSOR_CAT AND st.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME AND lu.Year=2022;


######
### ALL SPONSORS

DROP TABLE IF EXISTS work.ClinRsch_AmtYR;
Create table work.ClinRsch_AmtYR AS
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ClinRrch=1
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;

## NIH ONLY
DROP TABLE IF EXISTS work.ClinRsch_AmtYR;
Create table work.ClinRsch_AmtYR AS
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ClinRrch=1
AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;

################











### Create Output tables

DROP TABLE IF EXISTS Adhoc.ClinRsch_AmtYR;
Create table Adhoc.ClinRsch_AmtYR AS
SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE ClinRrch=1
AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;



DROP TABLE IF EXISTS Adhoc.ClinRsch_AmtYR;
Create table Adhoc.ClinRsch_AmtYR AS
SELECT 	CLK_AWD_PROJ_TYPE as ProjType,
		sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) IndirectAmt,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
GROUP BY CLK_AWD_PROJ_TYPE;
















############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
############################################################################
## Criteria Development FFY
Select Distinct ctsi_FFY from lookup.awards_history;

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
GROUP BY ctsi_FFY;


SET SQL_SAFE_UPDATES = 0;


#ALL NIH
UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' );

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#Reporting Sponsor is NIH & ProjType =Clinical Trials, Human Research (DSP Suggestion)

UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_PROJ_TYPE IN('Clinical Trial',
						 'Clinical Trial Operating',
						 'Human Sub/Clinical Resear');

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#######  Reporting Sponsor is NIH & Human Subjects=YES
UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#######  Reporting Sponsor is PCORI

UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST');

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#######  Reporting Sponsor is NIH & Human Subjects=YES

UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST')
AND CLK_AWD_HUMAN_SUBJ="YES";

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#######  Reporting Sponsor is NIH & Human Subjects=NO
UPDATE lookup.awards_history SET ClinRrch=0;

UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST')
AND CLK_AWD_HUMAN_SUBJ="NO";

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

#######  NIH+Human Subject | PCORI

UPDATE lookup.awards_history SET ClinRrch=0;

## All PCORI
UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST');

## NIH & Human Submects
UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";



Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;


####  NIH+Human Subject | PCORI | HUMAN SUBJECTS (ALL SPONSORS)


UPDATE lookup.awards_history SET ClinRrch=0;

## All PCORI
UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST');

## NIH & Human Subjects
UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";

### ALL HUMAN SUBJECTS
UPDATE lookup.awards_history SET ClinRrch=1
where CLK_AWD_HUMAN_SUBJ="YES";

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;


####  NIH+Human Subject | PCORI |CLINICAL TRIALS (ALL SPONSORS)



UPDATE lookup.awards_history SET ClinRrch=0;

## All PCORI
UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST');

## NIH & Human Subjects
UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";

### CLINICAL TRIALS
UPDATE lookup.awards_history SET ClinRrch=1
WHERE CLK_AWD_PROJ_TYPE IN
	('Clinical Trial',
     'Clinical Trial Operating',
     'Human Sub/Clinical Resear');

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;

########################################################
## Department of Education
UPDATE lookup.awards_history SET ClinRrch=0;

##DOE AMOUNT


Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
AND  REPORTING_SPONSOR_NAME='US DEPT OF EDUCATION'
GROUP BY ctsi_FFY;



########################################################
########################################################

####  NIH+Human Subject | PCORI |CLINICAL TRIALS (ALL SPONSORS-DOE)   FINAL CRITERIA



UPDATE lookup.awards_history SET ClinRrch=0;

## All PCORI
UPDATE lookup.awards_history SET ClinRrch=1
where (REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' OR CLK_AWD_PRIME_SPONSOR_NAME='PATIENT-CENTERED OUTCOMES RES INST');

## NIH & Human Subjects
UPDATE lookup.awards_history SET ClinRrch=1
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND CLK_AWD_HUMAN_SUBJ="YES";

### ALL HUMAN SUBJECTS
UPDATE lookup.awards_history SET ClinRrch=1
where CLK_AWD_HUMAN_SUBJ="YES";


### CLINICAL TRIALS
UPDATE lookup.awards_history SET ClinRrch=1
WHERE CLK_AWD_PROJ_TYPE IN
	('Clinical Trial',
     'Clinical Trial Operating',
     'Human Sub/Clinical Resear');
     
     
 UPDATE lookup.awards_history SET ClinRrch=0 
 WHERE REPORTING_SPONSOR_NAME='US DEPT OF EDUCATION'
 AND ClinRrch=1;

Select ctsi_FFY,sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAwd
from lookup.awards_history
WHERE ctsi_FFY IN ('FFY 2015-2016','FFY 2016-2017','FFY 2017-2018','FFY 2018-2019','FFY 2019-2020','FFY 2020-2021','FFY 2021-2022')
AND ClinRrch=1
GROUP BY ctsi_FFY;





############################################################################
############################################################################
############################################################################

##########################
## NIH EXCLUDED ANALYSIS

SELECT CLK_AWD_PROJ_TYPE,count(*) as n,sum(SPONSOR_AUTHORIZED_AMOUNT) as AMT FROM lookup.awards_history
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND ClinRrch=0
GROUP BY CLK_AWD_PROJ_TYPE;

SELECT * from lookup.awards_history
WHERE (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
AND ClinRrch=0
AND CLK_AWD_PROJ_TYPE IN 
('Continuation',
'Decrease',
'Extension',
'New',
'Renewal',
'Supplemental');
####################################################################
####################################################################
####################################################################



#################################################################
## scratch / diagnostics

SELECT DISTINCT CLK_AWD_PROJ_TYPE
FROM lookup.awards_history
WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%';

select CLK_AWD_PROJ_TYPE



select CLK_AWD_PROJ_TYPE,count(*) as N,Sum(SPONSOR_AUTHORIZED_AMOUNT) as Amt
from lookup.awards_history 
where ClinRrch=0 AND 
REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' 
GROUP BY CLK_AWD_PROJ_TYPE;

select * from lookup.awards_history where CLK_AWD_PROJ_TYPE='Research Applied';

select * from lookup.awards_history
where REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' 
AND CLK_AWD_PROJ_TYPE  IN ('Patient Care') ;