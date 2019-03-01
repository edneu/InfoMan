

### PILOT AWARD SURVEY 
### CREATE SUGGUESTED PUBLICATION AND GRANTS LIST FOR THOSE WITH NO Pub or GRANT
###

DROP TABLE IF EXISTS pilots.NeedSugg;
CREATE TABLE pilots.NeedSugg AS
SELECT Pilot_ID,Award_Year,AwardLetterDate,Award_Amt,PI_Last,PI_First,Title,Email,UFID,
       0 AS HasPub,
       0 AS HasGrant
FROM pilots.PILOTS_MASTER
WHERE Awarded="Awarded"
AND Award_Year>=2012;


SET SQL_SAFE_UPDATES = 0;

UPDATE pilots.NeedSugg NS, pilots.PILOTS_PUB_MASTER lu
SET NS.HasPub=1 
WHERE NS.Pilot_ID=lu.Pilot_ID; 

UPDATE pilots.NeedSugg NS, pilots.PILOTS_ROI_DETAIL lu
SET NS.HasGrant=1 
WHERE NS.Pilot_ID=lu.Pilot_ID; 


SELECT * FROM pilots.NeedSugg WHERE HasPub=0;

