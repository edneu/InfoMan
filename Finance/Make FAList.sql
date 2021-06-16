
DROP TABLE IF EXISTS work.pilotlist;
create table work.pilotlist AS
SELECT 	UFID,
		Email,
        PI_Last AS LastName,
        PI_First AS Firstname,
        Category AS PilotType,
        1 AS PilotAward
from pilots.PILOTS_MASTER
Where Awarded="Awarded"
AND AwardLetterDate>str_to_date('07,01,2019','%m,%d,%Y');


DROP TABLE IF EXISTS work.FAList;
create table work.FAList AS
SELECT 	UFID,
		email AS Email,
		LastName,
        FirstName,
        GROUP_CONCAT(DISTINCT STD_PROGRAM ORDER BY STD_PROGRAM SEPARATOR ', ') AS RosterServices
from lookup.roster
WHERE Year in (2019,2020)
  AND UFID NOT IN ('',"0") 
  AND Faculty="Faculty"
GROUP BY UFID,
		email,
		LastName,
        FirstName
UNION ALL
SELECT 	UFID,
		Email,
        LastName,
        Firstname, 
        " " AS RosterServices
FROM work.pilotlist WHERE UFID NOT IN   (select distinct UFID
											from lookup.roster
											WHERE Year in (2019,2020)
                                            AND UFID NOT IN ('',"0") 
                                            AND Faculty="Faculty");        
        
ALTER TABLE work.FAList
	ADD PilotAward int(1),
	ADD PilotType varchar(25),
    ADD NumAwards int(5),
    ADD Direct decimal(65,11),
    ADD Indirect decimal(65,11),
    ADD TotalAwd decimal(65,11);
    

UPDATE  work.FAList    
