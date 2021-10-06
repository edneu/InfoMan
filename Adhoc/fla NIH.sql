

select * from work.fla_nih;

DROP TABLE IF EXISTS work.fla_nih_FFY;
CREATE TABLE work.fla_nih_FFY AS
SELECT 	ORGANIZATION,
		max(CITY) as CITY 
from work.fla_nih
GROUP BY ORGANIZATION;

Alter TABLE work.fla_nih_FFY
ADD FFY2015_amt decimal(65,10),
ADD FFY2016_amt decimal(65,10),
ADD FFY2017_amt decimal(65,10),
ADD FFY2018_amt decimal(65,10),
ADD FFY2019_amt decimal(65,10),
ADD FFY2020_amt decimal(65,10),
ADD FFY2021_amt decimal(65,10),

ADD FFY2015_nAWD int(5),
ADD FFY2016_nAWD int(5),
ADD FFY2017_nAWD int(5),
ADD FFY2018_nAWD int(5),
ADD FFY2019_nAWD int(5),
ADD FFY2020_nAWD int(5),
ADD FFY2021_nAWD int(5);


SET SQL_SAFE_UPDATES = 0;

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2015_amt=lu.FUNDING,
	fn.FFY2015_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2015;    

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2016_amt=lu.FUNDING,
	fn.FFY2016_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2016;  


UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2017_amt=lu.FUNDING,
	fn.FFY2017_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2017;  

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2018_amt=lu.FUNDING,
	fn.FFY2018_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2018;  

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2019_amt=lu.FUNDING,
	fn.FFY2019_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2019;  

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2020_amt=lu.FUNDING,
	fn.FFY2020_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2020;  

UPDATE work.fla_nih_FFY fn, work.fla_nih lu
SET fn.FFY2021_amt=lu.FUNDING,
	fn.FFY2021_nAWD=lu.AWARDS
WHERE fn.ORGANIZATION=lu.ORGANIZATION
AND lu.FFY_=2021;  



select * from  work.fla_nih_FFY;