
select * from 
space.matt_proj;

select * 
from space.matt_proj
where Project_ID NOT IN (SELECT DISTINCT PRJNUM from space.ctrb_projects_2018) ;


select * from space.ctrb_projects_2018 where PRJNUM like "%37773%";

P0037690  OK 
P0037761  OK
P0037773  
P0047699

drop table if exists space.mattprojnotfnd;
create table space.mattprojnotfnd as
SELECT * from lookup.awards_history where CLK_AWD_PROJ_ID IN 
('P0037690','P0037761','P0037773','P0047699')
AND SPONSOR_AUTHORIZED_AMOUNT<>0;