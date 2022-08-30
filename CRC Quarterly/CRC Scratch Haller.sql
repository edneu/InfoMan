#######################################################################################
#######################################################################################
select distinct PI_NAME from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "%564%";

select * from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564";

select VisitStatus,count(distinct VisitID) from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber LIKE "564"
group by VisitStatus;



select distinct CRCNumber  from ctsi_webcamp_adhoc.VisitRoomCore
WHERE   LIKE "%564%";


select * from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%";

create table ;
select CRCNumber,ProtocolID,VisitType,PIPersonID,count(distinct VisitID) as nVISITS 
from ctsi_webcamp_adhoc.VisitRoomCore where PI_NAME like "%Haller%"
 group by CRCNumber,ProtocolID,VisitType,PIPersonID;


2304



1	43
2	604
4	13
5	154
8	5