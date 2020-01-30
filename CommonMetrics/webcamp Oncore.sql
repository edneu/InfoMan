desc work.crc_oncore;
desc work.webcamp_ocr

select * from work.crc_oncore;

select * from work.webcamp_ocr;

PROTOCOL_NO	IRB_NO	GCRC_NO	NCT_ID	IRB_INITIAL_APPROVAL_DATE	STATUS	STATUS_DATE	TOTAL_ACCRUAL

ALTER TABLE work.webcamp_ocr
ADD PROTOCOL_NO	varchar(12),
ADD IRB_NO	varchar(12)	,
ADD GCRC_NO	varchar(12),
ADD NCT_ID 	varchar(12),
ADD IRB_INITIAL_APPROVAL_DATE varchar(12),	
ADD STATUS	varchar(25),			
ADD STATUS_DATE	varchar(12),			
ADD TOTAL_ACCRUAL	int(11)	;	




UPDATE work.webcamp_ocr
SET PROTOCOL_NO=Null,
	IRB_NO=Null,
	GCRC_NO=Null,
	NCT_ID =Null,
	IRB_INITIAL_APPROVAL_DATE =Null,
	STATUS=Null,
	STATUS_DATE=Null,
	TOTAL_ACCRUAL=Null;


UPDATE work.webcamp_ocr ocr, work.crc_oncore lu
SET     ocr.PROTOCOL_NO=lu.PROTOCOL_NO,
		ocr.IRB_NO=lu.IRB_NO,
		ocr.GCRC_NO=lu.GCRC_NO,
		ocr.NCT_ID =lu.NCT_ID ,
		ocr.IRB_INITIAL_APPROVAL_DATE =lu.IRB_INITIAL_APPROVAL_DATE ,
		ocr.STATUS=lu.STATUS,
		ocr.STATUS_DATE=lu.STATUS_DATE,
		ocr.TOTAL_ACCRUAL=lu.TOTAL_ACCRUAL
WHERE ocr.IRBNUMBER=lu.IRB_NO;       



UPDATE work.webcamp_ocr ocr, work.crc_oncore lu
SET     ocr.PROTOCOL_NO=lu.PROTOCOL_NO,
		ocr.IRB_NO=lu.IRB_NO,
		ocr.GCRC_NO=lu.GCRC_NO,
		ocr.NCT_ID =lu.NCT_ID ,
		ocr.IRB_INITIAL_APPROVAL_DATE =lu.IRB_INITIAL_APPROVAL_DATE ,
		ocr.STATUS=lu.STATUS,
		ocr.STATUS_DATE=lu.STATUS_DATE,
		ocr.TOTAL_ACCRUAL=lu.TOTAL_ACCRUAL
 
WHERE   LOCATE(lu.IRB_NO,ocr.IRBNUMBER)<>0
AND ocr.IRB_NO IS NULL;        
 ;
 
 SELECT * from work.webcamp_ocr;    
 
 
 
 drop table work.temp;
 create table work.temp as
 
 
 select EMAIL,
		Employee_ID AS UFID, 
		Department_Code,
        Department,
        Name,
        ERACommons,
        Job_Code
 from lookup.Employees
 Where Name like "%Leeuwenburgh%c%";
 
 
 WHERE EMAIL IN
 
('bbyrne@ufl.edu',
'santon@aging.ufl.edu',
'bbyrne@ufl.edu',
'brantml@medicine.ufl.edu',
'cmavian@ufl.edu',
'coy.heldermon@medicine.ufl.edu',
'hallemj@peds.ufl.edu',
'muna.canales@medicine.ufl.edu',
'santon@aging.ufl.edu',
'bbyrne@ufl.edu',
'cookrl@ufl.edu',
'cookrl@ufl.edu',
'oshechtm@phhp.url.edu',
'cleeuwen@aging.ufl.edu',
'davidclark@phhp.ufl.edu',
'sjnixon@psychiatry.ufl.edu')
ORDER BY EMAIL;


drop table work.temp;
create table work.temp as
SELECT ID AS IRBNUMBER,
NCT_Number,
Study_Staff,
Study_Staff_Role,
PeopleSoft_Proposal_Number,
Date_First_Subject_Signed_ICF,
Actual_Enrollment_Number,
Approved_Number_Of_Subjects,
Brief_Description
from lookup.myIRB
WHERE ID IN
(
'CED000000110',
'IRB201600271',
'IRB201600334',
'IRB201601141',
'IRB201601667',
'IRB201700035',
'IRB201700315',
'IRB201702227',
'IRB201702564',
'IRB201801264',
'IRB201802914'
);


drop table work.temp;
create table work.temp as
select * from lookup.wirb
WHERE `Protocol_#` IN
('20161353',
'20170344',
'20170440',
'20172089',
'20172226',
'20172818',
'20180018');

select * from lookup.wirb;
