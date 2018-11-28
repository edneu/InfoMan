##############
drop table if exists results.rosterPubmed;
create table results.rosterPubmed as
select Year,
       count(*) Total_Records,
	   count(distinct Person_key) AS Num_People
from  lookup.roster
group by Year;

ALTER TABLE results.rosterPubmed ADD Num_Pubmed_Records integer(10),
					             ADD Num_Pubmed_People integer(10),
                                 ADD Num_People_pubmed_only integer(10);

drop table if exists work.t2;
create table work.t2 AS
select Year,
       count(*) AS Num_Pubmed_Records
FROM lookup.roster
where STD_PROGRAM="PubMed Compliance"
group by Year;

drop table if exists work.t3;
create table work.t3 AS
select Year,
       count(DISTINCT Person_key) AS Num_Pubmed_People 
FROM lookup.roster
where STD_PROGRAM="PubMed Compliance"
group by Year;




drop table if exists work.t4;
create table work.t4 as
select 2008 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2008
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2008 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2009 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2009
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2009 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2010 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2010
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2010 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2011 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2011
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2011 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2012 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2012
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2012 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2013 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2013
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2013 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2014 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2014
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2014 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2015 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2015
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2015 AND STD_PROGRAM<>"PubMed Compliance")
UNION ALL
select 2016 AS Year,count(DISTINCT Person_key) AS Num_People_pubmed_only
from  lookup.roster
WHERE Year=2016
  AND STD_PROGRAM="PubMed Compliance"
  AND Person_key NOT IN (SELECT DISTINCT Person_key from lookup.roster WHERE Year=2016 AND STD_PROGRAM<>"PubMed Compliance");

select * from  work.t4;


UPDATE results.rosterPubmed rp, work.t2 lu
SET rp.Num_Pubmed_Records=lu.Num_Pubmed_Records
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t3 lu
SET rp.Num_Pubmed_People=lu.Num_Pubmed_People
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t3 lu
SET rp.Num_Pubmed_People=lu.Num_Pubmed_People
WHERE rp.Year=lu.Year;

UPDATE results.rosterPubmed rp, work.t4 lu
SET rp.Num_People_pubmed_only=lu.Num_People_pubmed_only
WHERE rp.Year=lu.Year;


select * from results.rosterPubmed order by Year;


select count(*) from loaddata.roster;
 

