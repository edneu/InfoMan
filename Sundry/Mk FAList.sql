
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


DROP TABLE IF EXISTS work.FAList1;
create table work.FAList1 AS
SELECT 	UFID,
        max("Roster  ") as Source, 
		max(email) AS Email,
		max(LastName) AS LastName,
        max(FirstName) AS FirstName,
        GROUP_CONCAT(DISTINCT STD_PROGRAM ORDER BY STD_PROGRAM SEPARATOR ', ') AS RosterServices
from lookup.roster
WHERE Year in (2019,2020)
  AND UFID NOT IN ('',"0") 
  AND Faculty="Faculty"
GROUP BY UFID
UNION ALL
SELECT 	UFID,
        "Pilot" as Source, 
		Email,
        LastName,
        Firstname, 
        " " AS RosterServices
FROM work.pilotlist WHERE UFID NOT IN   (select distinct UFID
											from lookup.roster
											WHERE Year in (2019,2020)
                                            AND UFID NOT IN ('',"0") 
                                            AND Faculty="Faculty")
UNION ALL
SELECT 	UF_UFID AS UFID,
        "Payroll  " as Source,
		UF_EMAIL AS Email,
        UF_LAST_NM AS LastName,
        UF_FIRST_NM AS Firstname, 
        " " AS RosterServices                                            
 from lookup.ufids
 WHERE UF_UFID IN (SELECT DISTINCT UFID from work.allfaqc)
 AND UF_UFID NOT IN (select distinct UFID
					 from lookup.roster
					  WHERE Year in (2019,2020)
                      AND UFID NOT IN ('',"0") 
                      AND Faculty="Faculty");
 

DROP TABLE IF EXISTS work.FAList2;
create table work.FAList2 AS
 SELECT * from work.FAList1
 UNION ALL
 SELECT UF_UFID AS UFID,
        "COVIDAWD" as Source,
		UF_EMAIL AS Email,
        UF_LAST_NM AS LastName,
        UF_FIRST_NM AS Firstname, 
        " " AS RosterServices    
From lookup.ufids
WHERE UF_UFID IN (SELECT DISTINCT CLK_PI_UFID FROM lookup.awards_history
					WHERE CLK_AWD_PROJ_NAME LIKE "%COVID%")
AND UF_UFID NOT IN (SELECT DISTINCT UFID from work.FAList1);                  
							
DROP TABLE IF EXISTS work.FAList3;
create table work.FAList3 AS
 SELECT * from work.FAList2
 UNION ALL
 SELECT UF_UFID AS UFID,
        "LOS" as Source,
		UF_EMAIL AS Email,
        UF_LAST_NM AS LastName,
        UF_FIRST_NM AS Firstname, 
        " " AS RosterServices    
From lookup.ufids 
WHERE UF_UFID IN (SELECT DISTINCT UFID from work.falos)
AND UF_UFID NOT IN (SELECT DISTINCT UFID FROM work.FAList2);                              
                                
                                
 DROP TABLE IF EXISTS work.FAList;
create table work.FAList AS
 SELECT * from work.FAList3
 UNION ALL
 SELECT UF_UFID AS UFID,
        "PltApp" as Source,
		UF_EMAIL AS Email,
        UF_LAST_NM AS LastName,
        UF_FIRST_NM AS Firstname, 
        " " AS RosterServices    
From lookup.ufids 
WHERE UF_UFID IN (SELECT DISTINCT UFID from work.nonaward)
AND UF_UFID NOT IN (SELECT DISTINCT UFID FROM work.FAList3);                                 
        
ALTER TABLE work.FAList
	ADD PilotAward int(1),
    ADD PilotType varchar(25),
    ADD NumAwards int(5),
    ADD Direct decimal(65,11),
    ADD Indirect decimal(65,11),
    ADD TotalAwd decimal(65,11);
    

SET SQL_SAFE_UPDATES = 0;

UPDATE  work.FAList    
SET PilotAward=0,
	PilotType="",
    NumAwards=0,
    Direct=0,
    Indirect=0,
    TotalAwd=0;
    
    

DROP TABLE IF EXISTS work.Awdlist;
create table work.Awdlist AS    
SELECT CLK_PI_UFID AS UFID,
	   COUNT(DISTINCT CLK_AWD_ID) AS NumAwards,
       SUM(DIRECT_AMOUNT)  AS Direct,
       SUM(INDIRECT_AMOUNT) As Indirect,
       SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAwd
FROM lookup.awards_history
WHERE FUNDS_ACTIVATED>=str_to_date('07,01,2019','%m,%d,%Y')
AND CLK_PI_UFID IN (SELECT DISTINCT UFID from work.FAList )
GROUP BY CLK_PI_UFID ;
       
       
UPDATE  work.FAList Fa, work.pilotlist lu
SET Fa.PilotAward=lu.PilotAward,
	Fa.PilotType=lu.PilotType
Where Fa.UFID=lu.UFID;    

       
UPDATE  work.FAList Fa,  work.Awdlist lu
SET Fa.NumAwards=lu.NumAwards,
	Fa.Direct=lu.Direct,
 	Fa.Indirect=lu.Indirect,
    Fa.TotalAwd=lu.TotalAwd
Where Fa.UFID=lu.UFID;    

DROP TABLE IF EXISTS work.FAListOut;
create table work.FAListOut AS 
SELECT 	Email,
		LastName,
        FirstName,
        UFID,
        Source,
        PilotAward,
        PilotType,
		NumAwards AS nGrants,
        Direct,
        Indirect,
        TotalAwd,
        RosterServices
FROM work.FAList
ORDER BY Lastname,FirstName; 


UPDATE work.FAListOut fo, lookup.email_master lu
SET fo.Email=lu.UF_EMAIL
WHERE fo.UFID=lu.UF_UFID
AND lu.UF_PRIMARY_FLG="Y";     

UPDATE work.FAListOut 
SET LastName="He",
FirstName="Mei"
WHERE Email='MHe@cop.ufl.edu';



select * from work.FAListOut;

select distinct STD_PROGRAM FROM lookup.roster WHERE year in (2019,2020);
 UPDATE lookup.roster
 SET STD_PROGRAM="Intergrated Data Repository"
 WHERE STD_PROGRAM="Integrated Data Repository";


SELECT * from lookup.ufids WHERE UF_UFID="09444290";

select * from lookup.email_master where UF_EMAIL like "cywu%";
DROP TABLE work.nonaward;


Integrated Data Repository
Intergrated Data Repository
