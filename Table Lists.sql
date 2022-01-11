
####Schema Size LIst
SELECT table_schema AS 'Database', 
ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)' 
FROM information_schema.TABLES 
GROUP BY table_schema
;


### Table Sizes in Specific Schema
SELECT table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)',
CREATE_TIME,
UPDATE_TIME,
CHECK_TIME
FROM information_schema.TABLES
WHERE table_schema = "ctsi_survey"
ORDER BY (data_length + index_length) DESC;


desc information_schema.TABLES;

### FILE LIST BY SIZE
SELECT 
TABLE_SCHEMA AS 'Schema',
table_name AS 'Table',
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)',
CONCAT('OPTIMIZE TABLE ',TABLE_SCHEMA,'.',table_name,";") as OPtSQL,
CREATE_TIME,
UPDATE_TIME,
CHECK_TIME
FROM information_schema.TABLES
ORDER BY (data_length + index_length) DESC;

select count(*) from lookup.email_master;
select count(*) from lookup.email;


select * from information_schema.TABLES;
select distinct TABLE_SCHEMA from information_schema.TABLES;

OPTIMIZE TABLE lookup.ufids;
OPTIMIZE TABLE lookup.awards_history;
OPTIMIZE TABLE lookup.email_master;
OPTIMIZE TABLE loaddata.PedsEmp181920;
OPTIMIZE TABLE lookup.email;

OPTIMIZE TABLE Adhoc.combined_hist_rept;
OPTIMIZE TABLE Adhoc.comb_hist_report20211202BU;