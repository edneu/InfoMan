
create table work.actdept As
SELECT Distinct Department from lookup.active_emp; 


drop table if Exists work.active;
create table work.active as 
SELECT * from lookup.active_emp;

AlTER TABLE work.active add facgrp VARCHAR(15);

SET SQL_SAFE_UPDATES = 0;

update work.active SET facgrp="CLAS"
WHERE  Department like "LS-%";


update work.active SET facgrp='HealthScience' WHERE Department Like 'DN-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'JAX-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'JX-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'MD-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'MD-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'NR-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'OR-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'PH-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'PHHP-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'PH-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'VM-%';
update work.active SET facgrp='HealthScience' WHERE Department Like 'HA-%';

SELECT facgrp, 
	   Count(DISTINCT Employee_ID) AS nFAC
FROM work.active
WHERE Salary_Plan LIKE "%Faculty%"
GROUP BY facgrp;
       


select distinct Salary_Plan from  work.active ;