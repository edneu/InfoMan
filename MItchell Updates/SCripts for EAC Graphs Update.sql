

####################################################################################################################
####################################################################################################################
####################################################################################################################
####################################################################################################################
##### SET UserClass

UPDATE lookup.roster SET UserClass='UF Faculty' WHERE Faculty='Faculty' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='UF Research Professtionals' WHERE Factype='Non-Faculty' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='UF Grad Student / Trainee' WHERE Factype='Trainee' and Affiliation='UF';
UPDATE lookup.roster SET UserClass='FSU Grad Student / Trainee' WHERE Factype='Trainee' and Affiliation IN ('Florida State University','FSU');
UPDATE lookup.roster SET UserClass='FSU Faculty' WHERE Faculty='Faculty' and Affiliation IN ('Florida State University','FSU');
UPDATE lookup.roster SET UserClass='External Collaborators' WHERE Affiliation NOT IN ('Florida State University','FSU','UF');
UPDATE lookup.roster SET UserClass='FSU Research Professtionals' WHERE Factype='Non-Faculty' AND Affiliation IN ('Florida State University','FSU');

################ Report Program
UPDATE lookup.roster SET Rept_Program=NULL; 

UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Academcy for Research Excellence';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Coordinator Development';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Aging CRU';
UPDATE lookup.roster SET Rept_Program='BERD' WHERE STD_PROGRAM='BERD';  
UPDATE lookup.roster SET Rept_Program='BioInformatics' WHERE STD_PROGRAM='BioInformatics';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Biobehavioral';
UPDATE lookup.roster SET Rept_Program='Biorepository' WHERE STD_PROGRAM='Biorepository';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CCTR';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CTRB_Investigators';
UPDATE lookup.roster SET Rept_Program='CTS IT' WHERE STD_PROGRAM='CTS IT';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='CTSI Administration';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Cancer CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Cardiovascular CRU';
UPDATE lookup.roster SET Rept_Program='Cellular Reprogramming' WHERE STD_PROGRAM='Cellular Reprogramming';
UPDATE lookup.roster SET Rept_Program='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Clinical Research Professionals Advisory Council';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='ClinicalTrials.GOV';
UPDATE lookup.roster SET Rept_Program='Communications' WHERE STD_PROGRAM='Communications';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='Community Engagement - Jacksonville';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Dental CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Diabetes Center';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Ethics Consultation';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Evaluation';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Vouchers';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='GI Liver CRU';
UPDATE lookup.roster SET Rept_Program='Personalized Medicine' WHERE STD_PROGRAM='Genotyping';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Gainesville';
UPDATE lookup.roster SET Rept_Program='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Jacksonville';
UPDATE lookup.roster SET Rept_Program='Human Imaging' WHERE STD_PROGRAM='Human Imaging';
UPDATE lookup.roster SET Rept_Program='Implementation Science' WHERE STD_PROGRAM='Implementation Science';
UPDATE lookup.roster SET Rept_Program='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Jacksonville  CRU';
UPDATE lookup.roster SET Rept_Program='K College' WHERE STD_PROGRAM='K College';
UPDATE lookup.roster SET Rept_Program='KL TL' WHERE STD_PROGRAM='KL TL';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='MS CTS';
UPDATE lookup.roster SET Rept_Program='Mentor Academy' WHERE STD_PROGRAM='Mentor Academy';
UPDATE lookup.roster SET Rept_Program='Mentor Academy' WHERE STD_PROGRAM='Mentor';
UPDATE lookup.roster SET Rept_Program='Metabolomics' WHERE STD_PROGRAM='Metabolomics';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Neuromedicine CRU';
UPDATE lookup.roster SET Rept_Program='One Florida+' WHERE STD_PROGRAM IN ('One Florida','OneFlorida+');
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Pain CRU';
UPDATE lookup.roster SET Rept_Program='Personalized Medicine' WHERE STD_PROGRAM='Personalized Medicine';
UPDATE lookup.roster SET Rept_Program='Pilot Awards' WHERE STD_PROGRAM='Pilot Awards';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='PubMed Compliance';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Quality Assurance';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='RAC';
UPDATE lookup.roster SET Rept_Program='REDCap' WHERE STD_PROGRAM='REDCap';
UPDATE lookup.roster SET Rept_Program='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center';
UPDATE lookup.roster SET Rept_Program='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance';
UPDATE lookup.roster SET Rept_Program='Coordinator Development' WHERE STD_PROGRAM='Research Coordinator Consortium';
UPDATE lookup.roster SET Rept_Program='Research Subject Advocate' WHERE STD_PROGRAM='Research Subject Advocate';
UPDATE lookup.roster SET Rept_Program='Clinical Research Center' WHERE STD_PROGRAM='Service Center';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Simulation Center';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Sleep CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Study Registry';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='StudyConnect';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='TPDP';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='TRACTS';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='Tuberculosis PH CRU';
UPDATE lookup.roster SET Rept_Program='OMIT' WHERE STD_PROGRAM='UNDEFINED';
UPDATE lookup.roster SET Rept_Program='Research Administration' WHERE STD_PROGRAM='Research Administration';
UPDATE lookup.roster SET Rept_Program='Translational Drug Development' WHERE STD_PROGRAM='Translational Drug Development';
UPDATE lookup.roster SET Rept_Program='Tranlational Workforce Development' WHERE STD_PROGRAM='Translational Workforce Development';
UPDATE lookup.roster SET Rept_Program='FSU' WHERE STD_PROGRAM='FSU';
UPDATE lookup.roster SET Rept_Program='Learning Health System' WHERE STD_PROGRAM='Learning Health System';
UPDATE lookup.roster SET Rept_Program='Network Science' WHERE STD_PROGRAM='Network Science Program';
UPDATE lookup.roster SET Rept_Program='Research Administration' WHERE STD_PROGRAM='Office of Clinical Research';
UPDATE lookup.roster SET Rept_Program='UF Health Jacksonville' WHERE STD_PROGRAM='UF Health Jacksonville';
UPDATE lookup.roster SET Rept_Program='Cellular Reprogramming'  WHERE STD_PROGRAM='Cellular Reprograming';
UPDATE lookup.roster SET Rept_Program='Communications'  WHERE STD_PROGRAM='COMR';
UPDATE lookup.roster SET Rept_Program='COVID-19 SRCWG' WHERE STD_PROGRAM='COVID-19 SRCWG';
UPDATE lookup.roster SET Rept_Program='Integrated Data Repository' WHERE STD_PROGRAM='Intergrated Data Repository';




Select UserClass,count(*) as nRECs, count(distinct Person_Key) as nUndup from lookup.roster group by UserClass;

select Factype, Affiliation from lookup.roster where UserClass=' ';


#  PROGRAM UTILIZATION LIST

DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2012
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program,UserClass;

select distinct STD_PROGRAM from lookup.roster where Rept_Program=' ';

select distinct UserClass from lookup.roster;


#############  2019-2022
DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE  UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program,UserClass;

select * from lookup.roster where Person_Key is Null;

select distinct Person_key from lookup.roster;



select max(length(UserClass)) from work.userprogram;


DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Distinct Rept_Program as Rept_Program
FROM work.userprogram;

DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program;

ALTER TABLE work.ProgUsersOut
ADD UF_Faculty int(10),
ADD UF_Trainees int(10),
ADD UF_OtherReschPro int(10),
ADD Undup int(10);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.ProgUsersOut
SET UF_Faculty=0,
	UF_Trainees=0,
	UF_OtherReschPro=0,
    Undup=0;
	

UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Faculty=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Faculty';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_Trainees=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Grad Student / Trainee';
UPDATE work.ProgUsersOut po, work.userprogram lu SET po.UF_OtherReschPro=lu.nUNDUP where po.Rept_Program=lu.Rept_Program and lu.UserClass='UF Research Professtionals';

UPDATE work.ProgUsersOut po, work.ProgUsersUndup lu SET po.UNDUP=lu.nUNDUP where po.Rept_Program=lu.Rept_Program ;

drop table if Exists work.proguserout;
create table work.proguserout as 
SELECT * from work.ProgUsersOut ORDER BY Undup DESC;
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################



#########################################################  
#########################################################  
#########################################################  
#########################################################  
#########################################################  
##NIH FUnding by CTSI Affilation
 
drop table if exists work.nih;
create table work.nih as
SELECT *
from lookup.awards_history
where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%"
  AND UNIVERSITY_REPORTABLE="YES";


Alter table work.nih ADD CTSIAffil int(1) ;

SET SQL_SAFE_UPDATES = 0;

UPDATE work.nih SET CTSIAffil=0;

UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2009 and Roster2009=1; 
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2010 and Roster2010=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2011 and Roster2011=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2012 and Roster2012=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2013 and Roster2013=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2014 and Roster2014=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2015 and Roster2015=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2016 and Roster2016=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2017 and Roster2017=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2018 and Roster2018=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2019 and Roster2019=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2020 and Roster2020=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2021 and Roster2021=1;  
UPDATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2022 and Roster2022=1;  
UODATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2023 and Roster2023=1;  

DROP TABLE IF EXISTS work.nih_affil_lu;
Create table work.nih_affil_lu as
SELECT "NotCTSINIH" as Type, Year(nih.FUNDS_ACTIVATED) AS Year, Sum(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt from work.nih WHERE CTSIAffil=0 Group by "NotCTSINIH",Year(nih.FUNDS_ACTIVATED)
UNION ALL
SELECT "TotalNIH" as Type, Year(nih.FUNDS_ACTIVATED) AS Year, Sum(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt from work.nih Group by "TotalNIH",Year(nih.FUNDS_ACTIVATED)
UNION ALL
SELECT "CTSINIH" as Type, Year(nih.FUNDS_ACTIVATED) AS Year, Sum(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt from work.nih WHERE CTSIAffil=1 Group by "CTSINIH",Year(nih.FUNDS_ACTIVATED);

drop table if exists work.nih_affil;
Create table work.nih_affil AS
SELECT Distinct Year from work.nih_affil_lu
Where Year>=2009;

Alter table work.nih_affil
	ADD CTSI_Affiliate decimal(65,10),
	ADD NON_CTSI_Affiliate decimal(65,10),
	ADD NIH_Total decimal(65,10);
 
 UPDATE work.nih_affil aff, work.nih_affil_lu lu
 SET aff.CTSI_Affiliate=lu.TotalAmt
 WHERE aff.Year=lu.Year
 AND lu.Type="CTSINIH" ;
 
 UPDATE work.nih_affil aff, work.nih_affil_lu lu
 SET aff.NON_CTSI_Affiliate=lu.TotalAmt
 WHERE aff.Year=lu.Year
 AND lu.Type="NotCTSINIH" ;
 
  UPDATE work.nih_affil aff, work.nih_affil_lu lu
 SET aff.NIH_Total=lu.TotalAmt
 WHERE aff.Year=lu.Year
 AND lu.Type="TotalNIH" ;
    
    
    select * from work.nih_affil;
    
    
    ### Verify Total
    SELECT YEAR(FUNDS_ACTIVATED), SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt
from lookup.awards_history 
where REPORTING_SPONSOR_NAME like "NATL INST OF HLTH%"
AND UNIVERSITY_REPORTABLE="YES"
AND YEAR(FUNDS_ACTIVATED)>=2009
GROUP BY YEAR(FUNDS_ACTIVATED)
; 

#########################################################  
#########################################################  
#########################################################  
#########################################################  
######################################################### 

########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
## SPONSOR CATEGORY SUMMARY
SELECT DISTINCT REPORTING_SPONSOR_CAT FROM lookup.awards_history;
SELECT DISTINCT REPORTING_SPONSOR_NAME FROM lookup.awards_history;


ALTER TABLE lookup.awards_history ADD SponCat varchar(45);

SET SQL_SAFE_UPDATES = 0;

UPDATE lookup.awards_history SET SponCat="Other Non-Profit / Government"  ;
UPDATE lookup.awards_history SET SponCat="NIH" WHERE REPORTING_SPONSOR_CAT="Federal Agencies" AND  REPORTING_SPONSOR_NAME LIKE "NATL INST OF HLTH%";
UPDATE lookup.awards_history SET SponCat="Other Federal" WHERE REPORTING_SPONSOR_CAT="Federal Agencies" AND  REPORTING_SPONSOR_NAME NOT LIKE "NATL INST OF HLTH%";
UPDATE lookup.awards_history SET SponCat="Corporations / For Profit" WHERE REPORTING_SPONSOR_CAT="Corporations/CompanyForProfit" ;

ALTER TABLE lookup.awards_history ADD RSFY varchar(13);

UPDATE lookup.awards_history ah, lookup.sfy_classify lu
SET ah.RSFY=lu.SFY
WHERE ah.Month=lu.Month;



DROP TABLE IF EXISTS work.YearSponCat ; 
CREATE TABLE work.YearSponCat AS
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2009 and Roster2009=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2010 and Roster2010=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2011 and Roster2011=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2012 and Roster2012=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2013 and Roster2013=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2014 and Roster2014=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL 
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2015 and Roster2015=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2016 and Roster2016=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2017 and Roster2017=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2018 and Roster2018=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2019 and Roster2019=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2020 and Roster2020=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2021 and Roster2021=1
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat
UNION ALL
SELECT YEAR(FUNDS_ACTIVATED) AS YEAR, SponCat, SUM(DIRECT_AMOUNT) as Direct, SUM(INDIRECT_AMOUNT) as Indirect, SUM(SPONSOR_AUTHORIZED_AMOUNT) as TotAward
from lookup.awards_history 
WHERE YEAR(FUNDS_ACTIVATED)=2022 and Roster2022=1  
GROUP BY YEAR(FUNDS_ACTIVATED), SponCat;
;





DROP TABLE IF EXISTS work.YearSponCatSumm;
CREATE TABLE work.YearSponCatSumm AS
SELECT DISTINCT YEAR from work.YearSponCat;

desc work.YearSponCat;
SELECT DISTINCT SponCat from work.YearSponCat;

Alter TABLE work.YearSponCatSumm
ADD CORP decimal(65,10),
ADD OthGovNP decimal(65,10),
ADD OthFED decimal(65,10),
ADD NIH  decimal(65,10);



UPDATE work.YearSponCatSumm cs, work.YearSponCat lu SET cs.CORP=lu.TotAward WHERE cs.Year=lu.Year and lu.SponCat='Corporations / For Profit';
UPDATE work.YearSponCatSumm cs, work.YearSponCat lu SET cs.NIH=lu.TotAward WHERE cs.Year=lu.Year and lu.SponCat='NIH';    
UPDATE work.YearSponCatSumm cs, work.YearSponCat lu SET cs.OthFED=lu.TotAward WHERE cs.Year=lu.Year and lu.SponCat='Other Federal'; 
UPDATE work.YearSponCatSumm cs, work.YearSponCat lu SET cs.OthGovNP=lu.TotAward WHERE cs.Year=lu.Year and lu.SponCat='Other Non-Profit / Government'; 


SELECT * from work.YearSponCatSumm;

########################################################################################
########################################################################################
########################################################################################
########################################################################################
########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
######################################################################################### 
## Number of Faculty by Grouped Year
#select distinct ctsi_year from lookup.roster;






UPDATE lookup.roster SET ctsi_year='2009-2011' Where Year in (2009,2010,2011);
UPDATE lookup.roster SET ctsi_year='2012-2014' Where Year in (2012,2013,2014);
UPDATE lookup.roster SET ctsi_year='2015-2017' Where Year in (2015,2016,2017);
UPDATE lookup.roster SET ctsi_year='2018-2022' Where Year in (2018,2019,2020,2021,2022);

UPDATE lookup.roster SET FacType="N/A" Where FacType IS Null;

Select Distinct FacType from lookup.roster;



Select 	ctsi_year,
		FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Associate Professor','Professor','Assistant Professor')
GROUP BY 	ctsi_year,
			FacType;

#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
######################################################################################### 
########### UNDUP ALL YEARS

## FACULTY
select "Faculty" AS UserClass,count(distinct Person_key) as Undup from lookup.roster WHERE UserCLass IN ('UF Faculty','FSU Faculty') OR Faculty='Faculty' 
UNION ALL
## NON FACULTY
select"Non-Faculty" AS UserClass,count(distinct Person_key) as Undup from lookup.roster 
WHERE UserCLass NOT IN ('UF Faculty','FSU Faculty','UF Research Professtionals','FSU Research Professtionals','UF Grad Student / Trainee') OR Faculty<>'Faculty' 
UNION ALL
### TRAINEE
select "trainee" as UserClass,count(distinct Person_key) as Undup from lookup.roster WHERE UserCLass ='UF Grad Student / Trainee' 
UNION ALL
## OTHER REASEARCH PERSONNEL
select "Other Research Personnel" as UserClass ,count(distinct Person_key) as Undup from lookup.roster 
WHERE UserClass IN ('UF Research Professtionals','FSU Research Professtionals') 
UNION ALL
### Total UNdup
select "Total Undup" AS UserClass ,count(distinct Person_key) as Undup from lookup.roster
UNION ALL
## Assistant Professors
select "Ast Prof" AS UserClass,count(distinct Person_key) as Undup from lookup.roster 
WHERE FacType="Assistant Professor";
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
#########################################################################################
######################################################################################### 

########################################################
#######################################################
#######################################################
#######################################################
### SUMMARY TABLE
###SERVICE USERS BY TYPE YEAR

## FACULTY Adjsut for incomplete 2022 roster
SELECT 	Faculty,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND Faculty="Faculty"
  AND Year IN (2021,2022)
Group by Faculty ; 

## NON FACULTY  ## Adjsut for incomplete 2022 roster
SELECT Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND Faculty='Non-Faculty'
  AND Year IN (2021,2022)
; 

## TRAINEE  ## Adjsut for incomplete 2022 roster
SELECT 	FacType,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND FacType='Trainee'
    AND Year IN (2021,2022)
Group by FacType ;  

## Other Research Personnel  ## Adjsut for incomplete 2022 roster
SELECT Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND FacType<>'Trainee' 
  AND Faculty='Non-Faculty'
   AND Year IN (2021,2022)
;

## Total Service Users  ## Adjsut for incomplete 2022 roster
SELECT 	Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
   AND Year IN (2021,2022)
;

## Total Assistant Professors  ## Adjsut for incomplete 2022 roster
SELECT 	Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND FacType="Assistant Professor"
   AND Year IN (2021,2022)
;


##### Awards 2021
Select Year(FUNDS_ACTIVATED) as Year,
	  	COUNT(DISTINCT CLK_AWD_ID) as nAWD, 
	   Sum(SPONSOR_AUTHORIZED_AMOUNT) as TotAmt
From lookup.awards_history
WHERE Year(FUNDS_ACTIVATED)=2021
AND Roster2021=1;     

##### Awards 2022
Select Year(FUNDS_ACTIVATED) as Year,
	  	COUNT(DISTINCT CLK_AWD_ID) as nAWD, 
	   Sum(SPONSOR_AUTHORIZED_AMOUNT) as TotAmt
From lookup.awards_history
WHERE Year(FUNDS_ACTIVATED)=2022
AND Roster2022=1;       


################# UNDUPLICATE SINCE 2009

SELECT 	"faculty" AS Measure,
		Count(Distinct Person_key) as Undup
	from lookup.roster
	WHERE Affiliation="UF"
	AND Faculty="Faculty"
UNION ALL
	SELECT "Non-Faculty" AS Measure,
    Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND Faculty='Non-Faculty'
UNION ALL
SELECT "Trainee" AS Measure,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND FacType='Trainee'
UNION ALL
 SELECT "OtherRschd" AS Measure,
		Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND FacType<>'Trainee' 
  AND Faculty='Non-Faculty'
UNION ALL
 SELECT "TotalUsr" AS Measure,
		Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
UNION ALL
 SELECT "AsstProf" AS Measure,
		Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND FacType="Assistant Professor"
;
Select 
	  	COUNT(DISTINCT CLK_AWD_ID) as nAWD, 
	   Sum(SPONSOR_AUTHORIZED_AMOUNT) as TotAmt
From lookup.awards_history
WHERE Year(FUNDS_ACTIVATED)>=2009
AND (Roster2008+Roster2009+Roster2010+Roster2011+Roster2012+Roster2013+Roster2014+Roster2015+Roster2016+Roster2017+Roster2018+Roster2019+Roster2020+Roster2021+Roster2022)>0;


########################################################################
########################################################################
########################################################################
########################################################################
########################################################################