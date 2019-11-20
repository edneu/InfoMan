##Part 1


Select count(*) from lookup.roster;

Select count(distinct Person_key) from lookup.roster;

SELECT Year, count(*) from lookup.roster group by Year;

SELECT Year, count(distinct Person_key) from lookup.roster group by Year;

SELECT Year, count(distinct Person_key) from lookup.roster 
Where Faculty="Faculty"
group by Year;



## PART 2
#1
SELECT UF_GENDER_CD,Count(DISTINCT UF_UFID) 
from lookup.ufids
GROUP BY UF_GENDER_CD;

#2
Select Count(*),Count(Distinct UF_UFID) from  lookup.ufids ;

#3
SELECT UF_FIRST_NM
from lookup.ufids
WHERE UF_LAST_NM IN ("Bergerson",
					"Skolnick",
					"Neu",
					"Fischbach")
GROUP BY UF_FIRST_NM;                    
;

#4
SELECT UF_FIRST_NM, COUNT( DISTINCT UF_FIRST_NM)
from lookup.ufids
WHERE UF_LAST_NM IN ("Bergerson",
					"Skolnick",
					"Neu",
					"Fischbach")
GROUP BY UF_FIRST_NM;   




#5
Select Count(distinct Person_key) 
from lookup.roster
Where Year=2018
AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster where Year=2017);

#6
Select Count(distinct Person_key) 
from lookup.roster
Where Year=2018
AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster where Year<=2017);





