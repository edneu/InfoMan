 select * from work.ss_emails;

ALter Table work.ss_emails
DROP Lastname ,
DROP Firstname ,
DROP UF_EMAIL;

ALter Table work.ss_emails
ADD Lastname varchar(50),
ADD Firstname varchar(50),
ADD UF_EMAIL varchar(255);

UPDATE work.ss_emails ss, lookup.email_master lu
SET ss.Lastname=lu.Lastname,
	ss.Firstname=lu.Firstname,
    ss.UF_EMAIL=lu.UF_EMAIL
WHERE lu.UF_PRIMARY_FLG="Y"
AND ss.UFID=lu.UF_UFID;    


UPDATE work.ss_emails ss, lookup.ufids lu
SET ss.Lastname=lu.UF_LAST_NM,
	ss.Firstname=lu.UF_FIRST_NM,
    ss.UF_EMAIL=lu.UF_EMAIL
WHERE ss.UF_EMAIL is null
AND ss.UFID=lu.UF_UFID;  


UPDATE work.ss_emails ss, lookup.email_master lu
SET ss.Lastname=lu.Lastname,
	ss.Firstname=lu.Firstname,
    ss.UF_EMAIL=lu.UF_EMAIL
WHERE lu.UF_PRIMARY_FLG<>"Y"
AND ss.UF_EMAIL IS NULL
AND ss.UFID=lu.UF_UFID;   


select * from lookup.ufids where UF_UFID in (select distinct UF_UFID from work.ss_emails WHERE UF_EMAIL is null);
select * from work.ss_emails where UF_EMAIL is null;

select * from lookup.ufids where UF_UFID='38103242';
'97794770';
489-9185
8133-160
38103242
