


drop table if exists work.covidacttemp;
Create table work.covidacttemp AS
select * from work.covindact_infile;


UPDATE work.covidacttemp SET Q4=1 WHERE Q4=1;
UPDATE work.covidacttemp SET Q4=2 WHERE Q4=13;
UPDATE work.covidacttemp SET Q4=3 WHERE Q4=14;
UPDATE work.covidacttemp SET Q4=4 WHERE Q4=15;
UPDATE work.covidacttemp SET Q4=5 WHERE Q4=16;
UPDATE work.covidacttemp SET Q4=6 WHERE Q4=17;
UPDATE work.covidacttemp SET Q4=7 WHERE Q4=18;
UPDATE work.covidacttemp SET Q4=8 WHERE Q4=19;
UPDATE work.covidacttemp SET Q4=9 WHERE Q4=20;
UPDATE work.covidacttemp SET Q4=10 WHERE Q4=21;
UPDATE work.covidacttemp SET Q4=11 WHERE Q4=22;
UPDATE work.covidacttemp SET Q4=12 WHERE Q4=23;

UPDATE work.covidacttemp SET Q9=1 WHERE Q9=13;
UPDATE work.covidacttemp SET Q9=2 WHERE Q9=14;
UPDATE work.covidacttemp SET Q9=3 WHERE Q9=15;
UPDATE work.covidacttemp SET Q9=4 WHERE Q9=16;
UPDATE work.covidacttemp SET Q9=5 WHERE Q9=17;
UPDATE work.covidacttemp SET Q9=6 WHERE Q9=18;
UPDATE work.covidacttemp SET Q9=7 WHERE Q9=19;
UPDATE work.covidacttemp SET Q9=8 WHERE Q9=20;
UPDATE work.covidacttemp SET Q9=9 WHERE Q9=21;
UPDATE work.covidacttemp SET Q9=10 WHERE Q9=22;
UPDATE work.covidacttemp SET Q9=11 WHERE Q9=23;
UPDATE work.covidacttemp SET Q9=12 WHERE Q9=24;


UPDATE work.covidacttemp SET Q15=1 WHERE Q15=13;
UPDATE work.covidacttemp SET Q15=2 WHERE Q15=14;
UPDATE work.covidacttemp SET Q15=3 WHERE Q15=15;
UPDATE work.covidacttemp SET Q15=4 WHERE Q15=16;
UPDATE work.covidacttemp SET Q15=5 WHERE Q15=17;
UPDATE work.covidacttemp SET Q15=6 WHERE Q15=18;
UPDATE work.covidacttemp SET Q15=7 WHERE Q15=19;
UPDATE work.covidacttemp SET Q15=8 WHERE Q15=20;
UPDATE work.covidacttemp SET Q15=9 WHERE Q15=21;
UPDATE work.covidacttemp SET Q15=10 WHERE Q15=22;
UPDATE work.covidacttemp SET Q15=11 WHERE Q15=23;
UPDATE work.covidacttemp SET Q15=12 WHERE Q15=24;







DROP TABLE IF EXISTS  work.COVID_ACTIVITY;
Create table work.COVID_ACTIVITY AS
SELECT 	ResponseId AS ResponseId,
		Q2_1 AS FirstName,
		Q2_2 AS LastName,
		Q2_3 AS Department,
		Q2_4 AS WorkTitle,
		Q2_5 AS Email,
		Q2_6 AS Phone,
		Q3 AS Title,
		Q4 AS CatCODE,
		Q5 AS OtherCat,
		Q6 AS ProjDesc
from work.covidacttemp
WHERE Q3 IS NOT NULL
UNION ALL
SELECT 	ResponseId AS ResponseId,
		Q2_1 AS FirstName,
		Q2_2 AS LastName,
		Q2_3 AS Department,
		Q2_4 AS WorkTitle,
		Q2_5 AS Email,
		Q2_6 AS Phone,
		Q8 AS Title,
		Q9 AS CatCODE,
		Q10 AS OtherCat,
		Q11 AS ProjDesc
from work.covidacttemp
WHERE Q8 IS NOT NULL
UNION ALL
SELECT 	ResponseId AS ResponseId,
	Q2_1 AS FirstName,
	Q2_2 AS LastName,
	Q2_3 AS Department,
	Q2_4 AS WorkTitle,
	Q2_5 AS Email,
	Q2_6 AS Phone,
	Q14 AS Title,
	Q15 AS CatCODE,
	Q17 AS OtherCat,
	Q16 AS ProjDesc
from work.covidacttemp
WHERE Q14 IS NOT NULL;


ALTER TABLE work.COVID_ACTIVITY ADD Category varchar(125);

UPDATE work.COVID_ACTIVITY 
SET Category=OtherCat
WHERE Category="Other" and OtherCat IS NOT NULL;

UPDATE work.COVID_ACTIVITY ca, lookup.covid_proj_cat lu
SET ca.Category=lu.Category
WHERE ca.CatCODE=lu.CatCODE;


DROP  TABLE IF EXISTS results.COVID_ACT_OUT;
CREATE TABLE results.COVID_ACT_OUT AS
SELECT 	ResponseId,
		FirstName,
		LastName,
		Department,
		WorkTitle,
		Email,
		Phone,
		Title,
		Category,
		ProjDesc
FROM work.COVID_ACTIVITY
ORDER BY LastName,FirstName;





DROP TABLE IF EXISTS  results.COVID_ACT_COMMENT_OUT;
Create table results.COVID_ACT_COMMENT_OUT AS
SELECT 	ResponseId AS ResponseId,
		Q2_1 AS FirstName,
		Q2_2 AS LastName,
		Q2_3 AS Department,
		Q2_4 AS WorkTitle,
		Q2_5 AS Email,
		Q2_6 AS Phone,
		Q12 as OtherComment
from work.covidacttemp
WHERE Q12 IS NOT NULL
ORDER BY Q2_2,Q2_1;
;