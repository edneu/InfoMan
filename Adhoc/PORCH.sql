###create backup of orginal ped emp list (multiple SFY)
CREATE TABLE Adhoc.PedsList As select * from work.porchlist;

DROP TABLE IF EXISTS work.porchlist;
CREATE TABLE work.porchlist As 
select * from Adhoc.porchlist;
desc work.porchlist;


####*************** Adhoc.prochlist  ## FROM REBECCAH 08/23/2021

SELECT SFY,
		count(*) as nRecs, 
        count(Distinct Employee_ID) AS nPeople, 
        COUNT(DISTINCT Salary_PLan) As nSalPlan
from work.porchlist
 group by SFY;
 
 
 SELECT DISTINCT Salary_PLan As nSalPlan
from work.porchlist
 where SFY="SFY 2018-2019";
 

 
 DROP TABLE IF EXISTS work.fixPorchSalPlan;
 CREATE TABLE work.fixPorchSalPlan
 SELECT Job_Code,
		Salary_Plan 
 from work.porchlist 
 where Salary_Plan not in ('Housestaff') AND 
		Salary_Plan is not null
 GROUP BY  Job_Code,
			Salary_Plan ;    


### CREATE WORKFILE	
DROP TABLE IF EXISTS   work.PorchPeople;   
Create table work.PorchPeople AS
SELECT * from work.porchlist;
 
Alter table work.PorchPeople ADD New_Sal_Plan varchar(45);



SET SQL_SAFE_UPDATES = 0;

UPDATE work.PorchPeople SET New_Sal_Plan=NULL;

UPDATE work.PorchPeople 
	SET New_Sal_Plan=Salary_Plan 
    WHERE Salary_Plan IS NOT NULL;

DROP TABLE IF EXISTS work.salplanlookup ;
Create table work.salplanlookup AS    
SELECT seq,
	   Employee_ID,
	   Job_Code,
       Salary_Plan 
FROM work.PorchPeople    
 WHERE Salary_Plan IS NULL;  
 
 UPDATE work.salplanlookup sl, work.PorchPeople lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND lu.SFY='SFY 2017-2018' ;
 
  UPDATE work.salplanlookup sl, work.PorchPeople lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND lu.SFY='SFY 2019-2020' ;

  UPDATE work.salplanlookup sl, lookup.Employees lu
 SET sl.Salary_Plan=lu.Salary_Plan
 WHERE sl.Employee_ID=lu.Employee_ID
   AND sl.Job_Code=lu.Job_Code
   AND sl.Salary_Plan IS NULL; ;

  UPDATE work.salplanlookup sl, work.porchfillsal lu
 SET sl.Salary_Plan=lu.Salary_Code
 WHERE sl.Job_Code=lu.Job_Code
   AND sl.Salary_Plan IS NULL; ; 


SELECT Employee_ID,
	   Job_Code,
       Salary_Plan 
FROM work.salplanlookup   
 WHERE Salary_Plan IS NULL;
 
 
UPDATE work.PorchPeople pp, work.salplanlookup lu
SET pp.New_Sal_Plan=lu.Salary_Plan 
where pp.seq=lu.seq;



SELECT SFY,
		count(*) as nRecs, 
        count(Distinct Employee_ID) AS nPeople, 
        COUNT(DISTINCT Salary_PLan) As nSalPlan,
        COUNT(DISTINCT New_Sal_Plan ) AS nNewSalPLAN
from work.PorchPeople 
 group by SFY;
 
 
 Alter table work.PorchPeople 
		ADD Faculty varchar(12),
        ADD Factype varchar(25);
 
 
 UPDATE  work.PorchPeople SET Faculty="Non-Faculty";
 
 UPDATE  work.PorchPeople SET Faculty="Faculty"
 WHERE New_Sal_Plan LIKE '%Faculty%';
 
 
UPDATE work.PorchPeople pp, work.porchfactype lu
SET pp.FacType=lu.FacType
WHERE 	pp.Job_Code=lu.Job_Code
	AND	pp.New_Sal_Plan=lu.New_Sal_Plan
    AND pp.Faculty=lu.Faculty;
    
UPDATE work.PorchPeople pp
SET pp.FacType="Staff"
WHERE 	pp.facType is NULL;


UPDATE work.PorchPeople 
SET FacType="Assistant Professor" 
WHERE FacType in ('ASO DEAN & CLIN AST PROF','DIR & CLIN AST PROF');


UPDATE work.PorchPeople 
SET FacType='Associate Professor'
WHERE FacType in ('ASO PROF','CHIF & CLIN ASO PROF');

  SELECT Salary_PLan,
         New_Sal_Plan,
         FacType,
         count(*) as n,
         sum(Works_with_PoRCH) as nPorch
from work.PorchPeople
 where SFY="SFY 2018-2019"
 group by Salary_PLan,
         New_Sal_Plan,
         FacType;
         

UPDATE work.PorchPeople
SET Employee_ID=lpad(Employee_ID,8,'0');

SELECT SFY,
		count(*) as nRecs, 
        count(Distinct Employee_ID) AS nPeople, 
        COUNT(DISTINCT Salary_PLan) As nSalPlan,
        COUNT(DISTINCT New_Sal_Plan ) AS nNewSalPLAN,
        sum(Works_with_PoRCH) as nPorch
from work.PorchPeople 
 group by SFY;
    

 
SELECT Distinct FacType from work.PorchPeople;

SELECT * from work.PorchPeople 
WHERE FacType is NULL;





#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################
#########################################################################################################

##### PORCH sfy calssifcation table
drop table if Exists work.porchSFYlu;
create table work.porchSFYlu as
SELECT 	SFY,
		Employee_ID,
		max(Name) as Name,
		max(Works_with_PoRCH) as Porch
from work.PorchPeople
GROUP BY 	SFY,
			Employee_ID;



#### awards history extract
SET sql_mode = '';


DROP TABLE IF EXISTS work.PedsAwards;
create table work.PedsAwards AS
SELECT * from lookup.awards_history
WHERE CLK_PI_UFID IN (select distinct Employee_ID from  work.PorchPeople)
   OR  CLK_AWD_PROJ_MGR_UFID  IN (select distinct Employee_ID from  work.PorchPeople);
   
   
Alter table work.PedsAwards
  ADD SFY varchar(25),
  ADD NIH INT(1),
  ADD Industry int(1),
  ADD PedsPI INT(1),
  ADD PedsContPI INT(1),
  ADD ContEQProj int(1),
  ADD PI_Classify varchar(35),
  ADD PORCH_PROJ_PI int(1),
  ADD PORCH_PI int(1),
  ADD PorchInv int(1);

  
SET SQL_SAFE_UPDATES = 0;  
UPDATE work.PedsAwards SET SFY ='SFY 2017-2018' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2017','%m,%d,%Y') and str_to_date('06,30,2018','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2018-2019' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2018','%m,%d,%Y') and str_to_date('06,30,2019','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2019-2020' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2019','%m,%d,%Y') and str_to_date('06,30,2020','%m,%d,%Y');
UPDATE work.PedsAwards SET SFY ='SFY 2020-2021' WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2020','%m,%d,%Y') and str_to_date('06,30,2021','%m,%d,%Y');

DELETE FROM work.PedsAwards WHERE SFY IS NULL;

UPDATE work.PedsAwards SET NIH=0;
UPDATE work.PedsAwards SET NIH=1 WHERE REPORTING_SPONSOR_NAME LIKE '%NATL INST OF HLTH%';
UPDATE work.PedsAwards SET NIH=1 WHERE CLK_AWD_PRIME_SPONSOR_NAME LIKE '%NATL INST OF HLTH%';

UPDATE work.PedsAwards SET Industry=0;
UPDATE work.PedsAwards SET Industry=1 WHERE CLK_AWD_PRIME_SPONSOR_CAT ='Corporations/CompanyForProfit'
                                         OR REPORTING_SPONSOR_CAT='Corporations/CompanyForProfit' ;


UPDATE  work.PedsAwards SET PI_Classify=NULL;

UPDATE work.PedsAwards SET 	PedsPI=0,
							PedsContPI=0,
                            ContEQProj=0;
                            
UPDATE work.PedsAwards SET PedsPI=1 WHERE CLK_PI_UFID IN (select distinct Employee_ID from  work.PorchPeople) ;
UPDATE work.PedsAwards SET PedsContPI=1 WHERE CLK_AWD_PROJ_MGR_UFID IN (select distinct Employee_ID from  work.PorchPeople) ;
UPDATE work.PedsAwards SET ContEQProj=1 WHERE CLK_PI_UFID=CLK_AWD_PROJ_MGR_UFID;

UPDATE  work.PedsAwards SET PI_Classify="NOT PEDS CONT - PEDS PROJ" 
			WHERE 	CLK_AWD_PROJ_MGR_UFID  IN (select distinct Employee_ID from  work.PorchPeople)
			AND 	CLK_PI_UFID NOT IN (select distinct Employee_ID from  work.PorchPeople);
            
UPDATE  work.PedsAwards SET PI_Classify="PEDS CONT - NOT PEDS PROJ" 
			WHERE CLK_PI_UFID IN (select distinct Employee_ID from  work.PorchPeople)
            AND CLK_AWD_PROJ_MGR_UFID  NOT IN (select distinct Employee_ID from  work.PorchPeople);                                                  ;

UPDATE  work.PedsAwards SET PI_Classify="PEDS CONT AND DIFF PEDS PROJ" 
			WHERE CLK_PI_UFID IN (select distinct Employee_ID from  work.PorchPeople)
            AND CLK_AWD_PROJ_MGR_UFID  IN (select distinct Employee_ID from  work.PorchPeople)
            AND CLK_PI_UFID<>CLK_AWD_PROJ_MGR_UFID;

UPDATE  work.PedsAwards SET PI_Classify="PEDS CONT = PEDS PROJ" 
			WHERE CLK_PI_UFID IN (select distinct Employee_ID from  work.PorchPeople)
            AND CLK_AWD_PROJ_MGR_UFID  IN (select distinct Employee_ID from  work.PorchPeople)
            AND CLK_PI_UFID=CLK_AWD_PROJ_MGR_UFID;

DROP TABLE IF EXISTS work.PorchOut;
create table work.PorchOut as
SELECT 	PI_Classify,
		count(*) as N,
		SUM(PedsPI) as PedsPI,
		SUM(PedsContPI) as PedsContPI,
		SUM(ContEQProj) as ContEQProj
from work.PedsAwards 
GROUP BY PI_Classify;




UPDATE work.PedsAwards 
set PORCH_PI=0,  
	PORCH_PROJ_PI=0,
    PorchINV=0;

UPDATE work.PedsAwards pa, work.porchSFYlu lu
SET pa.PORCH_PI=1
WHERE pa.CLK_PI_UFID=lu.Employee_ID
AND pa.SFY=lu.SFY;


UPDATE work.PedsAwards pa, work.porchSFYlu lu
SET pa.PORCH_PROJ_PI=1
WHERE pa.CLK_AWD_PROJ_MGR_UFID=lu.Employee_ID
AND pa.SFY=lu.SFY;

UPDATE work.PedsAwards 
SET PorchInv=1
WHERE (PORCH_PI+PORCH_PROJ_PI)>0;


DROP TABLE IF EXISTS work.PorchOut;
create table work.PorchOut as
SELECT 	SFY,
		"All Peds" as InvType,
		count(DISTINCT CLK_AWD_ID) as nAwards,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Total_AWARD,
		SUM(SPONSOR_AUTHORIZED_AMOUNT*NIH) as NIH_AWARD,
		SUM(SPONSOR_AUTHORIZED_AMOUNT*Industry) as INDUSTRY_AMT
FROM work.PedsAwards 
GROUP BY SFY, InvType
UNION ALL
SELECT 	SFY,
		"PORCH" as InvType,
		count(DISTINCT CLK_AWD_ID) as nAwards,
		SUM(SPONSOR_AUTHORIZED_AMOUNT*PorchInv) as Total_AWARD,
		SUM(SPONSOR_AUTHORIZED_AMOUNT*NIH*PorchInv) as NIH_AWARD,
		SUM(SPONSOR_AUTHORIZED_AMOUNT*Industry*PorchInv) as INDUSTRY_AMT
FROM work.PedsAwards 
WHERE PorchInv=1
GROUP BY SFY, InvType;

#############
## Create person Verification
drop table if exists work.porchcensus;
create table work.porchcensus as
select Employee_ID,
	   MAX(Name) as Name,
       MAX(FacType) as FacType
from  work.PorchPeople
group by Employee_ID;

###SELECT * FROM work.PorchPeople;

ALTER TABLE work.porchcensus
	ADD Peds_17_18 int(1),
	ADD Peds_18_19 int(1),	
	ADD Peds_19_20 int(1),
	ADD Peds_20_21 int(1),

	ADD PORCH_17_18 int(1),
	ADD PORCH_18_19 int(1),	
	ADD PORCH_19_20 int(1),
	ADD PORCH_20_21 int(1),
    
	ADD FUND_17_18 decimal(65,10),
	ADD FUND_18_19 decimal(65,10),	
	ADD FUND_19_20 decimal(65,10),
	ADD FUND_20_21 decimal(65,10);
    
UPDATE work.porchcensus
SET  Peds_17_18=0,
	Peds_18_19=0,	
	Peds_19_20=0,
	Peds_20_21=0,
	PORCH_17_18=0,
	PORCH_18_19=0,
	PORCH_19_20=0,
	PORCH_20_21=0,  
    FUND_17_18=0,
	FUND_18_19=0,
	FUND_19_20=0,
	FUND_20_21=0;
    
    

UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_17_18=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_18_19=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_19_20=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_20_21=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2020-2021';

UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_17_18=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2017-2018' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_18_19=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2018-2019' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_19_20=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2019-2020' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_20_21=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2020-2021' AND lu.Works_with_PoRCH=1;





#### ADD FUNDING REFERENCE TO porchcensus

## Create funding summary
drop table if exists work.sfyfund1;
create table work.sfyfund1 as
SELECT 	SFY,
		CLK_PI_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT - NOT PEDS PROJ',
					  'PEDS CONT = PEDS PROJ')
GROUP  BY SFY,UFID
UNION ALL
SELECT 	SFY,
		CLK_AWD_PROJ_MGR_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT AND DIFF PEDS PROJ',
					  'NOT PEDS CONT - PEDS PROJ')
GROUP  BY SFY, UFID;


drop table if exists work.sfyfund;
create table work.sfyfund as
SELECT 	SFY,
		UFID,
		SUM(Amount) as Amount
from work.sfyfund1       
GROUP  BY SFY, UFID;

UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_17_18=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_18_19=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_19_20=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_20_21=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2020-2021';

SELECT * from work.porchcensus;

