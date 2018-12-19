
select * from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT ProjectID from Adhoc.fsu_proj);

drop table if exists work.fsu_proj_tot;
create table work.fsu_proj_tot
select CLK_AWD_PROJ_ID,
       sum(DIRECT_AMOUNT) as DIRECT_AMOUNT,
	   sum(INDIRECT_AMOUNT) as INDIRECT_AMOUNT,
       sum(SPONSOR_AUTHORIZED_AMOUNT) AS Total_Amt 
from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT ProjectID from Adhoc.fsu_proj)
GROUP BY CLK_AWD_PROJ_ID;


ALTER TABLE Adhoc.fsu_proj
ADD DIRECT_AMOUNT decimal(65,10),
ADD INDIRECT_AMOUNT  decimal(65,10),
ADD Total_Amt  decimal(65,10);


SET SQL_SAFE_UPDATES = 0;

UPDATE  Adhoc.fsu_proj fs,  work.fsu_proj_tot lu
SET fs.DIRECT_AMOUNT=lu.DIRECT_AMOUNT,
	fs.INDIRECT_AMOUNT=lu.INDIRECT_AMOUNT,
    fs.Total_Amt=lu.Total_Amt
WHERE fs.ProjectID=lu.CLK_AWD_PROJ_ID;

SET SQL_SAFE_UPDATES = 1;

select * from Adhoc.fsu_proj;