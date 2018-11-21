

select * from irb_aug2017;


CLK_AWD_PROJ_ID




#Create workfile

DROP TABLE IF EXISTS work.irb;
CREATE TABLE work.irb as
SELECT * from loaddata.irbaug2017;


ALTER TABLE work.irb
ADD 	nFirstReview_DT date,
ADD		nDate_IRB_Received date,
ADD		nDate_Originally_Approved date,
ADD		nApproval_Date date,
ADD		nExpiration_Date date,
ADD		nDate_First_Subject_Signed_ICF date,

ADD 	IRB_Approval_Year integer(4),
ADD     IRB_Approval_Month integer(2),
ADD 	IRB_Approval_YearMonth varchar(12),
ADD		IRB_APPROVAL_TIME integer(10),
ADD		IRB_APPROVAL_TIME_PRESCEEN integer(10);


SET SQL_SAFE_UPDATES = 0;


UPDATE work.irb SET nFirstReview_DT=date_add(date('1899-12-31'), interval FirstReview_DT day );
UPDATE work.irb SET nDate_IRB_Received=date_add(date('1899-12-31'), interval Date_IRB_Received day );
UPDATE work.irb SET nDate_Originally_Approved=date_add(date('1899-12-31'), interval Date_Originally_Approved day );
UPDATE work.irb SET nApproval_Date=date_add(date('1899-12-31'), interval Approval_Date day );
UPDATE work.irb SET nExpiration_Date=date_add(date('1899-12-31'), interval Expiration_Date day );
UPDATE work.irb SET nDate_First_Subject_Signed_ICF=date_add(date('1899-12-31'), interval Date_First_Subject_Signed_ICF day );



UPDATE work.irb SET nFirstReview_DT = NUll where nFirstReview_DT=date('1899-12-31');
UPDATE work.irb SET nDate_IRB_Received = NUll where nDate_IRB_Received=date('1899-12-31');
UPDATE work.irb SET nDate_Originally_Approved = NUll where nDate_Originally_Approved=date('1899-12-31');
UPDATE work.irb SET nApproval_Date = NUll where nApproval_Date=date('1899-12-31');
UPDATE work.irb SET nExpiration_Date = NUll where nExpiration_Date=date('1899-12-31');
UPDATE work.irb SET nDate_First_Subject_Signed_ICF = NUll where nDate_First_Subject_Signed_ICF=date('1899-12-31');


UPDATE work.irb SET IRB_Approval_Year=Year(nDate_Originally_Approved);
UPDATE work.irb SET IRB_Approval_Month=month(nDate_Originally_Approved);
UPDATE work.irb SET IRB_Approval_YearMonth=concat(Year(nDate_Originally_Approved),"-",LPAD(month(nDate_Originally_Approved),2,'0'));

UPDATE work.irb SET PreReview_Days=0;
UPDATE work.irb SET PreReview_Days=datediff(nFirstReview_DT, nDate_IRB_Received ) where nFirstReview_DT is not null;
;

select * from work.irb;


select IRB_Approval_YearMonth from work.irb;


UPDATE work.irb SET IRB_APPROVAL_TIME = datediff(nDate_Originally_Approved, nDate_IRB_Received);
UPDATE work.irb SET IRB_APPROVAL_TIME_PRESCEEN = datediff(nDate_Originally_Approved, nDate_IRB_Received)-PreReview_Days;


##desc work.irb;

##################################################################CHECK FILE NAME BELOW

drop table if exists lookup.myirbAug2017;
create table lookup.myirbAug2017 As
SELECT 	irbaug2017_id2,
		Committee,
        ID,
        Review_Type,
		nFirstReview_DT AS FirstReview_DT,
        PreReview_Days,
		nDate_IRB_Received AS Date_IRB_Received,
		nDate_Originally_Approved AS Date_Originally_Approved,
		nApproval_Date AS Approval_Date ,
		nExpiration_Date AS Expiration_Date,
		nDate_First_Subject_Signed_ICF AS Date_First_Subject_Signed_ICF,
        Current_Status,
        Project_title,
		NCT_Number,
		PI_First_Name,
		PI_Last_Name,
		PI_UFID,
		PI_Department,
		Funding_Department,
		Funding_Sources,
		PeopleSoft_Proposal_Number,
		Actual_Enrollment_Number,
		Approved_Number_Of_Subjects,
		Recruitment_Method_,
		Method_Other_Desc,
		Location_Types,
		Brief_Description,
		IRB_Approval_Year,
		IRB_Approval_Month,
		IRB_Approval_YearMonth,
		IRB_APPROVAL_TIME,
		IRB_APPROVAL_TIME_PRESCEEN
from work.irb;

##desc work.irb;

select distinct Current_Status from work.irb;






select IRB_Approval_Year,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_PRESCEEN),
       avg(IRB_APPROVAL_TIME-IRB_APPROVAL_TIME_PRESCEEN)
from lookup.myirbAug2017
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Year;


select IRB_Approval_Month,
       avg(IRB_APPROVAL_TIME),
       avg(IRB_APPROVAL_TIME_PRESCEEN),
       avg(IRB_APPROVAL_TIME-IRB_APPROVAL_TIME_PRESCEEN)
from lookup.myirbAug2017
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
GROUP BY IRB_Approval_Month;
;




select ID, PreReview_Days from work.irb order by PreReview_Days desc;


select distinct Review_Type from work.irb;

drop table if exists results.myIRBQ1Q22017;
CREATE TABLE results.myIRBQ1Q22017 AS
select * 
from lookup.myirbAug2017
WHERE Committee="IRB-01"
  AND Review_Type="Full IRB Review"
  AND Date_Originally_Approved>=str_to_date('01,01,2017','%m,%d,%Y')
  AND Date_Originally_Approved<=str_to_date('06,30,2017','%m,%d,%Y');






## Conversion of Date Fields






select date_add(date('1899-12-31'), interval Approval_Date day ) from loaddata.irb_aug_2017;