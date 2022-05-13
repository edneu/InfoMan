





         
         
         
DROP TABLE IF EXISTS loaddata.email_load;
CREATE TABLE loaddata.email_load 
(	UF_UFID varchar(12),
	UF_EMAIL varchar(255),
    UF_NAME_TXT varchar (255),
    UF_PRIMARY_FLG varchar(5)
);

SET GLOBAL local_infile = 1;         

load data local infile "P:\\My Documents\\My Documents\\LoadData\\EMAIL_LOOKUP.rpt" 
into table loaddata.email_load 
fields terminated by '|'
lines terminated by '\n'
##IGNORE 1 LINES
(	UF_UFID,
	UF_EMAIL,
    UF_NAME_TXT,
	UF_PRIMARY_FLG
);

/*
DROP TABLE IF EXISTS lookup.email_master;
DROP TABLE IF EXISTS lookup.email;
*/
CREATE TABLE lookup.email AS

SELECT UF_UFID as UFID,
       UF_EMAIL AS EMAIL,
       max(UF_NAME_TXT) as NameTxt, 
       max(UF_PRIMARY_FLG) as PrimaryFlag
       from loaddata.email_load
GROUP BY UF_UFID,
         UF_EMAIL;       ;