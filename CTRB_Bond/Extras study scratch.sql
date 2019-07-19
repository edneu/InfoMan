
SELECT * FROM lookup.awards_history
WHERE CLK_AWD_PRJ_START_DT<=STR_TO_DATE(concat('06,30,',year(curdate())),'%m,%d,%Y')
  and CLK_AWD_PRJ_END_DT>=STR_TO_DATE(concat('07,01,',year(curdate())-1),'%m,%d,%Y')
 AND CLK_AWD_FULL_TITLE LIKE "%DRUG%Surveillance%";

 
 
 
 
 AND CLK_AWD_ IN ('AWD05906')
 
 
 ;
  
  
  
 
AND CLK_AWD_PROJ_NAME Like ('%PDG%');


	  AND CLK_AWD_ID IN ('AWD02770');	
        AWD04769
        00098607
        
S
SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT)
FROM lookup.awards_history
WHERE CLK_AWD_PRJ_START_DT<=STR_TO_DATE(concat('06,30,',year(curdate())),'%m,%d,%Y')
  and CLK_AWD_PRJ_END_DT>=STR_TO_DATE(concat('07,01,',year(curdate())-1),'%m,%d,%Y')
  AND CLK_AWD_ID IN ('AWD01451');
  
  
AND CLK_AWD_PROJ_NAME Like ('%IGNITE%');






SELECT 
    CLK_AWD_PI,
	REPORTING_SPONSOR_NAME,
    REPORTING_SPONSOR_AWD_ID,
	CLK_AWD_PROJ_NAME,
	CLK_AWD_ID,
	REPORTING_SPONSOR_CAT
from lookup.awards_history

WHERE CLK_AWD_ID="AWD00737";

#WHERE CLK_PI_UFID ="19463669";

WHERE CLK_AWD_PROJ_NAME LIKE "%Applied%Research%Genomic%";



WHERE CLK_AWD_PROJ_ID LIKE "PRO00015111";
##WHERE CLK_AWD_ID='00070484';


WHERE REPORTING_SPONSOR_AWD_ID LIKE "%PR%O00015111";

WHERE CLK_PI_UFID ="61961877";
;


WHERE 	CLK_AWD_PROJ_NAME LIKE "Intermittent%Hypoxia%";

select UF_EMAIL,UF_UFID,UF_DISPLAY_NM from lookup.ufids
where UF_EMAIL IN
('bksmith@phhp.ufl.edu',
'jimax.chen@ufl.edu',
'julie.johnson@ufl.edu',
'lbcottler@ufl.edu',
'lbcottler@ufl.edu',
'm.prosperi@ufl.edu',
'm.prosperi@ufl.edu',
'matthewgurka@ufl.edu',
'matthewgurka@ufl.edu',
'mmmm@ufl.edu',
's.subramony@neurology.ufl.edu',
's.subramony@neurology.ufl.edu',
'tapearson@ufl.edu'

);

UPDATE space.bondmaster SET CTRB_PCT=100 WHERE bondmaster_key=315;
UPDATE space.bondmaster SET CTRB_PCT=75 WHERE bondmaster_key=128;
UPDATE space.bondmaster SET CTRB_PCT=50 WHERE bondmaster_key=65;
UPDATE space.bondmaster SET CTRB_PCT=20 WHERE bondmaster_key=33;





SELECT bondmaster_key,LastName,FirstName,IP_USAGE,CTRB_PCT,CTRB_PCT_PREV 
from space.bondmaster
WHERE IP_USAGE="Good" AND
CTRB_PCT_PREV>CTRB_PCT;



#########################################################

























