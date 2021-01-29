

select * from finance.mattmap;

Alter TABLE finance.mattmap 
	ADD Department varchar(45),
	ADD College Varchar(45);

SET SQL_SAFE_UPDATES = 0;
    
UPDATE  finance.mattmap mm, lookup.deptlookup lu
SET mm.Department=lu.Department,
	mm.College=lu.College
Where  mm.DEPTID=lu.DEPTID; 

  
    