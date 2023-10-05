
drop table if exists loaddata.email_lu;
create table loaddata.email_lu
(
recid Integer auto_increment primary key,
UF_UFID varchar (11) NOT NULL,
UF_EMAIL varchar (254)  NULL);

load data local infile "C:\\users\\edneu\\Desktop\\email.csv" 
into table loaddata.email_lu
fields terminated by ','
lines terminated by '\n'
(UF_UFID,
UF_EMAIL);

select * from loaddata.email_lu;

update loaddata.email_lu set UF_UFID="76376906" where recid=1;