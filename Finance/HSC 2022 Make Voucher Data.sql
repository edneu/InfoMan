#######################################################################################
#######################################################################################
######################## SORT OUT VOUCHER DATA
drop table if exists finance.voucher_work;
create table finance.voucher_work AS
select * from finance.loadvoucher_work;

UPDATE finance.voucher_work SET PI_UFID=LPAD(PI_UFID,8,'0');

Alter table finance.voucher_work
ADD DeptID varchaR(12),
Add DeptName Varchar(125),
Add College varchar(45);

UPDATE finance.voucher_work SET PI_UFID='02220960' WHERE PI='Nikolaus Gravenstein';
UPDATE finance.voucher_work SET PI_UFID='03660610' WHERE PI='Joseph Katz';
UPDATE finance.voucher_work SET PI_UFID='05363710' WHERE PI='Nandakumar Nagaraja';
UPDATE finance.voucher_work SET PI_UFID='17623400' WHERE PI='Yenisel Cruz-Almeida';
UPDATE finance.voucher_work SET PI_UFID='30167533' WHERE PI='Priya Sharma';
UPDATE finance.voucher_work SET PI_UFID='48431060' WHERE PI='Mariam Rahmani';
UPDATE finance.voucher_work SET PI_UFID='51593042' WHERE PI='Stephanie Marie Leon';
UPDATE finance.voucher_work SET PI_UFID='54807120' WHERE PI='Satya Narayan';
UPDATE finance.voucher_work SET PI_UFID='76874254' WHERE PI='Yijun Lin';
UPDATE finance.voucher_work SET PI_UFID='78719200' WHERE PI='Wei Wang';
UPDATE finance.voucher_work SET PI_UFID='93948441' WHERE PI='Yan Wang';
UPDATE finance.voucher_work SET PI_UFID='94617561' WHERE PI='Ting-Yuan David Cheng';
UPDATE finance.voucher_work SET PI_UFID='00404339' WHERE PI='Robert S Eisinger';
UPDATE finance.voucher_work SET PI_UFID='03663000' WHERE PI='Reem S. Abu-Rustum';
UPDATE finance.voucher_work SET PI_UFID='08512125' WHERE PI='Silvana Barbosa Carr';
UPDATE finance.voucher_work SET PI_UFID='13717930' WHERE PI='Dorian K Rose';
UPDATE finance.voucher_work SET PI_UFID='13788421' WHERE PI='Zheng Wang';
UPDATE finance.voucher_work SET PI_UFID='14336558' WHERE PI='Jeanne-Marie Stacciarini';
UPDATE finance.voucher_work SET PI_UFID='15192179' WHERE PI='Gabrielle Barnes';
UPDATE finance.voucher_work SET PI_UFID='16427444' WHERE PI='Loic Deleyrolle';
UPDATE finance.voucher_work SET PI_UFID='16570350' WHERE PI='Richard C Holbert';
UPDATE finance.voucher_work SET PI_UFID='17640480' WHERE PI='Adonice Khoury';
UPDATE finance.voucher_work SET PI_UFID='18278979' WHERE PI='Mustafa Mohammed Ahmed';
UPDATE finance.voucher_work SET PI_UFID='19579350' WHERE PI='Naykky Singh Ospina';
UPDATE finance.voucher_work SET PI_UFID='20111206' WHERE PI='Rozina Ali';
UPDATE finance.voucher_work SET PI_UFID='23763101' WHERE PI='Harvey W M Chim';
UPDATE finance.voucher_work SET PI_UFID='25965969' WHERE PI='Susan Nittrouer';
UPDATE finance.voucher_work SET PI_UFID='26780180' WHERE PI='Frederick Jay Fricker';
UPDATE finance.voucher_work SET PI_UFID='39149645' WHERE PI='Rachel Britton Forsyth';
UPDATE finance.voucher_work SET PI_UFID='39869149' WHERE PI='Amir Youssef Kamel';
UPDATE finance.voucher_work SET PI_UFID='41316100' WHERE PI='Kenneth H Rand';
UPDATE finance.voucher_work SET PI_UFID='41616363' WHERE PI='S. Madison Duff';
UPDATE finance.voucher_work SET PI_UFID='41838190' WHERE PI='Charlene P Pringle';
UPDATE finance.voucher_work SET PI_UFID='43639663' WHERE PI='Elmer Leonard Riley';
UPDATE finance.voucher_work SET PI_UFID='44511341' WHERE PI='Jason Cory Brunson';
UPDATE finance.voucher_work SET PI_UFID='46481410' WHERE PI='Roberto J Firpi-Morell';
UPDATE finance.voucher_work SET PI_UFID='46813561' WHERE PI='Natalie Bracewell';
UPDATE finance.voucher_work SET PI_UFID='48220817' WHERE PI='Elena Danielle Griffin';
UPDATE finance.voucher_work SET PI_UFID='49008939' WHERE PI='Erica Arden Dale';
UPDATE finance.voucher_work SET PI_UFID='53275290' WHERE PI='Frederick Seacrest Southwick';
UPDATE finance.voucher_work SET PI_UFID='56391650' WHERE PI='Merry Jennifer Markham';
UPDATE finance.voucher_work SET PI_UFID='57891069' WHERE PI='Nash S Moawad';
UPDATE finance.voucher_work SET PI_UFID='60766169' WHERE PI='Amanda Phalin';
UPDATE finance.voucher_work SET PI_UFID='62388170' WHERE PI='Sonal Sanjeev Tuli';
UPDATE finance.voucher_work SET PI_UFID='63899620' WHERE PI='Nicole J Tester';
UPDATE finance.voucher_work SET PI_UFID='73189951' WHERE PI='Shai Sewell';
UPDATE finance.voucher_work SET PI_UFID='74641387' WHERE PI='Ammar Isam Kamil';
UPDATE finance.voucher_work SET PI_UFID='74998390' WHERE PI='Adam L Wendling';
UPDATE finance.voucher_work SET PI_UFID='81499495' WHERE PI='Demetra D Christou';
UPDATE finance.voucher_work SET PI_UFID='81639480' WHERE PI='David E Winchester';
UPDATE finance.voucher_work SET PI_UFID='89783639' WHERE PI='Christopher Jankowski';
UPDATE finance.voucher_work SET PI_UFID='90416992' WHERE PI='Jacqlyn Lillie Yourell';
UPDATE finance.voucher_work SET PI_UFID='91633346' WHERE PI='Alisa J Johnson';
UPDATE finance.voucher_work SET PI_UFID='91713143' WHERE PI='Steven J Hughes';
UPDATE finance.voucher_work SET PI_UFID='92114496' WHERE PI='Tyler Glenn James';
UPDATE finance.voucher_work SET PI_UFID='93572850' WHERE PI='Ki Park';
UPDATE finance.voucher_work SET PI_UFID='93805983' WHERE PI='Andre Spiguel';
UPDATE finance.voucher_work SET PI_UFID='95754770' WHERE PI='Carl J Pepine';
UPDATE finance.voucher_work SET PI_UFID='96969432' WHERE PI='Christopher William Reb';
UPDATE finance.voucher_work SET PI_UFID='97113386' WHERE PI='Mohammad Ahmad Zaki Al-Ani';
UPDATE finance.voucher_work SET PI_UFID='92229847' WHERE PI='Andrea Herndon';
UPDATE finance.voucher_work SET PI_UFID='69687457' WHERE PI='Lisa J. Merlo';
UPDATE finance.voucher_work SET PI_UFID='86900831' WHERE PI='Carlos A Riveros Sabogal';
UPDATE finance.voucher_work SET PI_UFID='24652890' WHERE PI='Cortney Megan Starr';
UPDATE finance.voucher_work SET PI_UFID='53199263' WHERE PI='Paul Wasuwanich';
UPDATE finance.voucher_work SET PI_UFID='09953269' WHERE PI='Rasheedat Zakare';



## VERIFY UFID ASSIGNMENT
select count(DISTINCT PI) from  finance.voucher_work where PI_UFID IS NULL;
Select DISTINCT PI from  finance.voucher_work where PI_UFID IS NULL ;

## DEFINE HOME DEPARTMENTS

drop table if exists work.tempemp;
Create table work.tempemp AS
SELECT Employee_ID AS UFID,Name, max(Department_Code) as DeptID from lookup.Employees 
Where Employee_ID IN (SELECT DISTINCT PI_UFID from finance.voucher_work)
AND Salary_Plan_Code<>"CTSY"
Group by Employee_ID,Name;

select count(*), count(distinct Employee_ID) from work.tempemp;

UPDATE 	finance.voucher_work vw,
		work.tempemp lu
SET vw.DeptID=lu.DeptID
WHERE vw.PI_UFID=lu.UFID;        



drop table if exists work.deptlu;
create table work.deptlu as
SELECT UF_UFID,UF_DISPLAY_NM,UF_DEPT,UF_DEPT_NM
FROM lookup.ufids
WHERE UF_UFID IN (SELECT DISTINCT PI_UFID FROM finance.voucher_work WHERE DeptID is Null);


UPDATE 	finance.voucher_work vw, work.deptlu lu
SET vw.DeptID=lu.UF_DEPT
WHERE vw.PI_UFID=lu.UF_UFID
AND DeptID is Null;


UPDATE finance.voucher_work SET DeptID='29120300' WHERE PI='Lisa J. Merlo';
UPDATE finance.voucher_work SET DeptID='19340000' WHERE PI='Christopher D Batich';
UPDATE finance.voucher_work SET DeptID='29190000' WHERE PI='Ken Porche';



UPDATE finance.Vouchers_2020_2022  SET Report_College='Medicine' WHERE Last_Name='Paul Wasuwanich';
UPDATE finance.Vouchers_2020_2022  SET Report_College='Medicine - Jacksonville' WHERE Last_Name='Carlos A Riveros Sabogal';
UPDATE finance.Vouchers_2020_2022  SET Report_College='Medicine' WHERE Last_Name='Cortney Megan Starr';
UPDATE finance.Vouchers_2020_2022  SET Report_College='Medicine' WHERE Last_Name='Walter Steigleman';
UPDATE finance.Vouchers_2020_2022  SET Report_College='PHHP' WHERE Last_Name='Hannatu Tunga-Lergo';
UPDATE finance.Vouchers_2020_2022  SET Report_College='Health & Human Performance' WHERE Last_Name='Demetra D Christou';
UPDATE finance.Vouchers_2020_2022  SET Report_College='Pharmacy' WHERE Last_Name IN ('Andrea Herndono','Andrea Herndon');





SELECT PI_UFID, PI
FROM finance.voucher_work 
WHERE DeptID is Null;

### ASSIGN Department Names and College
UPDATE finance.voucher_work vw, lookup.depts lu
SET vw.DeptName=lu.DeptName,
	vw.College=lu.College
WHERE vw.DeptID=lu.DEPTID ;

UPDATE finance.voucher_work vw, lookup.deptlookup lu
SET vw.DeptName=lu.Department,
	vw.College=lu.College
WHERE vw.DeptID=lu.DEPTID 
AND vw.DeptName IS NULL;


SELECT PI_UFID, PI, DeptID, DeptName
FROM finance.voucher_work 
WHERE College is Null;