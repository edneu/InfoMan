
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

