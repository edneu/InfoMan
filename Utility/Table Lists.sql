
####Schema Size LIst
SELECT table_schema AS 'Database', 
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS SizeMB
FROM information_schema.TABLES 
GROUP BY table_schema
ORDER BY SizeMB DESC;
;


### Table Sizes in Specific Schema
SELECT table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)',
UPDATE_TIME
FROM information_schema.TABLES
WHERE table_schema NOT IN "Adhoc"
ORDER BY (data_length + index_length) DESC;


desc information_schema.TABLES;

### FILE LIST BY SIZE

DROP TABLE IF EXISTS  work.TableList;
CREATE TABLE work.TableList AS
SELECT 
TABLE_SCHEMA AS 'Schema',
table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
WHERE TABLE_SCHEMA NOT IN ('mysql','information_schema','sys','performance_schema')
ORDER BY ROUND(((data_length + index_length) / 1024 / 1024), 2)  DESC;

#######################
select "lookup" as DB, min(FUNDS_ACTIVATED) MinDate, MAX(FUNDS_ACTIVATED) as MaxDate from lookup.awards_history
UNION ALL
select "loaddata" as DB, min(FUNDS_ACTIVATED) MinDate, MAX(FUNDS_ACTIVATED) as MaxDate from loaddata.awards_history;


Select count(*) from lookup.roster;
Select count(*) from loaddata.newroster;

#######################################################
## DROP FROM 9/16/2022
/*
DROP TABLE ctsi_survey.LongWeight;
DROP TABLE ctsi_survey.LongWeightbackup;
DROP TABLE finance.DetailAssn;
DROP TABLE finance.Detail;
DROP TABLE finance.detail;
DROP TABLE loaddata.awards_history;
DROP TABLE loaddata.newtranshist202209;
DROP TABLE loaddata.newtranshist202208;
DROP TABLE loaddata.newtranshist202207;
DROP TABLE loaddata.newtranshist202206;
DROP TABLE loaddata.newtranshist202205;
DROP TABLE loaddata.newroster;
DROP TABLE loaddata.roster;
DROP TABLE loaddata.q1q2_2022_roster;
DROP TABLE lookup.ct_gov;
DROP TABLE work.EmployeeUpdate;
DROP TABLE work.Employees;
*/





#########################



#WHERE table_schema = "space"
ORDER BY (data_length + index_length) DESC;


/*
select count(*) from lookup.email_master;

select count(*) from space.Salary2016;
select count(*) from space.salary2016;

select count(*) from lookup.email;
*/

select * from information_schema.TABLES;
select distinct TABLE_SCHEMA from information_schema.TABLES;

OPTIMIZE TABLE lookup.ufids;
OPTIMIZE TABLE lookup.awards_history;
OPTIMIZE TABLE lookup.email_master;
OPTIMIZE TABLE loaddata.PedsEmp181920;
OPTIMIZE TABLE lookup.email;
OPTIMIZE TABLE lookup.roster;

OPTIMIZE TABLE Adhoc.combined_hist_rept;
OPTIMIZE TABLE Adhoc.comb_hist_report20211202BU;