
DROP TABLE IF EXISTS pilots.temp;
create table pilots.temp AS
SELECT 	Pilot_ID,
        PROJECT_ID, 
		Award_Year,
        Category,
        AwardType,
        PI_Last,
        PI_First,
        PI_DEPT,
        College,
        AwardLetterDate,
        Award_Amt,
        Status,
        Title,
        UFID,
        Email
from pilots.PILOTS_MASTER
WHERE College="Public Health and Health Professions"
AND Awarded="Awarded";




select max(pilot_id) from  pilots.PILOTS_MASTER;
### ADD  COVID Pilots
DROP TABLE IF EXISTS pilots.temp2;
create table pilots.temp2 AS
SELECT * from pilots.PILOTS_MASTER
WHERE PI_Last IN
('Ralston',
'Ralston',
'Cogle',
"D'Lugos",
'Fedele',
'Raup-Krieger',
'Lin',
'Mahmud',
'Mason',
'Phelps',
'Price',
'Reddy',
'Shechtman',
'Shechtman',
'Smith',
'Strekalova',
'Taivassalo',
'Wang',
'Mitchell',
'Brakenridge',
'Brown',
'Bulitta',
'Burne',
'Bylund-Lincoln',
'Harle',
'McKune',
'Merck',
'Pascual',
'Reznikov',
'Sawyer',
'Vulpe',
'Mitchell',
'Willcocks',
'Bruggeman',
'Coker',
'Huang',
'Kim',
'Neyroud',
'Heldermon',
'De Benedetto',
'Mobley',
'Mitchell',
'Fredenburg',
'Gaynor',
'Ghasemi',
'Nelson',
'Humes',
'Judge',
'Larkin',
'Shenkman',
'McQuail',
'Mitchell',
'Sayour',
'Mitchell',
'Singh Ospina',
'Terada',
'Fernandez',
'Maxwell',
'Fishe',
'Nelson',
'Mitchell',
'Whisler',
'Vulpe',
'Weyh',
'Winterstein'
)
;

select max(pilot_id) from pilots.PILOTS_MASTER;


SELECT UF_UFID,
       UF_DISPLAY_NM,
       UF_EMAIL,
       UF_DEPT,
       UF_DEPT_NM,
       UF_GENDER_CD,
       UF_BIRTH_DT
       
FROM lookup.ufids
WHERE UF_UFID IN
('14353582',
'14346518',
'59495991',
'19353800',
'27202101',
'86921953',
'58753640',
'41117580',
'63317945',
'74044849',
'31837342',
'28436682',
'15608955',
'10071257',
'31425917',
'13253139',
'00846510',
'01319428',
'13418549')

ORDER BY UF_DISPLAY_NM;



Create table loaddata.BACKUP_PILOTS_MASTER_20200713 AS SELECT * from pilots.PILOTS_MASTER;




#### MATCH WITH MATT PROJECT ID LISZT

SELECT  Pilot_ID,
		PI_Last,
        PI_First,
        AwardLetterDate,
        Title
 from pilots.PILOTS_MASTER
 WHERE PI_last like "pa%";
 
 
 IN (
'Brakenridge',
'Brown',
'Bruggeman',
'Bulitta',
'Burne',
'Bylund-Lincoln',
'Cogle',
'Coker',
'De Benedetto',
'Fedele',
'Fernandez',
'Fishe',
'Fredenburg',
'Gaynor',
'Ghasemi',
'Harle',
'Heldermon',
'Huang',
'Humes',
'Judge',
'Kim',
'Larkin',
'Lin',
'Mahmud',
'Mason',
'Maxwell',
'McKune',
'McQuail',
'Merck',
'Mitchell',
'Mobley',
'Nelson',
'Neyroud',
'Pascual',
'Phelps',
'Price',
'Ralston',
'Raup-Krieger',
'Reddy',
'Reznikov',
'Sawyer',
'Sayour',
'Shechtman',
'Shenkman',
'Singh Ospina',
'Smith',
'Strekalova',
'Taivassalo',
'Terada',
'Vulpe',
'Wang',
'Weyh',
'Whisler',
'Willcocks',
'Winterstein')
ORDER BY PI_LAST;


ALTER TABLE pilots.PILOTS_MASTER ADD PROJECT_ID varchar(12);

SET SQL_SAFE_UPDATES = 0;

UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0027345' WHERE Pilot_ID=115;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0168569' WHERE Pilot_ID=354;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0126499' WHERE Pilot_ID=385;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0104261' WHERE Pilot_ID=386;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0091564' WHERE Pilot_ID=402;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0095892' WHERE Pilot_ID=404;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0101505' WHERE Pilot_ID=405;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0087558' WHERE Pilot_ID=409;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0120599' WHERE Pilot_ID=411;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0103641' WHERE Pilot_ID=437;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109859' WHERE Pilot_ID=442;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109860' WHERE Pilot_ID=443;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109858' WHERE Pilot_ID=444;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109861' WHERE Pilot_ID=445;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109862' WHERE Pilot_ID=446;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0111303' WHERE Pilot_ID=447;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109863' WHERE Pilot_ID=448;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0127346' WHERE Pilot_ID=449;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0114338' WHERE Pilot_ID=450;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0109864' WHERE Pilot_ID=451;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0128721' WHERE Pilot_ID=452;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0119399' WHERE Pilot_ID=455;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0155706' WHERE Pilot_ID=459;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0152442' WHERE Pilot_ID=460;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0153355' WHERE Pilot_ID=461;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0152122' WHERE Pilot_ID=463;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0152121' WHERE Pilot_ID=464;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0154312' WHERE Pilot_ID=465;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0154749' WHERE Pilot_ID=466;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0158139' WHERE Pilot_ID=467;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0153356' WHERE Pilot_ID=468;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0153358' WHERE Pilot_ID=469;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0168510' WHERE Pilot_ID=470;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166832' WHERE Pilot_ID=471;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166834' WHERE Pilot_ID=472;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166833' WHERE Pilot_ID=473;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166342' WHERE Pilot_ID=474;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0168266' WHERE Pilot_ID=475;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0168568' WHERE Pilot_ID=476;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0171736' WHERE Pilot_ID=477;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166831' WHERE Pilot_ID=478;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166343' WHERE Pilot_ID=480;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166835' WHERE Pilot_ID=481;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0164288' WHERE Pilot_ID=482;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0166976' WHERE Pilot_ID=483;
UPDATE pilots.PILOTS_MASTER SET PROJECT_ID='P0102948' WHERE Pilot_ID=487;





