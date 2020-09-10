

CRC Staff Assignments
 Record selection criteria:
     (work was completed between 8/1/2020 and 8/31/2020) and
     (current status is 'Completed') and
     (core is 'CRC') and
     (site of related visit is 'CRC') and
     (additional SQL criteria: CORESERVICE.OPVISIT IS NOT NULL)





coreservice
select * from ctsi_webcamp_pr.coreservice_personprovider;


select max(CORESERVICE) from ctsi_webcamp_pr.coreservice_personprovider;

select UNIQUEFIELD,LASTNAME,FIRSTNAME from ctsi_webcamp_pr.person where UNIQUEFIELD in (select distinct PERSON from ctsi_webcamp_pr.coreservice_personprovider);
from ctsi_webcamp_pr.coreservice;
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################

drop table if exists ctsi_webcamp_adhoc.ServPers1;
create table ctsi_webcamp_adhoc.ServPers1 AS
SELECT cs.UNIQUEFIELD AS CoreServiceID,
	   cs.STARTDATE,cs.TIMEIN,
       cs.ENDDATE,cs.TIMEOUT,
       cs.TOTAL_TIME,
       cs.STATUS,
       cs.OPVISIT,
       pp.PERSON
from ctsi_webcamp_pr.coreservice cs 
LEFT JOIN ctsi_webcamp_pr.coreservice_personprovider pp
on cs.UNIQUEFIELD=pp.CORESERVICE
WHERE cs.STARTDATE>=str_to_date('08,01,2020','%m,%d,%Y') AND cs.STARTDATE<=CURDATE()
AND cs.OPVISIT IN (SELECT DISTINCT UNIQUEFIELD FROM ctsi_webcamp_pr.OPVISIT WHERE STATUS=2 and VISITDATE>=str_to_date('08,01,2020','%m,%d,%Y') AND VISITDATE<=CURDATE() )
AND cs.TOTAL_TIME IS NOT NULL
AND STATUS=2;

ALTER TABLE ctsi_webcamp_adhoc.ServPers1
ADD FIRSTNAME varchar(30),
ADD LASTNAME varchar(20);

SET SQL_SAFE_UPDATES = 0;
UPDATE ctsi_webcamp_adhoc.ServPers1 sp,  ctsi_webcamp_pr.person lu
SET sp.FIRSTNAME=lu.FIRSTNAME,
	sp.LASTNAME=lu.LASTNAME
WHERE sp.PERSON=lu.UNIQUEFIELD;    



SELECT * from ctsi_webcamp_adhoc.ServPers1;

#######################################################################################################################
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################

#######  Starting With OPVISIT
drop table if exists ctsi_webcamp_adhoc.OPBase;
create table ctsi_webcamp_adhoc.OPBase AS
SELECT 	UNIQUEFIELD AS OPVISIT_ID,
		STATUS AS OPVISIT_STATUS,
        VISITDATE AS OPVISIT_DATE,
        TIMEIN AS OP_TIMNEIN,
        TIMEOUT AS OP_TIMEOUT,
		VISITLEN AS OPVISTIT_LEN,
        PROTOCOL,
        PERSON As PI_PERSON
FROM ctsi_webcamp_pr.opvisit
WHERE STATUS=2 
and VISITDATE>=str_to_date('08,01,2020','%m,%d,%Y') AND VISITDATE<=CURDATE();     


ALTER TABLE ctsi_webcamp_adhoc.OPBase
ADD PI_LASTNAME varchar(30),
ADD PROTO_TITLE varchar(90),
ADD PROTO_LTITLE text,
ADD CORESERVICE_ID int(2),
ADD STAFF_PERSON int(20),
ADD STAFF_LNAME varchar(30),
ADD STAFF_FNAME varchar(30) ;


        
UPDATE ctsi_webcamp_adhoc.OPBase ob, ctsi_webcamp_pr.Person pr 
SET ob.PI_LASTNAME=pr.LASTNAME 
WHERE ob.PI_PERSON=pr.UNIQUEFIELD;  

UPDATE ctsi_webcamp_adhoc.OPBase ob, ctsi_webcamp_pr.protocol lu 
SET ob.PROTO_TITLE=lu.TITLE,
    ob.PROTO_LTITLE=lu.LONGTITLE 
WHERE ob.PROTOCOL=lu.UNIQUEFIELD;  


UPDATE ctsi_webcamp_adhoc.OPBase ob, ctsi_webcamp_pr.coreservice lu 
SET ob.CORESERVICE_ID=lu.UNIQUEFIELD
WHERE ob.OPVISIT_ID=lu.OPVISIT;  

UPDATE ctsi_webcamp_adhoc.OPBase ob, ctsi_webcamp_pr.coreservice_personprovider  lu 
SET ob.STAFF_PERSON=lu.PERSON
WHERE ob.CORESERVICE_ID=lu.CORESERVICE; 

???
SELECT DISTINCT PERSON from ctsi_webcamp_pr.coreservice_personprovider
WHERE PERSON in (SELECT DISTINCT PERSON from ctsi_webcamp_pr.coreservice);




SELECT * FROM ctsi_webcamp_adhoc.OPBase;   
        