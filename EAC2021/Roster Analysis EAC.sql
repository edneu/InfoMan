
### Undup Users By College All Years###

Select Display_College ,count(distinct Person_Key) as Undup
FROM lookup.roster 
WHERE Display_College not In ('Non-Academic','Non-UF')
group by Display_College;


####Undup Fac BY ype and Grouped Year
drop table if exists work.grYearFac;
create table work.grYearFac AS
Select 	ctsi_year,
		FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Associate Professor','Professor','Assistant Professor')
GROUP BY ctsi_year,
		FacType;
        
 DROP TABLE IF exists results.GrYearFacOut;
 Create table results.GrYearFacOut AS
 SELECT Distinct ctsi_year
 FROM work.grYearFac;
 
 Alter table  results.GrYearFacOut
	ADD AstProf int(10),
	ADD AsoProf int(10),
	ADD Profess int(10);
    
UPDATE results.GrYearFacOut yf, work.grYearFac lu
	SET yf.AstProf=lu.Undup
	WHERE yf.ctsi_year=lu.ctsi_year
	AND lu.FacType='Assistant Professor';    
    
UPDATE results.GrYearFacOut yf, work.grYearFac lu
	SET yf.AsoProf=lu.Undup
	WHERE yf.ctsi_year=lu.ctsi_year
	AND lu.FacType='Associate Professor';   
    
 UPDATE results.GrYearFacOut yf, work.grYearFac lu
	SET yf.Profess=lu.Undup
	WHERE yf.ctsi_year=lu.ctsi_year
	AND lu.FacType='Professor';    
    
Select * from results.GrYearFacOut;    
####################################################################################
#####By Ungrouped Year##############################################################
drop table if exists work.YearFac;
create table work.YearFac AS
Select 	Year,
		FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Associate Professor','Professor','Assistant Professor')
GROUP BY year,
		FacType;
        
        
        
        
 DROP TABLE IF exists results.YearFacOut;
 Create table results.YearFacOut AS
 SELECT Distinct Year
 FROM work.YearFac;
 
 Alter table  results.YearFacOut
	ADD AstProf int(10),
	ADD AsoProf int(10),
	ADD Profess int(10);
    
UPDATE results.YearFacOut yf, work.YearFac lu
	SET yf.AstProf=lu.Undup
	WHERE yf.Year=lu.Year
	AND lu.FacType='Assistant Professor';    
    
UPDATE results.YearFacOut yf, work.YearFac lu
	SET yf.AsoProf=lu.Undup
	WHERE yf.Year=lu.Year
	AND lu.FacType='Associate Professor';   
    
 UPDATE results.YearFacOut yf, work.YearFac lu
	SET yf.Profess=lu.Undup
	WHERE yf.Year=lu.Year
	AND lu.FacType='Professor';    
    
Select * from results.YearFacOut;    




################################################################
SELECT Year,count(distinct Person_key) as Undup
FROM lookup.roster 
Where Faculty="Non-Faculty"
GROUP BY Year;



Select 	FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Trainee')
GROUP BY FacType;

SELECT Year,count(distinct Person_key) as Undup
FROM lookup.roster 
Where FacType='Trainee'
GROUP BY Year;


Select 	count(distinct Person_key) as Undup
From lookup.roster         
Where UserClass='UF Research Professtionals'
GROUP BY FacType;

SELECT Year,count(distinct Person_key) as Undup
FROM lookup.roster 
Where UserClass='UF Research Professtionals'
GROUP BY Year;
############################################################***********************



Select 	FacType,
		count(distinct Person_key) as Undup
From lookup.roster         
Where FacType IN ('Associate Professor','Professor','Assistant Professor')
GROUP BY FacType;



#########################################################

SELECT Rept_Program,ctsi_year,count(*) 
from lookup.roster
WHERE Rept_Program<>"OMIT"  
GROUP BY Rept_Program,ctsi_year;  




select distinct UserClass from lookup.roster ;
select distinct FacType from lookup.roster ;
Select Affiliation,count(*) from lookup.roster group by Affiliation;

UPDATE lookup.roster SET UserClass='UF Faculty' Where FacType IN ('Associate Professor','Professor','Assistant Professor');
UPDATE lookup.roster SET UserClass='UF Research Professtionals' Where FacType IN ('Non-Faculty') AND Affiliation="UF";
UPDATE lookup.roster SET UserClass='UF Grad Student / Trainee' Where FacType IN ('Trainee');
UPDATE lookup.roster SET UserClass='External Collaborators' Where Affiliation NOT IN ("UF","FSU");
UPDATE lookup.roster SET UserClass='FSU Faculty' Where Affiliation="FSU";




select distinct ReportRole from lookup.roster ;

DROP TABLE IF EXISTS work.proclass;
Create table work.proclass AS
SELECT Rept_Program,
	   UserClass,
       count(distinct Person_key) As UnDup
from lookup.roster
WHERE UserClass in  ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
AND Rept_Program<>"Omit"
group by Rept_Program,
	   UserClass;       
       
DROP TABLE IF Exists  results.ProgClassSumm;
create table results.ProgClassSumm AS
SELECT DISTINCT Rept_Program
FROM work.proclass;

Alter table results.ProgClassSumm
	ADD Fac int(8),
    ADD Train int(8),
    ADD Other int(8);
    
UPDATE results.ProgClassSumm ps, work.proclass lu
SET ps.Fac=lu.Undup
WHERE ps.Rept_Program=lu.Rept_Program
  AND lu.UserClass='UF Faculty';		
    

UPDATE results.ProgClassSumm ps, work.proclass lu
SET ps.Train=lu.Undup
WHERE ps.Rept_Program=lu.Rept_Program
  AND lu.UserClass='UF Grad Student / Trainee';	

UPDATE results.ProgClassSumm ps, work.proclass lu
SET ps.Other=lu.Undup
WHERE ps.Rept_Program=lu.Rept_Program
  AND lu.UserClass='UF Research Professtionals';	
  
SELECT * from results.ProgClassSumm;  

################################################
##### AWARDS BY YEAR FOR CTSI USERS

Select max('2009') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2009=1 
UNION ALL
Select max('2010') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2010=1 
UNION ALL
Select max('2011') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2011=1 
UNION ALL
Select max('2012') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2012=1 
UNION ALL
Select max('2013') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2013=1 
UNION ALL
Select max('2014') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2014=1 
UNION ALL
Select max('2015') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2015=1 
UNION ALL
Select max('2016') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2016=1 
UNION ALL
Select max('2017') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2017=1 
UNION ALL
Select max('2018') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2018=1 
UNION ALL
Select max('2019') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2019=1 
UNION ALL
Select max('2020') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history WHERE Roster2020=1 
UNION ALL
Select max('ALL') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Amt from lookup.awards_history
WHERE (Roster2009+Roster2010+Roster2011+Roster2012+Roster2013+Roster2014+Roster2015+Roster2016+Roster2017+Roster2018+Roster2019+Roster2020)>0;
;



####################################
NIH AND NON-NIH

SELECT Year(FUNDS_ACTIVATED) AS Year,
	   SUM(SPONSOR_AUTHORIZED_AMOUNT) as NIH_ALLAmount from lookup.awards_history WHERE AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%';


Select max('2009') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2009=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' AND Year(FUNDS_ACTIVATED)=2009
UNION ALL
Select max('2010') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2010=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2010
UNION ALL
Select max('2011') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2011=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2011
UNION ALL
Select max('2012') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2012=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2012
UNION ALL
Select max('2013') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2013=1  AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' AND Year(FUNDS_ACTIVATED)=2013
UNION ALL
Select max('2014') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2014=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2014
UNION ALL
Select max('2015') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2015=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2015
UNION ALL
Select max('2016') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2016=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' AND Year(FUNDS_ACTIVATED)=2016
UNION ALL
Select max('2017') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2017=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2017
UNION ALL
Select max('2018') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2018=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2018
UNION ALL
Select max('2019') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2019=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2019
UNION ALL
Select max('2020') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2020=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%'  AND Year(FUNDS_ACTIVATED)=2020
UNION ALL
Select max('ALL') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history
WHERE (Roster2009+Roster2010+Roster2011+Roster2012+Roster2013+Roster2014+Roster2015+Roster2016+Roster2017+Roster2018+Roster2019+Roster2020)>0 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%';
;


Select max('2009') as Year,COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHCTSI from lookup.awards_history WHERE Roster2009=1 AND REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' AND Year(FUNDS_ACTIVATED)=2009
UNION ALL


SELECT Year(FUNDS_ACTIVATED) AS Year, COUNT(DISTINCT CLK_AWD_ID) AS nAwards,SUM(SPONSOR_AUTHORIZED_AMOUNT) AS NIHTOT from lookup.awards_history WHERE REPORTING_SPONSOR_NAME LIKE 'NATL INST OF HLTH%' GROUP BY Year;






