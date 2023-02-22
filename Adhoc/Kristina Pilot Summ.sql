
SELECT Category, 
       count(*) as nAwards,
       sum(Award_Amt) as AmtAwarded
from pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
GROUP BY Category;

SET SQL_SAFE_UPDATES = 0;
UPDATE pilots.PILOTS_MASTER SET Category='Network Science' WHERE Category='Network';


SELECT MIN(AwardLetterDate), max(AwardLetterDate) from pilots.PILOTS_MASTER
WHERE Awarded="Awarded";