## Payroll MAtch


DROP TABLE IF EXISTS work.pymatch ;
Create table work.pymatch AS
Select * from work.payrollmatchjan21;

select distinct Source from  work.pymatch;

select Source,(count(distinct UFID)) from work.pymatch group by Source;

DROP TABLE IF EXISTS work.pyxmatch ;
Create table work.pyxmatch AS
SELECT UFID,max(Employee_Name) AS Employee_Name
FROM work.pymatch 
GROUP BY UFID
ORDER BY max(Employee_Name);

##SELECT DISTINCT Source from work.pymatch;

ALTER TABLE work.pyxmatch
	ADD ASSIST int(1),
	ADD CTSI int(1),
	ADD SECIM int(1),
	ADD MD_PHD int(1),
	ADD OCR int(1),
	ADD CERHB int(1),
    ADD NETWORK int(1),
    ADD On_Payroll int(3);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.pyxmatch
SET ASSIST=0,
	CTSI=0,
	SECIM=0,
	MD_PHD=0,
	OCR=0,
	CERHB=0,
    NETWORK=0,
    On_Payroll=0; 

UPDATE work.pyxmatch pm, work.pymatch lu SET ASSIST=1 WHERE pm.UFID=lu.UFID AND lu.Source="ASSIST";
UPDATE work.pyxmatch pm, work.pymatch lu SET CTSI=1 WHERE pm.UFID=lu.UFID AND lu.Source="CTSI";
UPDATE work.pyxmatch pm, work.pymatch lu SET SECIM=1 WHERE pm.UFID=lu.UFID AND lu.Source="SECIM";
UPDATE work.pyxmatch pm, work.pymatch lu SET MD_PHD=1 WHERE pm.UFID=lu.UFID AND lu.Source="MD_PHD";
UPDATE work.pyxmatch pm, work.pymatch lu SET OCR=1 WHERE pm.UFID=lu.UFID AND lu.Source="OCR";
UPDATE work.pyxmatch pm, work.pymatch lu SET CERHB=1 WHERE pm.UFID=lu.UFID AND lu.Source="CERHB";
UPDATE work.pyxmatch pm, work.pymatch lu SET NETWORK=1 WHERE pm.UFID=lu.UFID AND lu.Source="NETWORK";
UPDATE work.pyxmatch SET On_Payroll= CTSI+SECIM+MD_PHD+OCR+CERHB+NETWORK;
##UPDATE work.pyxmatch SET On_Payroll= 1 WHERE (CTSI+SECIM+MD_PHD+OCR+CERHB)>0;

select *  from work.pyxmatch;