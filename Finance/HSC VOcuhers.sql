
######### ADD Standard SFY Varaible to TransHist
ALTER TABLE Adhoc.combined_hist_rept ADD SFY varchar(13);

SET SQL_SAFE_UPDATES = 0;
UPDATE Adhoc.combined_hist_rept th, lookup.sfy_classify lu
SET th.SFY=lu.SFY
WHERE th.TransMonth=lu.Month;



Select
		"Voucher File" AS Source, 
		SFY, 
		sum(Amount) as Amount, 
        count(*) as nRecs
	from lookup.Vouchers 
	WHERE SFY IN('SFY 2019-2020','SFY 2020-2021')
	GROUP BY Source,SFY
UNION ALL
SELECT 	"Trans Hist" AS Source, 
		SFY,
		SUM(Posted_Amount) as Amount,
        count(*) as nRecs
from Adhoc.combined_hist_rept 
WHERE SFY IN('SFY 2019-2020','SFY 2020-2021')
AND Alt_Dept_ID='29680704'
GROUP BY SFY;

SELECT Fiscal_Year from  Adhoc.combined_hist_rept ;

DROP TABLE if EXISTS work.thist20192021;
create table work.thist20192021 AS
SELECT 	*
from Adhoc.combined_hist_rept 
WHERE SFY IN('SFY 2019-2020','SFY 2020-2021')
AND Alt_Dept_ID='29680704';

DROP TABLE if EXISTS work.vouch20192021;
create table work.vouch20192021 AS
Select *
from lookup.Vouchers 
	WHERE SFY IN('SFY 2019-2020','SFY 2020-2021')
;


#########################################################################################
