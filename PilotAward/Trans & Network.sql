
drop table if exists work.transnet;
Create Table work.transnet as
SELECT 	Pilot_ID,
		Award_Year,
		Category,
        AwardType,
        AwardLetterDate,
        Award_Amt,
        PI_Last,
        PI_First,
        Title
from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND (Category="Translational" OR AwardType='Network');


drop table if exists work.transnetpub;
Create Table work.transnetpub as

SELECT 	pub_master_id,
        Pilot_ID,
		PubYear,
        PMID,
        PMCID,
        Citation
from pilots.PILOTS_PUB_MASTER
WHERE Pilot_ID IN (select distinct Pilot_ID from work.transnet)
;#AND PubYear<>0;


drop table if exists work.transnetgrant;
Create Table work.transnetgrant as
select  Pilot_ID,
		Grant_Summary,
        Pilot_Award_Date,
        GrantYear,
        Direct,
        Indirect,
        Total
from pilots.ROI_PILOTID_AGG
WHERE Pilot_ID IN (select distinct Pilot_ID from work.transnet);




########################## SCRATCH
########### FOR LOADING NEW PILOTS
drop table if exists work.pilotstruct;
Create Table work.pilotstruct as
SELECT 	*
from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND (Category="Translational");


Select max(Pilot_ID)+1 from pilots.PILOTS_MASTER;


SELECT UF_UFID,UF_EMAIL,UF_FIRST_NM,UF_LAST_NM,UF_DEPT,UF_DEPT_NM,UF_GENDER_CD,UF_BIRTH_DT,UF_WORK_TITLE
FROM lookup.ufids
WHERE 
(UF_LAST_NM='Bylund' ) OR
(UF_LAST_NM='Fische' ) OR
(UF_LAST_NM='Volpe' ) 


;
SELECT *
FROM lookup.Employees
WHERE 

Name LIKE 'Vulpe%' ;

select distinct College from pilots.PILOTS_MASTER;

select * from lookup.college where Lookup_COLLEGE='55050100';


select * from lookup.ufids
where UF_UFID in
('27202101',
'30697200',
'08549700',
'61769310',
'39218493',
'49742180',
'13418549',
'57979120')
ORDER BY UF_UFID;


select * from lookup.Employees
where Employee_ID in
('27202101',
'30697200',
'08549700',
'61769310',
'39218493',
'49742180',
'13418549',
'57979120')
ORDER BY Employee_ID;


select * from lookup.ufids
where UF_UFID ='61769310';

