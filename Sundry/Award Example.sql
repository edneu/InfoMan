##I used REPORTING_SPONSOR_AWD_ID instead of CLK_MOD_SPON_AWD_ID, both both provided the same results.

## This quesy uses the award ID for any that match the Prime Sponsor AwardID, 
##  Note the Suffix such as '-02' is ofthen omitted in this file
SELECT * from lookup.awards_history
WHERE CLK_AWD_ID IN 
(SELECT DISTINCT CLK_AWD_ID from lookup.awards_history
		WHERE REPORTING_SPONSOR_AWD_ID LIKE "%R01%CA207689%");


##This the same thing with less columns

SELECT 	CLK_AWD_ID,
		CLK_AWD_PI,
		FUNDS_ACTIVATED,
		CLK_AWD_PROJ_ID,
		CLK_AWD_PROJ_MGR,
		CLK_AWD_PROJ_MGR_UFID,
		CLK_AWD_PROJ_NAME,
		DIRECT_AMOUNT,
		INDIRECT_AMOUNT,
		SPONSOR_AUTHORIZED_AMOUNT
from lookup.awards_history
WHERE CLK_AWD_ID IN 
(SELECT DISTINCT CLK_AWD_ID from lookup.awards_history
		WHERE REPORTING_SPONSOR_AWD_ID  LIKE "%R01%CA207689%");

##This the same thing with less columns
## This is the Less Column Version for Dr Thomas George
SELECT 	CLK_AWD_ID,
		CLK_AWD_PI,
		FUNDS_ACTIVATED,
		CLK_AWD_PROJ_ID,
		CLK_AWD_PROJ_MGR,
		CLK_AWD_PROJ_MGR_UFID,
		CLK_AWD_PROJ_NAME,
		DIRECT_AMOUNT,
		INDIRECT_AMOUNT,
		SPONSOR_AUTHORIZED_AMOUNT
from lookup.awards_history
WHERE CLK_AWD_ID IN 
(SELECT DISTINCT CLK_AWD_ID from lookup.awards_history
		WHERE REPORTING_SPONSOR_AWD_ID  LIKE "%R01%CA207689%")
AND CLK_AWD_PROJ_MGR_UFID='29392400';   ## Thomas George Only



####   A Total for Dr. George
SELECT 	CLK_AWD_ID,
		CLK_AWD_PI,
		CLK_AWD_PROJ_ID,
		CLK_AWD_PROJ_MGR,
		CLK_AWD_PROJ_MGR_UFID,
		CLK_AWD_PROJ_NAME,
		SUM(DIRECT_AMOUNT) AS Direct,
		SUM(INDIRECT_AMOUNT) AS InDirect,
		SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Total
from lookup.awards_history
WHERE CLK_AWD_ID IN 
(SELECT DISTINCT CLK_AWD_ID from lookup.awards_history
		WHERE REPORTING_SPONSOR_AWD_ID  LIKE "%R01%CA207689%")
AND CLK_AWD_PROJ_MGR_UFID='29392400'
GROUP BY CLK_AWD_ID,
		CLK_AWD_PI,
		CLK_AWD_PROJ_ID,
		CLK_AWD_PROJ_MGR,
		CLK_AWD_PROJ_MGR_UFID,
		CLK_AWD_PROJ_NAME;