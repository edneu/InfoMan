
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




UPDATE Adhoc.VouchWork SET SFY="SFY 2014-2015"
WHERE Month IN (
'2014-07',
'2014-08',
'2014-09',
'2014-10',
'2014-11',
'2014-12',
'2015-01',
'2015-02',
'2015-03',
'2015-04',
'2015-05',
'2015-06');



UPDATE Adhoc.VouchWork SET SFY="SFY 2015-2016"
WHERE Month IN (
'2015-07',
'2015-08',
'2015-09',
'2015-10',
'2015-11',
'2015-12',
'2016-01',
'2016-02',
'2016-03',
'2016-04',
'2016-05',
'2016-06');




UPDATE Adhoc.VouchWork SET SFY="SFY 2016-2017"
WHERE Month IN (
'2016-07',
'2016-08',
'2016-09',
'2016-10',
'2016-11',
'2016-12',
'2017-01',
'2017-02',
'2017-03',
'2017-04',
'2017-05',
'2017-06');



UPDATE Adhoc.VouchWork SET SFY="SFY 2017-2018"
WHERE Month IN (
'2017-07',
'2017-08',
'2017-09',
'2017-10',
'2017-11',
'2017-12',
'2018-01',
'2018-02',
'2018-03',
'2018-04',
'2018-05',
'2018-06');

UPDATE Adhoc.VouchWork SET SFY="SFY 2018-2019"
WHERE Month IN (
'2018-07',
'2018-08',
'2018-09',
'2018-10',
'2018-11',
'2018-12',
'2019-01',
'2019-02',
'2019-03',
'2019-04',
'2019-05',
'2019-06');

UPDATE Adhoc.VouchWork SET SFY="SFY 2019-2020"
WHERE Month IN (
'2019-07',
'2019-08',
'2019-09',
'2019-10',
'2019-11',
'2019-12',
'2020-01',
'2020-02',
'2020-03',
'2020-04',
'2020-05',
'2020-06');

UPDATE Adhoc.VouchWork SET SFY="SFY 2020-2021"
WHERE Month IN (
'2020-07',
'2020-08',
'2020-09',
'2020-10',
'2020-11',
'2020-12',
'2021-01',
'2021-02',
'2021-03',
'2021-04',
'2021-05',
'2021-06');


SELECt SFY,Month,count(*) from Adhoc.VouchWork group by SFY,Month;

SELECT * from Adhoc.VouchWork;