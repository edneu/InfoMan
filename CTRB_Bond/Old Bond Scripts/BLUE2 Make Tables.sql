/* 
This code creates the tables for BOnd Certification Blue Zone 2 
Required Files     	ctrb_alloc_YYYY file from Jody Chase at UF Planning and Construction
					salary_YYYY from Enterprise REporting Query (Bryan Cooke Contact)
                    ctrb_occ_YYYY from Jody Chase at UF Planning and Construction (occupants of each room)



*/
#####################################################################################################
##### Supporting Tables
#####################################################################################################
## Create file to request Salary data from Enterprise Reporting (excludes Institute on Aging)
drop table if exists space.sal_rqst;
create table space.sal_rqst as 
select UFID, NAME 
from space.ctrb_occ_2017
WHERE DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000')
group by UFID, NAME
order by UFID, NAME;

## Use space.sal_rqst to request salry Data from Bryan Cooke  REQUESTED 6/05/2017
##################################################################################################
##################################################################################################
##################################################################################################
## MAKE LIST TO DEFINE COLONIES (Classify Departments as Major and Monor tenants of the CTRB 
## Major Tenants=BlueZone1
## Minor Tenants=B
##################################################################################################
DROP TABLE space.colonylistdept;
create table space.colonylistdept AS
Select dp.DEPTID,
       dp.Department,
	   Sum(al.Area) as Area
  FROM space.ctrb_alloc_2017 al 
  LEFT JOIN  lookup.depts dp
  ON al.DEPTID=dp.DEPTID
GROUP BY dp.DEPTID,dp.Department
ORDER BY Sum(al.Area) DESC;

select * from space.colonylistdept;
### REMOVE AGING
SET SQL_SAFE_UPDATES = 0;
DELETE FROM space.colonylistdept where DEPTID IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');
SET SQL_SAFE_UPDATES = 1;

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

## VERIFY DEPARTMENTS
##select * from space.colonylist;

## Use for Total Area (should be the same each year)
## select sum(area) from space.colonylist;

SET SQL_SAFE_UPDATES = 0;



select distinct Department from space.colonylist;

 
UPDATE space.colonylist SET PctArea=Area/37435.4925;

UPDATE space.colonylist SET OccType="Minor";
UPDATE space.colonylist SET OccType="Major" 
       where PctArea>=.1;


UPDATE space.colonylist SET Zone="Blue2";

UPDATE space.colonylist SET Zone="Blue1" WHERE OccType="Major"
AND  Department <>"MD-HEALTH OUTCOMES AND POLICY";


ALTER TABLE space.colonylistdept ADD OccType VarChar(12),
                                 ADD Zone varchar(12);

UPDATE space.colonylistdept SET OccType="Minor";
UPDATE space.colonylistdept 
  SET OccType="Major" 
       where Department IN (SELECT DISTINCT Department from space.colonylist WHERE OccType="Major"); 

UPDATE space.colonylistdept SET Zone="Blue2";

UPDATE space.colonylistdept 
  SET Zone="Blue1" 
       where Department IN (SELECT DISTINCT Department from space.colonylist WHERE Zone="Blue1"); 




SET SQL_SAFE_UPDATES = 1;


select * from space.colonylist order by  PctArea DESC;

######


#######################################################################################################################
## END OF SUPPORTING TABLES ###########################################################################################
#######################################################################################################################

#######################################################################################################################
### Create Blue2 Tables ###############################################################################################
#######################################################################################################################

### CREATE WORK TABLES


Drop table if exists space.salaryraw;
create table space.salaryraw AS
select * from space.salary2017;

## Create Working Allocatrion file Containing only the "Minor" departments in the CTRB

drop table if exists space.allocate;
create table space.allocate as
select *
from space.ctrb_alloc_2017
WHERE DEPTID IN (SELECT DISTINCT DEPTID FROM space.colonylistdept WHERE Zone="Blue2");


drop table if exists space.occ;
create table space.occ as
select *
from space.ctrb_occ_2017
WHERE DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');

## ADD Missing Department Name (DeptName) to Allocation Table  (IF NEEDED)

/*
## CHECK IF NEEDED
##select distinct DEPT_NAME  from space.allocate;

SET SQL_SAFE_UPDATES = 0;

UPDATE space.allocate al, lookup.depts dp
SET al.DEPT_NAME=dp.DeptName
WHERE al.DEPTID=dp.DEPTID
AND al.DEPT_NAME="";

select distinct DEPT_NAME   from space.allocate;
*/
# FUNDCODE TABLE
DROP TABLE space.Blue2FundList ;
CREATE TABLE space.Blue2FundList AS
SELECT FundCode,
       Description,
       BondFundClass
FROM lookup.fundcodes
WHERE FundCode in (select distinct FundCode from space.salary)
ORDER BY FundCode;

## MIssing BondFundCalss
## UPDATE lookup.fundcodes SET BondFundClass="GOOD" Where FundCode=185;

############################################################################################################
############################################################################################################
## Join the Occupants and Allocation Tables, removing the persons covered in the RED ZONE.
############################################################################################################
drop table space.Blue2Master;
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
WHERE occ.UFID NOT IN (SELECT DISTINCT AWARD_INV_UFID from space.bondmaster)
AND  occ.DEPTID NOT IN ('29310000','29310100','29310200','29310201','29310202','29310203','29310204','63620000');



### SELECT DeptID,Department from space.Blue2Master group by DeptID,Department;

#####################################################################################
#####################################################################################

### LOAD AND CLASSIFY SALARY DATA




## CREATE SALARY WORK TABLE WITH FUNDCODE CLASSIFICATION
## CHECK space.Blue2FundList for Missing BondFundClass Values

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


SELECT max(PayEndDate) from space.salary;

ALTER TABLE space.salary
      ADD Salary decimal(20.2),
      ADD Fringe decimal(20.2),
      ADD SalFringe  decimal(20.2),
      ADD KeepFund integer(1),
      ADD GoodMask integer(1),
      ADD BadMask integer(1);


## Annualize the Paid amounts for missing days, Initialize Masks.
## SELECT max(PayEndDate) from space.salary;
##

# FUNDCODE TABLE


UPDATE space.salary
       SET Salary=SalaryRaw*1.083,      
           Fringe=FringeAmtRaw*1.083,
           SalFringe=(SalaryRaw+FringeAmtRaw)*1.083,
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





DROP TABLE if exists space.blue2Salary;
CREATE TABLE space.blue2Salary AS
SELECT 	UFID,
		PersonName,
        SUM(Salary*KeepFund) AS TotalSalary,
        SUM(Fringe*KeepFund) AS TotalFringe,
        SUM(SalFringe*KeepFund) AS TotalSalFringe,

        SUM(Salary*KeepFund*GoodMask) AS GoodSalary,
        SUM(Fringe*KeepFund*GoodMask) AS GoodFringe,
        SUM(SalFringe*KeepFund*GoodMask) AS GoodSalFringe,

        SUM(Salary*KeepFund*BadMask) AS BadSalary,
        SUM(Fringe*KeepFund*BadMask) AS BadFringe,
        SUM(SalFringe*KeepFund*BadMask) AS BadSalFringe
FROM space.salary
WHERE UFID<>""
GROUP BY UFID, PersonName;


## Add Resrach Percentage

DROP TABLE if exists space.lookupRschPct;
CREATE TABLE space.lookupRschPct AS
SELECT UFID,
       SUM(RschPct) AS RschPct,
       SUM(NonRschPct) AS NonRschPct,
       max(1) as InBlueZone2
FROM space.Blue2Master
WHERE UFID<>""
GROUP BY UFID;



ALTER TABLE space.blue2Salary 
      ADD RschPct Decimal(10.2),
      ADD NonRschPct Decimal(10.2),
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


### DELETE FROM space.blue2Salary WHERE UFID NOT IN (SELECT DISTINCT UFID from space.Blue2Master );



/*
drop table if Exists bluezone.temp;
create table bluezone.temp AS
Select * from bluezone.Blue2Master where Occupant_UFID NOT IN (SELECT DISTINCT UFID FROM bluezone.blue2Salary);
*/



## Blue zone 2 Summary Table

DROP TABLE space.Blue2Summary;
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
       SUM(TotalSalary*(RschPct*.01)) AS Salary_Paid,
	   SUM(TotalFringe*(RschPct*.01)) AS Fringe_Paid,
       SUM(TotalSalFringe*(RschPct*.01)) AS Total_Paid
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
       SUM(TotalSalary*(RschPct*.01)) AS Salary_Paid,
	   SUM(TotalFringe*(RschPct*.01)) AS Fringe_Paid,
       SUM(TotalSalFringe*(RschPct*.01)) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Denominator"
UNION ALL
Select "Total Research Revenue" as FundType,
       SUM(TotalSalary) AS Salary_Paid,
	   SUM(TotalFringe) AS Fringe_Paid,
       SUM(TotalSalFringe) AS Total_Paid
FROM space.blue2Salary
WHERE InBlueZone2=1
GROUP BY "Total Research Revenue";


select * from space.Blue2Summary;


##*************** Supporting Tables



##############

## MAKE REPORT TABLE
DROP TABLE space.deptlist;
create table space.deptlist AS
Select bzc.Department,
	   Sum(al.Area) as Area
  FROM space.ctrb_alloc al 
  LEFT JOIN  bluezone.colonies bzc
  ON al.DEPTID=bzc.DEPTID
WHERE bzc.OccType<>"Omit"
GROUP BY bzc.Department
ORDER BY Sum(al.Area) DESC;



# FUNDCODE TABLE
DROP TABLE bluezone.FundList ;
CREATE TABLE bluezone.FundList AS
SELECT FundCode,
       Description,
       BondFundClass
FROM lookup.fundcodes
WHERE FundCode in (select distinct FundCode from space.salary)
ORDER BY FundCode;



################ EOF


select count(*) from  space.Blue2Master;



