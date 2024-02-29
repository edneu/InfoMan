select * from lookup.ufids where UF_LAST_NM like "Ekakitie%";

select * from lookup.ufids where UF_EMAIL LIKE '%m%';

drop table if exists work.temp;
create table work.temp as
SELECT
 Employee_ID AS UFID,
 "NOT ACTIVE" AS Fill,
 Department_Code,
 Department,
 Job_Code,
 Name
 from lookup.Employees
WHERE Employee_ID IN ( 
'01111131',
'10503135',
'11313712',
'12297661',
'12906572',
'16361906',
'16367974',
'18799417',
'20616220',
'27122120',
'29659100',
'31318724',
'34040760',
'34156355',
'34803653',
'35159379',
'36672124',
'39512928',
'41190503',
'42299560',
'42459381',
'46906133',
'47864233',
'51917924',
'59014467',
'66295054',
'68186067',
'69192439',
'70216370',
'71606871',
'74145360',
'76618055',
'81240465',
'81915848',
'84629906',
'85463179',
'86289321',
'86878130',
'88314201',
'89108364',
'94804374',
'98187797',
'99191401',
'99811240')
ORDER BY Employee_ID;

UFID	Department Code	Department	Job Code	Name

drop table if exists work.temp;
create table work.temp as
Select UF_UFID,
UF_PS_DEPT_ID,
UF_DEPT_NM,
UF_WORK_TITLE,
UF_DISPLAY_NM
FROM lookup.ufids 
WHERE UF_UFID IN 
('84629906',
'59014467',
'68186067',
'99811240',
'39512928',
'34156355',
'88314201',
'29659100',
'86878130',
'36672124',
'66295054',
'12906572')
ORDER BY UF_UFID;

