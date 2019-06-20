drop table if exists work.pilotaward;
create table work.pilotaward as
Select *
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


select count(*) from work.pilotaward;

select count(*) from work.pilotaward WHERE Category not in ("SECIM");

Select min(AwardLetterDate), max(AwardLetterDate)
from work.pilotaward;
 
SELECT Award_Amt,count(*) from work.pilotaward group by Award_Amt  ORDER by Award_Amt DESC;

select count(*) from work.pilotaward WHERE Award_Amt>=50000;
select count(*) from work.pilotaward WHERE Category not in ("SECIM") AND Award_Amt>=50000;

SELECT Award_Amt,count(*) from work.pilotaward where Category="Translational" group by Award_Amt ;



CREATE TABLE work.allpilots as
SELECT distinct Category As Category
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


drop table if exists work.pilotfitered;
create table work.pilotfitered as
SELECT * from pilots.PILOTS_MASTER
WHERE Awarded='Awarded'
AND Award_Year<=2012
AND Award_Amt>=50000;



select 	CONCAT(category," ",AwardType) AS AwardType,
		COUNT(*) AS NumAwards,
		Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
        SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE  Category NOT IN ('SECIM',"Communication")
AND CONCAT(category," ",AwardType) NOT IN ("Traditional Unkown","Traditional Cohort Applicant")
GROUP BY CONCAT(category," ",AwardType)
UNION ALL
select distinct 
		category AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE Category='SECIM'
GROUP BY Category
UNION ALL
select distinct 
		"Traditional Other" AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE CONCAT(category," ",AwardType) IN ("Traditional Unkown","Traditional Cohort Applicant")
GROUP BY "Traditional Other"
UNION ALL
select distinct 
		Category AS AwardType, 
        COUNT(*) as NumAwards,
        Min(Award_Amt) MinAward,
        AVG(Award_Amt) AS AvgAward,
        Max(Award_Amt) as MaxAward,
		SUM(Award_Amt) as TotalAwarded
from work.pilotfitered
WHERE Category IN ('Communication')
GROUP BY Category;



################  PULL PRe 2012 Pilots

DROP TABLE IF EXISTS pilots.EarlyCompPilots;
create table pilots.EarlyCompPilots AS
Select  *
FROM pilots.PILOTS_MASTER
WHERE Award_Year<2012 
AND ProjectStatus="Completed"
AND Awarded="Awarded"
;

  select Award_Year,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by Award_Year;
  select count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots ;

  select Category,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by Category;

  select AwardType,count(*),min(Award_Amt),AVG(Award_Amt),max(Award_Amt) from pilots.EarlyCompPilots group by AwardType;
 ;

DROP TABLE IF Exists pilots.EarlyExtract ;
CREATE TABLE pilots.EarlyExtract AS
SELECT 	Pilot_ID,
		Award_Year,
        Category,
        AwardType,
        Awarded,
        AwardLetterDate,
        Award_Amt,
        PI_Last,
        PI_First,
        Email AS PI_EMAIL,
        UFID AS PI_UFID,
        PI_DEPT,
        College
FROM pilots.EarlyCompPilots
ORDER BY Pilot_ID;
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
########## DATA EXTRACT

drop table if exists pilots.U01Master;
create table pilots.U01Master As
Select * 
from pilots.PILOTS_MASTER
Where Awarded="Awarded";


ALTER TABLE pilots.U01Master 
ADD Exclude int(1);

SET SQL_SAFE_UPDATES = 0;

UPDATE pilots.U01Master SET Exclude=0;


UPDATE pilots.U01Master SET Exclude=1
WHERE AwardType IN (
                       'Trainee',
                       'SECIM Targeted Metabolomics',
                       'SECIM Targeted LC-MS',
                       'SECIM NMR',
                       'SECIM IROA',
                       'SECIM Global Metabolomics Lipidomics Global NMR',
                       'SECIM Global LC-MS, 1C panel, Pyrimidine and Nucleotide panel',
                       'SECIM Global LC-MS Targeted LC-MS',
                       'SECIM Global LC-MS NMR',
                       'SECIM Global LC-MS Lipidomics',
                       'SECIM Global LC-MS (lipidomics/global combo)',
                       'SECIM Global LC-MS',
                       'SECIM Core 3: MALDI Imaging IROA',
                       'SECIM Core 3: MALDI',
                       'SECIM Core 2: NMR',
                       'SECIM Core 2: 13C NMR',
                       'SECIM Core 1: Untargeted Core 3: MALDI',
                       'SECIM Core 1: Untargeted Core 3: IROA',
                       'SECIM Core 1: Untargeted Core 2: NMR',
                       'SECIM Core 1: Untargeted Core 2',
                       'SECIM Core 1: Untargeted Core 1: Targeted: Acetyl-CoAs Amino Acids Organic Acids NAD Core 3: MALDI',
                       'SECIM Core 1: Untargeted Core 1: Targeted',
                       'SECIM Core 1: Untargeted',
                       'SECIM Core 1: Targeted: Acylcarnitines NAD+',
                       'SECIM Core 1: Targeted Sanford Burnham',
                       'SECIM Core 1: Targeted LC/MS (UF)',
                       'SECIM Core 1: Targeted LC/MS (SB)',
                       'SECIM Core 1: Lipidomics Core 3: MALDI',
                       'SECIM Core 1: Lipidomics Core 1: Targeted LC-MS (SB)',
                       'SECIM Core 1: IROA Core 1: Targeted LC/MS (SB)',
                       'SECIM Core 1: IROA',
                       'SECIM Core 1: Global LC/MS Core 1: Targeted LC/MS (SB) Core 2: NMR',
                       'SECIM Core 1: Global LC/MS',
                       'SECIM C13 isotopomer Analysis',
                       'SECIM 1H NMR'
                                             
				   );

DELETE FROM pilots.U01Master WHERE Exclude=1;
DELETE FROM pilots.U01Master WHERE Pilot_ID IN (94,95,98,100,108,118,120,113,394.30,31,1,9,10,390,136,107);  ## Remove Non Faculty



drop table if exists pilots.U01work;
create table pilots.U01work As
SELECT 	Pilot_ID,
        Category,
        AwardType,
		PI_GENDER,
        PI_DOB,
        datediff(AwardLetterDate,PI_DOB)/(365.25) AS PI_AGE_AT_AWARD,
		PI_Last,
        PI_First,
        AwardeePositionAtApp,
        Space(50) as CurrPosition,
        PI_DEPT,
        Award_Year,
		Award_Amt,
        UFID,
        AwardLetterDate
FROM pilots.U01Master
WHERE Award_Year<=2016 ;



UPDATE pilots.U01work uw, lookup.Employees lu
SET uw.CurrPosition=lu.Job_Code
WHERE uw.UFID=lu.Employee_ID;


select * from pilots.U01work;
##########################################################################################################
select count(*) from pilots.U01work;

select min(Award_Year), Max(award_Year) from pilots.U01work;

select min(Award_Amt), avg(Award_Amt), Max(Award_Amt) from pilots.U01work;


select * from pilots.U01work where Award_Amt>=25000;

select * from pilots.U01work where Award_Amt>=50000;

############################################################################################################

drop table if Exists work.temp1;
create table work.temp1;

DROP TABLE if EXISTS pilots.PILOTS_MASTER;
CREATE TABLE pilots.PILOTS_MASTER AS select * from pilots.temp1;



UPDATE work.temp1 t1, lookup.ufids lu
SET t1.PI_DOB=lu.UF_BIRTH_DT
WHERE t1.UFID=lu.UF_UFID;

select * from work.temp1;


UPDATE pilots.PILOTS_MASTER pm, work.temp1 lu
SET pm.PI_DOB=lu.PI_DOB
WHERE pm.Pilot_ID=lu.Pilot_ID
AND pm.PI_DOB IS NULL;


SELECT * FROM pilots.U01Master WHERE AwardLetterDate IS NULL;


UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('04,01,2011','%m,%d,%Y')    WHERE Pilot_ID=36;
UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('04,01,2011','%m,%d,%Y')    WHERE Pilot_ID=37;
UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('04,01,2011','%m,%d,%Y')    WHERE Pilot_ID=48;
UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('04,01,2011','%m,%d,%Y')    WHERE Pilot_ID=49;
UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('04,01,2011','%m,%d,%Y')    WHERE Pilot_ID=50;


create table loaddata.PILOTS_MASTER_BU AS SELECT * From  pilots.PILOTS_MASTER;
SET SQL_SAFE_UPDATES = 0;



## Bihorac
UPDATE pilots.PILOTS_MASTER SET Award_Amt=20000 WHERE Pilot_ID=13;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=15;

##  Tillman
UPDATE pilots.PILOTS_MASTER SET Award_Amt=24756 WHERE Pilot_ID=28;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=18;

## Sayeski
UPDATE pilots.PILOTS_MASTER SET Award_Amt=25000 WHERE Pilot_ID=27;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=17;

## Leeuwenburgh
UPDATE pilots.PILOTS_MASTER SET Award_Amt=45869 , AwardLetterDate=str_to_date('12,01,2009','%m,%d,%Y')
WHERE Pilot_ID=20;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=36;

## BYRNES
UPDATE pilots.PILOTS_MASTER SET Award_Amt=20000 WHERE Pilot_ID=83;

## NIXON
UPDATE pilots.PILOTS_MASTER SET Award_Amt=38200 WHERE Pilot_ID=29;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=7;

## Derendorf
UPDATE pilots.PILOTS_MASTER SET Award_Amt=62250 WHERE Pilot_ID=23;
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=37;

## Marsiske
DELETE FROM pilots.PILOTS_MASTER WHERE Pilot_ID=30;

##  SUndry Updates from Claire's review
UPDATE pilots.PILOTS_MASTER SET AwardeePositionAtApp="Associate Professor" ,
								PI_DEPT="HH-APK"                              
							WHERE Pilot_ID=28;

UPDATE pilots.PILOTS_MASTER SET Award_Year=2011 ,
								AwardLetterDate=str_to_date('03,30,2011','%m,%d,%Y')                            
							WHERE Pilot_ID=19;


UPDATE pilots.PILOTS_MASTER SET Category="Cohort Identification", AwardType="IDR" WHERE Pilot_ID IN (19,30,32);


UPDATE pilots.PILOTS_MASTER SET AwardLetterDate=str_to_date('03,31,2011','%m,%d,%Y') WHERE Pilot_ID=32;




UPDATE pilots.PILOTS_MASTER SET Category="Community Engagement",
								AwardType="IDR", 
                                AwardLetterDate=str_to_date('04,13,2011','%m,%d,%Y')
				WHERE Pilot_ID IN (48,49,50);

UPDATE pilots.PILOTS_MASTER SET AwardType="Junior Faculty" WHERE Pilot_ID IN (61);


UPDATE pilots.PILOTS_MASTER SET Title="Clinical Study to Dissect biomarkers if Aging Related Syndrome Sarcopenia",
  AwardeePositionAtApp="Assistant Professor" WHERE Pilot_ID IN (453);




select * from lookup.ufids where UF_EMAIL like "marlownm%";



SELECT  MAx(Pilot_ID)+1 from pilots.PILOTS_MASTER;


SELECT COUNT(*) from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
#AND Category NOT IN ("SECIM")
AND Award_Year<=2016;


ALTER TABLE pilots.PILOTS_MASTER 	ADD Rochester int(1),
									ADD RochCat varchar(45),
                                    ADD RochCat2 varchar(45);
                                    
UPDATE pilots.PILOTS_MASTER SET Rochester=0;

UPDATE pilots.PILOTS_MASTER SET Rochester=1
WHERE Pilot_ID IN (SELECT DISTINCT PILOT_ID from pilots.rochesterpid) ;

drop table if exists work.zzz;
Create table work.zzz as 
SELECT 	Pilot_ID,
		Category,
        AwardLetterDate,
		AwardType, 
		concat(PI_Last,", ",PI_First) as Name,
        RochCat,
        RochCat2,
        Title
FROM pilots.PILOTS_MASTER
WHERE  Rochester =1
ORDER BY CATEGORY,Award_Year;

