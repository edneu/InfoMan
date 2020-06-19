DROP TABLE IF EXISTS work.FacbyColl;
CREATE TABLE work.FacbyColl AS
SELECT Department,Count(DISTINCT Employee_ID) as nFac
from lookup.active_emp
WHERE Salary_Plan like "%FAC%"
GROUP BY Department;




ALTER TABLE work.FacbyColl ADD College varchar(65);


SET SQL_SAFE_UPDATES = 0;



select * from work.FacbyColl;

UPDATE work.FacbyColl SET College='College of Medicine' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='MD';
UPDATE work.FacbyColl SET College='College of Liberal Arts and Sciences' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='LS';
UPDATE work.FacbyColl SET College='College of Agricultural and Life Sciences' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='AG';
UPDATE work.FacbyColl SET College='College of Public Health and Health Professions' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='HP';
UPDATE work.FacbyColl SET College='College of the Arts' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='COTA';
UPDATE work.FacbyColl SET College='College of Engineering' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='EG';
UPDATE work.FacbyColl SET College='Information Technology' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='IT';
UPDATE work.FacbyColl SET College='HSC News and Communications' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='HA';
UPDATE work.FacbyColl SET College='UF Health Shands Hospital' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='Shands';
UPDATE work.FacbyColl SET College='College of Veterinary Medicine' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='VM';
UPDATE work.FacbyColl SET College='University Libraries' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='LB';
UPDATE work.FacbyColl SET College='Provost Office' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='PV';
UPDATE work.FacbyColl SET College='College of Nursing' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='NR';
UPDATE work.FacbyColl SET College='University Business Affairs' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='BA';
UPDATE work.FacbyColl SET College='Reitz Union' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='REITZ';
UPDATE work.FacbyColl SET College='College of Liberal Arts and Sciences' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='LS';
UPDATE work.FacbyColl SET College='College of Medicine' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='MD';
UPDATE work.FacbyColl SET College='Environmental Health and Safety' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='EHS';
UPDATE work.FacbyColl SET College='College of Journalism and Communications' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='CJC';
UPDATE work.FacbyColl SET College='College of Education' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='ED';
UPDATE work.FacbyColl SET College='College of Design Construction and Planning' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='DCP';
UPDATE work.FacbyColl SET College='College of Dentistry' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='DN';
UPDATE work.FacbyColl SET College='College of Pharmacy' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='PH';
UPDATE work.FacbyColl SET College='College of Agricultural and Life Sciences' WHERE SUBSTR(Department,1,Locate('-',Department)-1)='AG';



select * from work.FacbyColl;


SELECT College,SUM(nFac) 
FROM work.FacbyColl
GROUP BY College
ORDER BY College;





