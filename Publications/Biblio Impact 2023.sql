

select * from work.issn_work;

desc work.issn_work;

ALTER TABLE work.issn_work
	ADD JTitle varchar(255),
	ADD JAbbrTitl varchar(25),
	ADD Total_Cites int(11),
	ADD JIF Decimal(65,30),
	ADD JIF_noSelf Decimal(65,30),
	ADD JIF5yr decimal(65,30);
    
SET SQL_SAFE_UPDATES = 0;    
    
    
UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN1_AM=lu.ISSN
  AND  isn.Journal_ISSN2_AM=lu.`ISSN-2`;     
  
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN1_AM=lu.ISSN
  AND isn.JIF is Null; 
        
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN1_AM=lu.ISSN
  AND isn.JTitle is Null; 
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN1_AM=lu.`ISSN-2`
  AND isn.JTitle is Null;   
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN2_AM=lu.`ISSN-2`
  AND isn.JTitle is Null;    
  
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE isn.Journal_ISSN1_AM=lu.`ISSN-2`
  AND isn.JTitle is Null;   
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE substr(isn.Journal_ISSN2_AM,1,8)=substr(lu.ISSN,1,8)
  AND isn.JTitle is Null;      
  
  UPDATE work.issn_work isn, lookup.jcr_impact_factor lu
SET 	isn.JTitle=lu.Full_Journal_Title,
		isn.JAbbrTitl=lu.JCR_Abbreviated_Title,
        isn.Total_Cites=lu.Total_Cites,
        isn.JIF=lu.Journal_Impact_Factor,
        isn.JIF_noSelf=lu.Impact_Factor_without_Journal_Self_Cites,
        isn.JIF5yr=lu.Five_Year_Impact_Factor
WHERE substr(isn.Journal_ISSN2_AM,1,8)=substr(lu.ISSN,1,8)
  AND isn.JTitle is Null;  




select * from lookup.jcr_impact_factor;

select count(*) from work.issn_work where JTitle is Null ;


##################################################################
Select * from work.biblio_impact;


select count(distinct PMID) from work.biblio_impact; 
Select Award,
	   count(distinct PMID) as nPubs, 
       avg(Citations_Per_Year_Icite) AS avgCiteYr, 
       min(Citations_Per_Year_Icite) as MinCiteYr,
       Max(Citations_Per_Year_Icite) as MinCiteYr,
       AVG(RCR_iCITE) as AvgRCR, 
       Max(RCR_iCITE) as MaxRCR,
       AVG(NIH_Percentile_iCITE) as AvgNIHPct, 
       Max(NIH_Percentile_iCITE) as MaxNIHPct
 from work.biblio_impact Group by Award;
       

