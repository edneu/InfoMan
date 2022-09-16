SELECT CLK_AWD_PROJ_TYPE,count(*) as N from lookup.awards_history group by CLK_AWD_PROJ_TYPE;




### POPULATE CLINCIAL RESEARCH MARKER

#  ALter table lookup.awards_history ADD ClinRrch int(1);

SET SQL_SAFE_UPDATES = 0;


UPDATE lookup.awards_history SET ClinRrch=0;




UPDATE lookup.awards_history SET ClinRrch=1
WHERE CLK_AWD_PROJ_TYPE IN
	('Clinical Trial',
     'Clinical Trial Operating',
     'Human Sub/Clinical Resear',
      'Patient Care');

UPDATE lookup.awards_history SET ClinRrch=1
WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
AND CLK_AWD_PROJ_TYPE 
	NOT IN ('Institutional Training Gr',
			'Fellowship Other',
			'Conference/Workshop',
			'Animal Clinical Trials',
			'Inter-governmental Person',
			'Instruction',
            'Research Basic')
;
  
  
UPDATE lookup.awards_history SET ClinRrch=1
where REPORTING_SPONSOR_NAME = 'PATIENT-CENTERED OUTCOMES RES INST' ;
 ;
####################################################################
####################################################################
####################################################################
####################################################################
####################################################################
####################################################################
####################################################################
####################################################################
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



SELECT 	Year(FUNDS_ACTIVATED) as Year,
		sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE Year(FUNDS_ACTIVATED) IN (2016,2017,2018,2019,2020,2021,2022)
AND ClinRrch=1
###AND (REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' OR CLK_AWD_PRIME_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' )
GROUP BY Year(FUNDS_ACTIVATED)
ORDER BY Year(FUNDS_ACTIVATED) ;


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
####################################################################
####################################################################
####################################################################
####################################################################
####################################################################




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