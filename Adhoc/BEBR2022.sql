

ALter table lookup.roster ADD PersonKey2 varchar(255);

select distinct UFID from lookup.roster;
UPDATE lookup.roster SET UFID=NULL WHERE UFID IN ('','0');

SET SQL_SAFE_UPDATES = 0;

UPDATE lookup.roster SET PersonKey2=NULL;

UPDATE lookup.roster SET PersonKey2=UFID
WHERE UFID IS NOT NULL;

UPDATE lookup.roster SET PersonKey2=CONCAT(TRIM(LastName),",",TRIM(FirstName))
WHERE PersonKey2 IS NULL;








SET SQL_SAFE_UPDATES = 0;

SELECT Year,
       PersonKey2,
       max(UFID) AS UFID,
       max(LastName) AS LastName,
       max(FirstName) AS FirstName,
       max(FacultyType) AS FacultyType,
       max(FacType) AS FacType,
       max(Affiliation) as Affiliation,
       max(Display_College) AS Display_College,
       max(DepartmentID) AS DeptID,
       max(Department) AS Dept,
       ##max(College) AS College,
       max(Gender) AS Gender
FROM lookup.roster
GROUP BY Year,
       PersonKey2
ORDER BY Year,
       PersonKey2 ;      
       


      
/*      
      
      
SELECT distinct DISPLAY_COLLEGE from lookup.roster;
UPdate lookup.roster SET DISPLAY_COLLEGE=NULL WHERE TRIM(Display_College)=' ';

UPdate lookup.roster SET DEPARTMENT=NULL WHERE DEPARTMENT=' ';




UPDATE lookup.roster SET Department=trim(Department);
UPDATE lookup.disp_coll SET Department=trim(Department);

UPDATE lookup.roster rs, lookup.disp_coll lu
SET rs.Display_College=trim(lu.Display_College)
where rs.Department=lu.Department
AND rs.Display_College IS NULL;


UPDATE lookup.roster SET DISPLAY_COLLEGE='Agriculture and Life Sciences'
WHERE Department like "AG-%" AND DISPLAY_COLLEGE IS NULL;


UPDATE lookup.roster SET DISPLAY_COLLEGE='Latin American Studies'
WHERE Department like "LT-%" ;

UPDATE lookup.roster SET DISPLAY_COLLEGE='Non-Academic'
WHERE Department = "Network and Security Engineering" ;

UPDATE lookup.roster SET DISPLAY_COLLEGE='Medicine'
WHERE Department = 'Surgical Oncology';

select max(disp_coll_id)+1 from lookup.disp_coll;


select * from lookup.roster where Display_college IS Null AND UFID IS NOT NULL;



select * from lookup.Employees where EMPLOYEE_ID in
	(select distinct UFID from lookup.roster where Display_college IS Null AND UFID IS NOT NULL);
    
    SELECT Department,count(*) from lookup.roster 
    WHERE DISPLAY_COLLEGE IS NULL  group by Department;
    
    Update lookup.roster SET Display_college='Non-UF' WHERE  Affiliation='Non-UF';

    Update lookup.roster SET Display_college='Non-UF' WHERE  Affiliation='Non-UF';


SELECT DISPLAY_COLLEGE,count(*) as n from lookup.roster WHERE Affiliation='Non-UF' GROUP BY DISPLAY_COLLEGE;




SELECT Display_College,Department, count(*) as n from lookup.roster WHERE Display_College IS NOT NULL
group by Display_College,Department;


UPDAte lookup.roster SET Display_College='Medicine' 
WHERE Department like "MD-%"
AND Display_College="Non-UF";

UPDAte lookup.roster SET Display_College='Engineering' 
WHERE Department like "EG-%"
AND Display_College="Non-UF";

UPDAte lookup.roster SET Display_College='Non-Academic' 
WHERE Department like "SA-%"
AND Display_College="Office of Research";

UPDAte lookup.roster SET Display_College='Non-UF' 
WHERE Department IN ('Biopharmaceutical','Biopta')
AND Display_College="Pharmacy";


SELECT * from lookup.roster 
WHERE Display_College like "Engineering"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="EG-BIO
WHERE Display_College like "Engineering"
AND Department IS NULL;

SELECT * from lookup.roster 
WHERE Display_College like "Florida State University"
AND Department IS NULL;

UPDATE lookup.roster
SET Department="FSU"
WHERE Display_College like "Florida State University"
AND Department IS NULL;




SELECT * from lookup.roster 
WHERE Display_College like "Office of Research"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="Medicine"
WHERE Display_College like "Office of Research"
AND Department IS NULL;

SELECT * from lookup.roster 
WHERE Display_College like "Medicine - Jacksonville"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="JX-MEDICINE AT JAX"
WHERE Display_College like "Medicine - Jacksonville"
AND Department IS NULL;

SELECT * from lookup.roster 
WHERE Display_College like "Medicine"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="MD-MEDICINE"
WHERE Display_College like "Medicine"
AND Department IS NULL;


SELECT * from lookup.roster 
WHERE Display_College like "Non-UF"
AND Department ='36020000'
;

UPDATE lookup.roster
SET Department="PHHP-COM BIOSTATISTICS", Display_College='PHHP-COM Intergrated Programs'
WHERE Display_College like "Non-UF"
AND Department ='36020000';


SELECT * from lookup.roster 
WHERE Display_College like "Non-UF"
AND Department IS NULL;


SELECT * from lookup.roster 
WHERE Display_College like "Public Health and Health Professions"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="MD-HOBI-BIOMED INFORMATICS",
Display_College = "Medicine"
WHERE Display_College like "Public Health and Health Professions"
AND Department IS NULL;


SELECT * from lookup.roster 
WHERE Display_College like "Journalism and Communications"
AND Department IS NULL;


UPDATE lookup.roster
SET Department="DSO-SHANDS",
Display_College = "Non-Academic"
WHERE Display_College like "Journalism and Communications"
AND Department IS NULL;


SELECT * from lookup.roster 
WHERE Display_College like "Non-UF"
AND Department ='Academic Affairs, College of Provost';

UPDATE lookup.roster
SET Department="Non-UF",
Display_College = "Non-UF"
WHERE Display_College like "Non-UF"
AND Department ='Academic Affairs, College of Provost';




SELECT * from lookup.roster 
WHERE Display_College like 'Non-Academic'
AND Department ='AD-VP ADVANCEMENT';


SELECT Display_College,Department, count(*) as n from lookup.roster WHERE Display_College IS NOT NULL
group by Display_College,Department;

*/