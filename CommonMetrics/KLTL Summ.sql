

##################### KL TL Common Metrics 

Select * from Adhoc.cm_kltl_2018;


DROP TABLE IF EXISTS Adhoc.KLTLSummary; 
CREATE TABLE Adhoc.KLTLSummary AS

SELECT Program,
	   EndYear,
       COUNT(*) as numGRADs,
       SUM(StillinCTS) AS StillinCTS,
       SUM(Underserved*StillinCTS) as UnderServed,
       SUM(Female*StillinCTS) AS Female
from Adhoc.cm_kltl_2018     
       WHERE Completed=1
		 AND NCATSSupp=1
         AND EndYear<=2018
         AND EndYear>=2012
       GROUP BY Program,EndYear
       ORDER BY Program,EndYear;
       ;
	