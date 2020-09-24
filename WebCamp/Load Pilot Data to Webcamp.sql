DROP TABLE IF EXISTS work.pilotloadwebcamp ;
create table work.pilotloadwebcamp AS
SELECT 	Pilot_ID AS Protocol_ID,
		" " AS Short_Title, 
		Title AS Full_Title,
        "Pilot Award" as ProjectType,
        PI_Last AS PI_Last_Name,
        PI_First AS PI_First_Name,
        " " AS PI_Middle_Name,
        Email as PI_Email,
        " " AS Project_Abstract
from pilots.PILOTS_MASTER
WHERE Awarded="Awarded" ;       

desc work.pilotloadwebcamp ;


desc pilots.PILOTS_MASTER;