

SELECT distinct REPORTING_SPONSOR_NAME from lookup.awards_history where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%";



SELECT YEAR(FUNDS_ACTIVATED), SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt
from lookup.awards_history where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%"
GROUP BY YEAR(FUNDS_ACTIVATED); 

drop table if exists work.nih;
create table work.nih as
SELECT *
from lookup.awards_history
where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%";




drop table if exists work.ctsiufid2;
create table work.ctsiufid2 as 
select 	YEAR(FUNDS_ACTIVATED) AS Year,
		CLK_PI_UFID as UFID
from lookup.awards_history
group by 	YEAR(FUNDS_ACTIVATED), 
			CLK_PI_UFID
UNION ALL
select 	YEAR(FUNDS_ACTIVATED) AS Year,
		CLK_AWD_PROJ_MGR_UFID as UFID
from lookup.awards_history
group by YEAR(FUNDS_ACTIVATED),
		  CLK_AWD_PROJ_MGR_UFID;


drop table if exists work.ctsiufid;
create table work.ctsiufid as 
select Year,UFID
from work.ctsiufid2
ORDER BY Year,UFID;


DELETE FROM  work.ctsiufid WHERE UFID='';

CREATE INDEX tempindx2 ON work.ctsiufid (Year,UFID);
CREATE INDEX tempindx3 ON  work.nih (CLK_PI_UFID);
CREATE INDEX tempindx4 ON  work.nih (CLK_AWD_PROJ_MGR_UFID);

Alter table work.nih ADD CTSIAffil int(1) ;

SET SQL_SAFE_UPDATES = 0;

UPDATE work.nih SET CTSIAffil=0;



UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE nih.CLK_PI_UFID=lu.UFID
    AND Year(FUNDS_ACTIVATED)=lu.Year;
    
    
    
 UPDATE work.nih nih, work.ctsiufid lu
	SET CTSIAffil=1 
    WHERE CLK_AWD_PROJ_MGR_UFID=lu.UFID
    AND Year(FUNDS_ACTIVATED)=lu.Year;
    
    
select CLK_AWD_PROJ_MGR_UFID from  work.nih where CLK_AWD_PROJ_MGR_UFID IN (SELECT DISTINCT UFID FROM work.ctsiufid);

select * from work.nih where CTSIAffil=0;   



select CLK_PI_UFID,CLK_AWD_PROJ_MGR_UFID from work.nih ;


select * from work.ctsiufid
WHERE UFID NOT IN (select distinct UFID from work.nih);

select count(distinct UFID) from work.ctsiufid; 5051


select count(distinct CLK_AWD_PROJ_MGR_UFID) from work.nih; 1452
select count(distinct nih.CLK_PI_UFID) from work.nih; 1103