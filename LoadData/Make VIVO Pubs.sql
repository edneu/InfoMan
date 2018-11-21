SET sql_mode = '';
SET SQL_SAFE_UPDATES = 0;


drop table if exists loaddata.vivonov2017;
CREATE TABLE loaddata.vivonov2017
(
	vivoid Integer auto_increment primary key,
	gatorlink Varchar(45) not null,
	author Varchar(255) not null,
	fName Varchar(45) not null,
	lName Varchar(45) not null,
	article Varchar(255) not null,
	articlelabel Varchar(4000) not null,
	journal_uri Varchar(255) not null,
	journal_label Varchar(4000) not null,
	pub_date Varchar(25) not null,
	pubmed_id Integer not null
);




load data local infile "P:\\My Documents\\My Documents\\Loaddata\\VivoNov2017.txt" 
into table loaddata.vivonov2017 
fields terminated by '\t'
lines terminated by '\n'
( 	gatorlink,
	author,
	fName,
	lName,
	article,
	articlelabel,
	journal_uri,
	journal_label,
	pub_date,
	pubmed_id
);





DELETE from loaddata.vivonov2017 where gatorlink="gatorlink";

select count(*) from loaddata.vivonov2017;

drop table if exists work.vivopubs;
create table work.vivopubs as
select * from loaddata.vivonov2017;


select distinct pub_date from work.vivopubs;

Alter Table work.vivopubs ADD ufid varchar(12),
                          ADD email varchar(125),
                          ADD PubDate date,  
                          ADD PubYear integer (4);


SET SQL_SAFE_UPDATES = 0;
SET sql_mode = '';


drop table if exists work.vivoglink;
create table work.vivoglink as
select * from lookup.ufids
where UF_USER_NM IN
(SELECT distinct gatorlink from work.vivopubs
 WHERE Gatorlink<>"");

CREATE INDEX glink2 ON work.vivoglink (UF_USER_NM);

drop table if exists work.vivogl;
CREATE TABLE work.vivogl as
select * from work.vivopubs
WHERE Gatorlink<>"";

drop table if exists work.vivonogl;
CREATE TABLE work.vivonogl as
select * from work.vivopubs
WHERE Gatorlink="";




update work.vivogl vp, work.vivoglink lu
set vp.ufid=lu.UF_UFID,
    vp.email=lu.UF_EMAIL
WHERE vp.gatorlink=lu.UF_USER_NM
AND vp.gatorlink<>"" ;

DROP TABLE IF exists work.vivopubs;
create table work.vivopubs AS
select * from work.vivogl
UNION ALL
select * from work.vivonogl;

select distinct pub_date from work.vivopubs;

update work.vivopubs set PubDate=DATE_ADD("1900-01-01",INTERVAL pub_date-2 DAY) WHERE LENGTH(TRIM(pub_date))=5;

update work.vivopubs set PubDate=str_to_date(concat(substr(pub_date,6,2),",",substr(pub_date,9,2),",",substr(pub_date,1,4)),'%m,%d,%Y') WHERE LENGTH(pub_date)>5;

update work.vivopubs set PubYear=year(PubDate);

select Pubyear,pub_date,PubDate from work.vivopubs;

select PubYear,count(*) from work.vivopubs group by PubYear;
#select PubDate,count(*) from work.vivopubs group by PubDate;

##select pub_date,PubDate,PubYear, count(*) from work.vivopubs where Pubyear=1948 group by pub_date,PubDate,PubYear ;
##ALTER TABLE work.vivopubs DROP pub_date;
Alter table work.vivopubs
Add AnyRoster int(1),
Add RosterYear int(1);

UPDATE work.vivopubs set AnyRoster=0,
                         RosterYear=0  ;

UPDATE work.vivopubs set AnyRoster=1
where ufid in (select distinct UFID from lookup.roster where Roster=1 and UFID NOT IN ("","00000000"));

UPDATE work.vivopubs vp, lookup.roster lu
set RosterYear=1
where vp.ufid=lu.UFID
  AND vp.PubYear=lu.Year
  AND lu.Roster=1
  AND vp.ufid NOT IN ("","00000000");
 

drop table if exists lookup.vivo_pubs;
create table lookup.vivo_pubs as
select * from work.vivopubs;


select PubYear,count(distinct article) AS articles from lookup.vivo_pubs
group by Pubyear 
order by PubYear;

select PubYear,count(distinct article) AS articles from lookup.vivo_pubs
WHERE AnyRoster=1
group by Pubyear 
order by PubYear;

select PubYear,count(distinct article) AS articles from lookup.vivo_pubs
WHERE RosterYear=1
group by Pubyear 
order by PubYear;

############

select count(*) as records, count(distinct article) AS articles from lookup.vivo_pubs;

select * from lookup.vivo_pubs Where RosterYear=1;

select * from lookup.vivo_pubs where RosterYear=0 and AnyRoster=1;


select PubYear,count(distinct article) from lookup.vivo_pubs group by PubYear;
select count(distinct article) from lookup.vivo_pubs WHERE Gatorlink<>"";

select count(distinct article) from work.vivopubs;
select count(distinct article) from work.vivopubs WHERE Gatorlink<>"";



select PubYear,count(distinct article) from work.vivopubs group by PubYear;

select PubYear,count(distinct article) from work.vivopubs WHERE gatorlink<>'' group by PubYear;
select PubYear,count(distinct article) from work.vivopubs WHERE UFID IS NOT NULL group by PubYear;

select Pubyear,count(*) from work.vivopubs group by PubYear;

select Pubyear,count(*) from work.vivopubs WHERE gatorlink<>"" group by PubYear;

select distinct gatorlink from work.vivopubs where Gatorlink ='';
select distinct UFID from work.vivopubs ;
select distinct Gatorlink,UFID,count(*) from work.vivopubs where UFID is NULL group by Gatorlink,UFID ;
select distinct Gatorlink,UFID,count(Distinct article) from work.vivopubs where UFID is NULL group by Gatorlink,UFID ;

select count(distinct article) from work.vivopubs where Gatorlink="tapearson";
select count(*) from work.vivopubs where Gatorlink="tapearson";
;

select count(*) from work.vivopubs;

select * from work.vivopubs where Gatorlink="nelsodr";


select fname,lName from work.vivopubs where Gatorlink="nelsodr" group by fname,lname;


create table work,vivopub200817 AS
select * from work.vivopubs
where 

create table work.pearson
select * from work.vivopubs
where Gatorlink="tapearson";

create table work.nelsodr
select * from work.vivopubs
where Gatorlink="nelsodr";


desc work.vivopubs;

drop table if exists work.vivoundup;
create table work.vivoundup as 
select 
min(vivoid) as vivoid,
gatorlink,
author,
fName,
lName,
article,
articlelabel,
journal_uri,
journal_label,
pub_date,
pubmed_id,
ufid,
email,
PubDate,
PubYear

from work.vivopubs
group by
gatorlink,
author,
fName,
lName,
article,
articlelabel,
journal_uri,
journal_label,
pub_date,
pubmed_id,
ufid,
email,
PubDate,
PubYear;


select count(*) from work.vivoundup where Gatorlink="tapearson";
select count(distinct article) from work.vivoundup where Gatorlink="tapearson";

select count(*) from work.vivoundup where Gatorlink="nelsodr";
select count(distinct article) from work.vivoundup where Gatorlink="nelsodr";

drop table work.ud_pearson;
create table work.ud_pearson
select * from work.vivoundup
where Gatorlink="tapearson";

create table work.ud_nelsodr
select * from work.vivoundup
where Gatorlink="nelsodr";



select count(*) from work.vivoundup ;
select count(distinct article) from work.vivoundup ;
select count(distinct article) from work.vivoundup  WHERE Gatorlink<>"";
select count(distinct article) from work.vivoundup  WHERE UFID IS NOT NULL;

create table loaddata.vivobackupoct2017 as select * from lookup.vivo_pubs;

drop table if exists lookup.vivo_pubs;
create table lookup.vivo_pubs AS
select * from work.vivoundup;


select PubYear,count(distinct article) from lookup.vivo_pubs group by PubYear;




