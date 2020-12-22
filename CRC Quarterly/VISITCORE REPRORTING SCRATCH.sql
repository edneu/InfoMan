#######################################################################################
#######################################################################################
### CREATE SUMMARY TABLES 
#######################################################################################
#######################################################################################
### Monthly Summary
SELECT 
concat(YEAR(VisitStart),"-",LPAD(MONTH(VisitStart),2,"0")) AS MONTH,
COUNT(DISTINCT VISITID) As nVISIT,
COUNT(DISTINCT PatientID) nUndupPatients,
(sum(VisitLenMin))/60 AS VisitHours,
Sum(Amount) as Amount
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE YEAR(VisitStart) IN (2018,2019,2020)
GROUP BY concat(YEAR(VisitStart),"-",LPAD(MONTH(VisitStart),2,"0"));

#######################################################################################
#######################################################################################
### Calendar Year Summary 

DROP TABLE If exists ctsi_webcamp_adhoc.VCRSummary;
CREATE TABLE ctsi_webcamp_adhoc.VCRSummary AS
SELECT Year(VisitStart) As CalYear,
       Count(*) as nRecs,
       count(distinct VisitID) as nVISITS1,
	   count(distinct concat(VisitType,VisitID)) as nVISITS,
       Count(distinct ProtocolID) as nProtocols,
       SUM(CoreSvcLenDurMin)/60 as VisitLengthHr,
	   Count(distinct PIPersonID) as nPIs,
       Count(distinct Service) as nService,
       SUM(Amount) as TotalAmt,
       SUM( IF ( ProvPersonID is null, 1, 0 ) ) as nNULLProvID
From ctsi_webcamp_adhoc.VisitRoomCore
GROUP BY CalYear
Order by CalYear;

#######################################################################################
#######################################################################################
## Raw Listings

select * from ctsi_webcamp_adhoc.VisitRoomCore;


#######################################################################################
#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################
######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################    
#######################################################################################
#######################################################################################
#######################################################################################    


#######################################################################################
#######################################################################################    
#######################################################################################
################################
### SUNDRY REFERENCE 

/*
CORE SERVICE STATUS

0 or null=not entered
 1=Scheduled
 2=Completed
 3=Begun
 4=No-show
 5=Request cancelled
 6=Requested
 7=Request denied
 8=Stopped prematurely
 9=Re-scheduling requested
 9=Re-scheduling requested
 
 
 OPVISIT STATUS
0 or null=not entered
 1=Scheduled
 2=Completed
 3=Begun
 4=No-show
 5=Request cancelled
 6=Requested
 7=Request denied
 8=Stopped prematurely
 9=Re-scheduling requested
 9=Re-scheduling requested
 
 
CORESERVICE.REALTED_TO
What is this service related to (visit, admission, recognized protocol, or other)?	
1=Inpatient admission
 2=Outpatient visit
 3=Scatter bed admission
 4=Other
 5=Unknown protocol
 6=Non-CTSA or non-GCRC protocol
 7=CTSC/GCRC protocol
 */
#######################################################################################    
#######################################################################################
#######################################################################################
#######################################################################################    
### ADHOC  
##############################################################################
###########  Summary from MATTS List
 DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_study_summ ;
 create table ctsi_webcamp_adhoc.crc_study_summ AS
  select	Span,
			Email,
            LastName,
            FirstName,
            CRCID,
            IRB,
            Title,
            StudyClosed
 from  ctsi_webcamp_adhoc.crc_study_covid
 WHERE StudyClosed IN ('OPEN TO ACCRUAL', 'No');
 

ALTER TABLE ctsi_webcamp_adhoc.crc_study_summ
ADD nVISITS_FY20 bigint(21),
ADD nPatients_FY20 bigint(21),
ADD Amount_FY20 Double(19,2),
ADD nVISITS_FY21 bigint(21),
ADD nPatients_FY21 bigint(21),
ADD Amount_FY21 Double(19,2);



DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_statFY20 ;
create table ctsi_webcamp_adhoc.crc_statFY20 AS
select 	CRCNumber as CRCID,
 		Count(DISTINCT VisitID) As nVISITS_FY20,
		Count(DISTINCT PatientID) as nPatients_FY20,
		ROUND(SUM(Amount),2) as Amount_FY20
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE VisitStart BETWEEN str_to_date('07,01,2019','%m,%d,%Y') AND  str_to_date('06,30,2020','%m,%d,%Y')
AND CRCNumber IN (SELECT DISTINCT CRCID from ctsi_webcamp_adhoc.crc_study_covid)
GROUP BY CRCNumber;

 
 
 
 
DROP TABLE if EXISTS ctsi_webcamp_adhoc.crc_statFY21 ;
create table ctsi_webcamp_adhoc.crc_statFY21 AS
select 	CRCNumber as CRCID,
 		Count(DISTINCT VisitID) As nVISITS_FY21,
		Count(DISTINCT PatientID) as nPatients_FY21,
		ROUND(SUM(Amount),2) as Amount_FY21
FROM ctsi_webcamp_adhoc.visitroomcore
WHERE VisitStart BETWEEN str_to_date('07,01,2020','%m,%d,%Y') AND  str_to_date('06,30,2021','%m,%d,%Y')
AND CRCNumber IN (SELECT DISTINCT CRCID from ctsi_webcamp_adhoc.crc_study_covid)
GROUP BY CRCNumber;

desc ctsi_webcamp_adhoc.crc_statFY21;

UPDATE ctsi_webcamp_adhoc.crc_study_summ ss, ctsi_webcamp_adhoc.crc_statFY20 lu
SET ss.nVISITS_FY20=lu.nVISITS_FY20,
	ss.nPatients_FY20=lu.nPatients_FY20 ,
    ss.Amount_FY20=lu.Amount_FY20
WHERE ss.CRCID=lu.CRCID;    

UPDATE ctsi_webcamp_adhoc.crc_study_summ ss, ctsi_webcamp_adhoc.crc_statFY21 lu
SET ss.nVISITS_FY21=lu.nVISITS_FY21,
	ss.nPatients_FY21=lu.nPatients_FY21 ,
    ss.Amount_FY21=lu.Amount_FY21
WHERE ss.CRCID=lu.CRCID; 

SELECT * from ctsi_webcamp_adhoc.crc_study_summ ;

###########  END Summary from MATTS List
#######################################################################################    
#######################################################################################
DROP TABLE IF EXISTS ctsi_webcamp_adhoc.VistProvHrs ;
create table ctsi_webcamp_adhoc.VistProvHrs As
SELECT ProvPersonName,
       concat(YEAR(VisitStart),"-",LPAD(MONTH(VisitStart),2,"0")) AS MONTH,
       VisitID,
       max(CoreSvcLenDurMin) as VisitPatic
from  ctsi_webcamp_adhoc.visitroomcore
WHERE ProvPersonName IS NOT NULL
AND SERVICE NOT IN ('DIET: Regular meal (JJ,Subway)','CTRB:  Outpatient visit (budgeted)')
GROUP BY  	ProvPersonName,
			Month,
            VisitID;       



SELECT ProvPersonName,
       MONTH,
       COUNT(VisitID) AS  nVisits,
       COUNT(DISTINCT VisitID) AS  nUdVisits,
       SUM(VisitPatic)/60 AS VisitParticHrs
FROM ctsi_webcamp_adhoc.VistProvHrs 
GROUP BY  	ProvPersonName,
			Month ;    
	