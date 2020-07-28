######################################################################################################
######################################################################################################
#### CREATE WORK TABLES   ############################################################################
######################################################################################################



Drop table if exists space.salaryraw;
create table space.salaryraw AS
select * from space.salary2020;


drop table if exists space.allocate;
create table space.allocate as
select *
from space.ctrb_alloc_2020;

drop table if exists space.occ;
create table space.occ as
select *
from space.ctrb_occs_2020;

DROP TABLE IF EXISTS work.BondMasterTest;
CREATE TABLE work.BondMasterTest As
SELECT * from space.bondmaster;

######################################################################################################
######################################################################################################
#### SALARY TABLE WITH FUNDCODE CLASSIFICATIONs ######################################################
######################################################################################################

### VERIFY FUNDCODES ARE MAPPED

SELECT DISTINCT Fund_Code FROM space.salaryraw
WHERE Fund_Code NOT IN (SELECT Distinct FundCode from lookup.fundcodes);

####






DROP TABLE if exists space.salary;
CREATE TABLE space.salary AS
SELECT 	sal.Person_ID AS UFID,
		sal.Person_Name AS PersonName,
		sal.Fund_Code AS FundCode,
         fc.Description AS FundDesc,
         fc.BondFundClass, 
		sal.Earnings AS SalaryRaw,
		sal.Fringe_Rate AS FringeRateRaw,
		sal.Estimated_Fringe AS FringeAmtRaw,
		sal.Pay_end_date AS PayEndDate
FROM space.salaryraw sal
LEFT JOIN lookup.fundcodes fc
       ON sal.Fund_Code=fc.FundCode;
;
##########

DROP TABLE IF EXISTS space.salary_adj;
CREATE TABLE space.salary_adj AS
SELECT "BY2016" as BondYear, max(PayEndDate) as LastDate, str_to_date('06,30,2016','%m,%d,%Y') AS BY_End  from space.Salary2016
UNION ALL
SELECT "BY2017" as BondYear, max(Pay_end_date) as LastDate, str_to_date('06,30,2017','%m,%d,%Y') AS BY_End  from space.salary2017
UNION ALL
SELECT "BY2018" as BondYear, max(Pay_end_date) as LastDate, str_to_date('06,30,2018','%m,%d,%Y') AS BY_End  from space.salary2018
UNION ALL
SELECT "BY2019" as BondYear, max(Pay_end_date) as LastDate, str_to_date('06,30,2019','%m,%d,%Y') AS BY_End  from space.salary2019
UNION ALL
SELECT "BY2020" as BondYear, max(Pay_end_date) as LastDate, str_to_date('06,30,2020','%m,%d,%Y') AS BY_End  from space.salary2020;

Alter table space.salary_adj
ADD MissDay INT(5),
ADD AdjFac decimal(65,11);


SET SQL_SAFE_UPDATES = 0;

UPDATE space.salary_adj SET MissDay=ABS(datediff(LastDate,BY_End));
UPDATE space.salary_adj SET AdjFac=1+(MissDay/365.25);

SELECT * from space.salary_adj;

#############################################################################################################

ALTER TABLE space.salary
      ADD Salary decimal(20,2),
      ADD Fringe decimal(20,2),
      ADD SalFringe  decimal(20,2),
      ADD KeepFund integer(1),
      ADD GoodMask integer(1),
      ADD BadMask integer(1);


## 2019 VALUES

UPDATE space.salary
       SET Salary=SalaryRaw*1.05201916400,      
           Fringe=FringeAmtRaw*1.05201916400,
           SalFringe=(SalaryRaw+FringeAmtRaw)*1.05201916400,
           KeepFund=1,
           GoodMask=0,
	       BadMask=0;

UPDATE space.salary
       SET KeepFund=0
       WHERE BondFundClass="REMOVE";

UPDATE space.salary
       SET GoodMask=1
       WHERE BondFundClass="GOOD";

UPDATE space.salary
       SET BadMask=1
       WHERE BondFundClass="BAD";

######################################################################################################
######################################################################################################
#### COLONY LISTS ####################################################################################
######################################################################################################
DROP TABLE space.colonylistdept;
create table space.colonylistdept AS
Select dp.DEPTID,
       dp.Department,
	   Sum(al.Area) as Area
  FROM space.ctrb_alloc_2019 al 
  LEFT JOIN  lookup.depts dp
  ON al.DEPTID=dp.DEPTID
  WHERE al.DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000')
GROUP BY dp.DEPTID,dp.Department
ORDER BY Sum(al.Area) DESC;


### Aggregate by Department Name
drop table if exists space.colonylist;
create table space.colonylist AS
SELECT Department,
       sum(Area) AS AREA
from space.colonylistdept
WHERE DEPTID IS NOT NULL
GROUP BY Department;

ALTER TABLE space.colonylist ADD PctArea Float(12,4);
ALTER TABLE space.colonylist ADD OccType VarChar(12);
ALTER TABLE space.colonylist ADD Zone varchar(12);


SELECT SUM(Area) from space.colonylist;
 
UPDATE space.colonylist SET PctArea=Area/37805.7115;

UPDATE space.colonylist 
	SET OccType="Minor",
		Zone="BLUE2" ;

UPDATE space.colonylist 
		SET OccType="Major", 
        ZONE="BLUE1"
       where PctArea>=.13;   ## WAS .10 in Bond Specifications but Altered to Include HOBI in Blue2

SELECT * from space.colonylist ORDER BY PctArea DESC;



ALTER TABLE space.colonylistdept ADD Zone varchar(12);

UPDATE space.colonylistdept SET ZONE="";

UPDATE space.colonylistdept cld, space.colonylist lu
SET cld.Zone=lu.Zone
WHERE cld.Department=lu.Department;


SELECT * FROM space.colonylistdept ORDER BY Area DESC;




######################################################################################################
######################################################################################################
######################################################################################################
######################################################################################################
## Join the Occupants and Allocation Tables, removing the persons covered in the RED ZONE.
######################################################################################################
drop table if exists space.Blue2Master;
create table  space.Blue2Master as
Select occ.ROOM as Room,
       occ.ROOM_USE,
	   occ.DEPTID as DeptID,
       occ.DEPT_NAME as Department,
       occ.UFID,
       occ.NAME as Occupant_name,
       occ.DESCR as Occuppant_Desc,
       DR_11,
       OSA_17,
	   (DR_11+OSA_17) AS RschPct,
       TOTAL_00-(DR_11+OSA_17) AS NonRschPct
from space.occ occ
     JOIN space.allocate al
     ON occ.ROOM=al.ROOM
WHERE occ.UFID NOT IN (SELECT DISTINCT AWARD_INV_UFID from work.BondMasterTest)
AND  occ.DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000')
AND  occ.DEPTID in (SELECT DISTINCT DEPTID FROM space.colonylistdept WHERE Zone="Blue2")
AND   al.DEPTID in (SELECT DISTINCT DEPTID FROM space.colonylistdept WHERE Zone="Blue2");

select  * from space.Blue2Master;



######################################################################################################
######################################################################################################
######################################################################################################
######################################################################################################
##  CREATE SALARY FILE FOR BLUE2
######################################################################################################


DROP TABLE if exists space.blue2Salary;
CREATE TABLE space.blue2Salary AS
SELECT 	UFID,
		PersonName,
        SUM(Salary) as TotalSalary,
        SUM(Fringe) as TotalFringe,
        SUM(Salary+Fringe) AS TotalSalFringe,
        
        SUM(Salary*KeepFund) AS BondSalary,
        SUM(Fringe*KeepFund) AS BondFringe,
        SUM(SalFringe*KeepFund) AS BondSalFringe,

        SUM(Salary*KeepFund*GoodMask) AS GoodSalary,
        SUM(Fringe*KeepFund*GoodMask) AS GoodFringe,
        SUM(SalFringe*KeepFund*GoodMask) AS GoodSalFringe,

        SUM(Salary*KeepFund*BadMask) AS BadSalary,
        SUM(Fringe*KeepFund*BadMask) AS BadFringe,
        SUM(SalFringe*KeepFund*BadMask) AS BadSalFringe
FROM space.salary
WHERE UFID<>""
AND UFID IN (select Distinct UFID from space.Blue2Master)
GROUP BY UFID, PersonName;

select * from space.blue2Salary ;

#######################

DROP TABLE if exists space.lookupRschPct;
CREATE TABLE space.lookupRschPct AS
SELECT UFID,
       SUM(RschPct) AS RschPct,
       SUM(NonRschPct) AS NonRschPct,
       max(1) as InBlueZone2
FROM space.Blue2Master
WHERE UFID<>""
GROUP BY UFID;


## select * from space.lookupRschPct;

ALTER TABLE space.blue2Salary 
     ADD RschPct Decimal(10,2),
     ADD NonRschPct Decimal(10,2),
     ADD InBlueZone2 int(1); 


UPDATE space.blue2Salary b2s, space.lookupRschPct rp
		SET b2s.RschPct=0,
            b2s.NonRschPct=0,
            b2s.InBlueZone2=0;           ;


UPDATE space.blue2Salary b2s, space.lookupRschPct rp
		SET b2s.RschPct=(rp.RschPct),
			b2s.NonRschPct=(rp.NonRschPct),
            b2s.InBlueZone2=rp.InBlueZone2
WHERE b2s.UFID=rp.UFID;


#####################################################################################################
#####################################################################################################
## Blue zone 2 Summary Table

DROP TABLE if exists space.Blue2Summary;
CREATE TABLE space.Blue2Summary AS
Select "Good" as FundType,
       SUM(GoodSalary*(RschPct*.01)) AS Salary_Paid,
	   SUM(GoodFringe*(RschPct*.01)) AS Fringe_Paid,
       SUM(GoodSalFringe*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Good"
UNION ALL
Select "Bad" as FundType,
       SUM(BadSalary*(RschPct*.01)) AS Salary_Paid,
	   SUM(BadFringe*(RschPct*.01)) AS Fringe_Paid,
       SUM(BadSalFringe*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Bad"
UNION ALL
Select "Total" as FundType,
       SUM((GoodSalary+BadSalary)*(RschPct*.01)) AS Salary_Paid,
	   SUM((GoodFringe+BadSalary)*(RschPct*.01))  AS Fringe_Paid,
       SUM((GoodSalFringe+BadSalary)*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Total"
UNION ALL
Select "Numerator" as FundType,
       SUM(GoodSalary*(RschPct*.01)) AS Salary_Paid,
	   SUM(GoodFringe*(RschPct*.01)) AS Fringe_Paid,
       SUM(GoodSalFringe*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Numerator"
UNION ALL
Select "Denominator" as FundType,
       SUM((GoodSalary+BadSalary)*(RschPct*.01)) AS Salary_Paid,
	   SUM((GoodFringe+BadSalary)*(RschPct*.01))  AS Fringe_Paid,
       SUM((GoodSalFringe+BadSalary)*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Denominator"
UNION ALL
Select "Total Research Revenue" as FundType,
       SUM(BondSalary) AS Salary_Paid,
	   SUM(BondFringe) AS Fringe_Paid,
       SUM(BondSalFringe) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Total Research Revenue";


select * from space.Blue2Summary;



#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################
#####################################################################################################

