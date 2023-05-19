
## FROM ANGELA
DROP TABLE IF EXISTS finance.contribidcRAW;
create table finance.contribidcRAW as 
select * from finance.contribidc2023;

#################################################################
## Vouchers
DROP TABLE if Exists finance.voucherIDC;
create table finance.voucherIDC as 
SELECT * from finance.vocher2223;

################################################################
## CRC PIs
Select * from finance.crcidc;

Alter table finance.crcidc ADD UFID varchar(12);
SET SQL_SAFE_UPDATES = 0;

UPDATE finance.crcidc ci, lookup.email lu
SET ci.UFID=lu.UF_UFID
WHERE ci.EMAIL=lu.UF_EMAIL;

UPDATE finance.crcidc ci, lookup.roster lu
SET ci.UFID=lu.UFID
WHERE ci.EMAIL=lu.EMAIL
AND ci.UFID IS NULL;

UPDATE finance.crcidc ci, lookup.ufids lu
SET ci.UFID=lu.UF_UFID
WHERE ci.EMAIL=lu.UF_EMAIL
AND ci.UFID IS NULL;

UPDATE finance.crcidc ci, lookup.employee_by_term lu
SET ci.UFID=lu.UFID
WHERE concat(ci.Lastname,",",ci.Firstname)=lu.Name
AND ci.UFID IS NULL;


UPDATE finance.crcidc ci, lookup.ufids lu
SET ci.UFID=lu.UF_UFID
WHERE CONCAT(substr(EMAIL,1,LOCATE("@",EMAIL)),"UFL.EDU")=lu.UF_EMAIL
AND ci.UFID IS NULL;

UPDATE finance.crcidc ci, lookup.email lu
SET ci.UFID=lu.UF_UFID
WHERE CONCAT(substr(EMAIL,1,LOCATE("@",EMAIL)),"UFL.EDU")=lu.UF_EMAIL
AND ci.UFID IS NULL;

Update finance.crcidc SET UFID='07218980' WHERE PIPersonID=1294;
Update finance.crcidc SET UFID='35110437' WHERE PIPersonID=1302;
Update finance.crcidc SET UFID='16012600' WHERE PIPersonID=150;
Update finance.crcidc SET UFID='57131029' WHERE PIPersonID=1753;
Update finance.crcidc SET UFID='46481410' WHERE PIPersonID=1877;
Update finance.crcidc SET UFID='47782600' WHERE PIPersonID=2304;
Update finance.crcidc SET UFID='16365942' WHERE PIPersonID=3091;

DELETE from finance.crcidc WHERE UFID IS NULL;

##############################################################
##  Pilots
##############################################################
DROP TABLE IF EXISTS finance.PilotsIDC;
CREATE TABLE finance.PilotsIDC AS
Select DISTINCT UFID 
from pilots.PILOTS_MASTER
WHERE Award_Year in (2021,2022)
AND Awarded='Awarded';



##############################################################
##  ROSTER FACULTY
##############################################################
DROP TABLE IF EXISTS finance.rosterfacIDC1;
CREATE TABLE finance.rosterfacIDC1 AS
Select UFID 
from lookup.roster
where Year in ('2021','2022')
AND Faculty="Faculty"
AND UFID not in ('','0')
AND UFID IS NOT NULL
GROUP BY UFID;
#######################################################################
#######################################################################
#######################################################################
#######################################################################
#######################################################################
#######################################################################
###  CREATE MASTER UFID TABLE

DROP TABLE if exists finance.idc_ufid_dup;
Create table finance.idc_ufid_dup as
Select distinct UFID from finance.contribidcRAW
UNION ALL 
Select distinct UFID from finance.voucherIDC
UNION ALL 
Select distinct UFID from finance.rosterfacIDC1
UNION ALL 
select distinct UFID from finance.PilotsIDC
UNION ALL 
select distinct UFID from finance.crcidc;

DROP TABLE if exists finance.idc_master;
Create table finance.idc_master as
SELECT DISTINCT UFID from finance.idc_ufid_dup;

DELETE FROM finance.idc_master WHERE UFID LIKE '000000%';

ALTER TABLE finance.idc_master
ADD FirstName varchar(45),
ADD LastName varchar(45),
ADD FullName varchar(125),
ADD email varchar(65),
ADD Voucher int(1),
ADD Pilot int(1),
ADD Roster int(1),
ADD CRC int(1),
ADD LastYearIDC int(1),
ADD LastYearIDC_nProj int(5),
ADD LastYearIDCAmt decimal(65,10),
ADD nAwards int(5),
ADD TotalAmt decimal(65,10),
ADD DirectAmt decimal(65,10),
ADD IndirectAmt decimal(65,10);


SET SQL_SAFE_UPDATES = 0;

## SET Particpation Flags
UPDATE finance.idc_master
	SET Voucher=0,
		Pilot=0,
        Roster=0,
        CRC=0,
        LastYearIDC=0;

UPDATE finance.idc_master SET Voucher=1 WHERE UFID IN (SELECT DISTINCT UFID FROM finance.voucherIDC);
UPDATE finance.idc_master SET Pilot=1 WHERE UFID IN (SELECT DISTINCT UFID FROM finance.PilotsIDC); 
UPDATE finance.idc_master SET Roster=1 WHERE UFID IN (SELECT DISTINCT UFID FROM finance.rosterfacIDC1); 
UPDATE finance.idc_master SET LastYearIDC=1 WHERE UFID IN (SELECT DISTINCT UFID FROM finance.contribidcRAW); 
UPDATE finance.idc_master SET CRC=1 WHERE UFID IN (SELECT DISTINCT UFID FROM finance.crcidc); 


UPDATE finance.idc_master ms, lookup.ufids lu 
Set ms.FirstName=lu.UF_FIRST_NM,
    ms.LastName=lu.UF_LAST_NM,
    ms.FullName=lu.UF_DISPLAY_NM,
    ms.email=lu.UF_EMAIL
WHERE ms.UFID=lu.UF_UFID; 

### AGGREGATE LAST YEARS CONTRIBUTIONS
DROP TABLE IF EXISTS finance.LastYearIDC_AGG;
Create table finance.LastYearIDC_AGG AS
select UFID,
       Count(distinct ProjectID) as LastYearIDC_nProj,
       SUM(ContribIDC) as LastYearIDCAmt
 from finance.contribidcRAW
GROUP BY UFID;

UPDATE finance.idc_master ms, finance.LastYearIDC_AGG lu 
Set ms.LastYearIDC_nProj=lu.LastYearIDC_nProj,
	ms.LastYearIDCAmt=lu.LastYearIDCAmt
WHERE ms.UFID=lu.UFID; 


####################################################
#################################################
  
DELETE from finance.idc_master Where email is null;
DELETE from finance.idc_master Where UFID is null;
###########################################################
##  Get Awards History File for Possible IDC

	



DROP TABLE IF EXISTS finance.RosterFacAwd1;
CREATE TABLE finance.RosterFacAwd1 AS
SELECT 	CLK_AWD_ID as AwardID,
		CLK_AWD_PROJ_ID as ProjectID,
        MAX(1) as NumProjects,
		MAX(CLK_PI_UFID) AS PI_UFID,
		SUM(DIRECT_AMOUNT) AS Direct,
		SUM(INDIRECT_AMOUNT) As Indirect,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total
FROM lookup.awards_history
WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2022','%m,%d,%Y') AND str_to_date('06,30,2023','%m,%d,%Y')
AND CLK_PI_UFID in (SELECT DISTINCT UFID FROM finance.idc_master)
GROUP BY CLK_AWD_ID,CLK_AWD_PROJ_ID;

## ADD PUAC
#########################################################
DROP TABLE IF EXISTS finance.RosterFacAwdID;
CREATE TABLE finance.RosterFacAwdID AS
SELECT DISTINCT AwardID from  finance.RosterFacAwd1;

select * from finance.puac_lookup;

Select CLK_PI_UFID,max(CLK_AWD_PI), max(CLK_AWD_PUAC) from finance.puac_lookup
WHERE CLK_PI_UFID IN (SELECT DISTINCT PI_UFID from finance.RosterFacAwd1)
GROUP BY CLK_PI_UFID;

Select CLK_PI_UFID,CLK_AWD_PI, CLK_AWD_PUAC from finance.puac_lookup
WHERE CLK_PI_UFID IN (SELECT DISTINCT PI_UFID from finance.RosterFacAwd1)
GROUP BY CLK_PI_UFID,CLK_AWD_PI, CLK_AWD_PUAC;

Select count(distinct CLK_PI_UFID), COunt(distinct CLK_AWD_PUAC) from finance.puac_lookup
WHERE CLK_PI_UFID IN (SELECT DISTINCT PI_UFID from finance.RosterFacAwd1);

drop table finance.puac;
select * from finance.puac;

Alter table finance.puac ADD email varchar(60);

SET SQL_SAFE_UPDATES = 0;

UPDATE finance.puac pu, lookup.email lu 
SET pu.email=lu.UF_EMAIL
WHERE pu.PUAC_UFID=lu.UF_UFID;

UPDATE finance.puac pu, lookup.ufids lu 
SET pu.email=lu.UF_EMAIL
WHERE pu.PUAC_UFID=lu.UF_UFID
AND pu.email IS NULL;

delete from finance.puac where email is Null;

ALter table finance.puac ADD Active int(1);
UPDATE finance.puac set Active=0;

UPDATE finance.puac pu, loaddata.`Active 20230519` lu 
SET Active=1
WHERE pu.PUAC_UFID=lu.Employee_ID;

DELETE FROM finance.puac where Active=0;

drop table if exists finance.pi_puac;
Create table finance.pi_puac as
Select CLK_AGR_PI_UFID as PI_UFID,
       CLK_AGR_PI as PI,
        GROUP_CONCAT(DISTINCT email  SEPARATOR '; ') AS PUAC_Email
FROM finance.puac        
GROUP BY CLK_AGR_PI,  CLK_AGR_PI_UFID;      


DROP TABLE IF EXISTS finance.FacAwdSumm;
CREATE TABLE finance.FacAwdSumm AS
SELECT 	PI_UFID,
		SUM(NumProjects) AS NumProjects,
        Sum(Direct) AS TotalDirect,
        SUM(Indirect) AS TotalIndirect,
		SUM(Total) AS TotalAwardRec
FROM finance.RosterFacAwd1
GROUP BY PI_UFID;         

#####################################
DROP TABLE IF EXISTS finance.puac_email;
CREATE TABLE finance.puac_email as
select Distinct PUAC_UFID from finance.puac_ufid;

ALter table finance.puac_email ADD email;

##################################################################
##################################################################
## UPDATE MASTER WITH Awards

UPDATE finance.idc_master ms, finance.FacAwdSumm lu
SET ms.nAwards=lu.NumProjects,
	ms.TotalAmt=lu.TotalAwardRec,
	ms.DirectAmt=lu.TotalDirect,
    ms.IndirectAmt=lu.TotalIndirect
WHERE ms.UFID=lu.PI_UFID;    

##################################################################
##### COMPLETE SUMMARY TABLE

select * from finance.idc_master;






    

########################################################################################
########################################################################################
###################                   EOF               ################################
########################################################################################
########################################################################################

