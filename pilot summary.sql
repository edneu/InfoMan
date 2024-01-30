##  Pilots Since 2018  reconcile Progress reports	


SELECT 
Pilot_ID,Award_Year,Category,AwardType,PI_Last,PI_First,AwardLetterDate,Award_Amt,Title,Email
FROM pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Award_Year>=2018;

select distinct Awarded from  pilots.PILOTS_MASTER;

select * from work.pilots_since_2018;	

ALTER TABLE work.pilots_since_2018
ADD email varchar(45);

UPDATE work.pilots_since_2018 pm, pilots.PILOTS_MASTER lu
SET pm.email=lu.Email
WHERE pm.Pilot_ID=lu.Pilot_ID;


	
desc work.pilots_since_2018;	
	
DROP TABLE IF EXISTS  work.PilotProgressLU;	
create table work.PilotProgressLU AS	
SELECT 	Award_Year,
Category,
        Has_Progress_Report_File,	
        count(*) as nPilots,	
        SUM(Award_Amt) as Awd_Amt	
FROM work.pilots_since_2018	
GROUP BY Award_Year,	
	Category,
        Has_Progress_Report_File;  	
        	
        	
SELECT Category, COunt(*) as NAwards from work.pilots_since_2018 group by Category;       	
SELECT Category, COunt(*) as NAwards from work.pilots_since_2018 where Has_Progress_Report_File=1 group by Category ;           	
	
DROP TABLE IF EXISTS  work.PilotProgressSumm;	
create table work.PilotProgressSumm AS	
Select  Category	
FROM work.PilotProgressLU	
GROUP BY Category	
ORDER BY Category;        	
	
ALTER TABLE work.PilotProgressSumm	
ADD CY2018 int(5),	
ADD CY2019 int(5),	
ADD CY2020 int(5),	
ADD CY2021 int(5),	
ADD CY2022 int(5);	
	
select * from  work.PilotProgressSumm;   
    
SET SQL_SAFE_UPDATES = 0;    
    
UPDATE work.PilotProgressSumm	
SET CY2018=0,	
	CY2019=0,
	CY2020=0,
	CY2021=0,
	CY2022=0;
	
	
SET SQL_SAFE_UPDATES = 0;	
/*	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2018=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2018 AND Has_Progress_Report_File=1;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2019=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2019 AND Has_Progress_Report_File=1;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2020=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2020 AND Has_Progress_Report_File=1;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2021=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2021 AND Has_Progress_Report_File=1;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2022=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2022 AND Has_Progress_Report_File=1;	
*/  	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2018=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2018 AND Has_Progress_Report_File=0;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2019=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2019 AND Has_Progress_Report_File=0;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2020=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2020 AND Has_Progress_Report_File=0;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2021=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2021 AND Has_Progress_Report_File=0;	
UPDATE work.PilotProgressSumm ps,  work.PilotProgressLU lu SET ps.CY2022=lu.nPilots Where ps.Category=lu.Category and lu.Award_Year=2022 AND Has_Progress_Report_File=0;	
	
	
  	
  select * from work.PilotProgressSumm;	
