
### Check Display College

SELECT Year,Department, College, Display_College, count(*)
FROM lookup.roster
WHERE Faculty="Faculty"
  AND Affiliation="UF"
  AND Display_College is NULL 
Group by Year,Department, College, Display_College;     


### Faculty Users by College
SELECT Display_College,
	   COUNT(DISTINCT Person_KEY) AS Undup
FROM lookup.roster
WHERE Faculty="Faculty"
  AND Affiliation="UF"
Group by Display_College;
  
  
       
 


## on roster more than one year
drop table if exists work.temp;
create table work.temp as
SELECT Person_Key,Year,1 as YearCNT
FROM lookup.roster
WHERE Faculty="Faculty"
  AND Affiliation="UF"
Group by Person_Key,Year;


drop table if exists work.temp2;
create table work.temp2 as
SELECT Person_Key,sum(YearCNT) as YearCNT
from work.temp
group by Person_Key;


Select Count(distinct Person_key) from work.temp2;
#### # 2283

Select Count(distinct Person_key) from work.temp2
WHERE YearCNT>1;
##### 1713   


############  More than one service in a year

drop table if exists work.temp;
create table work.temp as
SELECT Person_Key,Year,STD_PROGRAM,1 as SvcCNT
FROM lookup.roster
WHERE Faculty="Faculty"
  AND Affiliation="UF"
Group by Person_Key,Year,STD_PROGRAM;


drop table if exists work.temp2;
create table work.temp2 as
SELECT Person_Key,Year,sum(SvcCNT) as SvcCNT
from work.temp
group by Person_Key,Year;


Select Count(distinct Person_key) from work.temp2;
#### # 2283

Select Count(distinct Person_key) from work.temp2
WHERE SvcCNT>1;
##### 1170


######################################################################################
### AVERAGE #Service Users by Year by Faculty Rank


SELECT DISTINCT CTSA_Award from lookup.roster;
SELECT DISTINCT Year,ctsi_year from lookup.roster group by Year,ctsi_year;


/*  
##### ASSIGN 2019 to last Cohort          
UPDATE lookup.roster SET ctsi_year="2015-2019" 
WHERE Year in (2015,2016,2017,2018,2019);            
*/

drop table if exists work.temp;
create table work.temp as
Select 	Year,
        ctsi_year,
		FacType,
        count(distinct Person_Key) AS Undup
from lookup.roster
WHERE Faculty="Faculty"
  AND Affiliation="UF"
GROUP BY 	Year,
			ctsi_year,
			FacType;  
            
            
drop table if exists work.temp2;
create table work.temp2 as
Select 	ctsi_year,
		FacType,
        Avg(Undup)
from work.temp
WHERE FacType <>'Other Faculty'
GROUP BY 	ctsi_year,
			FacType;    

/*            
UPDATE lookup.roster SET ctsi_year="2015-2019" 
WHERE Year in (2015,2016,2017,2018,2019);            
*/



###  FACULTY PORPORTION BY YEAE
SELECT 	Year,
		FacType,
        Count(Distinct Person_key)
from lookup.roster
WHERE Faculty="Faculty"
	AND FacType <>'Other Faculty'
	AND Affiliation="UF"
Group by Year,FacType  ;  


SELECT 	Year,
		FacType,
        Count(Distinct Person_key)
from lookup.roster
WHERE Faculty="Faculty"
	AND FacType <>'Other Faculty'
	AND Affiliation="UF"
Group by Year,FacType  ;  




#######################################################
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
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################

########################
### SERIVCE USE


ALter table lookup.roster ADD ReportRole Varchar(45);


UPDATE lookup.roster SET ReportRole="UF Graduate Students / Trainees" WHERE FacType='Trainee';
UPDATE lookup.roster SET ReportRole="UF Faculty" WHERE Faculty="Faculty" and Affiliation="UF";
UPDATE lookup.roster SET ReportRole="Other Users" WHERE Faculty='Non-Faculty' AND FacType<>'Trainee';



SELECT STD_PROGRAM, Rept_Program2 from lookup.roster 
WHERE Rept_Program2 IN (NULL,'')
group by STD_PROGRAM, Rept_Program2;





UPDATE lookup.roster SET Rept_Program2='BERD' WHERE STD_PROGRAM='BERD' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Clinical Research Center' WHERE STD_PROGRAM='Clinical Research Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Communications' WHERE STD_PROGRAM='Communications' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Community Engagement - Jacksonville' WHERE STD_PROGRAM='Community Engagement - Jacksonville' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Biobehavioral' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Biorepository' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Cellular Reprogramming' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Genotyping' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Human Imaging' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Translational Drug Development' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='CTS IT' WHERE STD_PROGRAM='CTS IT' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='FSU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Gainesville' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Healthstreet' WHERE STD_PROGRAM='HealthStreet-Jacksonville' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Implementation Science' WHERE STD_PROGRAM='Implementation Science' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Implementation Science' WHERE STD_PROGRAM='One Florida' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Integrated Data Repository' WHERE STD_PROGRAM='Integrated Data Repository' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Metabolomics' WHERE STD_PROGRAM='Metabolomics' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Multisite' WHERE STD_PROGRAM='Learning Health System' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='One Florida' WHERE STD_PROGRAM='One Florida' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Office of Clinical Research' WHERE STD_PROGRAM='Office of Clinical Research' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Office of Clinical Research' WHERE STD_PROGRAM='Research Administration' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Aging CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Cancer CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Cardiovascular CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Clinical Research Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='ClinicalTrials.GOV' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='CTRB_Investigators' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='CTSI Administration' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Dental CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Diabetes Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Evaluation' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='GI Liver CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Neuromedicine CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Pain CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='PubMed Compliance' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Recruitment Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Research Subject Advocate' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Service Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Simulation Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Sleep CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Study Registry' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='StudyConnect' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='Tuberculosis PH CRU' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='UF Health Jacksonville' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM IN ('UF Health Jacksonville','Florida State University');



UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE STD_PROGRAM='UNDEFINED' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Personalized Medicine' WHERE STD_PROGRAM='Personalized Medicine' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Pilot Awards' WHERE STD_PROGRAM='Pilot Awards' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Recruitment Center' WHERE STD_PROGRAM='Recruitment Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='REDCap' WHERE STD_PROGRAM='REDCap' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Ethics Consultation' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Quality Assurance' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Regulatory Assistance' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Regulatory Assistance' WHERE STD_PROGRAM='Research Administration' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Service Center' WHERE STD_PROGRAM='Service Center' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Academcy for Research Excellence' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='BioInformatics' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Professionals Advisory Council' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='K College' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='KL TL' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Mentor Academy' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='MS CTS' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Network Science Program' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Research Coordinator Consortium' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='TRACTS' AND (Rept_Program2=' ' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Translational Workforce Development' AND (Rept_Program2=' ' or Rept_Program2 is Null);


UPDATE lookup.roster SET Rept_Program2='OMIT' WHERE Rept_Program2='Florida State University';

UPDATE lookup.roster SET Rept_Program2='Core Facilities' WHERE STD_PROGRAM='Cellular Reprograming' AND (Rept_Program2='' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Translational Workforce Development' WHERE STD_PROGRAM='Clinical Research Prof Advisory Council' AND (Rept_Program2='' or Rept_Program2 is Null);
UPDATE lookup.roster SET Rept_Program2='Communications' WHERE STD_PROGRAM='COMR' AND (Rept_Program2='' or Rept_Program2 is Null);





##############
UPDATE lookup.roster SET ReportRole="UF Graduate Students / Trainees" WHERE FacType='Trainee' ;
UPDATE lookup.roster SET ReportRole="UF Faculty" WHERE Faculty="Faculty" ;
UPDATE lookup.roster SET ReportRole="Other Users" WHERE Faculty='Non-Faculty' AND FacType<>'Trainee';



UPDATE lookup.roster set affiliation="UF" where rosterid in (39222,39223,39224,39225,39552);

UPDATE lookup.roster set Faculty="Faculty", FacultyType='Junior', FacType="Assistant Professor" WHERE rosterid=39222;
UPDATE lookup.roster set Faculty="Faculty",FacultyType='Mid-Career', FacType='Associate Professor' WHERE rosterid=39223;
UPDATE lookup.roster set Faculty="Faculty", FacultyType='Junior', FacType="Assistant Professor" WHERE rosterid=39224;
UPDATE lookup.roster set Faculty='Non-Faculty',FacultyType='N/A', FacType="Trainee" WHERE rosterid=39225;
UPDATE lookup.roster set Faculty="Faculty", FacultyType='Senior', FacType='Professor' WHERE rosterid=39552;
UPDATE lookup.roster set Faculty='Non-Faculty',FacultyType='N/A', FacType="Trainee" WHERE rosterid=38717;


select FacultyType,count(*) from lookup.roster group by FacultyType;

select Faculty,count(*) from lookup.roster group by Faculty;

select FacType,count(*) from lookup.roster group by FacType;

select * from lookup.roster where facType='N/A';

UPDATE lookup.roster set Faculty='Non-Faculty' where Faculty='';


Select FacultyType,Faculty,FacType, count(*)
from lookup.roster
group by FacultyType,Faculty,FacType;


SELECT ReportRole,count(*)
from lookup.roster
group by ReportRole;



Select FacultyType,Faculty,FacType, count(*)
from lookup.roster
WHERE ReportRole is Null
group by FacultyType,Faculty,FacType;





################# Service use by usew type


SELECT ReportRole,Rept_Program2,Count(Distinct Person_Key) AS UNDUP
FROM lookup.roster
WHERE Rept_Program2<>"OMIT"
GROUP BY ReportRole,Rept_Program2 ;

select ReportRole, Count(Distinct Person_Key) AS UNDUP
FROM lookup.roster
WHERE Rept_Program2<>"OMIT"
GROUP BY ReportRole;



###SERVICE USE BY FACTYPE

DROP TABLE IF EXISTS work.ftypesvc;
CREATE TABLE  work.ftypesvc AS
SELECT Factype,Rept_Program2,Count(Distinct Person_Key) AS UNDUP
FROM lookup.roster
WHERE Rept_Program2 NOT IN ("OMIT","Office of Clinical Research")
  AND FacType NOT IN ("Other Faculty")
GROUP BY FacType,Rept_Program2 ;


DROP TABLE IF EXISTS work.ftypesvcagg;
CREATE TABLE  work.ftypesvcagg AS
SELECT distinct Rept_Program2 AS Service
FROM work.ftypesvc;

ALTER TABLE work.ftypesvcagg
	ADD AssPro int(10),
    ADD AsoPro int(10),
    ADD Prof   int(10),
    ADD Trainee int(10),
    ADD Staff  int(10);

    

SET SQL_SAFE_UPDATES = 0;

UPDATE work.ftypesvcagg sa, work.ftypesvc lu SET sa.AssPro=lu.UNDUP where sa.Service=lu.Rept_Program2 AND lu.Factype='Assistant Professor';

UPDATE work.ftypesvcagg sa, work.ftypesvc lu SET sa.AsoPro=lu.UNDUP where sa.Service=lu.Rept_Program2 AND lu.Factype='Associate Professor';

UPDATE work.ftypesvcagg sa, work.ftypesvc lu SET sa.Prof=lu.UNDUP where sa.Service=lu.Rept_Program2 AND lu.Factype='Professor';

UPDATE work.ftypesvcagg sa, work.ftypesvc lu SET sa.Trainee=lu.UNDUP where sa.Service=lu.Rept_Program2 AND lu.Factype='Trainee';

UPDATE work.ftypesvcagg sa, work.ftypesvc lu SET sa.Staff=lu.UNDUP where sa.Service=lu.Rept_Program2 AND lu.Factype='Non-Faculty';


select * from work.ftypesvcagg;
##############################################



 



drop table if exists work.svcUsers;
Create table work.svcUsers as
SELECT DISTINCT Rept_Program2 from lookup.roster
WHERE Rept_Program2<>"OMIT";

ALter table work.svcUsers ADD Faculty int(10),
                          ADD Trainee int(10),
                          ADD Other int(10),
						  ADD Total int(10);

Drop Table if Exists work.tempfac;                           
Create table work.tempfac as
SELECT Rept_Program2, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole="UF Faculty"
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Rept_Program2;


Drop Table if Exists work.temptrain;                           
Create table work.temptrain as
SELECT Rept_Program2, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole="UF Graduate Students / Trainees"
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Rept_Program2;


Drop Table if Exists work.tempoth;                           
Create table work.tempoth as
SELECT Rept_Program2, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole="Other Users"
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Rept_Program2;

Drop Table if Exists work.tempoth;                           
Create table work.tempoth as
SELECT Rept_Program2, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole="Other Users"
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Rept_Program2;


Drop Table if Exists work.temptot;                           
Create table work.temptot as
SELECT Rept_Program2, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole IS NOT NULL
and Affiliation="UF"
and Rept_Program2<>"OMIT"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Rept_Program2;

select distinct ReportRole from lookup.roster;


UPDATE work.svcUsers su, work.tempfac lu
SET su.Faculty=lu.Undup
WHERE su.Rept_Program2=lu.Rept_Program2;

UPDATE work.svcUsers su, work.temptrain lu
SET su.Trainee=lu.Undup
WHERE su.Rept_Program2=lu.Rept_Program2;

UPDATE work.svcUsers su, work.tempoth lu
SET su.Other=lu.Undup
WHERE su.Rept_Program2=lu.Rept_Program2;

UPDATE work.svcUsers su, work.temptot lu
SET su.Total=lu.Undup
WHERE su.Rept_Program2=lu.Rept_Program2;


select * from work.svcUsers ORDER BY Total DESC;


select FacType,count(distinct Person_Key) from lookup.roster where Rept_Program2='Integrated Data Repository' group by FacType;

select Year,STD_PROGRAM, count(distinct Person_Key) from lookup.roster where Rept_Program2='Integrated Data Repository' group by Year,STD_PROGRAM;


#################

Drop Table if Exists work.tempyear;                           
Create table work.tempyear as
SELECT Year,ReportRole, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole IS NOT NULL
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Year,ReportRole;


drop table if exists work.tempfacyear;
create table work.tempfacyear AS
SELECT DISTINCT ReportRole from work.tempyear;

ALTER TABLE work.tempfacyear
	ADD Y2012 int(6),
	ADD Y2013 int(6),
    ADD Y2014 int(6),
    ADD Y2015 int(6),
    ADD Y2016 int(6),
    ADD Y2017 int(6),
    ADD Y2018 int(6),
    ADD Y2019 int(6);
    
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2012=lu.Undup Where Year=2012 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2013=lu.Undup Where Year=2013 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2014=lu.Undup Where Year=2014 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2015=lu.Undup Where Year=2015 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2016=lu.Undup Where Year=2016 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2017=lu.Undup Where Year=2017 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2018=lu.Undup Where Year=2018 and fy.ReportRole=lu.ReportRole;
UPDATE work.tempfacyear fy, work.tempyear lu  SET fy.Y2019=lu.Undup Where Year=2019 and fy.ReportRole=lu.ReportRole;






select * from work.tempfacyear; 

SELECT Year, COUNT(DISTINCT Person_key) AS Undup
from lookup.roster
WHERE ReportRole IS NOT NULL
and Affiliation="UF"
and Year IN (2012,2013,2014,2015,2016,2017,2018,2019)
GROUP BY Year;


######################################################
######################################################
######################################################
######################################################
######################################################
######################################################
##############    PILOTS  ############################
######################################################



drop table if exists pilots.PILOTS_GRANT_SUMMARY;
create table pilots.PILOTS_GRANT_SUMMARY as 
SELECT Pilot_ID,
       Grant_Title,
       min(Year_Activiated) as Year_Activiated,
       min(Grant_Sponsor) As Grant_Sponsor,
       min(Grant_Sponsor_ID) AS Grant_Sponsor_ID,
		sum(Direct) AS Direct,
		sum(Indirect) AS Indirect,
		sum(Total) As Total,
       FORMAT(SUM(Total),0) AS Fmt_total
from pilots.ROI_AWARD_AGG
WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.PILOTS_MASTER 
					WHERE Award_Year>=2012 AND 						
                    Award_Year<2019
					AND Status="Completed"
					AND Awarded="Awarded"
					AND Category NOT IN ("SECIM")) 
group by Pilot_ID,Grant_Title;


## Number of Awards
select count(*) from pilots.PILOTS_GRANT_SUMMARY;
## 50


## Total of Awards
SELECT Sum(Total) from pilots.PILOTS_GRANT_SUMMARY;
## 25485425.4100000000


SELECT * from pilots.PILOTS_GRANT_SUMMARY;


### SPONSORS
select Grant_Sponsor,count(*)  from pilots.PILOTS_GRANT_SUMMARY group by Grant_Sponsor; 


UPDATE pilots.PILOTS_GRANT_SUMMARY SET Grant_Sponsor_ID=Trim(Grant_Sponsor_ID);

#Types of NIH Awards

SELECT substr(Grant_Sponsor_ID,1,3) as Type,count(*) from pilots.PILOTS_GRANT_SUMMARY WHERE Grant_Sponsor LIKE "NATL INST OF HLTH%"
GROUP BY substr(Grant_Sponsor_ID,1,3)
ORDER BY substr(Grant_Sponsor_ID,1,3);


### College of Awardees



SELECT College,count(DISTINCT UFID) from pilots.PILOTS_MASTER
WHERE Pilot_ID in (SELECT DISTINCT Pilot_id from pilots.PILOTS_GRANT_SUMMARY)
Group by College;

SELECT College,count(UFID) from pilots.PILOTS_MASTER
WHERE Pilot_ID in (SELECT DISTINCT Pilot_id from pilots.PILOTS_GRANT_SUMMARY)
Group by College;

##check Discrepency for CVM
select * from pilots.PILOTS_MASTER where College='Veterinary Medicine'
AND  Pilot_ID in (SELECT DISTINCT Pilot_id from pilots.PILOTS_GRANT_SUMMARY);

######## aWARDEES WITH MULTIPLE AWARDS

drop table if exists work.multawd; 
create table work.multawd As
select Pilot_ID, count(*) as nAWD from pilots.PILOTS_GRANT_SUMMARY
GROUP BY Pilot_ID;

Select 	pm.Pilot_ID,
		pm.PI_Last,
		pm.PI_First,College, 
        ma.nAWD
from pilots.PILOTS_MASTER pm 
		LEFT JOIN work.multawd ma
ON pm.Pilot_ID=ma.Pilot_ID
WHERE nAWD>1;



####################
## Pilot ROI Summary Chart
##  

drop table if exists work.subqaward;
Create table work.subqaward as
Select Pilot_ID,
       Sum(Total) AS SubqGrantAmt
from pilots.PILOTS_GRANT_SUMMARY
WHERE Pilot_ID IN (SELECT DISTINCT Pilot_ID from pilots.PILOTS_MASTER 
					WHERE Award_Year>=2012 AND 						
                    Award_Year<2019
					AND Status="Completed"
					AND Awarded="Awarded"
					AND Category NOT IN ("SECIM")) 
Group by Pilot_ID;


        
        
UPDATE work.roitemp SET CompCat='Clinical - Non-CRC Study' WHERE Category='Clinical' AND AwardType IN ('','Junior Faculty') ;
UPDATE work.roitemp SET CompCat='Clinical - CRC Study' WHERE Category='Clinical' AND AwardType='' AND CRC_STUDY=1;
UPDATE work.roitemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType IN ('Faculty','Junior Faculty') AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType = 'Trainee' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Pipeline' WHERE Category='Pipeline' AND AwardType='Pipeline' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='PRICE' WHERE Category='PRICE' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Trad-Junior Faculty' WHERE Category='Traditional' AND AwardType='Junior Faculty' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Trad-Network' WHERE Category='Traditional' AND AwardType='Network' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Trad-Novel Methods' WHERE Category='Traditional' AND AwardType='Novel Methods' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Trad-Trainee' WHERE Category='Traditional' AND AwardType='Trainee' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 1' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=0;
UPDATE work.roitemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=1;
UPDATE work.roitemp SET CompCat='UFII-CTSI' WHERE Category='UFII-CTSI' AND AwardType='' AND CRC_STUDY=0;        
		
        
select distinct   CompCat from work.roitemp;      
        
        
SELECT CompCat,sum(Award_Amt) as PilotAmt,Sum(SubqGrantAmt) as SubqGrantAmt  
from work.roitemp
group by CompCat;   





drop table if exists work.roitemp;
Create table work.roitemp as
SELECT 	Pilot_ID,
		Category,
        AwardType,
        CRC_STUDY,
        Award_Amt,
        SPACE(45) as CompCat
from pilots.PILOTS_MASTER		
WHERE 	Award_Year>=2012  		
		AND Award_Year<2019
		AND Status="Completed"
		AND Awarded="Awarded"
		AND Category NOT IN ("SECIM") ;   
        
ALTER TABLE work.roitemp ADD SubqGrantAmt decimal(65,10);

SET SQL_SAFE_UPDATES = 0;

UPDATE work.roitemp rt, work.subqaward sa
SET rt.SubqGrantAmt=sa.SubqGrantAmt
WHERE rt.Pilot_ID=sa.Pilot_ID;        

####################        
####################
#####  Project Completeionm to related  publication and or grant
        
    
drop table if exists work.lagtemp;
Create table work.lagtemp as
SELECT 	Pilot_ID,
		Category,
        AwardType,
        PI_Last,
        PI_First,
        Title
        CRC_STUDY,
        Award_Amt,
        AwardLetterDate,
        SPACE(45) as CompCat
from pilots.PILOTS_MASTER		
WHERE 	Award_Year>=2012  		
		AND Award_Year<2019
		AND Status="Completed"
		AND Awarded="Awarded"
		AND Category NOT IN ("SECIM")   ; 
        
        
drop table if exists work.lagpub;
Create table work.lagpub as
SELECT 	Pilot_ID, MIN(PubDate) AS Pubdate
from pilots.PILOTS_PUB_MASTER
GROUP BY Pilot_ID;       
        
drop table if exists work.laggrant;
Create table work.laggrant as
SELECT 	Pilot_ID, MIN(FUNDS_ACTIVATED) AS GrantDate
from pilots.PILOTS_ROI_MASTER
WHERE AwardLetterDate<=FUNDS_ACTIVATED
GROUP BY Pilot_ID;       


ALTER TABLE work.lagtemp
ADD Pubdate datetime,
ADD GrantDate datetime,
ADD publag decimal(65,10),
ADD grantLag decimal(65,10);


UPDATE work.lagtemp lt, work.lagpub lu
SET lt.Pubdate=lu.Pubdate
WHERE lt.Pilot_ID=lu.Pilot_ID;

   
UPDATE work.lagtemp lt, work.laggrant lu
SET lt.GrantDate=lu.GrantDate
WHERE lt.Pilot_ID=lu.Pilot_ID;       


UPDATE  work.lagtemp
SET publag=DATEDIFF(Pubdate,AwardLetterDate),
	grantLag=DATEDIFF(GrantDate,AwardLetterDate);
    
    
UPDATE work.lagtemp SET CompCat='Clinical - Non-CRC Study' WHERE Category='Clinical' AND AwardType IN ('','Junior Faculty') ;
UPDATE work.lagtemp SET CompCat='Clinical - CRC Study' WHERE Category='Clinical' AND AwardType='' AND CRC_STUDY=1;
UPDATE work.lagtemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType IN ('Faculty','Junior Faculty') AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Communications' WHERE Category='Communication' AND AwardType = 'Trainee' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Pipeline' WHERE Category='Pipeline' AND AwardType='Pipeline' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='PRICE' WHERE Category='PRICE' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Trad-Junior Faculty' WHERE Category='Traditional' AND AwardType='Junior Faculty' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Trad-Network' WHERE Category='Traditional' AND AwardType='Network' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Trad-Novel Methods' WHERE Category='Traditional' AND AwardType='Novel Methods' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Trad-Trainee' WHERE Category='Traditional' AND AwardType='Trainee' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 1' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=0;
UPDATE work.lagtemp SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=1;
UPDATE work.lagtemp SET CompCat='UFII-CTSI' WHERE Category='UFII-CTSI' AND AwardType='' AND CRC_STUDY=0;           
        


select * from work.lagsum;

drop table if exists work.lagsumm;
create table work.lagsumm as
select CompCat,
       AVG(publag),
       AVG(grantLag)
FROM work.lagtemp
gROUP BY CompCat;       
       
drop table if exists work.lagsumm;
create table work.lagsumm as
select 
       AVG(publag),
       AVG(grantLag)
FROM work.lagtemp
;     
              
       
       
desc work.lagtemp;    





##################################################
select * from pilots.PILOTS_ROI_MASTER
Where Pilot_ID IN 
(369,
93,
97,
99,
101,
102,
103,
385,
389);

####################################################





desc pilots.PILOTS_ROI_MASTER;


 select * from pilots.PILOTS_ROI_MASTER ;  
 
 
 SELECT DISTINCT REPORTING_SPONSOR_AWD_ID from pilots.PILOTS_ROI_MASTER;
 
 
 drop table if exists  work.eacpg;
 create table work.eacpg as
  SELECT DISTINCT REPORTING_SPONSOR_NAME from pilots.PILOTS_ROI_MASTER;
         


ALter table pilots.PILOTS_ROI_MASTER
MODIFY SponsorType varchar(45),
MODIFY AwardType varchar(45);

SET SQL_SAFE_UPDATES = 0;

UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='Alexs Lemonade Stand Fou';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='AMER HEART ASSOCIATION';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='AMER PSYCHOLOGICAL ASSO';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='AMER PSYCHOLOGICAL FOU';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='FL CLINICAL PRACTICE ASSO';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='FDOH King Biomedical Research Program'  WHERE REPORTING_SPONSOR_NAME ='FL DEPT OF HLTH BIOMED RES PGM/J&E KING';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='FRIEDRICHS ATAXIA RESEARCH ALLIANCE';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NHLBI';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIA';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIAID';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIAMS';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NICHD';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIDCD';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIDDK';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NIGMS';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NIH'  WHERE REPORTING_SPONSOR_NAME ='NATL INST OF HLTH NINDS';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='NSF'  WHERE REPORTING_SPONSOR_NAME ='NATL SCIENCE FOU';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='OAK RIDGE ASSO UNIVERSITIES';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='PCORI'  WHERE REPORTING_SPONSOR_NAME ='PATIENT-CENTERED OUTCOMES RES';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='PCORI'  WHERE REPORTING_SPONSOR_NAME ='PATIENT-CENTERED OUTCOMES RES INST';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='PEDIATRIC ENDOCRINE SOCIETY';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='THE OBESITY SOCIETY';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='Non Profit'  WHERE REPORTING_SPONSOR_NAME ='TOURETTE ASSOCIATION OF AMERICA';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='UF'  WHERE REPORTING_SPONSOR_NAME ='UF Department of Pharmacy';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='UF'  WHERE REPORTING_SPONSOR_NAME ='UF DSR OPPORTUNITY FUND';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='UF'  WHERE REPORTING_SPONSOR_NAME ='UF FOU';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='UF'  WHERE REPORTING_SPONSOR_NAME ='University of FlaFoundation';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='DOD'  WHERE REPORTING_SPONSOR_NAME ='US ARMY MED RES AND MATERIAL COM';
UPDATE pilots.PILOTS_ROI_MASTER SET SponsorType='DOD'  WHERE REPORTING_SPONSOR_NAME ='US DEPT OF DEFENSE';

select SponsorType, count(*) from pilots.PILOTS_ROI_MASTER  group by SponsorType;

select * from pilots.PILOTS_ROI_MASTER where SponsorType is Null;





select * from lookup.awards_history where CLK_AWD_ID='00087487';

UPDATE pilots.PILOTS_ROI_MASTER 
SET REPORTING_SPONSOR_NAME='NATL INST OF HLTH',
REPORTING_SPONSOR_AWD_ID='U01AI101990'
WHERE roi_master_id=10;




UPDATE pilots.PILOTS_ROI_MASTER SET AwardType=SponsorType;


 drop table if exists  work.eacpg;
 create table work.eacpg as
  SELECT DISTINCT REPORTING_SPONSOR_AWD_ID from pilots.PILOTS_ROI_MASTER where AwardType="NIH";
  
  
select * from pilots.PILOTS_ROI_MASTER  WHERE REPORTING_SPONSOR_AWD_ID="GM02451";

UPDATE pilots.PILOTS_ROI_MASTER SET REPORTING_SPONSOR_AWD_ID='K08AR064836' WHERE REPORTING_SPONSOR_AWD_ID="GM02451";






UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-F31'  WHERE REPORTING_SPONSOR_AWD_ID ='1F31HL132463-01';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R42'  WHERE REPORTING_SPONSOR_AWD_ID ='4R42HD0889804-02';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-F31'  WHERE REPORTING_SPONSOR_AWD_ID ='F31 MH102089';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K01'  WHERE REPORTING_SPONSOR_AWD_ID ='K01 AR066077';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K01'  WHERE REPORTING_SPONSOR_AWD_ID ='K01AG048259';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K01'  WHERE REPORTING_SPONSOR_AWD_ID ='K01DK115632';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K01'  WHERE REPORTING_SPONSOR_AWD_ID ='K01HL138172';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K01'  WHERE REPORTING_SPONSOR_AWD_ID ='K01HL141535';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-K08'  WHERE REPORTING_SPONSOR_AWD_ID ='K08AR064836';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-P50'  WHERE REPORTING_SPONSOR_AWD_ID ='P50 GM111152';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-P50'  WHERE REPORTING_SPONSOR_AWD_ID ='P50GM111152';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01 GM079359';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01 GM104481';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01AG054370';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01AI118999';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01AR069660';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01AR071335';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01DK109560';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01DK109570';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01GM113945';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01HD091658';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01HL033610';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01HL136759';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R01'  WHERE REPORTING_SPONSOR_AWD_ID ='R01MH112558';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R21'  WHERE REPORTING_SPONSOR_AWD_ID ='R21 NS091435';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R21'  WHERE REPORTING_SPONSOR_AWD_ID ='R21 NS091686';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R21'  WHERE REPORTING_SPONSOR_AWD_ID ='R21AG062884';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R21'  WHERE REPORTING_SPONSOR_AWD_ID ='R21AR069844';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R21'  WHERE REPORTING_SPONSOR_AWD_ID ='R21DC013751';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R24'  WHERE REPORTING_SPONSOR_AWD_ID ='R24GM119977';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-R56'  WHERE REPORTING_SPONSOR_AWD_ID ='R56AI108434';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-U01'  WHERE REPORTING_SPONSOR_AWD_ID ='U01AI101990';
UPDATE pilots.PILOTS_ROI_MASTER SET AwardType='NIH-UC4'  WHERE REPORTING_SPONSOR_AWD_ID ='UC4 DK104194';


ALTER TABLE pilots.PILOTS_ROI_MASTER ADD SUMMCAT varchar(45);

UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT =SponsorType;


UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Fellowship (F)' WHERE AwardType='NIH-F31';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Development (K)' WHERE AwardType='NIH-K01';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Development (K)' WHERE AwardType='NIH-K08';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Center (P50)' WHERE AwardType='NIH-P50';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Project (R)' WHERE AwardType='NIH-R01';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Project (R)' WHERE AwardType='NIH-R21';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Project (R)' WHERE AwardType='NIH-R24';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Project (R)' WHERE AwardType='NIH-R42';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH Project (R)' WHERE AwardType='NIH-R56';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH - Co-op Agreement (U)' WHERE AwardType='NIH-U01';
UPDATE pilots.PILOTS_ROI_MASTER SET SUMMCAT='NIH - Co-op Agreement (U)' WHERE AwardType='NIH-UC4';










select distinct AwardType from pilots.PILOTS_ROI_MASTER;



select distinct AwardType from pilots.PILOTS_ROI_MASTER;



DROP TABLE IF EXISTS work.awdtype;
CREATE TABLE work.awdtype AS

select 	pm.Pilot_ID,
		pm.Award_Year,
        pm.Category,
        pm.AwardType,
        pm.Awarded,
        pm.AwardLetterDate,
        pm.Award_Amt,
        pm.CRC_STUDY,
        pm.AwardeePositionAtApp,
        pm.AwardeeCareerStage,
        pa.CLK_AWD_ID,
        pa.CLK_AWD_PROJ_ID,
        pa.AggLevel,
		pa.SponsorType,
        pa.AwardType AS AwdCat,
        pa.SUMMCAT

from pilots.PILOTS_MASTER pm LEFT JOIN pilots.PILOTS_ROI_MASTER pa ON pm.Pilot_ID=pa.Pilot_id
WHERE
        YEAR(pm.AwardLetterDate) >= 2012
        AND pm.Awarded = 'Awarded'
        AND pm.Category NOT IN ('SECIM')
        AND pm.Pilot_ID IN (select Distinct Pilot_ID from pilots.PILOTS_ROI_MASTER);
        
        
        



ALter table work.awdtype Add CompCat varchar(50);
Alter table work.awdtype Add GrantAmt decimal(65,10);

############
DROP TABLE IF EXISTS work.paAWD;
Create table work.paAWD AS
Select CLK_AWD_ID, AggLevel, SUM(SPONSOR_AUTHORIZED_AMOUNT) AS GrantAmt
FROM pilots.PILOTS_ROI_DETAIL
WHERE AggLevel="Award"
GROUP BY CLK_AWD_ID, AggLevel;

select distinct AggLevel from pilots.PILOTS_ROI_MASTER;

DROP TABLE IF EXISTS work.paProj;
Create table work.paProj AS
Select CLK_AWD_PROJ_ID,  AggLevel, SUM(SPONSOR_AUTHORIZED_AMOUNT) AS GrantAmt
FROM pilots.PILOTS_ROI_DETAIL
WHERE AggLevel= AggLevel
GROUP BY CLK_AWD_PROJ_ID, AggLevel;

UPDATE work.awdtype at, work.paAWD lu
SET at.GrantAmt=lu.GrantAmt
WHERE at.CLK_AWD_ID=lu.CLK_AWD_ID
AND  at.AggLevel="Award" ;


UPDATE work.awdtype at, work.paProj lu
SET at.GrantAmt=lu.GrantAmt
WHERE at.CLK_AWD_PROJ_ID=lu.CLK_AWD_PROJ_ID
AND  at.AggLevel= "Project";



UPDATE work.awdtype SET CompCat='Clinical - Non-CRC Study' WHERE Category='Clinical' AND AwardType IN ('','Junior Faculty') ;
UPDATE work.awdtype SET CompCat='Clinical - CRC Study' WHERE Category='Clinical' AND AwardType='' AND CRC_STUDY=1;


UPDATE work.awdtype SET CompCat='Communications' WHERE Category='Communication' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Communications' WHERE Category='Communication' AND AwardType IN ('Faculty','Junior Faculty') AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Communications' WHERE Category='Communication' AND AwardType = 'Trainee' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Pipeline' WHERE Category='Pipeline' AND AwardType='Pipeline' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='PRICE' WHERE Category='PRICE' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Trad-Junior Faculty' WHERE Category='Traditional' AND AwardType='Junior Faculty' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Trad-Network' WHERE Category='Traditional' AND AwardType='Network' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Trad-Novel Methods' WHERE Category='Traditional' AND AwardType='Novel Methods' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Trad-Trainee' WHERE Category='Traditional' AND AwardType='Trainee' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 1' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='Translational' WHERE Category='Translational' AND AwardType='Phase 2' AND CRC_STUDY=1;
UPDATE work.awdtype SET CompCat='UFII-CTSI' WHERE Category='UFII-CTSI' AND AwardType='' AND CRC_STUDY=0;
UPDATE work.awdtype SET CompCat='SECIM' WHERE Category='SECIM' ;


SELECT * from work.awdtype where CompCat is Null;


SELECT * from work.awdtype where SUMMCAT IS NULL;
SELECT DISTINCT SUMMCAT from work.awdtype ;

s
select sum(GrantAmt) from work.awdtype;

select * from work.awdtype;

select AwardeeCareerStage,AwdCat,count(*) from work.awdtype group by AwardeeCareerStage,AwdCat;

select CompCat,AwdCat,count(*) from work.awdtype group by CompCat,AwdCat;


select * from work.awdtype where GrantAmt is Null;

drop table if exists work.fixamt ;
create table work.fixamt as
SELECT Pilot_ID, TotalAMT from pilots.pilots_summary where PIlot_ID in (select Distinct Pilot_ID from work.awdtype where GrantAmt is Null);

UPDATE  work.awdtype at, work.fixamt lu
SET at.GrantAmt=lu.TotalAMT
WHERE at.pilot_ID=lu.Pilot_ID
AND at.GrantAmt is Null;


ALTER TABLE work.awdtype ADD AwdClass varchar(20);

ALTER TABLE work.awdtype ADD UNIAWD varchar(20);

UPDATE work.awdtype SET AwdClass=AwdCat;

UPDATE work.awdtype SET AwdClass=AwdCat;
UPDATE work.awdtype SET AwdClass="NIH" WHERE substr(AwdCat,1,3)="NIH";






drop table if exists work.awdrept ;
create table work.awdrept as
SELECT AwdClass, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
GROUP BY AwdClass;


drop table if exists work.awdrept ;
create table work.awdrept as
SELECT AwdCat, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
WHERE AwdClass="NIH"
GROUP BY AwdCat;

drop table if exists work.awdrept ;
create table work.awdrept as
SELECT CompCat, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
WHERE AwdClass="NIH"
GROUP BY CompCat;

drop table if exists work.awdrept ;
create table work.awdrept as
SELECT CompCat, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
WHERE AwdClass<>"NIH"
GROUP BY CompCat;


drop table if exists work.awdrept ;
create table work.awdrept as
SELECT AwardeeCareerStage, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
WHERE AwdClass="NIH"
GROUP BY AwardeeCareerStage;


drop table if exists work.awdrept ;
create table work.awdrept as
SELECT AwardeeCareerStage, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
WHERE AwdClass<>"NIH"
GROUP BY AwardeeCareerStage;

                                                                                       #################!!!!!!!!!!!!!
drop table if exists work.awdrept ;
create table work.awdrept as
SELECT CompCat, SUMMCAT, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
GROUP BY CompCat, SUMMCAT;


drop table if exists work.awdrept ;
create table work.awdrept as
SELECT AwardeeCareerStage, SUMMCAT, Count(DISTINCT CLK_AWD_ID ) as NumAwd
from work.awdtype
GROUP BY AwardeeCareerStage, SUMMCAT;


select distinct SUMMCAT from work.awdrept;





select AwdCat,AwdClass, count(*) from work.awdtype group by AwdCat,AwdClass;

SELECT * from pilots.PILOTS_ROI_MASTER WHERE REPORTING_SPONSOR_NAME IN ('FL CLINICAL PRACTICE ASSO','FL DEPT OF HLTH BIOMED RES PGM/J&E KING');




#######################
DESC lookup.myIRB;
select distinct Review_Type from lookup.myIRB;
select distinct Committee from lookup.myIRB;


SELECT IRB_Approval_Year, count(distinct ID) from lookup.myIRB WHERE Ceded_Review=1 group by IRB_Approval_Year;


SELECT IRB_Approval_Year, count(distinct ID) from lookup.myIRB WHERE Committee='IRB-01' and Review_Type='Full IRB Review' group by IRB_Approval_Year;



###################################

SELECT 	Year,
		Faculty,
        Count(Distinct Person_key)
from lookup.roster
WHERE #Affiliation="UF"   AND
   Faculty="Faculty"
  AND Year>=2012
Group by Year,Faculty ; 





SELECT 	Year,
		FacType,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
  AND FacType='Trainee'
  AND Year>=2012
Group by Year,FacType ;  

SELECT 	Year,
		FacType,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND FacType='Non-Faculty'
  AND Year>=2012
Group by Year,FacType ; 


SELECT 	Year,
        Count(Distinct Person_key)
from lookup.roster
WHERE Affiliation="UF"
AND Year>=2012
Group by Year; 
