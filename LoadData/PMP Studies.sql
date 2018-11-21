

desc loaddata.irb_raw_oct_2017;

drop table if exists work.irb;
create table work.irb as
select * from loaddata.irb_raw_oct_2017;


### FIX UFIDS
UPDATE work.irb SET PI_UFID=LPAD(PI_UFID,8,'0');


ALTER TABLE work.irb
ADD 	IRB_Approval_Year integer(4),
ADD 	IRB_Approval_Month varchar(12),
ADD		IRB_APPROVAL_TIME integer(10),
ADD		IRB_APPROVAL_TIME_NOPRESCREEN integer(10),
ADD     PreReview_Days integer(10),



UPDATE work.irb SET IRB_Approval_Year=Year(Date_Originally_Approved);
UPDATE work.irb SET IRB_Approval_Month=concat(Year(Date_Originally_Approved),"-",LPAD(month(Date_Originally_Approved),2,'0'));

UPDATE work.irb SET PreReview_Days=0;
UPDATE work.irb SET PreReview_Days=datediff(First_Review_Date, Date_IRB_Received ) where First_Review_Date is not null;



UPDATE work.irb SET IRB_APPROVAL_TIME_NOPRESCREEN = datediff(Date_Originally_Approved, Date_IRB_Received);
UPDATE work.irb SET IRB_APPROVAL_TIME = datediff(Date_Originally_Approved, Date_IRB_Received)-PreReview_Days;




####
select IRB_Approval_Year,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_NOPRESCREEN)
from work.irb
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Year;


select IRB_Approval_Month,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_NOPRESCREEN)
from work.irb
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Month;
;



### ON SETS WITH EVEN NUMBER OF ROWS THIS CODE DOES NOT AVEWRASGE THE Two Middle Values

SELECT IRB_Approval_Year, 
SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(IRB_APPROVAL_TIME ORDER BY IRB_APPROVAL_TIME), ',', CEILING((COUNT(IRB_APPROVAL_TIME)/2))), ',', -1) median
FROM work.irb
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Year;;


#####

drop table if exists work.irb;
create table work.irb as
select * from loaddata.irb_raw_oct_2017;

ALTER TABLE work.irb
ADD GenomeScore int(10);

UPDATE  work.irb SET GenomeScore=0;

UPDATE work.irb set GenomeScore=GenomeScore+1 WHERE Project_Title LIKE '%Personalized Medicine%' OR Brief_Description LIKE '%Personalized Medicine%';
UPDATE work.irb set GenomeScore=GenomeScore+1 WHERE Project_Title LIKE '%pharmacogenomic%' OR Brief_Description LIKE '%pharmacogenomic%';
UPDATE work.irb set GenomeScore=GenomeScore+1 WHERE Project_Title LIKE '%Precision Medicine%' OR Brief_Description LIKE '%Precision Medicine%';


DROP TABLE IF EXISTS Adhoc.PMPStudies;
create table Adhoc.PMPStudies AS
select 	ID,
		GenomeScore, 
		Project_Title,
        PI_Last_Name,
		PI_First_Name,
		Actual_Enrollment_Number,
		Approved_Number_Of_Subjects,
		Date_Originally_Approved,
		Expiration_Date,
		NCT_Number,
		Brief_Description
from work.irb 
where GenomeScore>0 ORDER BY GenomeScore Desc;



############### NUMBER OF CLINICAL TRIALS AND ENROLLMENT BY IRB APPROVAL YEAR
SELECT YEAR(Date_Originally_Approved) AS ApprovalYear,
       COUNT(DISTINCT ID) AS nStudies,
       SUM(Actual_Enrollment_Number) as Enrollment
from work.irb
WHERE (NCT_Number<>"" OR NCT_Number IS NOT NULL)
  AND Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY YEAR(Date_Originally_Approved);




create table Adhoc.IRBAPPR AS
select * from work.irb 
where YEAR(Date_Originally_Approved)>2014
  AND (NCT_Number<>"" OR NCT_Number IS NOT NULL)
  AND Committee="IRB-01"
  AND Review_Type="Full IRB Review";


