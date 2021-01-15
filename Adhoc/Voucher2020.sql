
########### VERIFY VOUCHER DATA

Drop table if exists  Adhoc.VouchWork;
Create Table Adhoc.VouchWork AS
select * from Adhoc.voucher1;

DROP TABLE if exists Adhoc.vochver1;
create table Adhoc.vochver1 AS
select v1.OrigSeq,
	   v1.UFID,
       lu.UF_UFID,
       v1.Last_Name,
       lu.UF_LAST_NM,
       v1.First_Name,
       lu.UF_First_NM,
       v1.Email,
       lu.UF_EMAIL
from Adhoc.VouchWork v1
left join lookup.ufids lu
on v1.UFID=lu.UF_UFID
WHERE trim(v1.Last_name)<>trim(lu.UF_LAST_NM);


UPDATE 	Adhoc.VouchWork vw,
		lookup.ufids lu
SET vw.Last_Name=lu.UF_LAST_NM,
	vw.First_Name=lu.UF_First_NM
WHERE vw.UFID=lu.UF_UFID
  AND trim(vw.Last_name)<>trim(lu.UF_LAST_NM)
  AND vw.Email=lu.UF_EMAIL;
  
  
UPDATE 	Adhoc.VouchWork vw,
		Adhoc.vouch_upd2 lu
SET vw.Last_Name=lu.Last_Name,
	vw.First_Name=lu.First_Name,
    vw.Email=lu.Email
WHERE vw.OrigSeq=lu.OrigSeq;
  
 
DROP TABLE if exists Adhoc.vochver1;
create table Adhoc.vochver1 AS
select v1.OrigSeq,
	   v1.UFID,
       lu.UF_UFID,
       v1.Last_Name,
       lu.UF_LAST_NM,
       v1.First_Name,
       lu.UF_First_NM,
       v1.Email,
       lu.UF_EMAIL
from Adhoc.VouchWork v1
left join lookup.ufids lu
on v1.UFID=lu.UF_UFID
WHERE trim(v1.Last_name)<>trim(lu.UF_LAST_NM)
AND OrigSeq NOT IN (106,189); 


SELECT Employee_ID,
       max(LastName) as Last_Name,
       max(FirstName) AS First_Name,
       max(EMAIL) As Email
 from lookup.Employees
WHERE Employee_ID in
('05363710',
'14950070',
'16745261',
'51715100',
'64267842',
'69789964',
'84957104'
)
GROUP BY Employee_ID;
 
UPDATE 	Adhoc.VouchWork vw,
		Adhoc.vouch_upd2 lu
SET vw.Last_Name=lu.Last_Name,
	vw.First_Name=lu.First_Name,
    vw.Email=lu.Email
WHERE vw.OrigSeq=lu.OrigSeq;
 
SELECT * from Adhoc.VouchWork ; 

select * from lookup.ufids where UF_EMAIL="kmotaparthi@dermatology.med.ufl.edu";
UPDATE Adhoc.VouchWork SET UFID='98625620' WHERE OrigSeq=3; 
  
DROP TABLE if exists Adhoc.vochver1;
create table Adhoc.vochver1 AS
select v1.OrigSeq,
	   v1.UFID,
       lu.UF_UFID,
       v1.Last_Name,
       lu.UF_LAST_NM,
       v1.First_Name,
       lu.UF_First_NM,
       v1.Email,
       lu.UF_EMAIL
from Adhoc.VouchWork v1
left join lookup.ufids lu
on v1.UFID=lu.UF_UFID
WHERE trim(v1.Last_name)<>trim(lu.UF_LAST_NM)
AND OrigSeq NOT IN (106,189); 


SELECT UF_UFID,UF_LAST_NM,UF_FIRST_NM,UF_EMAIL,UF_DEPT,UF_WORK_TITLE from lookup.ufids
WHERE UF_LAST_NM='Lope' ;


SELECT Employee_ID,LastName,FirstName,Email,Job_Code,Department from lookup.Employees WHERE Name LIKE "Bird%" ;
; 



(UF_LAST_NM='Richer' AND UF_FIRST_NM like 'C%') OR 
(UF_LAST_NM='Van' AND UF_FIRST_NM like 'C%') OR 
(UF_LAST_NM='Lopez' AND UF_FIRST_NM like 'N%') OR 
(UF_LAST_NM='Terry' AND UF_FIRST_NM like 'A%') OR 
(UF_LAST_NM='Roberts' AND UF_FIRST_NM like 'H%') OR 
(UF_LAST_NM='Fredenburgh' AND UF_FIRST_NM like 'C%') OR 
(UF_LAST_NM='Shen' AND UF_FIRST_NM like ' %') 
 ; 



UPDATE 	Adhoc.VouchWork vw,
		Adhoc.vouch_upd3 lu
SET vw.Last_Name=lu.Last_Name,
	vw.First_Name=lu.First_Name,
    vw.Email=lu.Email,
    vw.UFID=lu.UFID
WHERE vw.OrigSeq=lu.OrigSeq;


UPDATE Adhoc.VouchWork SET Date_Issued=str_to_date('03,30,2016','%m,%d,%Y') WHERE OrigSeQ=384;


ALTER TABLE Adhoc.VouchWork
ADD Month varchar(7),
ADD SFY varchar(15);


UPDATE Adhoc.VouchWork SET MONTH=concat(YEAR(Date_Issued),"-",LPAD(MONTH(Date_Issued),2,"0")) ;
UPDATE Adhoc.VouchWork vw, lookup.sfy lu SET vw.SFY=lu.SFY WHERE vw.MONTH=lu.MONTH;

SELECt SFY,Month,count(*) from Adhoc.VouchWork group by SFY,Month;

ALTER TABLE Adhoc.VouchWork 
ADD Name varchar(122),
ADD DeptID varchar(12),
ADD Department varchar(45);

UPDATE Adhoc.VouchWork SET NAME=Concat(Last_Name,", ",First_Name);


UPDATE Adhoc.VouchWork SET DeptID=Null, Department=Null;

UPDATE Adhoc.VouchWork vw, lookup.active_emp lu
SET vw.DeptID=lu.Department_Code,
    vw.Department=lu.Department
WHERE vw.UFID=lu.Employee_ID;    




UPDATE Adhoc.VouchWork vw, lookup.Employees lu
SET vw.DeptID=lu.Department_Code,
    vw.Department=lu.Department
WHERE vw.UFID=lu.Employee_ID
AND vw.DeptID IS NULL
;

UPDATE Adhoc.VouchWork vw, lookup.ufids lu
SET vw.DeptID=lu.UF_DEPT,
    vw.Department=lu.UF_DEPT_NM
WHERE vw.UFID=lu.UF_UFID
AND vw.DeptID IS NULL
AND UF_DEPT_NM<>"00000000";  


UPDATE Adhoc.VouchWork vw
SET vw.DeptID='Unknown',
    vw.Department='Unknown'
WHERE vw.DeptID=' ' OR vw.DeptID IS NULL;  

ALTER TABLE Adhoc.VouchWork ADD College varchar(45);


UPDATE Adhoc.VouchWork SET College=NULL;

UPDATE Adhoc.VouchWork vw, lookup.depts lu
SET vw.College=lu.College
WHERE vw.DeptID=lu.DEPTID;

UPDATE Adhoc.VouchWork vw
SET vw.College="Unknown"
WHERE vw.DeptID="Unknown";


UPDATE Adhoc.VouchWork vw
SET vw.Department='Student',
    vw.College='Student'
WHERE vw.DeptID="ST010000";


ALTER TABLE Adhoc.VouchWork Add SrvName varchar(45);

UPDATE Adhoc.VouchWork SET SrvName='BERD' WHERE Service='BERD';
UPDATE Adhoc.VouchWork SET SrvName='HealthStreet' WHERE Service='HLTHST';
UPDATE Adhoc.VouchWork SET SrvName='CTS-IT' WHERE Service='CTS_IT';
UPDATE Adhoc.VouchWork SET SrvName='IDR' WHERE Service='IDR';
UPDATE Adhoc.VouchWork SET SrvName='RedCap' WHERE Service='REDCAP';
UPDATE Adhoc.VouchWork SET SrvName='Recruitment Center' WHERE Service='RECRUIT';
UPDATE Adhoc.VouchWork SET SrvName='Regulatory Assistance' WHERE Service='REG';
UPDATE Adhoc.VouchWork SET SrvName='Stem Cell' WHERE Service='iPSC';
UPDATE Adhoc.VouchWork SET SrvName='Other' WHERE Service='OTHERS';
UPDATE Adhoc.VouchWork SET SrvName='Clinical Trials.GOV' WHERE Service='CLINICAL TRIALS.GOV';
UPDATE Adhoc.VouchWork SET SrvName='Communications' WHERE Service='Communication Research';
UPDATE Adhoc.VouchWork SET SrvName='Quality Assurance' WHERE Service='QA';
UPDATE Adhoc.VouchWork SET SrvName='Research Admin and Compliance ' WHERE Service='RAC';
UPDATE Adhoc.VouchWork SET SrvName='BioRepository' WHERE Service='BIOREPOSITORY';
UPDATE Adhoc.VouchWork SET SrvName='Human Imaging' WHERE Service='HUMAN IMAGING';





select * from Adhoc.VouchWork;

create table finance.VoucherFY2020on AS
SELECT * from Adhoc.VouchWork
WHERE SFY IN ("SFY 2019-2020","SFY 2020-2021");

###############################################################
###############################################################
## CHART DATA

DROP TABLE IF EXISTS Adhoc.VouchChart;
create table Adhoc.VouchChart AS
SELECT SFY, SUM(Amount) as Amount, COUNT(*) as nVOUCH
FROM Adhoc.VouchWork
GROUP BY SFY;

DROP TABLE IF EXISTS Adhoc.VouchChart;
create table Adhoc.VouchChart AS
SELECT SrvName, SUM(Amount) as Amount, COUNT(*) as nVOUCH
FROM Adhoc.VouchWork
GROUP BY SrvName;


DROP TABLE IF EXISTS Adhoc.VouchChart;
create table Adhoc.VouchChart AS
SELECT College, SUM(Amount) as Amount, COUNT(*) as nVOUCH
FROM Adhoc.VouchWork
GROUP BY College;


DROP TABLE IF EXISTS Adhoc.VouchChart;
create table Adhoc.VouchChart AS
Select 	Name,
		max(Department) as Department,
        SUM(Amount) as Amount, 
        COUNT(*) as nVOUCH, 
        count(Distinct Service) as NDiffSvc,
        Min(Date_Issued) as FirstVoucher,
        max(Date_Issued) as LastVoucher 
FROM Adhoc.VouchWork
WHERE NAME<>""
GROUP BY Name
ORDER BY nVOUCH DESC;


desc Adhoc.VouchWork;
