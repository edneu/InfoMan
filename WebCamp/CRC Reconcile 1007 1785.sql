select * from ctsi_webcamp_pr.labtestcost;

select * from ctsi_webcamp_pr.labtest
WHERE labtest Like "%Infusion%Pump%";

### Labtest = 104  EQS: Infusion pump
select * from ctsi_webcamp_pr.labtestcost
WHERE labtest=104;

select * FROM ctsi_webcamp_adhoc.visitroomcore
where LabTestID=104
AND ProtocolID=388;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.temp;
create table ctsi_webcamp_adhoc.temp as
SELECT * FROM ctsi_webcamp_pr.approvedresource WHERE LABTEST=104
AND Protocol=388;




select * from ctsi_webcamp_pr.protocol where protocol="1007";
protocol =388


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.vrc_1007_1785;
Create table ctsi_webcamp_adhoc.vrc_1007_1785 as
Select  CRCNumber,
		VisitID,
        VisitStatus,
		Month,
		VisitStart,
        VisitEnd,
        ParticipantID,
        PatientName,
		Service,  ## LABTEST
        CoreSvcID,
        CoreSvcStatus,
        CoreSvcStart,
        CoreSvcEnd,
        SvcUnitCost,
        CoreSvcQuant,
        CoreSvcLenDurMin,
        CoreSvcLenDurMin/60 AS CoreSvcLenDurHRS,
        ProtoSpecRate,
        UnitOfService,
        BillingUnitSrvc,
        Amount
 from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber IN ('1785','1007')
AND VisitStart>=str_to_date('01,01,2020','%m,%d,%Y')
AND VisitStatus=2
AND CoreSvcStatus=2
ORDER BY CRCNumber, PatientName, VisitStart;



Select  CRCNumber,
		VisitID,
        VisitStatus,
		Month,
		VisitStart,
        VisitEnd,
        ParticipantID,
        PatientName,
		Service,  ## LABTEST
        CoreSvcID,
        CoreSvcStatus,
        CoreSvcStart,
        CoreSvcEnd,
        SvcUnitCost,
        CoreSvcQuant,
        CoreSvcLenDurMin,
        CoreSvcLenDurMin/60 AS CoreSvcLenDurHRS,
        ProtoSpecRate,
        UnitOfService,
        BillingUnitSrvc,
        Amount
 from ctsi_webcamp_adhoc.VisitRoomCore
WHERE CRCNumber IN ('1785','1007')
AND VisitStart>=str_to_date('10,18,2022','%m,%d,%Y')
AND VisitStatus=2
AND CoreSvcStatus=2
ORDER BY CRCNumber, PatientName, VisitStart;



