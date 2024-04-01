DROP TABLE IF EXISTS work.CollUndup;
Create Table work.CollUndup as
Select 	Display_College,
		Count(Distinct Person_key) AS Undup
from lookup.roster
WHERE Display_College IS NOT NULL
GROUP BY Display_College
ORDER BY Undup DESC ;



