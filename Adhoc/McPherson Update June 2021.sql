select count(Pilot_ID),SUM(Award_Amt) from pilots.PILOTS_MASTER WHERE Awarded="Awarded" AND Award_year >=2008;
AND Category<>"SECIM";

298 Pilot Awards (including SECIM) totaling $7,433,763 since 2008
243 Pilot Awards (Excluding SECIM) totalling $6,356,216 since 2008

SELECT College,count(distinct Person_KEY) from lookup.roster Group BY College;

SELECT COUNT(DISTINCT PERSON_KEY) from lookup.roster WHERE Faculty="Faculty";

SELECT FacType,COUNT(DISTINCT PERSON_KEY) from lookup.roster group by FacType; 

SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Awarded
FROM 
lookup.awards_history
WHERE REPORTING_SPONSOR_AWD_ID
	IN ("UL1TR001427","UL1RR029890","UL1TR001427");
    
    
    
 
SELECT SUM(SPONSOR_AUTHORIZED_AMOUNT) AS Awarded
FROM 
lookup.awards_history
where    
REPORTING_SPONSOR_AWD_ID like '%KL2RR029888%' OR 	
REPORTING_SPONSOR_AWD_ID like '%KL2TR000065%' OR 		
REPORTING_SPONSOR_AWD_ID like '%KL2TR001429%' OR 		
REPORTING_SPONSOR_AWD_ID like '%TL1RR029889%' OR 		
REPORTING_SPONSOR_AWD_ID like '%L1TR000066%' OR 		
REPORTING_SPONSOR_AWD_ID like '%TL1TR001428%' OR 	
REPORTING_SPONSOR_AWD_ID like '%UL1RR029890%' OR 	   
REPORTING_SPONSOR_AWD_ID like '%UL1TR000064%' OR 		
REPORTING_SPONSOR_AWD_ID like '%UL1TR001427%' ; 	


McCurdy, Christopher R
McCall-Wright,  Patti
Rethlefsen,  Melissa 
	
