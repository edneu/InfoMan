

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
##DATE work.nih SET CTSIAffil=1 WHERE Year(nih.FUNDS_ACTIVATED)=2023 and Roster2023=1;  

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

#######################################################  
#########################################################  
#########################################################  
#########################################################  
#########################################################  