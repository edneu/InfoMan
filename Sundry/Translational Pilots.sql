drop table if exists work.temp;
create table work.temp AS
select Pilot_ID,PI_Last,PI_First,Email,Title,Category,AwardLetterDate,Award_Amt
from pilots.PILOTS_MASTER
WHERE Category="Translational"
AND Awarded="Awarded";


drop table if exists work.temp2;
create table work.temp2 AS
select Pilot_ID,PubYear,PMID,PMCID,Citation,PubDate,Total_Citations,Citations_per_Year,Expected_Citations_per_Year,Field_Citation_Rate,Relative_Citation_Ratio,NIH_Percentile
from pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID in (select Pilot_ID from work.temp)  ;

drop table if exists work.temp3;
create table work.temp3 AS
select Pilot_ID,Grant_Title,Year_Activiated,Grant_Sponsor,Grant_Sponsor_ID,Direct,Indirect,Total
from pilots.PILOTS_GRANT_SUMMARY
WHERE Pilot_ID in (select Pilot_ID from work.temp)  ;


SET SQL_SAFE_UPDATES = 0;



UPDATE  pilots.PILOTS_MASTER
SET Status="Completed"
WHERE Pilot_ID in (138,387,388,419);


UPDATE  pilots.PILOTS_MASTER
SET Status="Terminated"
Where Pilot_ID=386;

UPDATE  pilots.PILOTS_MASTER
SET Category="LHS"
Where Pilot_ID=419;


drop table if exists work.temp3;
create table work.temp3 AS
SELECT * from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Category in ("LHS","Translational");


desc pilots.PILOTS_MASTER;

select max(Pilot_ID) from  pilots.PILOTS_MASTER;

Select UF_UFID,UF_EMAIL,UF_DISPLAY_NM,UF_DEPT_NM from lookup.ufids WHERE UF_LAST_NM='Bylund';

select * from lookup.Employees WHERE NAME like "Bylund%";



 AND UF_FIRST_NM='Carma' OR
UF_LAST_NM='Price' AND UF_FIRST_NM='Catherine' OR
UF_LAST_NM='Fedele' AND UF_FIRST_NM='David' OR
UF_LAST_NM='Winterstein' AND UF_FIRST_NM='Almut' OR
UF_LAST_NM='Shenkman' AND UF_FIRST_NM='Betsy' OR
UF_LAST_NM='Tighe' AND UF_FIRST_NM='Patrick' OR
UF_LAST_NM='Duarte' AND UF_FIRST_NM='Julio' ;



Select UF_UFID,UF_EMAIL,UF_DISPLAY_NM,UF_DEPT_NM from lookup.ufids WHERE UF_LAST_NM='Bylund' AND UF_FIRST_NM LIKE 'C%' OR
UF_LAST_NM='Shenkman' AND UF_FIRST_NM='Elizabeth' ;





UFID
PI_DEPT
PI_DEPTID
PI_DEPTNM
Orig_Award_Year
ProjectStatus
ORGINAL_AWARD
College
PI_GENDER
PI_DOB
AwardeePositionAtApp
AwardeeCareerStage
Award_HummanSubjectResearch
CancerScore
AprilPilotID
IRB_Num
IRB_Approval_Date
IRB_Close_Date
CRC_STUDY
Survey2019
Rochester
RochCat
RochCat2
PROJECT_ID;


SELECT 	Employee_ID AS UFID,
		Name,
		Department AS PI_DEPT,
        Department_Code AS PI_DEPTID,
        Department AS PI_DEPTNM
FROM lookup.Employees
WHERE Employee_ID
IN ('27202101',
'30697200',
'37021280',
'49742180',
'52486590',
'54431330',
'57979120')
ORDER BY Employee_ID;


select distinct college from pilots.PILOTS_MASTER;


SELECT UF_UFID, UF_LAST_NM, UF_BIRTH_DT from lookup.ufids
WHERE UF_UFID 
IN ('27202101',
'30697200',
'37021280',
'49742180',
'52486590',
'54431330',
'57979120')
ORDER BY UF_UFID;


College
PI_GENDER
PI_DOB
AwardeePositionAtApp
AwardeeCareerStage
Award_HummanSubjectResearch
CancerScore
AprilPilotID
IRB_Num
IRB_Approval_Date
IRB_Close_Date
CRC_STUDY
Survey2019
Rochester
RochCat
RochCat2
PROJECT_ID
        


SELECT 	Employee_ID AS UFID,
		Name,
		Job_Code,
        Faculty,
        FacType,
        FacultyType
FROM lookup.Employees
WHERE Employee_ID
IN ('27202101',
'30697200',
'37021280',
'49742180',
'52486590',
'54431330',
'57979120')
ORDER BY Employee_ID;


desc pilots.PILOTS_MASTER;


select Status,ProjectStatus, count(*) AS N from pilots.PILOTS_MASTER group by Status,ProjectStatus;


ALTER TABLE pilots.PILOTS_MASTER
DROP COLUMN Cohort,
DROP COLUMN NumCollab,
DROP COLUMN ProjectStatus,
DROP COLUMN Survey2019,
DROP COLUMN Rochester,
DROP COLUMN RochCat,
DROP COLUMN RochCat2;

