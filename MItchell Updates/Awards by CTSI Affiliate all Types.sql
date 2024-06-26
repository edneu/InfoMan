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

