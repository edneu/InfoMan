
DROP TABLE IF EXISTS  work.NIHRank ;
CREATE TABLE work.NIHRank AS

select CLK_AWD_PI,CLK_PI_UFID,
sum(DIRECT_AMOUNT) as Direct,
sum(INDIRECT_AMOUNT) as Indirect,
Sum(SPONSOR_AUTHORIZED_AMOUNT) as Total
from lookup.awards_history
WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'
AND YEAR(FUNDS_ACTIVATED)=2020
GROUP BY CLK_AWD_PI,CLK_PI_UFID;




ALTER TABLE work.NIHRank
ADD JobTitle varchar(55),
ADD Salary_Plan varchar(45),
ADD FacRank Varchar(35);



SET SQL_SAFE_UPDATES = 0;

UPDATE work.NIHRank nr, lookup.active_emp lu
SET nr.JobTitle=lu.Job_Code,
	nr.Salary_Plan=lu.Salary_Plan
WHERE nr.CLK_PI_UFID=lu.Employee_ID;    


UPDATE work.NIHRank nr, lookup.Employees lu
SET nr.JobTitle=lu.Job_Code,
	nr.Salary_Plan=lu.Salary_Plan
WHERE nr.CLK_PI_UFID=lu.Employee_ID
AND  nr.JobTitle is null
AND  nr.Salary_Plan is null;    


DELETE FROM  work.NIHRank WHERE SALARY_PLAN LIKE ('%Fellowship%');
DELETE FROM  work.NIHRank WHERE JobTitle = ('Clinical Research Coord III');

UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='JNT SCTST';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='VA Faculty';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='JNT AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='AFFL CLIN AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='AFFL AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='CO AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='AFFL RES AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='CLIN AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='RES AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='CHIEF & CLIN AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='DIR & CLIN AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='JNT RES AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='ADJ RES AST PROF';
UPDATE work.NIHRank SET FacRank='Assistant Professor' WHERE JobTitle='DIR & AST SCTST';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='JNT ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='RES ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='AFFL ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='PRG DIR & ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='CLIN ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='ASO PRG DIR & ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='POSTDOC ASO';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='PRG DIR & CLIN ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='ASO SCTST';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='ASO PRG DIR & RES ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='CO ASO PROF';
UPDATE work.NIHRank SET FacRank='Associate Professor' WHERE JobTitle='AFFL RES ASO PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='DIR & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='JNT PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='CHAIR & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='AFFL PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ADJ PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='PRG DIR & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='JNT EMIN SCHOLAR';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='CHIEF & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='RES PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='CLIN PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='CO PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='AFFL GRADUATE RES PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='AFFL RES PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='DIS PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='PRG DIR & DIS PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='CHIEF & CLIN PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ACT CHAIR & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='PRG DIR & EMIN SCHOLAR';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='AFFL EMIN SCHOLAR';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ACT ASO DEAN & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ASO DEAN & DIS PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ASO CHAIR & CLIN PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ASO CHAIR & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='DIR & RES ASO PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='EXEC ASO DEAN & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='INTERIM ASO DEAN & PROF';
UPDATE work.NIHRank SET FacRank='Professor' WHERE JobTitle='ASO PRG DIR & PROF';


select distinct JobTitle from work.NIHRank;

select distinct FacRank from work.NIHRank;



