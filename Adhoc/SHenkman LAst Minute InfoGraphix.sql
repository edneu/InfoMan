

select distinct STD_PROGRAM from  lookup.roster;

SELECT FacType,count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='BERD'
GROUP BY FacType;

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='BERD'
AND Faculty="Faculty";

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='BERD';

######################################

select distinct STD_PROGRAM from  lookup.roster;

SELECT FacType,count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='REDCap'
GROUP BY FacType;

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='REDCap'
AND Faculty="Faculty";

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='REDCap';

##################################
#################################
## Recruitment Centert


select distinct STD_PROGRAM from  lookup.roster;

SELECT FacType,count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='Recruitment Center'
GROUP BY FacType;

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='Recruitment Center'
AND Faculty="Faculty";

SELECT count(distinct Person_key) as nUNDUP
FROm lookup.roster
WHERE Year>=2018
AND STD_PROGRAM='Recruitment Center';