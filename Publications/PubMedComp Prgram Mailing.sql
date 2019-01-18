
############################
############################
############################

UPDATE pubs.pmc_comp_mail pm, pubs.PUB_CORE lu
SET pm.Citation=lu.Citation
WHERE pm.pubmaster_id2=lu.pubmaster_id2;

drop table if exists pubs.pubmail;
create table pubs.pubmail as
SELECT * from pubs.pmc_comp_mail
ORDER BY Email;


select distinct citation,PubFMT from  pubs.pubmail;

ALTER TABLE pubs.pubmail ADD PubFMT varchar(4000);


UPDATE pubs.pubmail
   SET PubFMT=CONCAT(TRIM(Citation));


UPDATE pubs.pubmail
   SET PubFMT=CONCAT(TRIM(PubFMT),'\r  CTSI Authors: ',trim(CTSI_Author))
   WHERE CTSI_Author<>" "; 

UPDATE pubs.pubmail
SET PubFMT=concat(TRIM(PubFMT),'\r  CTSI Grant Cited: ',Grant_Number_Cited)
WHERE Grant_Number_Cited<>" ";

drop table if exists pubs.temp;
create table pubs.temp as
select PubFMT from pubs.pubmail;



#### SPANS FOR QUALTRICS 
############ ## 10 Spans

DROP TABLE IF EXISTS pubs.PMCMail ;
CREATE TABLE pubs.PMCMail AS 
SELECT Email,
       Max(Last) as Last,
       Max(First) as First
from work.pubmail
group by Email
order by Email;



ALTER TABLE pubs.PMCMail
	ADD Pub1 varchar(4000),
	ADD pubmasterid1 int(11),

	ADD Pub2 varchar(4000),
	ADD pubmasterid2 int(11),

	ADD Pub3 varchar(4000),
	ADD pubmasterid3 int(11),

	ADD Pub4 varchar(4000),
	ADD pubmasterid4 int(11),

	ADD Pub5 varchar(4000),
	ADD pubmasterid5 int(11),

	ADD Pub6 varchar(4000),
	ADD pubmasterid6 int(11),

	ADD Pub7 varchar(4000),
	ADD pubmasterid7 int(11),

	ADD Pub8 varchar(4000),
	ADD pubmasterid8 int(11),

	ADD Pub9 varchar(4000),
	ADD pubmasterid9 int(11),

	ADD Pub10 varchar(4000),
	ADD pubmasterid10 int(11);

select * from  pubs.PMCMail;


Select t1.Email,
       t1.pubmaster_id2,	
	   count(*) as Span
from pubs.pubmail t1
group by t1.Email,
       t1.pubmaster_id2;


Drop table work.mailRank ;
Create table work.mailRank as
Select t1.Email,
       t1.pubmaster_id2,	
	   count(*) as Span
from pubs.pubmail AS t1
join pubs.pubmail AS t2 
     on (t2.pubmaster_id2, t2.Email) >= (t1.pubmaster_id2, t1.Email)
    and t1.Email = t2.Email
Group by t1.Email, t1.pubmaster_id2
Order by t1.Email, Span;


### 
### 



select * from pubs.pubmail ORDER by EMAIL, Span;

ALTER TABLE  pubs.pubmail ADD Span int(11);

UPDATE pubs.pubmail pm, work.mailRank lu
SET pm.Span=lu.Span
WHERE pm.Email=lu.Email
  AND pm.pubmaster_id2=lu.pubmaster_id2;




UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub1=lu.PubFMT,
    pm.pubmasterid1=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=1;    	


UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub2=lu.PubFMT,
    pm.pubmasterid2=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=2;    	


UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub3=lu.PubFMT,
    pm.pubmasterid3=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=3;   

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub4=lu.PubFMT,
    pm.pubmasterid4=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=4;  


UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub5=lu.PubFMT,
    pm.pubmasterid5=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=5;  

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub6=lu.PubFMT,
    pm.pubmasterid6=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=6;  

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub7=lu.PubFMT,
    pm.pubmasterid7=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=7; 

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub8=lu.PubFMT,
    pm.pubmasterid8=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=8; 

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub9=lu.PubFMT,
    pm.pubmasterid9=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=9; 

UPDATE pubs.PMCMail pm, pubs.pubmail lu
SET pm.pub10=lu.PubFMT,
    pm.pubmasterid10=lu.pubmaster_id2
Where pm.Email=lu.Email
and lu.Span=10; 


select * from pubs.PMCMail;



/*



###
/*
Drop table work.SpaceRank ;
Create table work.SpaceRank as
Select t1.AWARD_INV_UFID,
       t1.AWARD_ID,	
	   count(*) as Span
from work.bondmaster AS t1
join work.bondmaster AS t2 
     on (t2.AWARD_ID, t2.AWARD_INV_UFID) >= (t1.AWARD_ID, t1.AWARD_INV_UFID)
    and t1.AWARD_INV_UFID = t2.AWARD_INV_UFID
Group by t1.AWARD_INV_UFID, t1.AWARD_ID
Order by t1.AWARD_INV_UFID, Span;
*/