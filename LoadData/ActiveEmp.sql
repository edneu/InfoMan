




create table loaddata.active_emp_bu
AS Select * from lookup.active_emp;

Alter table loaddata.active_emp_bu CHANGE COLUMN `active_emp_2017_02_10_id` `active_emp_id` int(11);


drop table if exists lookup.active_emp;
create table lookup.active_emp AS
select * from loaddata.active_emp_20180912;


Alter table lookup.active_emp CHANGE COLUMN `active_emp_20180912_id2` `active_emp_id` int(11);

drop table if exists loaddata.EmpAccrued;
Create table loaddata.EmpAccrued AS
select * from lookup.active_emp
UNION ALL 
SELECT * from loaddata.active_emp_bu
WHERE Employee_ID NOT IN (SELECT DISTINCT Employee_ID from lookup.active_emp);

### lookup.Employees contains Employee records including non active employees.
DROP TABLE IF EXISTS lookup.Employees;
CREATE TABLE lookup.Employees As
SELECT * FROM loaddata.EmpAccrued;


############### APPEND NEW DATA  MAKE into Active EMP
drop table if exists loaddata.active_emp_bu;
create table loaddata.active_emp_bu
AS Select * from lookup.active_emp;


drop table if exists lookup.active_emp;
create table lookup.active_emp AS
select * from loaddata.active_emp_2018_09_28;

### LAST UPDATED ON 2018-09-28

drop table if exists loaddata.EmpAccrued;
Create table loaddata.EmpAccrued AS
select * from lookup.Employees
UNION ALL 
SELECT * from lookup.active_emp
WHERE Employee_ID NOT IN (SELECT DISTINCT Employee_ID from lookup.Employees);

drop table exists

select "lookup.Employees" as measure, count(*) as n from lookup.Employees
union all 
select "loaddata.EmpAccrued" as measure, count(*) as n  from loaddata.EmpAccrued;

/*
drop table if exists lookup.Employees;
create table lookup.Employees as select * from loaddata.EmpAccrued;
*/

desc lookup.Employees;