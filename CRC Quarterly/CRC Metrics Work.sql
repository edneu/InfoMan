select distinct PI_NAME from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "%564%";

select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564" ;



select count(distinct VisitID) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564";



select distinct CRCNumber  from ctsi_webcamp_adhoc.VisitRoomCore
WHERE PROTOCOL = 98;


select * from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%";

create table ;
select CRCNumber,ProtocolID,VisitType,PIPersonID,count(distinct VisitID) as nVISITS 
from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%"
 group by CRCNumber,ProtocolID,VisitType,PIPersonID;

select * from ctsi_webcamp_pr.personprot
WHERE PERSON=2309 ;
USE ctsi_webcamp_pr;
select * from PERSON where LASTNAME like "%Haller%" ;
select * from PERSON where UNIQUEFIELD like 2304 ;


select * from  personprot where PROTOCOL=98;

select * from PERSON where UNIQUEFIELD like 291 ;


select * from protocol where PERSON like 2304;
select * from rsupperson where PERSON like 2304;

select * from rsupprot where  PROTOCOL=98;
select * from rsupprotnot where  PROTOCOL=98;
create table ctsi_webcamp_adhoc.dbstructure AS
select * from databasestructure;

create table ctsi_webcamp_adhoc.dbstructuredesc AS
select * from databasestructuredescriptions;

 where person like 2304;


/*
Person 2304 Haller
Protocol 98
CRC 564
*/
select * from INVOICE WHERE  ;
where PERSON like 2304;