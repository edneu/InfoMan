select distinct category from pilots.PILOTS_MASTER;




DROP TABLE IF EXISTS work.lhspilots;
CREATE TABLE work.lhspilots As

select Pilot_ID,
		Award_Year,
        Category,
        AwardType,
        AwardLetterDate,
        Award_Amt,
        Status,
        PI_Last,
        PI_First,
        Title
from pilots.PILOTS_MASTER
where Category='LHS'
	AND Awarded="Awarded"
    ORDER BY Pilot_ID;
    

SET SQL_SAFE_UPDATES = 0;
UPdate pilots.PILOTS_MASTER
SET Category="Network" WHERE AwardType="Network";


SELECT * from lookup.Employees
WHERE NAme Like "Shenkman%";


Select Employee_ID,Name,Department_Code,Department,Salary_Plan,Job_Code
from lookup.Employees
WHERE Employee_ID IN
('06650986',
'08549700',
'17624245',
'18080040',
'24269289',
'29050800',
'39387807',
'62770426',
'74607680',
'75359014',
'85002360',
'88059430',
'95139899');


select * from lookup.ufids
where UF_LAST_NM ='Seraphin';



SELECT UF_UFID,UF_LAST_NM,UF_FIRST_NM,UF_EMAIL,UF_GENDER_CD,UF_BIRTH_DT
from lookup.ufids
WHERE UF_UFID IN
(
'00251675',
'06650986',
'08549700',
'17624245',
'18080040',
'24269289',
'39387807',
'54431330',
'62770426',
'74607680',
'75359014',
'85002360',
'88059430',
'95139899')
ORDER BY UF_UFID;



SELECT Employee_ID,Name,Salary_Plan,Job_Code,FacType,FacultyType
from lookup.Employees
WHERE Employee_ID IN
(
'00251675',
'06650986',
'08549700',
'17624245',
'18080040',
'24269289',
'39387807',
'54431330',
'62770426',
'74607680',
'75359014',
'85002360',
'88059430',
'95139899')
ORDER BY Employee_ID;

select max(pilot_ID)+1 from pilots.PILOTS_MASTER;


create table pilots.backupPIlotMaster20220131 AS
select * from pilots.PILOTS_MASTER;

CREATE TABLE pilots.PILOTS_MASTER AS
select * from PILOT_MASTER;
