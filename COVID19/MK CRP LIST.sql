
drop table if exists work.CRPList;
create table work.CRPList as select * from work.email2;

drop table if exists work.email1;
create table work.email1 as
Select * from loaddata.`emp_email_2020-04`
WHERE Job_Title<>'ACADEMIC LUMP SUM PAYMENT';



drop table if exists work.CRPMailList1;
Create table work.CRPMailList1 as 
SELECT email,
       max(Name) as Name,
       Max(Department_Code) As Department_Code,
       MAX(Department) as Department,
       MAX(Job_Code) as Job_Code,
       MAx(Job_Title) As Job_Title
 from work.email1 where email in (SELECT DISTINCT Email2 FROM work.CRPList)
group by email;




select Job_Title,count(*) from work.CRPMailList1 group by Job_Title;  


SET SQL_SAFE_UPDATES = 0;

DELETE FROM work.CRPMailList1
WHERE Job_Title IN
('Academic Advisor I',
'Academic Assistant III',
'Academic Program Spec II',
'AFFL CLIN AST PROF',
'Application Programmer II',
'ASO DIR & AST SCTST',
'ASO UNIV LIBRARIAN',
'AST DIR, Administrative Svcs',
'AST DIR, Educ/Training Prgms',
'Ast Dir, Strategic Init/Adv',
'AST IN',
'AST SCTST',
'Biological Scientist III',
'CHAIR & PROF',
'CO PROF',
'CO RES AST PROF',
'DIR & CLIN PROFESSOR',
'DIR & SR LECTURER',
'DIR, Health Care Admin',
'DRC Rsch Regulatory Manager',
'Education/Training Spec III',
'GRADUATE AST-G',
'GRADUATE AST-T',
'GRADUATE RES ASO',
'HSC RAC Administrator I',
'Image Guidance Technician',
'JNT AST PROF',
'JNT PROF',
'JNT RES AST PROF',
'LECTURER',
'Medical Scientist III',
'MGR, Operations',
'OPS - Healthcare',
'OPS - Secondary',
'OPS Exempt',
'OPS LUMP SUM PAYMENT',
'PRG DIR & AST SCTST',
'PRG DIR & PROF',
'Quality Officer',
'RES ASO PROF',
'RES AST SCTST',
'RES PROF',
'SCHOLAR',
'Senior Assistant Dean',
'STU AST - NON-CLERICAL & ADMIN',
'VA Faculty',
'Administrative Spec III',
'Administrative Support AST II',
'ASO CHAIR & PROF',
'Biological Scientist II',
'CO AST PROF',
'Core Rsch Facility Manager',
'Education/Training Spec II',
'GRADUATE RES AST',
'OPS - Special Project',
'OPS - Time Limited',
'RESIDENT',
'Administrative Support AST III',
'AST DIR, Health Care Admin',
'AST PROF',
'CLIN ASO PROF',
'Data Management Analyst III',
'JNT ASO PROF',
'POSTDOC FELLOWSHIP',
'CO CLIN AST PROF',
'PREDOC FELLOWSHIP',
'CLIN AST PROF',
'POSTDOC ASO',
'RES AST PROF',
'GRADUATE AST-R',ml.UFID=lu.
'CHAIR & ASO UNIV LIBRARIAN',
'CLIN PROF',
'Genetic Counselor');



select Job_Title,count(*) from work.CRPMailList1 group by Job_Title;  

ALter table work.CRPMailList1 ADD UFID varchar(12);

ALter table work.CRPMailList1 ADD LastName varchar(45),
							ADD FIrstName varchar(45);





UPDATE work.CRPMailList1 ml, lookup.Employees lu
SET ml.UFID=lu.Employee_ID,
	ml.LastName=lu.LastName,
    ml.FirstName=lu.FirstName
WHERE ml.email=lu.EMAIL
;


select * from work.CRPMailList1;

DELETE from work.CRPMailList1 where UFID is Null;
