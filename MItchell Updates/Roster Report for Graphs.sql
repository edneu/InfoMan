

####################################################################################################################
####################################################################################################################
####################################################################################################################
####################################################################################################################

#  PROGRAM UTILIZATION LIST

DROP TABLE IF EXISTS  work.userprogram;
CREATE TABLE work.userprogram as
SELECT Rept_Program,UserClass, count(distinct Person_Key) As nUndup
from lookup.roster
WHERE Year>=2012
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
group by Rept_Program,UserClass;

select max(length(UserClass)) from work.userprogram;


DROP TABLE IF EXISTS work.ProgUsersOut;
Create TABLE work.ProgUsersOut AS
SELECT Distinct Rept_Program as Rept_Program
FROM work.userprogram;

DROP TABLE IF EXISTS work.ProgUsersUndup;
Create TABLE work.ProgUsersUndup AS
SELECT Rept_Program, Count(Distinct Person_key) as nUndup
from lookup.roster
WHERE Year>=2012
AND UserClass IN ('UF Faculty','UF Research Professtionals','UF Grad Student / Trainee')
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

#########################################################  
#########################################################  
#########################################################  
#########################################################  
######################################################### 