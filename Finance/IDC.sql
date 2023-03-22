
## FROM ANGELA
DROP TABLE IF EXISTS finance.contribidcRAW;
create table finance.contribidcRAW as 
select * from finance.contribidc2023;


##############################################################
## AWARDS FOR ROSTER FACULTY
##############################################################
DROP TABLE IF EXISTS finance.rosterfacIDC1;
CREATE TABLE finance.rosterfacIDC1 AS
Select UFID 
from lookup.roster
where Year in ('2021','2022')
AND Faculty="Faculty"
AND UFID not in ('','0')
GROUP BY UFID
UNION ALL 
SELECT DISTINCT UFID
FROM finance.contribidcRAW 
WHERE UFID <> '0000000';



DROP TABLE IF EXISTS finance.rosterfacIDC;
CREATE TABLE finance.rosterfacIDC AS
Select DISTINCT UFID from finance.rosterfacIDC1
WHERE UFID <>'0000000'; 




DROP TABLE IF EXISTS finance.RosterFacAwd1;
CREATE TABLE finance.RosterFacAwd1 AS
SELECT 	CLK_AWD_PROJ_ID as ProjectID,
		MAX(1) as NumProjects,
		MAX(CLK_PI_UFID) AS PI_UFID,
		SUM(DIRECT_AMOUNT) AS Direct,
		SUM(INDIRECT_AMOUNT) As Indirect,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) As Total
FROM lookup.awards_history
WHERE FUNDS_ACTIVATED BETWEEN str_to_date('07,01,2022','%m,%d,%Y') AND str_to_date('06,30,2023','%m,%d,%Y')
AND CLK_PI_UFID in (SELECT DISTINCT UFID FROM finance.rosterfacIDC)
GROUP BY CLK_AWD_PROJ_ID;


DROP TABLE IF EXISTS finance.RosterFacAwdSumm;
CREATE TABLE finance.RosterFacAwdSumm AS
SELECT 	PI_UFID,
		SUM(NumProjects) AS NumProjects,
        Sum(Direct) AS TotalDirect,
        SUM(Indirect) AS TotalIndirect,
		SUM(Total) AS TotalAwardRec
FROM finance.RosterFacAwd1
GROUP BY PI_UFID;         

##################################################################
##   IDC Recevied (from Angela's Table)
##################################################################

DROP TABLE IF EXISTS finance.ContribIDClu;
CREATE TABLE finance.ContribIDClu AS
SELECT UFID,
       COUNT(ProjectID) AS IDCContrib_nProj,
       SUM(ContribIDC) AS IDCContrib_Amount
from finance.contribidcRAW
GROUP BY UFID;


##################################################################
##### COMPLETE SUMMARY TABLE

DROP TABLE IF EXISTS finance.IDC_SUMMARY;
Create table finance.IDC_SUMMARY AS
SELECT * from finance.rosterfacIDC
WHERE UFID <>'0000000';





ALTER TABLE finance.IDC_SUMMARY
	ADD PI_LastName varchar(45),
	ADD PI_FirstName varchar(45),
    ADD PI_Email varchar(45),
    ADD PI_DeptID varchar(12),
    ADD PI_DeptName varchar(60),
    ADD PI_Title varchar(45),
    ADD NumProjects int(5),
	ADD TotalDirect decimal(65,10),
	ADD TotalIndirect decimal(65,10),
	ADD TotalAwardRec decimal(65,10),
	ADD IDCContrib_nProj int(5),
	ADD IDCContrib_Amount decimal(65,10);
    
    
 
SET SQL_SAFE_UPDATES = 0;

####INITALIZE NUMERICS
UPDATE finance.IDC_SUMMARY
SET NumProjects=0,
	TotalDirect=0,
	TotalIndirect=0,
	TotalAwardRec=0,
	IDCContrib_nProj=0,
	IDCContrib_Amount=0;
    




UPDATE finance.IDC_SUMMARY ids, lookup.ufids lu
SET 	ids.PI_LastName=lu.UF_LAST_NM,
		ids.PI_FirstName=lu.UF_FIRST_NM,
        ids.PI_Email=lu.UF_EMAIL,
        ids.PI_DeptID=lu.UF_DEPT,
        ids.PI_DeptNAme=lu.UF_DEPT_NM
WHERE ids.UFID=lu.UF_UFID;   

 /*
UPDATE finance.IDC_SUMMARY ids, lookup.Employees lu
SET 	ids.PI_DeptID=lu.Department_Code,
        ids.PI_DeptNAme=lu.Department,
        ids.PI_Title=lu.Job_Code
WHERE ids.UFID=lu.Employee_ID;  


 
UPDATE finance.IDC_SUMMARY ids, lookup.email lu
SET 	ids.PI_Email=UF_EMAIL
WHERE ids.UFID=lu.UF_UFID
AND UF_PRIMARY_FLG="Y"; 


UPDATE finance.IDC_SUMMARY ids, lookup.Employees lu
SET 	ids.PI_DeptID=lu.Department_Code,
        ids.PI_DeptNAme=lu.Department,
        ids.PI_Title=lu.Job_Code
WHERE ids.UFID=lu.Employee_ID;  
*/


### ADD AWARD SUMMARY
UPDATE finance.IDC_SUMMARY ids, finance.RosterFacAwdSumm lu
SET 	ids.NumProjects=lu.NumProjects,
		ids.TotalDirect=lu.TotalDirect,
        ids.TotalIndirect=lu.TotalIndirect,
        ids.TotalAwardRec=lu.TotalAwardRec
WHERE ids.UFID=lu.PI_UFID;  
    
##  ADD CONTRIBUTION SUMMARY
UPDATE finance.IDC_SUMMARY ids, finance.ContribIDClu lu
SET 	ids.IDCContrib_nProj=lu.IDCContrib_nProj,
		ids.IDCContrib_Amount=lu.IDCContrib_Amount
WHERE ids.UFID=lu.UFID;   


DELETE FROM finance.IDC_SUMMARY
WHERE NumProjects =0 
   AND IDCContrib_nProj=0 ;
   
Select * from finance.IDC_SUMMARY;   
########################################################################################
########################################################################################
###################                   EOF               ################################
########################################################################################
########################################################################################

