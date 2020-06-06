
/*
## INCLUDE THE PROJECTS NOT FOUND IN AWARDS HISTORY
drop table space.Project_Not_found;
create table space.Project_Not_found as 
select distinct ProjectID 
       from work.spacelist 
       where ProjectID NOT IN (SELECT DISTINCT CLK_AWD_PROJ_ID FROM lookup.awards_history); 
*/
#determine project numbers already included

DROP TABLE IF EXISTS space.CRC_PROJ_IN_RedZone; 
create table space.CRC_PROJ_IN_RedZone AS 
select distinct PRJNUM 
from space.ctrb_projects_2018
WHERE PRJNUM IN (select distinct ProjectID from crc_projects_2018)
AND PRJNUM NOT IN (select distinct ProjectID from space.Project_Not_found);



select * from space.crc_projects_2018
WHERE ProjectID in (select distinct ProjectID from work.spacelist);




##############
select * from space.mattmroject;

ALTER TABLE space.mattmroject ADD Red int(1), 
						ADD Blue2 int(1);

UPDATE space.mattmroject SET Red=0, Blue2=0;


UPDATE space.mattmroject SET Red=1
WHERE ProjectID in (select distinct PRJNUM from space.ctrb_projects_2019);

select distinct PRJ_VERIFIED from space.ctrb_alloc_2019;

############

SELECT * from space.crcprojectmatch;

ALTER TABLE space.crcprojectmatch 
		##ADD IPUsage Varchar(5),
		##ADD InRed int(1)
        DROP Column Sponsor ,
        ADD SponsorName varchar(45),
        ADD SponsorType varchar(45);
        
UPDATE space.crcprojectmatch SET InRed=0;

UPDATE space.crcprojectmatch SET InRed=1
WHERE ProjectID IN (select distinct ProjectID from work.spacelist);


select * from space.crc_projects_2018;


drop table if exists work.crccontract ;
create table work.crccontract as
select CLK_AWD_PROJ_ID AS ProjectID,
       MAX(REPORTING_SPONSOR_NAME) AS SponsorName,
       MAX(REPORTING_SPONSOR_CAT) AS SponsorType
from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (select distinct ProjectID FROM space.crcprojectmatch)
GROUP BY CLK_AWD_PROJ_ID;


UPDATE space.crcprojectmatch pm, work.crccontract lu
SET  pm.SponsorName=lu.SponsorName,
	 pm.SponsorType=lu.SponsorType
 WHERE pm.ProjectID=lu.ProjectID;



select * from work.crc19_2;

UPDATE space.crcprojectmatch pm, work.crc19_2 lu
SET pm.IPUSAGE=lu.IP_from_2018
WHERE pm.ProtocolID=lu.ProtocolID;




select * from space.crcprojectmatch ;

drop table if exists space.crc2019 ;
create table space.crc2019 as
SELECT ProtocolID AS CRCID,
       MAX(IPUsage) as IPUsage,
       MAX(InRed) as InRed,
       MAX(SponsorName) as SponsorName,
       MAX(SponsorType) as SponsorType,
       GROUP_CONCAT(ProjectID SEPARATOR ' ') AS ProjectID
FROM space.crcprojectmatch 
GROUP BY ProtocolID;

SELECT DISTINCT SponsorType from work.crc2019;


UPDATE space.crc2019 SET IPUsage="GOOD" 
WHERE  SponsorType IN ('Federal Agencies','University of Florida','Florida Government','UF DSO and Related HSC Affilia','Universities');
       

