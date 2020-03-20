
drop table if exists work.pilotpi;
create table work.pilotpi as
SELECT 	Pilot_ID,
        
		UFID,
		AwardLetterDate,
        PI_First,
        PI_Last,
        Email,
        Title,
        Category,
        Award_Amt
        FROM pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Status="Completed"
AND Award_Year>=2012;


Alter table work.pilotpi
ADD Has_GRANT int(1),
ADD Has_PUB int(1);

UPDATE work.pilotpi
SET  	Has_GRANT=0,
		Has_PUB=0;
        
UPDATE work.pilotpi pp, pilots.PILOTS_ROI_MASTER lu
SET pp.Has_GRANT=1
WHERE pp.Pilot_ID=lu.Pilot_ID;

        
UPDATE work.pilotpi pp, pilots.PILOTS_PUB_MASTER lu
SET pp.Has_PUB=1
WHERE pp.Pilot_ID=lu.Pilot_ID;

#########




SET sql_mode = '';

DROP TABLE IF EXISTS work.pilot_grant1;
Create table work.pilot_grant1 as 
SELECT * from lookup.awards_history
WHERE CLK_PI_UFID in (SELECT DISTINCT UFID from work.pilotpi  WHERE UFID<>'')
   OR CLK_AWD_PROJ_MGR_UFID in (SELECT DISTINCT UFID from work.pilotpi WHERE UFID<>'');
   
   
ALter table work.pilot_grant1
ADD Pilot_ID int(11),
ADD AggLevel varchar(12);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.pilot_grant1 
SET PIlot_ID=NULL,
	AggLevel=NULL;


UPDATE work.pilot_grant1 gr, work.pilotpi lu
SET gr.Pilot_ID=lu.Pilot_ID,
    gr.Agglevel = "Project"
WHERE lu.UFID=gr.CLK_AWD_PROJ_MGR_UFID
AND lu.UFID<>''
AND lu.AwardLetterDate<=gr.FUNDS_ACTIVATED
;



UPDATE work.pilot_grant1 gr, work.pilotpi lu
SET gr.Pilot_ID=lu.Pilot_ID,
    gr.AggLevel = "Award"
WHERE lu.UFID=gr.CLK_PI_UFID
AND lu.UFID<>''
AND lu.AwardLetterDate<=gr.FUNDS_ACTIVATED
;

DROP TABLE IF EXISTS work.pilot_possgrant;
Create table work.pilot_possgrant  AS
SELECT * from work.pilot_grant1 gr WHERE Pilot_ID is not Null;

drop table if exists work.temp;
create table work.temp as

SELECT 	Pilot_ID, 	
		count(distinct CLK_AWD_ID) AS NumAwards,
		count(distinct CLK_AWD_PROJ_ID) AS NumProj,
        sum(SPONSOR_AUTHORIZED_AMOUNT) as Totamt
FROM  work.pilot_possgrant
GROUP BY Pilot_ID;       


Alter table work.pilotpi  	ADD NPossAWD int(11),
							ADD NPossProj int(11),
                            ADD PossTotlal decimal(65,10);
                            
                            
UPDATE work.pilotpi pi, work.temp lu
SET pi.NPossAWD=lu.NumAwards,
	pi.NPossProj=lu.NumProj,
    pi.PossTotlal=lu.Totamt
WHERE pi.Pilot_ID = lu.Pilot_ID;

select * from lookup.Employees WHERE Employee_ID='85067340';


select * from work.pilotpi ;






select sum(Has_GRANT), SUM(Has_PUB), count(*) from work.pilotpi;







