drop table if exists work.irb;					
create table work.irb as					
select * from loaddata.myirb201908;					
					
#### Fix Date ERROR					
SET SQL_SAFE_UPDATES = 0;					
				
					
SET SQL_SAFE_UPDATES = 1;					
### FIX UFIDS					
					
				########## myirb201908	
SET SQL_SAFE_UPDATES = 0;					
UPDATE work.irb SET PI_UFID=LPAD(PI_UFID,8,'0');					
					
					
ALTER TABLE work.irb					
ADD 	IRB_Approval_Year integer(4),				
ADD 	IRB_Approval_Month varchar(12),				
ADD		IRB_APPROVAL_TIME integer(10),			
ADD		IRB_APPROVAL_TIME_NOPRESCREEN integer(10),			
ADD     PreReview_Days integer(10);					
					
					
					
UPDATE work.irb SET IRB_Approval_Year=Year(Date_Originally_Approved);					
UPDATE work.irb SET IRB_Approval_Month=concat(Year(Date_Originally_Approved),"-",LPAD(month(Date_Originally_Approved),2,'0'));					
					
UPDATE work.irb SET PreReview_Days=0;					
UPDATE work.irb SET PreReview_Days=datediff(First_Review_Date, Date_IRB_Received ) where First_Review_Date is not null;					
					
					
					
UPDATE work.irb SET IRB_APPROVAL_TIME_NOPRESCREEN = datediff(Date_Originally_Approved, Date_IRB_Received);					
UPDATE work.irb SET IRB_APPROVAL_TIME = datediff(Date_Originally_Approved, Date_IRB_Received)-PreReview_Days;					








SELECT 	IRB_Approval_Year,				
		COUNT(*) 			
from work.irb					
WHERE Committee="IRB-01"					
	AND Review_Type='Full IRB Review'				
group by IRB_Approval_Year;					
					
SELECT 	IRB_Approval_Month,				
		COUNT(*) 			
from work.irb					
WHERE Committee="IRB-01"					
	AND Review_Type='Full IRB Review'				
group by IRB_Approval_Month;					
					

## Annual Volume IRB-01 Full Board
SELECT 	Year(Date_Originally_Approved),				
		COUNT(*) 			
from work.irb					
WHERE Committee="IRB-01"					
	AND Review_Type='Full IRB Review'				
group by Year(Date_Originally_Approved);					
					
## Monthly Volume IRB-01 Full Board                    
SELECT 	concat(Year(Date_Originally_Approved),"-",LPAD(month(Date_Originally_Approved),2,'0')),				
		COUNT(*) 			
from work.irb					
WHERE Committee="IRB-01"					
	AND Review_Type='Full IRB Review'				
group by concat(Year(Date_Originally_Approved),"-",LPAD(month(Date_Originally_Approved),2,'0'));	