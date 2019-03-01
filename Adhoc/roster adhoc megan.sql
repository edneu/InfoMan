

SELECT YEAR,COUNT(DISTINCT PERSON_KEY)
FROM lookup.roster
WHERE Roster=1
group by Year;

select distinct FacType from lookup.roster;

select FacType,Roster,count(*) from lookup.roster where Year=2017 group by FacType,Roster;

UPDATE lookup.roster
SET Roster=1
WHERE FacType IN ('Assistant Professor','Associate Professor','Professor')
AND YEAR=2017;

SELECT YEAR,COUNT(DISTINCT PERSON_KEY)
FROM lookup.roster
WHERE FacType in ('Trainee','Assistant Professor','Associate Professor','Professor')
AND STD_PROGRAM NOT IN ('UNDEFINED','Study Registry','Simulation Center','Research Coordinator Consortium','PubMed Compliance','Evaluation',
						'Clinical Research Professionals Advisory Council','CTRB_Investigators')
group by Year;