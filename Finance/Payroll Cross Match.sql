## Payroll MAtch
drop table work.payrollmatchaug26;

DROP TABLE IF EXISTS work.pymatch ;
Create table work.pymatch AS
Select * from work.payrollmatchaug26;

SET SQL_SAFE_UPDATES = 0;
delete from work.pymatch WHERE UFID IS NULL;

select distinct Source from  work.pymatch;

## select Source,(count(distinct UFID)) from work.pymatch group by Source;

##  ALTER TABLE work.pymatch CHANGE `Line_Item_Detail` Employee_Name varchar(255);

select * from work.pymatch ;


;



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
	##ADD OCR int(1),
	ADD CERHB int(1),
    ##ADD NETWORK int(1),
    ADD On_Payroll int(3);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.pyxmatch
SET ASSIST=0,
	CTSI=0,
	SECIM=0,
	MD_PHD=0,
	##OCR=0,
	CERHB=0,
    ##NETWORK=0,
    On_Payroll=0; 

UPDATE work.pyxmatch pm, work.pymatch lu SET ASSIST=1 WHERE pm.UFID=lu.UFID AND lu.Source="ASSIST";
UPDATE work.pyxmatch pm, work.pymatch lu SET CTSI=1 WHERE pm.UFID=lu.UFID AND lu.Source="CTSI";
UPDATE work.pyxmatch pm, work.pymatch lu SET SECIM=1 WHERE pm.UFID=lu.UFID AND lu.Source="SECIM";
UPDATE work.pyxmatch pm, work.pymatch lu SET MD_PHD=1 WHERE pm.UFID=lu.UFID AND lu.Source="MD_PHD";
##UPDATE work.pyxmatch pm, work.pymatch lu SET OCR=1 WHERE pm.UFID=lu.UFID AND lu.Source="OCR";
UPDATE work.pyxmatch pm, work.pymatch lu SET CERHB=1 WHERE pm.UFID=lu.UFID AND lu.Source="CERHB";
##UPDATE work.pyxmatch pm, work.pymatch lu SET NETWORK=1 WHERE pm.UFID=lu.UFID AND lu.Source="NETWORK";
UPDATE work.pyxmatch SET On_Payroll= CTSI+SECIM+MD_PHD+CERHB;


select *  from work.pyxmatch;


Alter table work.pyxmatch ADD HomeDeptID varchar(15);

UPDATE work.pyxmatch pm, work.assisthomedept lu
SET pm.HomeDeptID=lu.Home_Dept_ID
WHERE pm.UFID=lu.UFID;


###################
##COMPLETE UFIDS in Assist Records

Select * from work.payrollmatchjuly21;

select * from work.no_ufids;

SET SQL_SAFE_UPDATES = 0;


UPDATE work.no_ufids SET UFID=NULL;

## LOOK UP ANY ON EMPLOYEE FILE
UPDATE work.no_ufids ids, lookup.Employees lu
SET ids.UFID=lu.Employee_ID 
WHERE ids.NAME=lu.NAME
AND ids.UFID is NULL 
AND lu.Employee_ID  IS NOT NULL;

UPDATE work.no_ufids ids, lookup.Employees lu
SET ids.UFID=lu.Employee_ID 
WHERE ids.NAME=lu.NAME
AND ids.UFID is NULL 
AND lu.Employee_ID  IS NOT NULL;

UPDATE work.no_ufids ids, lookup.Employees lu
SET ids.UFID=lu.Employee_ID 
WHERE ids.LU_NAME=lu.NAME
AND ids.UFID is NULL 
AND lu.Employee_ID  IS NOT NULL;

UPDATE work.no_ufids ids, lookup.ufids lu
SET ids.UFID=lu.UF_UFID 
WHERE ids.LU_NAME=lu.UF_DISPLAY_NM
AND ids.UFID is NULL 
AND lu.UF_UFID IS NOT NULL;

UPDATE work.no_ufids ids, lookup.ufids lu
SET ids.UFID=lu.UF_UFID 
WHERE ids.NAME=lu.UF_DISPLAY_NM
AND ids.UFID is NULL 
AND lu.UF_UFID IS NOT NULL;


ALTER TABLE work.no_ufids 
ADD FNAME varchar(45),
ADD LNAME varchar(45);


UPDATE work.no_ufids
SET FNAME=NULL,
	LNAME=NULL;
    
UPDATE  work.no_ufids
SET LNAME=TRIM(SUBSTR(LU_NAME,1,locate(',',LU_NAME)-1)),
	FNAME=SUBSTR(LU_NAME,locate(',',NAME)+1,length(LU_NAME));

SELECT * from work.no_ufids;

drop table if exists work.temp;
create table work.temp as
select * from work.no_ufids WHERE UFID IS NULL;


drop table if exists work.temp2;
create table work.temp2 as
SELECT Employee_ID,Name,Department,Job_Code
FROM lookup.active_emp
WHERE TRIM(SUBSTR(NAME,1,locate(',',NAME)-1)) IN (SELECT DISTINCT lname from work.temp)
ORDER BY NAME;

UPDATE work.no_ufids SET UFID='05568930' WHERE SEQ=2106;
UPDATE work.no_ufids SET UFID='29477500' WHERE SEQ=1995;
UPDATE work.no_ufids SET UFID='43603840' WHERE SEQ=1873;
UPDATE work.no_ufids SET UFID='56294570' WHERE SEQ=1874;
UPDATE work.no_ufids SET UFID='88780189' WHERE SEQ=1819;
UPDATE work.no_ufids SET UFID='00387480' WHERE SEQ=2018;
UPDATE work.no_ufids SET UFID='03143353' WHERE SEQ=2128;
UPDATE work.no_ufids SET UFID='14033560' WHERE SEQ=1877;
UPDATE work.no_ufids SET UFID='35144300' WHERE SEQ=1979;
UPDATE work.no_ufids SET UFID='43311437' WHERE SEQ=2132;
UPDATE work.no_ufids SET UFID='44969884' WHERE SEQ=1850;
UPDATE work.no_ufids SET UFID='85090908' WHERE SEQ=2028;

UPDATE work.no_ufids SET UFID='33297109' WHERE SEQ=1882;
UPDATE work.no_ufids SET UFID='91693904' WHERE SEQ=1884;
UPDATE work.no_ufids SET UFID='80977973' WHERE SEQ=1895;
UPDATE work.no_ufids SET UFID='10979748' WHERE SEQ=1917;
UPDATE work.no_ufids SET UFID='51155969' WHERE SEQ=2111;
UPDATE work.no_ufids SET UFID='15421303' WHERE SEQ=2126;
UPDATE work.no_ufids SET UFID='43903097' WHERE SEQ=2127;
UPDATE work.no_ufids SET UFID='44500359' WHERE SEQ=2129;
UPDATE work.no_ufids SET UFID='94185746' WHERE SEQ=2050;


UPDATE work.pymatch pm, work.no_ufids lu
SET pm.UFID=lu.UFID 
WHERE pm.Seq=lu.Seq
;



select * from  work.pymatch;

 








SELECT * from lookup.ufids WHERE UF_LAST_NM='Guirgis' ;
SELECT * from lookup.ufids WHERE UF_LAST_NM='Krasnogorskyi' AND UF_FIRST_NM LIKE 'E%';
SELECT * from lookup.ufids WHERE UF_LAST_NM='Chamba' ;
SELECT * from lookup.ufids WHERE UF_LAST_NM='Farrell' AND UF_FIRST_NM LIKE 'C%';
SELECT * from lookup.ufids WHERE UF_LAST_NM='caputo' AND UF_FIRST_NM LIKE 'An%';

SELECT * from lookup.ufids WHERE UF_EMAIL='huihu@ufl.edu';



Caputo, Anna Maria
Caton, Tina
Chamba, Tony
Edwards, Talethia
Gwin, Charlie
Moore
Thomas, Jessiaca Browder



SELECT * FROM lookup.Employees
WHERE Name like 'caputo%a%';

,
'Jones,Zach',
'Lemos,Kevin',
'Lynch,Brittany',
'Wilson,Jessica');


 