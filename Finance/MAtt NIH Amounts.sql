

## MATT NIH REQUEST



ALTER TABLE lookup.awards_history 
ADD ReptMon varchar(7),
ADD SFY varchar(13); 

UPDATE lookup.awards_history  
	SET ReptMon=concat(YEAR(FUNDS_ACTIVATED),"-",LPAD(MONTH(FUNDS_ACTIVATED),2,"0")) ;



CREATE INDEX srm1ReptMon ON lookup.awards_history (ReptMon);


UPDATE lookup.awards_history ah, lookup.sfy lu
	SET ah.SFY=lu.SFY
	WHERE ah.ReptMon=lu.Month;
    
   
    
DROP TABLE IF EXISTS results.NIH_SFY_SUMM    ;
Create table results.NIH_SFY_SUMM AS    
Select SFY,
       Count(Distinct CLK_AWD_ID) As nAwards,
       Count(Distinct CLK_AWD_PROJ_ID) as nProjects,
       SUM(DIRECT_AMOUNT) as DirectAmt,
       SUm(INDIRECT_AMOUNT) as IndirectAmt,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt
from lookup.awards_history
WHERE REPORTING_SPONSOR_NAME like 'NATL INST OF HLTH%'
AND SFY IS NOT NULL
GROUP BY SFY;

