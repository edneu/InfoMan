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