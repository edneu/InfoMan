

SELECT distinct REPORTING_SPONSOR_NAME from lookup.awards_history where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%";

##like "NATL INST OF HLTH%"

SELECT YEAR(FUNDS_ACTIVATED), SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt
from lookup.awards_history 
where REPORTING_SPONSOR_CUSTID IN  (SELECT DISTINCT SponsorID from lookup.nih_sponser_ids)
AND UNIVERSITY_REPORTABLE="YES"
GROUP BY YEAR(FUNDS_ACTIVATED)
; 

drop table if exists work.nih;
create table work.nih as
SELECT *
from lookup.awards_history
where REPORTING_SPONSOR_CUSTID IN  (SELECT DISTINCT SponsorID from lookup.nih_sponser_ids)
  AND UNIVERSITY_REPORTABLE="YES";




drop table if exists work.ctsiufid;
create table work.ctsiufid as 
select Year,UFID
from lookup.roster
WHERE UFID IS NOT NULL AND UFID<>"" AND UFID<>"00000000"
ORDER BY Year,UFID;


CREATE INDEX tempindx2 ON work.ctsiufid (Year,UFID);
CREATE INDEX tempindx3 ON  work.nih (CLK_PI_UFID);
CREATE INDEX tempindx4 ON  work.nih (CLK_AWD_PROJ_MGR_UFID);

Alter table work.nih ADD CTSIAffil int(1) ;

SET SQL_SAFE_UPDATES = 0;

UPDATE work.nih SET CTSIAffil=0;

### TEST MORE LIBERAL POLICY

######### UFID AND Year>=
UPDATE work.nih SET CTSIAffil=0;

UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_PI_UFID=lu.UFID
    AND Year(nih.FUNDS_ACTIVATED)>=lu.Year;
    
    
    
 UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_AWD_PROJ_MGR_UFID=lu.UFID
    AND Year(nih.FUNDS_ACTIVATED)>=lu.Year;

#################
### TEST MORE LIBERAL POLICY
/*
UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_PI_UFID=lu.UFID;

 UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_AWD_PROJ_MGR_UFID=lu.UFID
    ;
*/    
########################


/*
#### UFID AND YEAR
UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_PI_UFID=lu.UFID
    AND Year(nih.FUNDS_ACTIVATED)=lu.Year;
    
    
    
 UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_AWD_PROJ_MGR_UFID=lu.UFID
    AND Year(nih.FUNDS_ACTIVATED)=lu.Year;
*/    

########## OUTPUT TABLE
DROP TABLE if exists results.NIH_FUND_ATTRIB;    
CREATE TABLE results.NIH_FUND_ATTRIB AS
SELECT YEAR
 FROM work.ctsiufid
 GROUP BY Year;
 
 DROP TABLE IF Exists work.nihtotal;
Create table work.nihtotal As
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt
from work.nih 
GROUP BY YEAR(FUNDS_ACTIVATED)  ;

 DROP TABLE IF Exists work.nihctsitotal;
Create table work.nihctsitotal As
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SUM(SPONSOR_AUTHORIZED_AMOUNT) AS CTSIAmt
from work.nih 
where CTSIAffil=1
GROUP BY YEAR(FUNDS_ACTIVATED)  ;
 
 
 ALter Table results.NIH_FUND_ATTRIB
  ADD NIH_AMOUNT decimal(65,10),
  ADD CTSI_NIH_AMT decimal (65,10);
  
  UPDATE results.NIH_FUND_ATTRIB 
  SET 	NIH_AMOUNT=0,
		CTSI_NIH_AMT=0;
        
  UPDATE  results.NIH_FUND_ATTRIB rt, work.nihtotal lu
  SET rt.NIH_AMOUNT=lu.TotalAmt
  WHERE rt.Year=lu.Year;
        
        
          
  UPDATE  results.NIH_FUND_ATTRIB rt, work.nihctsitotal lu
  SET rt.CTSI_NIH_AMT=lu.CTSIAmt
  WHERE rt.Year=lu.Year;
              
              
              

select * from   results.NIH_FUND_ATTRIB ;      
  
 




