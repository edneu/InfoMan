

select * from Adhoc.idrlist;

UPdate Adhoc.idrlist SET Source="ContribIDR";


## PIs with Grants on 2019 Roster
DROP TABLE IF Exists work.piroster1;
Create table work.piroster1 AS
Select CLK_PI_UFID AS UFID, "PI_Roster" from lookup.awards_history
WHERE CLK_PI_UFID NOT IN (SELECT DISTINCT UFID from Adhoc.idrlist)
AND Roster2019=1
AND CLK_AWD_OVERALL_END_DATE>CURDATE()
GROUP BY CLK_PI_UFID , "PI_Roster";
;


## Project PIs with Grants on 2019 Roster
DROP TABLE IF Exists work.piroster2;
Create table work.piroster2 AS
Select CLK_AWD_PROJ_MGR_UFID AS UFID, "PPI_Roster" from lookup.awards_history
WHERE CLK_AWD_PROJ_MGR_UFID NOT IN (SELECT DISTINCT UFID from Adhoc.idrlist)
AND Roster2019=1
AND CLK_AWD_OVERALL_END_DATE>CURDATE()
AND CLK_AWD_PROJ_MGR_UFID NOT IN (SELECT DISTINCT UFID from work.piroster1)
GROUP BY CLK_AWD_PROJ_MGR_UFID , "PPI_Roster";

## CTRB Project PI not on List
DROP TABLE IF Exists work.ctrbidr;
Create table work.ctrbidr
Select AWARD_INV_UFID AS UFID, "CTRBProj" As Source 
FROM space.bondmaster
WHERE AWARD_INV_UFID not in (select distinct UFID from Adhoc.idr_Request_2020);


## Combine Raw Records
DROP TABLE IF EXISTS Adhoc.idr_Request_2020 ;
Create table Adhoc.idr_Request_2020 AS
select UFID,Source from Adhoc.idrlist
UNION ALL
select * from work.piroster1
UNION ALL
select * from work.piroster2
UNION ALL
Select * from work.ctrbidr
;


ALTER table Adhoc.idr_Request_2020
ADD LastName varchar(45),
ADD FirstName varChar(45),
ADD EMAIL  varchar(45),
ADD ActiveEmp int(1),
ADD Name varchar(125),
ADD DeptID Varchar(12),
ADD Department varchar(45) ,
ADD Job_Title varchar(255);


### UPDATE WITH ACTIVE EMPLOYYE DATA
UPDATE Adhoc.idr_Request_2020 SET ActiveEmp=0;

UPDATE Adhoc.idr_Request_2020 idr, lookup.active_emp lu
SET idr.ActiveEmp=1,
    idr.Name=lu.Name,
    idr.DeptID=lu.Department_Code,
    idr.Department=lu.Department,
    idr.Job_Title=lu.Job_Code
WHERE idr.UFID=lu.Employee_ID;

#Current Employees ONLY
DELETE FROM Adhoc.idr_Request_2020 WHERE ActiveEmp=0;



UPDATE Adhoc.idr_Request_2020 idr, lookup.Employees lu
SET idr.LastName=lu.LastName,
	idr.Firstname=lu.FirstName,
    idr.EMAIL=lu.EMAIL
WHERE idr.UFID=lu.Employee_ID    ;




SELECT * from Adhoc.idr_Request_2020;


DROP TABLE IF EXISTS Adhoc.idr_Request_2020_ls;
Create table Adhoc.idr_Request_2020_ls as
SELECT 	EMAIL,
		LastName,
        FirstName,
        DeptID,
        Department,
        Job_Title,
        Source,
        UFID,
        ActiveEmp
FROM Adhoc.idr_Request_2020
ORDER by LastName, FirstName;        



