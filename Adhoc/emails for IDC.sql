select * from lookup.email;

SELECT * from work.idc2022;
desc work.idc2022;

Alter table work.idc2022
ADD email varchar(125);

Alter table work.idc2022
ADD UFID varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.idc2022 idc, lookup.Employees lu
SET idc.email=lu.EMAIL
WHERE idc.LookupName=lu.NAME;

UPDATE work.idc2022 idc, lookup.roster lu
SET idc.email=lu.email
WHERE idc.LookupName=concat(lu.LastName,",",lu.FirstName)
and idc.email is null;

drop table if exists work.vouchufid;
Create table work.vouchufid as
SELEct UFID,EMAIL,Last_name as Lastname
from finance.Vouchers_2020_2022;

UPDATE work.vouchufid vu, lookup.roster lu
SET vu.Lastname=lu.LastName
WHERE vu.UFID=lu.UFID;




UPDATE work.idc2022 idc, work.vouchufid lu
SET idc.email=lu.EMAIL,
	idc.UFID=lu.UFID	
WHERE substr(idc.LookupName,1,(locate(',',idc.LookupName))-1)=UPPER(lu.LastName)
and idc.email is null;


drop table if exists work.rosterufid;
Create table work.rosterufid as
SELEct UFID,EMAIL,LastName,FirstName
from lookup.roster
GROUP BY UFID,EMAIL,LastName,FirstName;


UPDATE work.idc2022 idc, work.rosterufid lu
SET idc.email=lu.EMAIL,
	idc.UFID=lu.UFID	
WHERE idc.LookupName=concat(UPPER(lu.LastName),",",UPPER(lu.FirstName))
AND idc.email is null;

select UFID,Email from lookup.email
where UFID in
('15708549',
'08411620',
'48740250',
'79086138',
'73189951',
'94617561',
'91633346');



SELECT "Have Email" as cat, COUNT(*) as Measure from work.idc2022 where email is not NULL
UNION ALL
SELECT "No Email" as cat, COUNT(*) as Measure from work.idc2022 where email is NULL;

Select source, count(*) from work.idc2022 where email is null group by source;

SET idc.email=lu.EMAIL
WHERE idc.LookupName=lu.NAME;

select lastname,firstname, email , department from lookup.roster where lastname="merlo";

select  lastname,firstname, email,department from lookup.roster
 where lastname="loftus" and firstname like "j%";