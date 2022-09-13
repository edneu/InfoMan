

use finance;

select * from assistbudgetyr8;

### Create worktable

Drop table if exists finance.hscwork;
CREATE TABLE finance.hscwork as
SELECT * from assistbudgetyr8;


ALTER TABLE finance.hscwork
ADD RecType varchar(25),
ADD ReportCollege varchar(45);


SET SQL_SAFE_UPDATES = 0;
UPDATE finance.hscwork SET RecType="Assist Budget";

SELECT * FROM finance.hscwork;


Drop table if exists finance.reptcolllu;
CREATE TABLE finance.reptcolllu as
SELECT Home_Dept_ID,REPORT_COLLEGE from finance.HSCdetail
WHERE (Home_Dept_ID <> '00000000' AND Home_Dept_ID IS NOT NULL)
group by Home_Dept_ID,REPORT_COLLEGE;


UPDATE finance.hscwork hs, finance.reptcolllu lu
SET hs.ReportCollege=lu.REPORT_COLLEGE
WHERE hs.Home_Dept_ID=lu.Home_Dept_ID; 

### UPDATE NEW HOME DEPTIDS
UPDATE finance.hscwork SET ReportCollege='Agriculture & Natural Resources' WHERE Home_Dept_ID='60880000';
UPDATE finance.hscwork SET ReportCollege='Medicine' WHERE Home_Dept_ID='29680505';
UPDATE finance.hscwork SET ReportCollege='Pharmacy' WHERE Home_Dept_ID='32030000';
UPDATE finance.hscwork SET ReportCollege='Libraries' WHERE Home_Dept_ID='55010900';
UPDATE finance.hscwork SET ReportCollege='Medicine' WHERE Home_Dept_ID='29680191';
UPDATE finance.hscwork SET ReportCollege='Liberal Arts And Sciences' WHERE Home_Dept_ID='12690100';

select Program,sum(Total) from finance.hscwork group by program;

select * from finance.hscwork where RFA_COMPONENT in ('I.InstCareerDevCore','J.NRSATL');

select * from finance.hscwork where PROGRAM in ('KLFunding','TLFunding');

drop table if exists finance.temp;
 create table finance.temp as 
select SEQ,PROGRAM,RFA_COMPONENT, Expense_Type, Employee_Name, UFID, Email, Home_Dept_ID, Line_Item_Detail, CTSI_Role, Total, RecType, ReportCollege
from finance.hscwork 
where RFA_COMPONENT in ('I.InstCareerDevCore','J.NRSATL') OR 
PROGRAM in ('KLFunding','TLFunding')
ORDER BY PROGRAM,SEQ;

Expense_Type	Employee_Name	UFID	Email Home_Dept_ID  Line_Item_Detail CTSI_Role Total	RecType	ReportCollege

select * from lookup.depts
WHERE Deptid IN 
(
'60100000',
'29050900',
'60320000',
'16600100',
'36020000',
'29110000',
'31020000',
'33160000');

);
select * from lookup.ufids WHERE UF_UFID="26292017";


select * from finance.reptcolllu;


