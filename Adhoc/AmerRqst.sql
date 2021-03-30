
drop table if exists work.AmerRqst;
create table work.AmerRqst as
Select  Year,
        STD_PROGRAM, 
		Person_key,
        max(UFID) AS UFID,
        max(LastName) as LastName,
        max(FirstName) as FirstName,
        max(DepartmentID) as DeptID,
        max(Department) as Department,
        max(Title) as Title,
        max(email) as Email,
        max(Affiliation) as Affiliation,
        max(FacType) as FacType
from lookup.roster
WHERE STD_PROGRAM='Biorepository'
GROUP BY Year,
        STD_PROGRAM, 
		Person_key
Order by  Year,
        STD_PROGRAM, 
		LastName,
        FirstName;


## Undup by Year
drop table if exists work.AmerRqstSumm;
create table work.AmerRqstSumm as
Select  Year,
		count(distinct Person_key) as nServed
from lookup.roster
WHERE STD_PROGRAM='Biorepository'
GROUP BY Year;


# Total Undup
Select count(distinct Person_key) as nServed
from lookup.roster
WHERE STD_PROGRAM='Biorepository'
;
