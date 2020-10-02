


DROP TABLE IF EXISTS work.CoordCont ;
Create table work.CoordCont AS
SELECT * from work.coordsurvcont;

ALTER TABLE work.CoordCont
ADD LastName Varchar(45),
ADD FirstName Varchar(45),
ADD Email Varchar(45),
ADD UFID Varchar(12),
ADD Deptid VarChar(12),
ADD Department VarChar(45),
ADD Title varchar(45);


UPDATE work.CoordCont  SET 	Email='sumner@anest.ufl.edu' ,
							UFID='88265490'
WHERE coordsurvcont_id=26;

UPDATE work.CoordCont  SET 	Email='ldukes@neuroscience.ufl.edu' ,
							UFID='82868619'
WHERE coordsurvcont_id=13;


UPDATE work.CoordCont  SET 	Email='mmarzoug@gmail.com',
							UFID='98106341'
WHERE coordsurvcont_id=20;



UPDATE work.CoordCont  SET 	Email='waty0001@shands.ufl.edu',
							LastName="Atyvo",
                            FirstName="Walter",
                            Title="Administrative Director UFP",          
                            Department="Regional Physician Network"
WHERE coordsurvcont_id=31;



UPDATE work.CoordCont  SET 	Title="Director of Operations III",          
                            Department="Admin Congenital Heart Center"
WHERE coordsurvcont_id=19;






UPDATE work.CoordCont cc, lookup.email lu
SET cc.Email=lu.UF_EMAIL,
	cc.UFID=UF_UFID
WHERE cc.OrigEmail=lu.UF_EMAIL
AND UF_PRIMARY_FLG="Y";



UPDATE work.CoordCont cc, lookup.ufids lu
SET cc.LastName=lu.UF_LAST_NM,
	cc.FirstName=lu.UF_FIRST_NM
WHERE cc.UFID=lu.UF_UFID;


UPDATE work.CoordCont cc, lookup.active_emp lu
SET cc.DeptID=lu.Department_Code,
	cc.Department=lu.Department,
    cc.Title=Job_Code
WHERE cc.UFID=lu.Employee_ID;


SELECT * from work.CoordCont ;



	
