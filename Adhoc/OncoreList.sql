


drop table if exists ctsi_webcamp_adhoc.protocolList;
CREATE TABLE ctsi_webcamp_adhoc.protocolList AS
    SELECT Year(VISITDATE) AS ActYear,
           PROTOCOL,
            "OPVisit" AS VisitType 
      FROM ctsi_webcamp_pr.OPVISIT 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3)
     UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
           "IPVisit" AS VisitType  
      FROM ctsi_webcamp_pr.ADMISSIO 
      WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
    UNION ALL
    SELECT Year(ADMITDATE) as ActYear,
           PROTOCOL,
          "SBVisit" AS VisitType 
      FROM ctsi_webcamp_pr.SBADMISSIO 
     WHERE PROTOCOL IS NOT NULL 
       AND STATUS IN (2,3) 
;

ALter table ctsi_webcamp_adhoc.protocolList
## FROM ctsi_webcamp_pr.protocol
ADD CRC_Number varchar(25),
ADD IRBNUMBER varchar(25),
ADD IRBAPPROV Datetime,
ADD IRBEXPIRE Datetime,
ADD TITLE varchar(90),
ADD LONGTITLE text,
ADD CLINICALTRIAL int(4),
ADD  MULTICENTE int(4),
ADD CLINTRIALSGOVID int(20),
ADD PERSON varchar(20);


SET SQL_SAFE_UPDATES = 0;

UPDATE 	ctsi_webcamp_adhoc.protocolList pl,
		ctsi_webcamp_pr.protocol lu
SET	CRC_Number=lu.Protocol,
	pl.IRBNUMBER=lu.IRBNUMBER,
	pl.IRBAPPROV=lu.IRBAPPROV,
	pl.IRBEXPIRE=lu.IRBEXPIRE,
	pl.TITLE=lu.TITLE,
	pl.LONGTITLE=lu.LONGTITLE,
	pl.CLINICALTRIAL=lu.CLINICALTRIAL,
    pl.MULTICENTE=lu.MULTICENTE,
    pl.CLINTRIALSGOVID=lu.CLINTRIALSGOVID ,
 	pl.PERSON=lu.PERSON
WHERE pl.Protocol=lu.UNIQUEFIELD;




ALter table ctsi_webcamp_adhoc.protocolList
## FROM ctsi_webcamp_pr.person
ADD FIRSTNAME varchar(30),
ADD LASTNAME varchar(30),
ADD EMAIL Text
;


UPDATE 	ctsi_webcamp_adhoc.protocolList pl,
		ctsi_webcamp_pr.person lu
SET pl.FIRSTNAME=lu.FIRSTNAME,
	pl.LASTNAME=lu.LASTNAME,
	pl.EMAIL=lu.EMAIL
where pl.PERSON=lu.UNIQUEFIELD;



drop table if exists ctsi_webcamp_adhoc.protocolAGG ;
create table ctsi_webcamp_adhoc.protocolAGG  AS
SELECT PROTOCOL,
       min(ActYear) AS minYear,
       max(ActYear) as maxYear,
       min(CRC_Number) as CRC_Number,
       max(IRBNUMBER) as IRBNUMBER,
       min(IRBAPPROV) as IRBAPPROV,
       max(IRBEXPIRE) as IRBEXPIRE,
       max(TITLE) as Title,
       max(LONGTITLE) as LONGTITLE,
       max(LASTNAME) as LASTNAME,
       max(FIRSTNAME) as FIRSTNAME,
       max(EMAIL) as EMAIL,
       max(CLINICALTRIAL) AS CLINICALTRIAL,
       max(MULTICENTE) AS MULTICENTE,
       max(CLINTRIALSGOVID) AS CLINTRIALSGOVID
From ctsi_webcamp_adhoc.protocolList
group by PROTOCOL;



drop table if exists ctsi_webcamp_adhoc.protocol201819 ;
create table ctsi_webcamp_adhoc.protocol201819  AS
SELECT * from ctsi_webcamp_adhoc.protocolAGG
WHERE  maxYear>=2018;

select CLINICALTRIAL,count(*) from ctsi_webcamp_adhoc.protocol201819 group by CLINICALTRIAL; #FEW
select MULTICENTE,count(*) from ctsi_webcamp_adhoc.protocol201819 group by MULTICENTE; # FEW
select CLINTRIALSGOVID,count(*) from ctsi_webcamp_adhoc.protocol201819 group by CLINTRIALSGOVID;  #NONE