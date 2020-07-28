
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
from space.ctrb_projects_2020
WHERE PRJNUM IN (select distinct Project_ID from space.crc_proj_2020)
AND PRJNUM NOT IN (select distinct ProjectID from space.Project_Not_found);


DROP TABLE IF EXISTS space.CRC_SPON; 
create table space.CRC_SPON AS 
SELECT CLK_AWD_ID,
##       CLK_AWD_PROJ_ID,
	   MAX(CLK_AWD_PI) AS PI,
       MAX(REPORTING_SPONSOR_NAME) AS Sponsor,
       MAX(REPORTING_SPONSOR_CAT) AS SponsorCat,
       MAX(CLK_AWD_PROJ_NAME) As Title
from lookup.awards_history 
WHERE CLK_AWD_PROJ_ID in
                         (select distinct Project_ID
                          FROM space.crc_proj_2020
                          WHERE Project_ID NOT IN (SELECT DISTINCT PRJNUM from space.CRC_PROJ_IN_RedZone))
GROUP BY  CLK_AWD_ID;#CLK_AWD_PROJ_ID;                         ;

DROP TABLE IF EXISTS space.CRC_SPON; 
create table space.CRC_SPON AS 

SELECT CLK_AWD_PROJ_ID,
	   MAX(CLK_AWD_PI) AS PI,
       MAX(REPORTING_SPONSOR_NAME) AS Sponsor,
       MAX(REPORTING_SPONSOR_CAT) AS SponsorCat,
       MAX(CLK_AWD_PROJ_NAME) As Title
from lookup.awards_history 
#WHERE  CLK_AWD_PROJ_ID LIKE "%89932%"
WHERE CLK_AWD_PI LIKE "BERCELI,%"
GROUP BY  CLK_AWD_PROJ_ID;     

DROP TABLE IF EXISTS space.OCR_CRC ;
create table space.OCR_CRC AS
Select CLK_AWD_ID,
	   MAX(CLK_AWD_PI) AS PI,
       MAX(REPORTING_SPONSOR_NAME) AS Sponsor,
       MAX(REPORTING_SPONSOR_CAT) AS SponsorCat,
       MAX(REPORTING_SPONSOR_AWD_ID) AS SposorAwdID,
       MAX(CLK_AWD_PROJ_NAME) As Title
from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN 
('P0158125',
'P0031922',
'P0128194',
'P0136172',
'P0140078',
'P0135980',
'P0136845',
'P0136845',
'P0137156',
'P0141103',
'P0136845',
'P0142128',
'P0096484',
'P0112303',
'P0149645',
'P0107620',
'P0101906',
'P0145369',
'P0108144',
'P0114773',
'P0102588',
'P0104592',
'P0124117',
'P0137540',
'P0100650')
GROUP BY CLK_AWD_ID;





select * from space.crc_projects_2020
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
       




Select CLK_AWD_PROJ_ID,
##max(CLK_AWD_PI) AS CLK_AWD_PI,
#max(CLK_AWD_FULL_TITLE) AS Title,
#max(CLK_AWD_SPONSOR_NAME) AS Sponsor,
max(CLK_AWD_SPONSOR_CAT) AS SponsorCat
#max(CLK_AWD_SPONSOR_AWD_ID) SponsorID,
#max(CLK_AWD_ID) as AWD_ID 
from lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (
'00127441',
'P0074389',
'P0074392',
'P0101897',
'P0081157  ',
'',
'P0104596',
'P0118862',
'P0133583',
'P0126963',
'P0129191',
'P0135663',
'P0153045',
'P0133541',
'P0091556',
'00095198',
'00044936',
'175',
'171',
'00115054',
'00107735',
'P0137943',
'P0070690',
'P0054253',
'P0074209',
'P0068231',
'P0068231',
'P0121972',
'P0134858',
'00052609',
'P0017926',
'P0087365',
'P0149250',
'P0148452',
'P0015866',
'P0050294',
'P0060800',
'P0097741',
'00126239',
'P0036448',
'P0046067',
'P0031922',
'P0120873',
'P0061414',
'P0062263',
'P0052359',
'P0132853',
'P0105525',
'P0148452',
'P0148452',
'P0077234',
'P0096484',
'P0100113',
'P0106080',
'P0149667',
'P0133585',
'P0133585',
'P0031069',
'P0046056',
'P0076395',
'P0094548',
'P0116924',
'P0094552',
'00087123',
'00126519',
'P0131084',
'P0153034',
'P0157333',
'00056471',
'P0163926',
'171',
'P0087359',
'171',
'P0108144',
'00047323',
'P0110859',
'P0119764',
'P0140875',
'P0136232',
'171',
'171',
'P0131292',
'P0052555',
'P0052555',
'P0052801',
'P0096005',
'P0092885',
'P0093320',
'P0093320',
'P0088427',
'P0103549',
'P0138876',
'P0019470',
'P0102673',
'171',
'P0138043',
'P0057630',
'P0102394',
'P0070343',
'P0107622',
'P0093161',
'00118591',
'00118591',
'P0069587',
'00127095',
'00127095',
'P0095080',
'P0101906',
'P0074310',
'00127903',
'P0102044',
'P0063081',
'P0102044',
'P0102044',
'P0124119',
'P0136372',
'P0139669',
'P0088210',
'00128442',
'00111840',
'P0119743',
'P0101480',
'00111118',
'P0069213',
'P0138876',
'P0087369           ',
'',
'P0066259',
'P0070343',
'P0112303',
'P0079438',
'P0106027',
'00127409',
'P0124100',
'00112740',
'00127918',
'00045404',
'P0040467',
'P0153053',
'P0052619',
'P0034556',
'P0070339',
'P0048781',
'P0066401',
'P0055126',
'P0070340',
'P0074463',
'P0069913',
'P0077410',
'00047323',
'171',
'171',
'171',
'P0094972',
'P0083012',
'P0087365',
'P0094038',
'P0018697',
'P0074741',
'P0080873',
'00116116',
'P0099048',
'00045743',
'P0025018',
'P0015413',
'P0112303',
'00120673',
'P0010703',
'00045298',
'P0078107',
'P0104175',
'P0038437',
'P0032461',
'P0032461',
'P0033250',
'P0067392',
'P0032461',
'P0033253',
'P0137936',
'P0066531',
'P0137934',
'P0140877',
'P0067392',
'P0033253',
'P0083225',
'P0099048',
'P0124131',
'00127019',
'P0101503',
'P0157595',
'P0101499',
'P0057523',
'00120819',
'P0020638',
'P0122362',
'P0122362',
'P0122362',
'00128442',
'P0045782',
'P0108718',
'P0101505',
'P0164457',
'P0126960',
'P0122144',
'P0061213',
'P0136656',
'P0153041',
'P0063705',
'P0101906',
'P0154101',
'',
'P0131308',
'P0069913',
'P0146838',
'P0070340',
'',
'',
'P0092264',
'00075267',
'00075267',
'P0139934',
'P0138074',
'P0106546',
'P0118656',
'P0106027',
'101',
'171',
'P0119980',
'171',
'P0153053',
'P0153053',
'171',
'171',
'P0150605',
'P0150605',
'171',
'P0138876',
'P0163505',
'P0081625',
'P0135274',
'P0135274',
'P0160920',
'P0131168',
'P0135274',
'P0135274',
'P0160920',
'P0160920',
'P0160920',
'P0160920',
'P0124121',
'00045277',
'P0136993',
'P0143247',
'P0117888',
'P0153049',
'P0118656',
'P0161775',
'P0125475',
'P0131308',
'P0150013',
'171',
'P0139758',
'P0103641',
'P0081625',
'P0081625',
'P0081625',
'P0081625',
'P0160920',
'P0102377',
'P0131029',
'P0135274',
'P0135274',
'P0135274',
'P0135274',
'P0160920',
'P0160920',
'P0161374',
'P0054924',
'P0092264',
'P0131265',
'P0163625',
'P0143639',
'00092024',
'P0063081',
'89932',
'00045158',
'P0158125',
'P0031922',
'P0135980',
'P0136845',
'P0143037',
'P0128194',
'P0136172',
'P0140078',
'P0135980',
'P0136845',
'P0136845',
'P0137156',
'P0141103',
'P0136845',
'P0142128',
'P0096484',
'P0112303',
'P0149645',
'P0107620',
'P0101906',
'P0145369',
'P0149689',
'P0149691',
'P0091566',
'00129082',
'P0108144',
'P0114773',
'P0102588',
'P0104592',
'P0124117',
'P0137540',
'P0100650'

)
GROUP BY CLK_AWD_PROJ_ID;





