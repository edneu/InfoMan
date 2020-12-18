DROP TABLE IF EXISTS Adhoc.Temp;
Create table Adhoc.Temp AS
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.year1_lineitems group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL 
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.year2_lineitems group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION All
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.year3_lineitems group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.year4_lineitems group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.Year1Budget group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.Year2Budget group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.Year3Budget group by DEPTID,DeptName,CollAbbr,College,ReportCollege
UNION ALL
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege from Adhoc.Year4Budget group by DEPTID,DeptName,CollAbbr,College,ReportCollege;


DROP TABLE IF EXISTS Adhoc.LU_Report_College;
CREATE TABLE Adhoc.LU_Report_College AS
SELECT DEPTID,DeptName,CollAbbr,College,ReportCollege 
from Adhoc.Temp 
WHERE DEPTID <>""
group by DEPTID,DeptName,CollAbbr,College,ReportCollege
ORDER BY ReportCollege,DeptID;