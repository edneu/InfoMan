#  COVID PIS on GRANT AWARDS

DROP TABLE if exists work.covidinv;
CREATE TABLE work.covidinv AS
SELECT CLK_PI_UFID AS INV_UFID,
	   CLK_AWD_PI INV_NAME
from lookup.awards_history
WHERE CLK_AWD_PURPOSE_NAME LIKE "%COVID%" OR
CLK_AWD_PROJ_NAME LIKE "%COVID%" OR 
CLK_AWD_FULL_TITLE LIKE "%COVID%"
GROUP BY INV_UFID,INV_NAME
UNION ALL
SELECT CLK_AWD_PROJ_MGR_UFID AS INV_UFID,
	   CLK_AWD_PROJ_MGR AS INV_NAME 
from lookup.awards_history
WHERE CLK_AWD_PURPOSE_NAME LIKE "%COVID%" OR
CLK_AWD_PROJ_NAME LIKE "%COVID%" OR 
CLK_AWD_FULL_TITLE LIKE "%COVID%"
GROUP BY INV_UFID,INV_NAME;


DROP TABLE if exists work.covidinvud;
CREATE TABLE work.covidinvud AS
SELECT INV_UFID, INV_NAME
from work.covidinv
GROUP BY INV_UFID, INV_NAME;

ALTER TABLE work.covidinvud ADD Email varchar(255);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.covidinvud ci, lookup.ufids lu
set ci.Email=lu.UF_Email
WHERE ci.INV_UFID=lu.UF_UFID
AND lu.UF_EMAIL like "%ufl%";

delete from work.covidinvud where Email is NULL;


   ##work.email
select * from work.covidinvud; 

select * from lookup.ufids where UF_EMAIL like "Cpb@%";