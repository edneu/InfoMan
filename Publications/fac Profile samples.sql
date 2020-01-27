

DROP TABLE IF EXISTS work.ProfileSample;
CREATE TABLE work.ProfileSample AS
Select 	UFID,
		MAX(LastName) AS LastName,
        MAX(FirstName) AS FirstName,
        max(email) AS email,
        max(FacType) as FacType
from lookup.roster        
WHERE Faculty="Faculty"  
AND Year in (2019)
AND UFID in (SELECT DISTINCT Employee_ID  from lookup.active_emp WHERE Salary_Plan LIKE "%FACULTY%")
GROUP BY UFID;

select FacType,count(*) from  work.ProfileSample group by FacType;


ALTER TABLE work.ProfileSample
ADD RandSEQ decimal(65,10),
ADD IncludeRec int(1);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.ProfileSample SET IncludeRec=0;
UPDATE work.ProfileSample SET RandSEQ=10000000*RAND();

select * from  work.ProfileSample;

SELECT RandSEQ,UFID,FacType,0 AS IncludeRec
from work.ProfileSample
ORDER BY FacType,RandSEQ;

## FacSeq Added in Excel


UPDATE work.ctsi_profile_sample SET IncludeRec=1 WHERE facSEQ<=10;

create table ctsi_frame AS
select * from work.ctsi_profile_sample where IncludeRec=1
ORDER BY FacType,LastName,FirstName;
