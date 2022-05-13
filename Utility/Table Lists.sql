
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
WHERE table_schema = "Adhoc"
ORDER BY (data_length + index_length) DESC;


desc information_schema.TABLES;

### FILE LIST BY SIZE
SELECT 
TABLE_SCHEMA AS 'Schema',
table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES
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