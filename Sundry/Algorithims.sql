SET sql_mode = '';
SET sql_mode = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION";
set global sql_mode= 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';


 SELECT VERSION();
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE "secure_file_priv";

SET SQL_SAFE_UPDATES = 0;

set @@global.net_write_timeout = 9999999;

SET SQL_SAFE_UPDATES = 1;


str_to_date('03,31,2015','%m,%d,%Y');




RESET QUERY CACHE;


/*  ADD UNDUP Variable DISCONTINED
*/
SET SQL_SAFE_UPDATES = 0;

drop table if exists work.undup_temp;
create table work.undup_temp as 
SELECT Roster_Key,min(rosterid) AS UndupRec
FROM loaddata.roster
WHERE Roster=1
GROUP BY Roster_Key;

UPDATE loaddata.roster SET Undup_ROSTER=0;

UPDATE loaddata.roster SET Undup_ROSTER=1
WHERE rosterid in (select UndupRec from work.undup_temp);

drop table if exists work.undup_temp;


CREATE INDEX rosterufid ON lookup.roster (UFID);
CREATE INDEX rosterpkey ON lookup.roster (Person_key);
CREATE INDEX vivoufid on lookup.vivo_pubs (ufid);
CREATE INDEX ufid ON lookup.ufids (UF_UFID);
CREATE INDEX email ON lookup.ufids (UF_EMAIL);
CREATE INDEX UF_USER_NM ON lookup.ufids (UF_USER_NM);
CREATE INDEX UFID_EMP ON lookup.employees (Employee_ID);
CREATE INDEX ufid_Active ON lookup.active_emp (Employee_ID);
CREATE INDEX rosterid ON lookup.roster (rosterid);

SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS work.TableList;
CREATE TABLE work.TableList AS
SELECT TABLE_SCHEMA,table_name,create_time, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_schema NOT IN  ('work','information_schema','performance_schema','mysql','phpmyadmin');
##AND table_name = 'active_emp';

desc INFORMATION_SCHEMA.TABLES;

select * from INFORMATION_SCHEMA.TABLES;

/* END ADD UNDUP Variable
*/

DROP TABLE IF EXISTS work.TableList;
CREATE TABLE work.TableList AS
SELECT TABLE_SCHEMA,table_name,create_time,UPDATE_TIME, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES 
WHERE table_schema  IN  ('Adhoc');




/*
CTSI GRANTS
Grant Number	Year	Grant Desc
KL2 RR029888	2009-2011	KL2 2009-2011
KL2 TR000065	2012-2015	KL2 2012-2015
KL2 TR001429	2015-2018	KL2 2015-2018
TL1 RR029889	2009-2011	TL1 2009-2011
TL1 TR000066	2012-2015	TL1 2012-2015
TL1 TR001428	2015-2018	TL1 2015-2018
UL1 RR029890    2009-2011	UL1 2009-2011
UL1 TR000064	2012-2015	UL1 2012-2015
UL1 TR001427	2015-2018	UL1 2015-2018


RR029888 | TR000065 | TR001429 | RR029889 | TR000066 | TR001428 | RR029890 | TR000064 | TR001427

2009-2011
RR029888 | RR029889 | RR029890

2012-2015
TR000065 | TR000066 | TR000064

2015-2018
TR001429 | TR001428 | TR001427

U Grant 2012 & @016
TR000064 | TR001427


EDWARDNEU    E423P!
DRNELSON UFctsi01
PEARSON #kylineDrive


All KL  TR001429 | TR000065 | RR029888

UL1 TR000064

TR000065 | TR000066 | TR000064 
*/

ALL U
RR029890 | TR000064 | TR001427

UL1 RR029890 | UL1 TR000064	| UL1 TR001427

#### GROUP_CONCAT
SELECT PMID,
       GROUP_CONCAT(DISTINCT Grant_Number SEPARATOR ', ') As CitedGrants
FROM work.pubmedgrants
GROUP BY PMID;       




#################### FIX DATES FROM EXCEL INTEGER DATES


Alter TABLE loaddata.employees
ADD ServiceDate date,
ADD HireDate date;

SET SQL_SAFE_UPDATES = 0;


UPDATE loaddata.employees
SET ServiceDate=DATE_ADD("1900-01-01",INTERVAL Service_Date-2 DAY),
       HireDate=DATE_ADD("1900-01-01",INTERVAL Hire_Date-2 DAY);


ALTER TABLE loaddata.employees
DROP Service_Date,
DROP Hire_Date;

select * from loaddata.employees;



########################################
SELECT TABLE_NAME,CREATE_TIME,UPDATE_TIME, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES
  WHERE table_schema = 'pubs';




DESC INFORMATION_SCHEMA.TABLES;

select * from bluezone.Blue2Master;



SHOW INDEX FROM lookup.ufids;

SELECT 
    TABLE_NAME,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'pubs';


desc INFORMATION_SCHEMA.STATISTICS;



SELECT DISTINCT
    TABLE_NAME,
    'TABLE_ROWS'
    COLUMN_NAME,
    index_type
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'pubs';



desc INFORMATION_SCHEMA.STATISTICS;


UL1 RR029890 | UL1 TR000064	| UL1 TR001427


