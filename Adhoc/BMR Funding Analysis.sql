SET sql_mode = '';
SET SQL_SAFE_UPDATES = 0;

###########################################################################
## Create work table 
## Include nly Active Awards or those receiveing funds after 1/1/2018
DROP TABLE IF EXISTS work.dm_awards;
CREATE TABLE work.dm_awards AS
SELECT *
from lookup.awards_history
WHERE FUNDS_ACTIVATED>=str_to_date('01,01,2017','%m,%d,%Y') OR  
	CLK_AWD_STATE= "Active";
    
###########################################################################
###########################################################################
############ Identify Biomedical Research Awards
### Create Record Classification Variables    
ALTER TABLE work.dm_awards 
	ADD bmr_RecStatus varchar(12),
    ADD bmr_RecCurate varchar(12),
    ADD bmr_HSC int(1),
    ADD bmr_Roster int(1),
    ADD bmr_NIH int(1),
    ADD bmr_PCORI int(1),
    ADD bmr_HumanSub int(1),
    ADD bmr_AnimalSub int(1),
    ADD bmr_AwardParent int(1),
    ADD bmr_SponsorMatch int(1);

### Initialize Records Classification Variables    
UPDATE work.dm_awards
	SET bmr_RecStatus="Omit",
		bmr_RecCurate="No Criteria",
		bmr_HSC=0,
		bmr_Roster=0,
		bmr_NIH=0,
		bmr_PCORI=0,
		bmr_HumanSub=0,
		bmr_AnimalSub=0,
        bmr_AwardParent=0,
        bmr_SponsorMatch=0;
##########################################################
##########################################################
############ Assign Records Classification Variables

################################### 
### PI or Project PI in HSC    

UPDATE work.dm_awards SET bmr_HSC=1 WHERE  CLK_AWD_PI_DEPTID IN (SELECT DEPTID from lookup.deptlookup where HSC="HSC");
UPDATE work.dm_awards SET bmr_HSC=1 WHERE  CLK_AWD_DEPTID IN (SELECT DEPTID from lookup.deptlookup where HSC="HSC");
UPDATE work.dm_awards SET bmr_HSC=1 WHERE  CLK_AWD_PROJ_DEPTID IN (SELECT DEPTID from lookup.deptlookup where HSC="HSC");
UPDATE work.dm_awards SET bmr_HSC=1 WHERE  CLK_AWD_PROJ_MGR_DEPTID IN (SELECT DEPTID from lookup.deptlookup where HSC="HSC");


################################### 
### PI or Project PI ever on Roster
UPDATE work.dm_awards SET bmr_Roster=1
		WHERE 	Roster2008+
				Roster2009+
				Roster2010+
				Roster2011+
				Roster2012+
				Roster2013+
				Roster2014+
				Roster2015+
				Roster2016+
				Roster2017+
				Roster2018+
				Roster2019+
				Roster2020>0;

###################################                 
### Award from NIH
UPDATE work.dm_awards SET bmr_NIH=1
		WHERE (REPORTING_SPONSOR_NAME LIKE "%NATL INST OF HLTH%"
        OR CLK_AWD_SPONSOR_NAME LIKE "%NATL INST OF HLTH%"
        OR CLK_AWD_PRIME_SPONSOR_NAME LIKE "&NATL INST OF HLTH%");

################################### 
### Award from PCORI
UPDATE work.dm_awards SET bmr_PCORI=1
		WHERE (REPORTING_SPONSOR_NAME LIKE '%PATIENT-CENTERED OUTCOMES RES INST%'
        OR CLK_AWD_SPONSOR_NAME LIKE '%PATIENT-CENTERED OUTCOMES RES INST%'
        OR CLK_AWD_PRIME_SPONSOR_NAME LIKE '%PATIENT-CENTERED OUTCOMES RES INST%');
 

################################### 
#### Human Subjects       
 UPDATE work.dm_awards SET bmr_HumanSub=1 
		WHERE CLK_AWD_HUMAN_SUBJ='YES';   

################################### 
##### Lab Animals        
 UPDATE work.dm_awards SET bmr_AnimalSub=1 
		WHERE CLK_AWD_LAB_ANMLS='YES'; 
        


##########################################################
##########################################################
#### SET RECORD STATUS FLAG 

 UPDATE work.dm_awards 
		SET bmr_RecStatus="Include",
			bmr_RecCurate="Criteria"
		Where (	bmr_HSC+
				bmr_Roster+
				bmr_NIH+
				bmr_PCORI+
				bmr_HumanSub+
                bmr_AnimalSub)>0;  

##########################################################
##########################################################
##### update based on curated human subjects records

CREATE INDEX Dm1 ON work.dm_awards  (REPORTING_SPONSOR_NAME);
CREATE INDEX Dm2 ON work.dm_awards  (CLK_AWD_PROJ_NAME);
CREATE INDEX xch1 ON work.xcludehuman (REPORTING_SPONSOR_NAME);
CREATE INDEX xch2 ON work.xcludehuman (CLK_AWD_PROJ_NAME);

UPDATE work.dm_awards dm, work.xcludehuman lu
SET 	bmr_RecStatus="Omit",
		bmr_RecCurate="Curated"
WHERE dm.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME 
  AND dm.CLK_AWD_PROJ_NAME=	lu.CLK_AWD_PROJ_NAME
  AND bmr_HumanSub=1
  AND bmr_HSC=0
  AND bmr_Roster=0
  AND bmr_NIH=0
  AND bmr_PCORI=0;

##########################################################
##########################################################  
############ SPONSORS

DROP TABLE IF EXISTS work.bmr_sponsors1;
CREATE TABLE work.bmr_sponsors1 AS
      
SELECT 	REPORTING_SPONSOR_NAME AS Sponsor,
		REPORTING_SPONSOR_CAT AS SponsorCat
FROM work.dm_awards
WHERE bmr_RecStatus="Include"
GROUP BY 	REPORTING_SPONSOR_NAME, 
			REPORTING_SPONSOR_CAT
UNION ALL
SELECT DISTINCT CLK_AWD_SPONSOR_NAME AS Sponsor,
				CLK_AWD_SPONSOR_CAT AS SponsorCat
FROM work.dm_awards
WHERE bmr_RecStatus="Include"
GROUP BY 	CLK_AWD_SPONSOR_NAME,
			CLK_AWD_SPONSOR_CAT 
UNION ALL            
SELECT DISTINCT CLK_AWD_PRIME_SPONSOR_NAME AS Sponsor,
				CLK_AWD_PRIME_SPONSOR_CAT AS SponsorCat
FROM work.dm_awards
WHERE bmr_RecStatus="Include"
GROUP BY 	CLK_AWD_PRIME_SPONSOR_NAME,
			CLK_AWD_PRIME_SPONSOR_CAT ;
            
            
DROP TABLE IF EXISTS work.bmr_sponsors;
CREATE TABLE work.bmr_sponsors AS
SELECT 	Sponsor,
		SponsorCat
FROM work.bmr_sponsors1
WHERE SponsorCat IN ('Corporations/CompanyForProfit','Non Profit Organizations')
GROUP BY 	Sponsor,
			SponsorCat;
        


CREATE INDEX Dm5 ON work.bmr_sponsors  (Sponsor);
CREATE INDEX Dm6 ON work.dm_awards  (REPORTING_SPONSOR_NAME);
CREATE INDEX Dm7 ON work.dm_awards  (CLK_AWD_SPONSOR_NAME);
CREATE INDEX Dm8 ON work.dm_awards  (CLK_AWD_PRIME_SPONSOR_NAME);



UPDATE work.dm_awards
SET bmr_SponsorMatch=1,
	bmr_RecCurate="Include"
WHERE bmr_RecStatus="Omit"
  AND  (REPORTING_SPONSOR_NAME IN (SELECT DISTINCT Sponsor from work.bmr_sponsors) 
			OR CLK_AWD_SPONSOR_NAME IN (SELECT DISTINCT Sponsor from work.bmr_sponsors) 
			OR CLK_AWD_PRIME_SPONSOR_NAME IN (SELECT DISTINCT Sponsor from work.bmr_sponsors));


##########################################################
##########################################################
##### update all award records for included awards (i.e. Project is Identified)

DROP TABLE IF EXISTS work.bmr_AwardList;
CREATE TABLE work.bmr_AwardList AS
SELECT DISTINCT CLK_AWD_ID
from work.dm_awards 
WHERE  bmr_HSC=1
   OR bmr_Roster=1
   OR bmr_NIH=1
   OR bmr_PCORI=1
   OR bmr_SponsorMatch=1; 

CREATE INDEX Dm3 ON work.dm_awards  (CLK_AWD_ID);
CREATE INDEX Dm4 ON work.bmr_AwardList  (CLK_AWD_ID);

Update work.dm_awards
SET bmr_RecStatus="Include",
    bmr_AwardParent=1,
    bmr_RecCurate="Orphan"
WHERE CLK_AWD_ID IN (SELECT DISTINCT CLK_AWD_ID
						from work.bmr_AwardList) 
AND bmr_RecStatus<>"Include"; 


########## CY AND SFY Variables



ALTER TABLE work.dm_awards
ADD CalYear varchar(12),
ADD SFY Varchar(25),
ADD FFY varchar(12);

CREATE INDEX dm8 ON work.dm_awards (Month);
CREATE INDEX FiscalYear ON lookup.fiscal_years (Month);


UPDATE work.dm_awards da, lookup.fiscal_years lu
SET da.CalYear=lu.CY,
	da.SFY=lu.SFY,
    da.FFY=lu.FFY
WHERE da.Month=lu.Month;    


##########################################################
##########################################################
##########################################################
##########################################################
########################################################## 
#### Create Record Status Summary Table

DROP TABLE IF EXISTS work.dm_summ;
CREATE TABLE work.dm_summ AS
 
 select bmr_RecStatus,
		bmr_RecCurate,
		count(*) as nRecs,
 		count(Distinct CLK_AWD_ID) AS nAwards,
        count(Distinct CLK_AWD_PROJ_ID) AS nProjects,
        sum(DIRECT_AMOUNT) as DirectAmt,
        sum(INDIRECT_AMOUNT) as IndirectAmt,
        sum(SPONSOR_AUTHORIZED_AMOUNT) as TotalAmt,
		SUM(bmr_HSC) AS bmr_HSC,
		SUM(bmr_Roster) AS bmr_Roster,
		SUM(bmr_NIH) AS bmr_NIH,
		SUM(bmr_PCORI) AS bmr_PCORI,
		SUM(bmr_HumanSub) AS bmr_HumanSub,
		SUM(bmr_AnimalSub) AS bmr_AnimalSub,
        SUM(bmr_AwardParent) as bmr_AwardParent,
        SUM(bmr_SponsorMatch) as bmr_SponsorMatch
 FROM work.dm_awards
 GROUP BY bmr_RecStatus,
		bmr_RecCurate;
###########################################################################################
###########################################################################################
###########################################################################################
###Analysis for DM
###HSC Wide Extramural Funding by College
###HSC wide funding by Sponsor Type

Select * from work.dm_summ;


###########################################################################################
###########################################################################################
############################   EOF   ######################################################
###########################################################################################
###########################################################################################
###########################################################################################
######### ADD ASSIS






############################################################################################
###Analysis for DM
###HSC Wide Extramural Funding by College
###HSC wide funding by Sponsor Type

Select * from work.dm_summ;


#################################################
### Biomedical Research VS Not Biomedical Research
drop table if exists work.bmr1OUT;
CREATE TABLE work.bmr1OUT AS
SELECT 	CalYear,
		Bmr_RecStatus AS BMR,
        Count(distinct CLK_AWD_ID) As nAwards,
        Count(distinct CLK_AWD_PROJ_ID) AS nProjects,
        Sum(DIRECT_AMOUNT) as Direct,
        Sum(INDIRECT_AMOUNT) as Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
GROUP BY CalYear, Bmr_RecStatus
ORDER BY  Bmr_RecStatus, CalYear;
 
################################################# 
### Biomedical Research By College BY CY

DROP TABLE IF EXISTS work.dmCOLLTemp1;
Create table work.dmCOLLTemp1 AS
SELECT DISTINCT CLK_AWD_COLLEGE AS College
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include";	
  
ALTER TABLE work.dmCOLLTemp1
 ADD CY2018 Decimal(65,10),
 ADD CY2019 Decimal(65,10),
 ADD CY2020 Decimal(65,10);  
 
  

drop table if exists work.bmrCollYearTemp;
CREATE TABLE work.bmrCollYearTemp AS
SELECT 	CalYear,
		CLK_AWD_COLLEGE AS College,
        Count(distinct CLK_AWD_ID) As nAwards,
        Count(distinct CLK_AWD_PROJ_ID) AS nProjects,
        Sum(DIRECT_AMOUNT) as Direct,
        Sum(INDIRECT_AMOUNT) as Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include"	
GROUP BY CalYear, CLK_AWD_COLLEGE;


UPDATE work.dmCOLLTemp1 cl, work.bmrCollYearTemp lu   SET cl.CY2018=lu.TotalAward WHERE cl.College=lu.College AND lu.CalYear="CY 2018";
UPDATE work.dmCOLLTemp1 cl, work.bmrCollYearTemp lu   SET cl.CY2019=lu.TotalAward WHERE cl.College=lu.College AND lu.CalYear="CY 2019";
UPDATE work.dmCOLLTemp1 cl, work.bmrCollYearTemp lu   SET cl.CY2020=lu.TotalAward WHERE cl.College=lu.College AND lu.CalYear="CY 2020";

drop table if exists work.bmr1OUT;
CREATE TABLE work.bmr1OUT AS
SELECT 	CalYear,
		Bmr_RecStatus AS BMR,
        Count(distinct CLK_AWD_ID) As nAwards,
        Count(distinct CLK_AWD_PROJ_ID) AS nProjects,
        Sum(DIRECT_AMOUNT) as Direct,
        Sum(INDIRECT_AMOUNT) as Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
GROUP BY CalYear, Bmr_RecStatus
ORDER BY  Bmr_RecStatus, CalYear;
 
################################################# 
### Biomedical Reporting Sponsor Type by CY

DROP TABLE IF EXISTS work.dmSPONout;
Create table work.dmSPONout AS
SELECT DISTINCT REPORTING_SPONSOR_CAT AS SponsorType
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include";	
  
ALTER TABLE work.dmSPONout
 ADD CY2018 Decimal(65,10),
 ADD CY2019 Decimal(65,10),
 ADD CY2020 Decimal(65,10);  
 
  

drop table if exists work.bmrSponYearTemp;
CREATE TABLE work.bmrSponYearTemp AS
SELECT 	CalYear,
		REPORTING_SPONSOR_CAT AS SponsorType,
        Count(distinct CLK_AWD_ID) As nAwards,
        Count(distinct CLK_AWD_PROJ_ID) AS nProjects,
        Sum(DIRECT_AMOUNT) as Direct,
        Sum(INDIRECT_AMOUNT) as Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include"	
GROUP BY CalYear, REPORTING_SPONSOR_CAT;


UPDATE work.dmSPONout cl, work.bmrSponYearTemp lu   SET cl.CY2018=lu.TotalAward WHERE cl.SponsorType=lu.SponsorType AND lu.CalYear="CY 2018";
UPDATE work.dmSPONout cl, work.bmrSponYearTemp lu   SET cl.CY2019=lu.TotalAward WHERE cl.SponsorType=lu.SponsorType AND lu.CalYear="CY 2019";
UPDATE work.dmSPONout cl, work.bmrSponYearTemp lu   SET cl.CY2020=lu.TotalAward WHERE cl.SponsorType=lu.SponsorType AND lu.CalYear="CY 2020";

Select * from work.dmSPONout;


select distinct REPORTING_SPONSOR_NAME from work.dm_awards  where REPORTING_SPONSOR_CAT IS NULL;

select * from work.dm_awards  where REPORTING_SPONSOR_CAT ="NULL";



#####################
###REPORTING SPONSOR CATEGORIZE NIH etc
drop table if exists work.SponList;
CREATE TABLE work.SponList
SELECT
	REPORTING_SPONSOR_NAME,
	REPORTING_SPONSOR_CAT,
	Count(distinct CLK_AWD_ID) As nAwards,
	SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
from work.dm_awards
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include"
GROUP BY  REPORTING_SPONSOR_NAME,
			REPORTING_SPONSOR_CAT ;


ALter table work.dm_awards ADD SponsorSummCat varchar(45);

UPDATE work.dm_awards da, work.sponsorsumm lu
SET da.SponsorSummCat=lu.SponsorSummCat
WHERE da.REPORTING_SPONSOR_NAME=lu.REPORTING_SPONSOR_NAME;

################################################################################################
####### REPORTING SPONSOR (SUMM) by CY
DROP TABLE IF EXISTS work.dmSPONORout;
Create table work.dmSPONORout AS
SELECT DISTINCT SponsorSummCat AS SponsorSummCat
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include";	
  
ALTER TABLE work.dmSPONORout
 ADD CY2018 Decimal(65,10),
 ADD CY2019 Decimal(65,10),
 ADD CY2020 Decimal(65,10);  
 
  

drop table if exists work.bmrSponorTemp;
CREATE TABLE work.bmrSponorTemp AS
SELECT 	CalYear,
		SponsorSummCat AS SponsorSummCat,
        Count(distinct CLK_AWD_ID) As nAwards,
        Count(distinct CLK_AWD_PROJ_ID) AS nProjects,
        Sum(DIRECT_AMOUNT) as Direct,
        Sum(INDIRECT_AMOUNT) as Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotalAward
FROM work.dm_awards        
WHERE CalYear IN ('CY 2018', 'CY 2019', 'CY 2020')
  AND bmr_RecStatus="Include"	
GROUP BY CalYear, SponsorSummCat;


UPDATE work.dmSPONORout cl, work.bmrSponorTemp lu   SET cl.CY2018=lu.TotalAward WHERE cl.SponsorSummCat=lu.SponsorSummCat AND lu.CalYear="CY 2018";
UPDATE work.dmSPONORout cl, work.bmrSponorTemp lu   SET cl.CY2019=lu.TotalAward WHERE cl.SponsorSummCat=lu.SponsorSummCat AND lu.CalYear="CY 2019";
UPDATE work.dmSPONORout cl, work.bmrSponorTemp lu   SET cl.CY2020=lu.TotalAward WHERE cl.SponsorSummCat=lu.SponsorSummCat AND lu.CalYear="CY 2020";

Select * from work.dmSPONORout;







        
################################################# 
### Highest Awardees
drop table if exists work.high10;
Create table work.high10 AS
Select CLK_AWD_PI,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amount
FROM work.dm_awards  
WHERE CalYear IN ('CY 2020')
  AND bmr_RecStatus="Include"	
GROUP BY CLK_AWD_PI,CLK_PI_UFID
ORDER BY Amount DESC
LIMIT 10;

###
drop table if exists work.high20noCTSI;
Create table work.high20noCTSI AS
Select CLK_AWD_PI,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amount
FROM work.dm_awards  
WHERE CalYear IN ('CY 2020')
AND   (REPORTING_SPONSOR_NAME LIKE "%NATL INST OF HLTH%"
        OR CLK_AWD_SPONSOR_NAME LIKE "%NATL INST OF HLTH%"
        OR CLK_AWD_PRIME_SPONSOR_NAME LIKE "&NATL INST OF HLTH%")
AND             Roster2008+
				Roster2009+
				Roster2010+
				Roster2011+
				Roster2012+
				Roster2013+
				Roster2014+
				Roster2015+
				Roster2016+
				Roster2017+
				Roster2018+
				Roster2019+
				Roster2020=0      
GROUP BY CLK_AWD_PI,CLK_PI_UFID
ORDER BY Amount DESC
LIMIT 20;





SELECT Month,CalYear, SFY, FFY, COUNT(*) AS N from work.dm_awards group by Month,CalYear, SFY, FFY;



SELECT 
