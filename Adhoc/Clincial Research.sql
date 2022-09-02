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

################################################################################################
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
WHERE 
 Year(FUNDS_ACTIVATED)=2020
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