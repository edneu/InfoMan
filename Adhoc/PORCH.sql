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

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
## Create person Summary Table
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
	ADD FUND_20_21 decimal(65,10),
    
    ADD NIH_FUND_17_18 decimal(65,10),
	ADD NIH_FUND_18_19 decimal(65,10),	
	ADD NIH_FUND_19_20 decimal(65,10),
	ADD NIH_FUND_20_21 decimal(65,10),
    
    ADD IND_FUND_17_18 decimal(65,10),
	ADD IND_FUND_18_19 decimal(65,10),	
	ADD IND_FUND_19_20 decimal(65,10),
	ADD IND_FUND_20_21 decimal(65,10),
 
	ADD nPropSub_1718 int(5),
	ADD nPropSub_1819 int(5),
	ADD nPropSub_1920 int(5),
	ADD nPropSub_2021 int(5),

	ADD nPropAwd_1718 int(5),
	ADD nPropAwd_1819 int(5),
	ADD nPropAwd_1920 int(5),
	ADD nPropAwd_2021 int(5),
  
	ADD amtPropSub_1718 decimal(12,2),
	ADD amtPropSub_1819 decimal(12,2),
	ADD amtPropSub_1920 decimal(12,2),
	ADD amtPropSub_2021 decimal(12,2),

	ADD amtPropAwd_1718 decimal(12,2),
	ADD amtPropAwd_1819 decimal(12,2),
	ADD amtPropAwd_1920 decimal(12,2),
	ADD amtPropAwd_2021 decimal(12,2),
  
	ADD nIRBappr_1718 int(5),
	ADD nIRBappr_1819 int(5),
	ADD nIRBappr_1920 int(5),
	ADD nIRBappr_2021 int(5);
  


 
 
 
 
SET SQL_SAFE_UPDATES = 0; 
 
UPDATE work.porchcensus
SET Peds_17_18=0,
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
	FUND_20_21=0,
    
    NIH_FUND_17_18=0,
	NIH_FUND_18_19=0,
	NIH_FUND_19_20=0,
	NIH_FUND_20_21=0,
    
    IND_FUND_17_18=0,
	IND_FUND_18_19=0,
	IND_FUND_19_20=0,
	IND_FUND_20_21=0,
    
    nPropSub_1718=0,
	nPropSub_1819=0,
	nPropSub_1920=0,
	nPropSub_2021=0,

	nPropAwd_1718=0,
	nPropAwd_1819=0,
	nPropAwd_1920=0,
	nPropAwd_2021=0,
  
	amtPropSub_1718=0,
	amtPropSub_1819=0,
	amtPropSub_1920=0,
	amtPropSub_2021=0,

	amtPropAwd_1718=0,
	amtPropAwd_1819=0,
	amtPropAwd_1920=0,
	amtPropAwd_2021=0,
    
    nIRBappr_1718=0,
	nIRBappr_1819=0,
	nIRBappr_1920=0,
	nIRBappr_2021=0;
    

UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_17_18=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_18_19=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_19_20=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc,  work.PorchPeople lu SET Peds_20_21=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2020-2021';

UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_17_18=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2017-2018' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_18_19=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2018-2019' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_19_20=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2019-2020' AND lu.Works_with_PoRCH=1;
UPDATE work.porchcensus pc,  work.PorchPeople lu SET PORCH_20_21=1 WHERE pc.Employee_ID=lu.Employee_ID and lu.SFY='SFY 2020-2021' AND lu.Works_with_PoRCH=1;


SELECT PI_CLASSIFY from work.PedsAwards;


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

########## NIH
drop table if exists work.sfyNIHfund1;
create table work.sfyNIHfund1 as
SELECT 	SFY,
		CLK_PI_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT - NOT PEDS PROJ',
					  'PEDS CONT = PEDS PROJ')
AND NIH=1                      
GROUP  BY SFY,UFID
UNION ALL
SELECT 	SFY,
		CLK_AWD_PROJ_MGR_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT AND DIFF PEDS PROJ',
					  'NOT PEDS CONT - PEDS PROJ')
AND NIH=1                         
GROUP  BY SFY, UFID;


drop table if exists work.sfyNIHfund;
create table work.sfyNIHfund as
SELECT 	SFY,
		UFID,
		SUM(Amount) as Amount
from work.sfyNIHfund1       
GROUP  BY SFY, UFID;

##########################################
#### INDUSTRY
drop table if exists work.sfyINDUSTRYfund1;
create table work.sfyINDUSTRYfund1 as
SELECT 	SFY,
		CLK_PI_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT - NOT PEDS PROJ',
					  'PEDS CONT = PEDS PROJ')
AND Industry=1                     
GROUP  BY SFY,UFID
UNION ALL
SELECT 	SFY,
		CLK_AWD_PROJ_MGR_UFID AS UFID,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) as Amount
from work.PedsAwards        
WHERE PI_Classify IN ('PEDS CONT AND DIFF PEDS PROJ',
					  'NOT PEDS CONT - PEDS PROJ')
AND Industry=1                       
GROUP  BY SFY, UFID;


drop table if exists work.sfyINDUSTRYfund;
create table work.sfyINDUSTRYfund as
SELECT 	SFY,
		UFID,
		SUM(Amount) as Amount
from work.sfyINDUSTRYfund1  
GROUP  BY SFY, UFID;









UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_17_18=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_18_19=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_19_20=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc, work.sfyfund lu SET FUND_20_21=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2020-2021';

UPDATE work.porchcensus pc, work.sfyNIHfund lu SET NIH_FUND_17_18=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc, work.sfyNIHfund lu SET NIH_FUND_18_19=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc, work.sfyNIHfund lu SET NIH_FUND_19_20=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc, work.sfyNIHfund lu SET NIH_FUND_20_21=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2020-2021';

UPDATE work.porchcensus pc, work.sfyINDUSTRYfund lu SET IND_FUND_17_18=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2017-2018';
UPDATE work.porchcensus pc, work.sfyINDUSTRYfund lu SET IND_FUND_18_19=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2018-2019';
UPDATE work.porchcensus pc, work.sfyINDUSTRYfund lu SET IND_FUND_19_20=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2019-2020';
UPDATE work.porchcensus pc, work.sfyINDUSTRYfund lu SET IND_FUND_20_21=lu.Amount WHERE pc.Employee_ID=lu.UFID and lu.SFY='SFY 2020-2021';


SELECT * from work.porchcensus;

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################

##### PROPOSAL DATA
select * from lookup.proposals;




### create workfile of proposal from PEDs employees
drop table if exists work.pedspropsals; 
create table work.pedspropsals as
select * from lookup.proposals
WHERE CLK_PI_UFID IN (Select DISTINCT Employee_ID from work.porchcensus)
AND CLK_PRO_DATE_SUBMITTED>=str_to_date('01,01,2017','%m,%d,%Y');


ALTER TABLE work.pedspropsals
  ADD UFID varchar(12),
  ADD SFY varchar(25),
  ADD PropStatus varchar(25);
  
UPDATE work.pedspropsals SET UFID=lpad(CLK_PI_UFID,8,'0');

UPDATE work.pedspropsals SET SFY ='SFY 2017-2018' WHERE CLK_PRO_DATE_SUBMITTED BETWEEN str_to_date('07,01,2017','%m,%d,%Y') and str_to_date('06,30,2018','%m,%d,%Y');
UPDATE work.pedspropsals SET SFY ='SFY 2018-2019' WHERE CLK_PRO_DATE_SUBMITTED BETWEEN str_to_date('07,01,2018','%m,%d,%Y') and str_to_date('06,30,2019','%m,%d,%Y');
UPDATE work.pedspropsals SET SFY ='SFY 2019-2020' WHERE CLK_PRO_DATE_SUBMITTED BETWEEN str_to_date('07,01,2019','%m,%d,%Y') and str_to_date('06,30,2020','%m,%d,%Y');
UPDATE work.pedspropsals SET SFY ='SFY 2020-2021' WHERE CLK_PRO_DATE_SUBMITTED BETWEEN str_to_date('07,01,2020','%m,%d,%Y') and str_to_date('06,30,2021','%m,%d,%Y');

UPDATE work.pedspropsals SET PropStatus="Awarded" WHERE CLK_CURRENTSTATE IN ("Awarded","Award Pending");
UPDATE work.pedspropsals SET PropStatus="Not Awarded" WHERE CLK_CURRENTSTATE IN ("Not Funded");
UPDATE work.pedspropsals SET PropStatus="In Review" WHERE CLK_CURRENTSTATE IN ('Pending Sponsor Review','NOT USED - Pending Post Submission Response');
UPDATE work.pedspropsals SET PropStatus="Withdrawn" WHERE CLK_CURRENTSTATE IN ('Withdrawn','Terminated','Not Invited');

DELETE FROM work.pedspropsals WHERE CLK_CURRENTSTATE IS NULL;
DELETE FROM work.pedspropsals WHERE SFY IS NULL;




drop table if exists work.pedsPropsalsSumm; 
create table work.pedsPropsalsSumm as
select 	SFY,
		UFID,
        PropStatus,
        COUNT(DISTINCT CLK_PROPOSAL_ID) as nProposals,
        SUM(CLK_GRAND_TOTAL) as Amount
from work.pedspropsals
GROUP BY SFY, UFID, PropStatus;  

##############################################################   

#SUBMITTED	   	
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropSub_1718=lu.nProposals,
           pc.amtPropSub_1718=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       and lu.SFY='SFY 2017-2018' ;   
       
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropSub_1819=lu.nProposals,
           pc.amtPropSub_1819=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       and lu.SFY='SFY 2018-2019' ;   
       
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropSub_1920=lu.nProposals,
           pc.amtPropSub_1920=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       and lu.SFY='SFY 2019-2020' ;          
       
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropSub_2021=lu.nProposals,
           pc.amtPropSub_2021=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       and lu.SFY='SFY 2020-2021' ;          

# AWARDED
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropAwd_1718=lu.nProposals,
           pc.amtPropAwd_1718=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       AND lu.PropStatus="Awarded" 
       and lu.SFY='SFY 2017-2018'   ;

UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropAwd_1819=lu.nProposals,
           pc.amtPropAwd_1819=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       AND lu.PropStatus="Awarded" 
       and lu.SFY='SFY 2018-2019'   ;
       
UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropAwd_1920=lu.nProposals,
           pc.amtPropAwd_1920=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       AND lu.PropStatus="Awarded" 
       and lu.SFY='SFY 2019-2020'   ;

UPDATE work.porchcensus pc, work.pedsPropsalsSumm lu 
	   SET pc.nPropAwd_2021=lu.nProposals,
           pc.amtPropAwd_2021=lu.Amount
       WHERE pc.Employee_ID=lu.UFID 
       AND lu.PropStatus="Awarded" 
       and lu.SFY='SFY 2020-2021'   ;       

################################################################

#########################################################################
#########################################################################
#########################################################################
#########################################################################
### IRB

select * from lookup.myirb;

SET SQL_SAFE_UPDATES = 0;
UPDATE lookup.myirb SET PI_UFID=lpad(PI_UFID,8,'0');

DROP TABLE IF EXISTS work.irb;
CREATE TABLE work.irb as
SELECT * from lookup.myirb;
 

ALTER TABLE work.irb ADD SFY varchar(25);

SET SQL_SAFE_UPDATES = 0;  
UPDATE work.irb SET SFY ='SFY 2017-2018' WHERE Date_Originally_Approved BETWEEN str_to_date('07,01,2017','%m,%d,%Y') and str_to_date('06,30,2018','%m,%d,%Y');
UPDATE work.irb SET SFY ='SFY 2018-2019' WHERE Date_Originally_Approved BETWEEN str_to_date('07,01,2018','%m,%d,%Y') and str_to_date('06,30,2019','%m,%d,%Y');
UPDATE work.irb SET SFY ='SFY 2019-2020' WHERE Date_Originally_Approved BETWEEN str_to_date('07,01,2019','%m,%d,%Y') and str_to_date('06,30,2020','%m,%d,%Y');
UPDATE work.irb SET SFY ='SFY 2020-2021' WHERE Date_Originally_Approved BETWEEN str_to_date('07,01,2020','%m,%d,%Y') and str_to_date('06,30,2021','%m,%d,%Y');

DELETE from work.irb where SFY is NULL;

drop table if Exists work.irb_summ;
CREATE TABLE work.irb_summ as
SELECT SFY,PI_UFID,COUNT(DISTINCT ID) as nIRB from work.irb group by SFY,PI_UFID ;

UPDATE work.porchcensus pc, work.irb_summ lu 
	   SET pc.nIRBappr_1718=lu.nIRB
       WHERE pc.Employee_ID=lu.PI_UFID 
       and lu.SFY='SFY 2017-2018'   ;
       
UPDATE work.porchcensus pc, work.irb_summ lu 
	   SET pc.nIRBappr_1819=lu.nIRB
       WHERE pc.Employee_ID=lu.PI_UFID 
       and lu.SFY='SFY 2018-2019'   ;

UPDATE work.porchcensus pc, work.irb_summ lu 
	   SET pc.nIRBappr_1920=lu.nIRB
       WHERE pc.Employee_ID=lu.PI_UFID 
       and lu.SFY='SFY 2019-2020'   ;
       
UPDATE work.porchcensus pc, work.irb_summ lu 
	   SET pc.nIRBappr_2021=lu.nIRB
       WHERE pc.Employee_ID=lu.PI_UFID 
       and lu.SFY='SFY 2020-2021'   ;    
       
       
#####################################################       
SELECT * from work.porchcensus;

DROP TABLE IF EXISTS work.porchfactypeagg;
CREATE TABLE work.porchfactypeagg as
SELECT FacType,
     Sum(Peds_17_18) AS Peds_17_18,
     Sum(Peds_18_19) AS Peds_18_19,
     Sum(Peds_19_20) AS Peds_19_20,
     Sum(Peds_20_21) AS Peds_20_21,
     Sum(PORCH_17_18) AS PORCH_17_18,
     Sum(PORCH_18_19) AS PORCH_18_19,
     Sum(PORCH_19_20) AS PORCH_19_20,
     Sum(PORCH_20_21) AS PORCH_20_21,
     Sum(FUND_17_18) AS FUND_17_18,
     Sum(FUND_18_19) AS FUND_18_19,
     Sum(FUND_19_20) AS FUND_19_20,
     Sum(FUND_20_21) AS FUND_20_21,
     Sum(NIH_FUND_17_18) AS NIH_FUND_17_18,
     Sum(NIH_FUND_18_19) AS NIH_FUND_18_19,
     Sum(NIH_FUND_19_20) AS NIH_FUND_19_20,
     Sum(NIH_FUND_20_21) AS NIH_FUND_20_21,
     Sum(IND_FUND_17_18) AS IND_FUND_17_18,
     Sum(IND_FUND_18_19) AS IND_FUND_18_19,
     Sum(IND_FUND_19_20) AS IND_FUND_19_20,
     Sum(IND_FUND_20_21) AS IND_FUND_20_21,
     Sum(nPropSub_1718) AS nPropSub_1718,
     Sum(nPropSub_1819) AS nPropSub_1819,
     Sum(nPropSub_1920) AS nPropSub_1920,
     Sum(nPropSub_2021) AS nPropSub_2021,
     Sum(nPropAwd_1718) AS nPropAwd_1718,
     Sum(nPropAwd_1819) AS nPropAwd_1819,
     Sum(nPropAwd_1920) AS nPropAwd_1920,
     Sum(nPropAwd_2021) AS nPropAwd_2021,
     Sum(amtPropSub_1718) AS amtPropSub_1718,
     Sum(amtPropSub_1819) AS amtPropSub_1819,
     Sum(amtPropSub_1920) AS amtPropSub_1920,
     Sum(amtPropSub_2021) AS amtPropSub_2021,
     Sum(amtPropAwd_1718) AS amtPropAwd_1718,
     Sum(amtPropAwd_1819) AS amtPropAwd_1819,
     Sum(amtPropAwd_1920) AS amtPropAwd_1920,
     Sum(amtPropAwd_2021) AS amtPropAwd_2021,
     Sum(nIRBappr_1718) AS nIRBappr_1718,
     Sum(nIRBappr_1819) AS nIRBappr_1819,
     Sum(nIRBappr_1920) AS nIRBappr_1920,
     Sum(nIRBappr_2021) AS nIRBappr_2021
  
from work.porchcensus
GROUP BY FacType ;


DROP TABLE IF EXISTS work.porchwork;
CREATE TABLE work.porchwork as
SELECT "Faculty" as Type,
     Sum(Peds_17_18) AS Peds_17_18,
     Sum(Peds_18_19) AS Peds_18_19,
     Sum(Peds_19_20) AS Peds_19_20,
     Sum(Peds_20_21) AS Peds_20_21,
     Sum(PORCH_17_18) AS PORCH_17_18,
     Sum(PORCH_18_19) AS PORCH_18_19,
     Sum(PORCH_19_20) AS PORCH_19_20,
     Sum(PORCH_20_21) AS PORCH_20_21,
     Sum(FUND_17_18) AS FUND_17_18,
     Sum(FUND_18_19) AS FUND_18_19,
     Sum(FUND_19_20) AS FUND_19_20,
     Sum(FUND_20_21) AS FUND_20_21
FROM  work.porchcensus   
WHERE FacType IN ('Assistant Professor','Associate Professor','Professor')
GROUP BY "Faculty"
UNION ALL 
SELECT FacType as Type,
     Sum(Peds_17_18) AS Peds_17_18,
     Sum(Peds_18_19) AS Peds_18_19,
     Sum(Peds_19_20) AS Peds_19_20,
     Sum(Peds_20_21) AS Peds_20_21,
     Sum(PORCH_17_18) AS PORCH_17_18,
     Sum(PORCH_18_19) AS PORCH_18_19,
     Sum(PORCH_19_20) AS PORCH_19_20,
     Sum(PORCH_20_21) AS PORCH_20_21,
     Sum(FUND_17_18) AS FUND_17_18,
     Sum(FUND_18_19) AS FUND_18_19,
     Sum(FUND_19_20) AS FUND_19_20,
     Sum(FUND_20_21) AS FUND_20_21
FROM  work.porchcensus   
WHERE FacType NOT IN ('Assistant Professor','Associate Professor','Professor')
GROUP BY FacType;



DROP TABLE IF EXISTS work.porchwork;
CREATE TABLE work.porchwork as
SELECT
     Sum(FUND_17_18) AS FUND_17_18,
     Sum(FUND_18_19) AS FUND_18_19,
     Sum(FUND_19_20) AS FUND_19_20,
     Sum(FUND_20_21) AS FUND_20_21,
     
     Sum(NIH_FUND_17_18) AS NIH_FUND_17_18,
     Sum(NIH_FUND_18_19) AS NIH_FUND_18_19,
     Sum(NIH_FUND_19_20) AS NIH_FUND_19_20,
     Sum(NIH_FUND_20_21) AS NIH_FUND_20_21,
     
     Sum(IND_FUND_17_18) AS IND_FUND_17_18,
     Sum(IND_FUND_18_19) AS IND_FUND_18_19,
     Sum(IND_FUND_19_20) AS IND_FUND_19_20,
     Sum(IND_FUND_20_21) AS IND_FUND_20_21,

     Sum(FUND_17_18*PORCH_17_18) AS PRCH_FUND_17_18,
     Sum(FUND_18_19*PORCH_18_19) AS PRCH_FUND_18_19,
     Sum(FUND_19_20*PORCH_19_20) AS PRCH_FUND_19_20,
     Sum(FUND_20_21*PORCH_20_21) AS PRCH_FUND_20_21,
     
     Sum(NIH_FUND_17_18*PORCH_17_18) AS PRCH_NIH_FUND_17_18,
     Sum(NIH_FUND_18_19*PORCH_18_19) AS PRCH_NIH_FUND_18_19,
     Sum(NIH_FUND_19_20*PORCH_19_20) AS PRCH_NIH_FUND_19_20,
     Sum(NIH_FUND_20_21*PORCH_20_21) AS PRCH_NIH_FUND_20_21,
     
     Sum(IND_FUND_17_18*PORCH_17_18) AS PRCH_IND_FUND_17_18,
     Sum(IND_FUND_18_19*PORCH_18_19) AS PRCH_IND_FUND_18_19,
     Sum(IND_FUND_19_20*PORCH_19_20) AS PRCH_IND_FUND_19_20,
     Sum(IND_FUND_20_21*PORCH_20_21) AS PRCH_IND_FUND_20_21

FROM  work.porchcensus   ;
  
  
  select sum(PORCH_17_18),
  #######################################################
  DROP TABLE IF EXISTS work.PorchRecon;
  create table work.PorchRecon AS
  select * from work.new_peds_emp;
  

  select count(*) as N, count(distinct Employee_ID) as nUFID, count(distinct Name) as nName from  work.PorchRecon;
  
  
  select * from lookup.ufids where UF_UFID="58293959";
  
  drop table if exists work.temp;
  create table work.temp as 
  select Employee_ID,Name from work.emp_assn_peds group by Employee_ID,Name;
  
  select count(*) as N, count(distinct Employee_ID) as nUFID, count(distinct Name) as nName from  work.PorchRecon;
  
    select Employee_ID, Name, COUNT(*) as nRECS from  work.PorchRecon  group by Employee_ID, Name;
    
    
SELECT * from work.PorchRecon WHERE Employee_ID IN     
('53264799',
'55713888',
'62593021',
'83481523');
 
 ######################################################### 
 ######################################################### 
 ######################################################### 
 ######################################################### 
 ######################################################### 
  DROP TABLE IF EXISTS work.PedsEmptemp;
  create table work.PedsEmptemp AS
  select  Employee_ID AS UFID,
		  max(NAME) as Name
  from work.PorchRecon
  GROUP BY Employee_ID
  UNION ALL 
  select  Employee_ID AS UFID,
		  max(NAME) as Name
  from  work.porchcensus 
  GROUP BY Employee_ID;
  
  DROP TABLE IF EXISTS work.PedsEmp;
  create table work.PedsEmp AS
  select  UFID,
		  max(NAME) as Name
  from  work.PedsEmptemp
  GROUP BY UFID
  ORDER BY UFID;
   
  ##############################################################
ALTER TABLE work.PedsEmp
  ADD ORIG_HIRE_DT datetime,
  ADD Hire_Month int(11),
  ADD EMAIL_ADDR varchar(45),
  ADD Salary_Admin_Plan_Code varchar(5),
  ADD Salary_Admin_Plan varchar(45),
  ADD DEPTID varchar(12),
  ADD DESCR varchar(45),
  ADD FIELDVALUE varchar(5),

  ADD FacType varchar(25),
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
  ADD FUND_20_21 decimal(65,10),
  ADD NIH_FUND_17_18 decimal(65,10),
  ADD NIH_FUND_18_19 decimal(65,10),
  ADD NIH_FUND_19_20 decimal(65,10),
  ADD NIH_FUND_20_21 decimal(65,10),
  ADD IND_FUND_17_18 decimal(65,10),
  ADD IND_FUND_18_19 decimal(65,10),
  ADD IND_FUND_19_20 decimal(65,10),
  ADD IND_FUND_20_21 decimal(65,10),
  ADD nPropSub_1718 int(5),
  ADD nPropSub_1819 int(5),
  ADD nPropSub_1920 int(5),
  ADD nPropSub_2021 int(5),
  ADD nPropAwd_1718 int(5),
  ADD nPropAwd_1819 int(5),
  ADD nPropAwd_1920 int(5),
  ADD nPropAwd_2021 int(5),
  ADD amtPropSub_1718 decimal(12,2),
  ADD amtPropSub_1819 decimal(12,2),
  ADD amtPropSub_1920 decimal(12,2),
  ADD amtPropSub_2021 decimal(12,2),
  ADD amtPropAwd_1718 decimal(12,2),
  ADD amtPropAwd_1819 decimal(12,2),
  ADD amtPropAwd_1920 decimal(12,2),
  ADD amtPropAwd_2021 decimal(12,2),
  ADD nIRBappr_1718 int(5),
  ADD nIRBappr_1819 int(5),
  ADD nIRBappr_1920 int(5),
  ADD nIRBappr_2021 int(5);
  

SET SQL_SAFE_UPDATES = 0;

     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.ORIG_HIRE_DT=pr.ORIG_HIRE_DT WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.Hire_Month=pr.Hire_Month WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.EMAIL_ADDR=pr.EMAIL_ADDR WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.Salary_Admin_Plan_Code=pr.Salary_Admin_Plan_Code WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.Salary_Admin_Plan=pr.Salary_Admin_Plan WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.DEPTID=pr.DEPTID WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.DESCR=pr.DESCR WHERE pe.UFID=pr.Employee_ID;
     UPDATE work.PedsEmp pe, work.PorchRecon pr SET pe.FIELDVALUE=pr.FIELDVALUE WHERE pe.UFID=pr.Employee_ID;


     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.FacType=pc.FacType WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.Peds_17_18=pc.Peds_17_18 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.Peds_18_19=pc.Peds_18_19 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.Peds_19_20=pc.Peds_19_20 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.Peds_20_21=pc.Peds_20_21 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.PORCH_17_18=pc.PORCH_17_18 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.PORCH_18_19=pc.PORCH_18_19 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.PORCH_19_20=pc.PORCH_19_20 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.PORCH_20_21=pc.PORCH_20_21 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.FUND_17_18=pc.FUND_17_18 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.FUND_18_19=pc.FUND_18_19 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.FUND_19_20=pc.FUND_19_20 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.FUND_20_21=pc.FUND_20_21 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.NIH_FUND_17_18=pc.NIH_FUND_17_18 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.NIH_FUND_18_19=pc.NIH_FUND_18_19 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.NIH_FUND_19_20=pc.NIH_FUND_19_20 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.NIH_FUND_20_21=pc.NIH_FUND_20_21 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.IND_FUND_17_18=pc.IND_FUND_17_18 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.IND_FUND_18_19=pc.IND_FUND_18_19 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.IND_FUND_19_20=pc.IND_FUND_19_20 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.IND_FUND_20_21=pc.IND_FUND_20_21 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropSub_1718=pc.nPropSub_1718 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropSub_1819=pc.nPropSub_1819 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropSub_1920=pc.nPropSub_1920 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropSub_2021=pc.nPropSub_2021 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropAwd_1718=pc.nPropAwd_1718 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropAwd_1819=pc.nPropAwd_1819 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropAwd_1920=pc.nPropAwd_1920 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nPropAwd_2021=pc.nPropAwd_2021 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropSub_1718=pc.amtPropSub_1718 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropSub_1819=pc.amtPropSub_1819 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropSub_1920=pc.amtPropSub_1920 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropSub_2021=pc.amtPropSub_2021 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropAwd_1718=pc.amtPropAwd_1718 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropAwd_1819=pc.amtPropAwd_1819 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropAwd_1920=pc.amtPropAwd_1920 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.amtPropAwd_2021=pc.amtPropAwd_2021 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nIRBappr_1718=pc.nIRBappr_1718 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nIRBappr_1819=pc.nIRBappr_1819 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nIRBappr_1920=pc.nIRBappr_1920 WHERE pe.UFID=pc.Employee_ID;
     UPDATE work.PedsEmp pe, work.porchcensus  pc SET pe.nIRBappr_2021=pc.nIRBappr_2021 WHERE pe.UFID=pc.Employee_ID;

select * from work.PedsEmp; 

#############################################################
  
  