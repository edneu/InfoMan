

use finance;

select * from assistbudgetyr8;

### Create worktable

Drop table if exists finance.hscwork;
CREATE TABLE finance.hscwork as
SELECT * from assistbudgetyr8;


ALTER TABLE finance.hscwork
ADD RecType varchar(25),
ADD ReportCollege varchar(45);

ALter table finance.hscwork MODIFY Home_Dept_ID varchar(12);



SET SQL_SAFE_UPDATES = 0;
UPDATE finance.hscwork SET RecType="Assist Budget";

SELECT * FROM finance.hscwork;


Drop table if exists finance.reptcolllu;
CREATE TABLE finance.reptcolllu as
SELECT Home_Dept_ID,REPORT_COLLEGE from finance.HSCdetail
WHERE (Home_Dept_ID <> '00000000' AND Home_Dept_ID IS NOT NULL)
group by Home_Dept_ID,REPORT_COLLEGE;

delete from finance.reptcolllu where Home_Dept_IS 
IN ('TBD',
'ST010000',
'N/A',
'FSU');


UPDATE finance.hscwork hs, finance.reptcolllu lu
SET hs.ReportCollege=lu.REPORT_COLLEGE
WHERE hs.Home_Dept_ID=lu.Home_Dept_ID; 

select distinct Home_Dept_ID from finance.reptcolllu;



delete from finance.reptcolllu where Home_Dept_IS 
IN ('TBD',
'ST010000',
'N/A',
'FSU');


select distinct Home_Dept_ID from finance.hscwork;

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


select distinct  REPORT_COLLEGE from finance.reptcolllu;




#############################################################################################
#############################################################################################
# VOUCHERS

##DROP TABLE lookup.vouchers2023;


Alter table lookup.vouchers2023
ADD HomeDeptID varchar(12),
ADD HomeDept varchar(45),
ADD REPORT_COLLEGE Varchar(45);

Update lookup.vouchers2023 SET PI_UFID='62251270',  HomeDeptID='19340000', HomeDept='EG-BIOMEDICAL ENGINEERING', REPORT_COLLEGE='Engineering' WHERE vouchers2023_id=448;
Update lookup.vouchers2023 SET PI_UFID='40363600',  HomeDeptID='33030000', HomeDept='HP-OCCUPATIONAL THERAPY', REPORT_COLLEGE='Public Health & Health Professions' WHERE vouchers2023_id=461;
Update lookup.vouchers2023 SET PI_UFID='73189951',  HomeDeptID='33050000', HomeDept='HP-PHYSICAL THERAPY', REPORT_COLLEGE='Public Health & Health Professions' WHERE vouchers2023_id=457;
Update lookup.vouchers2023 SET PI_UFID='08326426',  HomeDeptID='29050400', HomeDept='MD-CARDIOLOGY', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=460;
Update lookup.vouchers2023 SET PI_UFID='13844103',  HomeDeptID='29092500', HomeDept='MD-COGNITAL HRT CTR EXCELLENCE', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=446;
Update lookup.vouchers2023 SET PI_UFID='49052230',  HomeDeptID='29680241', HomeDept='MD-CTSI SVC CTR - IDR', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=452;
Update lookup.vouchers2023 SET PI_UFID='15172985',  HomeDeptID='29290100', HomeDept='MD-EMERGENCY MED-AED', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=451;
Update lookup.vouchers2023 SET PI_UFID='95849921',  HomeDeptID='29290100', HomeDept='MD-EMERGENCY MED-AED', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=466;
Update lookup.vouchers2023 SET PI_UFID='21161434',  HomeDeptID='29240105', HomeDept='MD-HOBI-BIOMED INFORMATICS', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=465;
Update lookup.vouchers2023 SET PI_UFID='28284520',  HomeDeptID='29240101', HomeDept='MD-HOBI-GENERAL', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=450;
Update lookup.vouchers2023 SET PI_UFID='00251675',  HomeDeptID='29050800', HomeDept='MD-INFECTIOUS DISEASES', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=447;
Update lookup.vouchers2023 SET PI_UFID='67766182',  HomeDeptID='29150000', HomeDept='MD-OPHTHALMOLOGY', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=456;
Update lookup.vouchers2023 SET PI_UFID='19680850',  HomeDeptID='29210000', HomeDept='MD-OTOLARYNGOLOGY', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=459;
Update lookup.vouchers2023 SET PI_UFID='43639663',  HomeDeptID='29050900', HomeDept='MD-PULMONARY MEDICINE', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=463;
Update lookup.vouchers2023 SET PI_UFID='20484828',  HomeDeptID='29141402', HomeDept='MD-SURGERY-GI-COLORECTAL SURG', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=455;
Update lookup.vouchers2023 SET PI_UFID='83038210',  HomeDeptID='29141401', HomeDept='MD-SURGERY-GI-MINIM INVAS SURG', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=458;
Update lookup.vouchers2023 SET PI_UFID='38030072',  HomeDeptID='29141202', HomeDept='MD-SURGERY-SURGONC-PBS', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=453;
Update lookup.vouchers2023 SET PI_UFID='01536919',  HomeDeptID='29141900', HomeDept='MD-SURGERY-VASCULAR', REPORT_COLLEGE='Medicine' WHERE vouchers2023_id=462;
Update lookup.vouchers2023 SET PI_UFID='18080040',  HomeDeptID='31030000', HomeDept='NR-BNS-BIOBEHAVORIAL NUR SCI', REPORT_COLLEGE='Nursing' WHERE vouchers2023_id=445;
Update lookup.vouchers2023 SET PI_UFID='16141243',  HomeDeptID='36020000', HomeDept='PHHP-COM EPIDEMIOLOGY', REPORT_COLLEGE='PHHP-COM' WHERE vouchers2023_id=464;
Update lookup.vouchers2023 SET PI_UFID='63801344',  HomeDeptID='32060300', HomeDept='PH-OFFICE-EXPERIENTAL TRAIN', REPORT_COLLEGE='Pharmacy' WHERE vouchers2023_id=449;
Update lookup.vouchers2023 SET PI_UFID='62968490',  HomeDeptID='32060000', HomeDept='PH-PHARMTHERAPY TRNSL RSCH', REPORT_COLLEGE='Pharmacy' WHERE vouchers2023_id=454;


drop table if exists work.vouchers;
create table work.vouchers as
select * from lookup.vouchers2023
Where Date_issued>=str_to_date('07,01,2022','%m,%d,%Y')
AND Date_issued<=str_to_date('06,30,2023','%m,%d,%Y')
AND Status<>"Cancelled"; 


SELECT distinct PROGRAM from finance.hscwork;



SELECT SUM(Total) from finance.hscwork WHERE PROGRAM="VouchersFunding";

SELECT SUM(Total) from finance.hscwork ;


SELECT distinct PROGRAM from finance.hscwork;

SELECT distinct Primary_CTSI_Funding_Bucket from finance.hscwork;
SELECT distinct Expense_Type from finance.hscwork;
SELECT distinct PROGRAM from finance.hscwork;


select sum(Total) from finance.hscwork where  Expense_Type="Pilots";

select sum(Total) from finance.hscwork where Primary_CTSI_Funding_Bucket
IN (
'Existing Pilots (clin)',
'ExistingPilotsClinFunding',
'LHSPIlotsFunding');

############## FILL IN UFIDS
SELECT Name,Employee_ID,Department_Code,Department,Job_Code FROM lookup.Employees
WHERE
(NAME LIKE 'Parker%Leslie%') OR 
(NAME LIKE 'Lopez-Colon%Dalia%') OR 
(NAME LIKE 'Séraphin%Marie%') OR 
(NAME LIKE 'Arreola%Manuel%') OR 
(NAME LIKE 'Smith%Jordan%') OR 
(NAME LIKE 'Salloum%Ramzi%') OR 
(NAME LIKE 'Marchick%Michael%') OR 
(NAME LIKE 'Hanson%Kevin%') OR 
(NAME LIKE 'Nassour%Ibrahim%') OR 
(NAME LIKE 'Manasco%Kalen%') OR 
(NAME LIKE 'Nordenstam%Johan%') OR 
(NAME LIKE 'Khurshid%Gibran%') OR 
(NAME LIKE 'Sewell%Shai%') OR 
(NAME LIKE 'Al-Mansour%Mazen%') OR 
(NAME LIKE 'Dziegielewski%Peter%') OR 
(NAME LIKE 'Ruzieh%Mohammed%') OR 
(NAME LIKE 'Bodison%Stefanie%') OR 
(NAME LIKE 'Cooper%Michol%') OR 
(NAME LIKE 'Riley%Elmer%') OR 
(NAME LIKE 'Fenton%Melissa%') OR 
(NAME LIKE 'Lemas%Dominick%') OR 
(NAME LIKE 'Hwang%Charles%') ; 










select distinct Job_Code from lookup.Employees;


Where Date_issued>=str_to_date('07,01,2022','%m,%d,%Y')
AND Date_issued<=str_to_date('06,30,2023','%m,%d,%Y')
AND Status<>"Cancelled";










##################################
#### PILOT MAnagement
/* select * from pilots.PILOTS_MASTER;

select max(pilot_ID)+1 from pilots.PILOTS_MASTER;

Select UF_UFID,UF_LAST_NM,UF_FIRST_NM,UF_DEPT,UF_DEPT_NM," " as college,UF_GENDER_CD,UF_BIRTH_DT,UF_WORK_TITLE
FROM lookup.ufids
WHERE UF_EMAIL  like "dianataft@ufl.edu";



Select UF_UFID,UF_LAST_NM,UF_FIRST_NM,UF_DEPT,UF_DEPT_NM," " as college,UF_GENDER_CD,UF_BIRTH_DT,UF_WORK_TITLE
FROM lookup.ufids
WHERE UF_UFID in
(
'15773339',
'30015156',
'41256259',
'44511341',
'55556968',
'56399672',
'94911830'
)
ORDER BY UF_UFID;


select * from lookup.Employees where Employee_ID="55556968";

desc pilots.PILOTS_MASTER;



create table pilots.newmaster as
SELECT * from pilots.PILOTS_MASTER
UNION ALL
SELECT * from pilots.add2master;

select * from pilots.newmaster;

create table pilots.BUPilotsMaster20220914 as
SELECT * from pilots.PILOTS_MASTER;

drop table if Exists pilots.PILOTS_MASTER;
create table pilots.PILOTS_MASTER AS
SELECT * from pilots.newmaster;
*/

SELECT * from pilots.newmaster;

select * from lookup.ufids where UF_LAST_NM="Kuntz";

desc finance.hscwork;


SELECT program,`RFA_Function/Module`,RFA_COMPONENT,Primary_CTSI_Funding_Bucket,ASSIST_Primary_Category,CTSI_Role 
from finance.hscwork 
group by  program,`RFA_Function/Module`,RFA_COMPONENT,Primary_CTSI_Funding_Bucket,ASSIST_Primary_Category,CTSI_Role ;



##########################
## PILOT WORK

drop table if exists work.pilotstemp ;
create table work.pilotstemp as 
SELECT * from finance.hscwork 
WHERE  	(Primary_CTSI_Funding_Bucket IN ('ExistingPilotsClinFunding','Existing Pilots (clin)')) OR
		(CTSI_Role IN ('Existing Pilots'));





###########################################################################
### RECORDS SUBSTUTION

UPDATE finance.hscwork SET RecType="OMIT - Voucher Assist Record"
WHERE program="VouchersFunding";

UPDATE finance.hscwork SET RecType="OMIT - TL1 Assist Record"
WHERE program="TLFunding";

UPDATE finance.hscwork SET RecType="OMIT - KL2 Assist Record"
WHERE program="KLFunding";
