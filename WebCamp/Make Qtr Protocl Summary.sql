#######################################################################################
####Protcol Summary Time Series

select distinct SFY from ctsi_webcamp_adhoc.VisitRoomCore;


SELECT 
SFY,
QUARTER

from ctsi_webcamp_adhoc.VisitRoomCore 

group by 
SFY,
QUARTER;



desc ctsi_webcamp_adhoc.VisitRoomCore;

SELECT distinct sfy FROM ctsi_webcamp_adhoc.VisitRoomCore;


SELECT * FROM ctsi_webcamp_adhoc.VisitRoomCore;


use ctsi_webcamp_adhoc;

drop table If existS PROTOwORK;
CREATE TABLE PROTOwORK as
sELECT * FROM ctsi_webcamp_adhoc.VisitRoomCore
where sfy in ('SFY 2020-2021','SFY 2021-2022','SFY 2022-2022')
AND VisitStatus=2;


drop table If existS PROTOSUMMlu;
CREATE TABLE PROTOSUMMlu as
select 	PI_NAME,
		Title,
        ProtocolID,
        CRCNumber,
        Month,
        count(Distinct VisitID) as nVisits,
        count(Distinct PatientID) as nPAtients,
        sum(VisitLenMin/60) as visitdur,
        Sum(Amount) as Amount
from PROTOwORK
WHERE CRCNumber<>'0000'
GROUP BY  PI_NAME,
		Title,
        ProtocolID,
        CRCNumber,
        Month;   
        


 
drop table If existS PROTOSUMM;
CREATE TABLE PROTOSUMM as
select 	ProtocolID,
        CRCNumber,
        PI_NAME,
		Title
from PROTOwORK
WHERE CRCNumber<>'0000'
GROUP BY ProtocolID,
		 CRCNumber,
         PI_NAME,
		 Title;    
            
ALTER TABLE PROTOSUMM   
        
     ADD visits_2020_07 INT(8),
     ADD visits_2020_08 INT(8),
     ADD visits_2020_09 INT(8),
     ADD visits_2020_10 INT(8),
     ADD visits_2020_11 INT(8),
     ADD visits_2020_12 INT(8),
     ADD visits_2021_01 INT(8),
     ADD visits_2021_02 INT(8),
     ADD visits_2021_03 INT(8),
     ADD visits_2021_04 INT(8),
     ADD visits_2021_05 INT(8),
     ADD visits_2021_06 INT(8),
     ADD visits_2021_07 INT(8),
     ADD visits_2021_08 INT(8),
     ADD visits_2021_09 INT(8),
     ADD visits_2021_10 INT(8),
     ADD visits_2021_11 INT(8),
     ADD visits_2021_12 INT(8),
     ADD visits_2022_01 INT(8),
     ADD visits_2022_02 INT(8),
     ADD visits_2022_03 INT(8),
	 
     ADD visits_2022_04 INT(8),
     ADD visits_2022_05 INT(8),
     ADD visits_2022_06 INT(8),
     ADD visits_2022_07 INT(8),
     ADD visits_2022_08 INT(8),
     
     
     
     
     

     ADD patients_2020_07 INT(8),
     ADD patients_2020_08 INT(8),
     ADD patients_2020_09 INT(8),
     ADD patients_2020_10 INT(8),
     ADD patients_2020_11 INT(8),
     ADD patients_2020_12 INT(8),
     ADD patients_2021_01 INT(8),
     ADD patients_2021_02 INT(8),
     ADD patients_2021_03 INT(8),
     ADD patients_2021_04 INT(8),
     ADD patients_2021_05 INT(8),
     ADD patients_2021_06 INT(8),
     ADD patients_2021_07 INT(8),
     ADD patients_2021_08 INT(8),
     ADD patients_2021_09 INT(8),
     ADD patients_2021_10 INT(8),
     ADD patients_2021_11 INT(8),
     ADD patients_2021_12 INT(8),
     ADD patients_2022_01 INT(8),
     ADD patients_2022_02 INT(8),
     ADD patients_2022_03 INT(8),
     
     ADD patients_2022_04 INT(8),
     ADD patients_2022_05 INT(8),
     ADD patients_2022_06 INT(8),
     ADD patients_2022_07 INT(8),
     ADD patients_2022_08 INT(8),

     ADD amount_2020_07 Decimal(65,10),
     ADD amount_2020_08 Decimal(65,10),
     ADD amount_2020_09 Decimal(65,10),
     ADD amount_2020_10 Decimal(65,10),
     ADD amount_2020_11 Decimal(65,10),
     ADD amount_2020_12 Decimal(65,10),
     ADD amount_2021_01 Decimal(65,10),
     ADD amount_2021_02 Decimal(65,10),
     ADD amount_2021_03 Decimal(65,10),
     ADD amount_2021_04 Decimal(65,10),
     ADD amount_2021_05 Decimal(65,10),
     ADD amount_2021_06 Decimal(65,10),
     ADD amount_2021_07 Decimal(65,10),
     ADD amount_2021_08 Decimal(65,10),
     ADD amount_2021_09 Decimal(65,10),
     ADD amount_2021_10 Decimal(65,10),
     ADD amount_2021_11 Decimal(65,10),
     ADD amount_2021_12 Decimal(65,10),
     ADD amount_2022_01 Decimal(65,10),
     ADD amount_2022_02 Decimal(65,10),
     ADD amount_2022_03 Decimal(65,10),
     

     ADD visitdur_2020_07 Decimal(65,10),
     ADD visitdur_2020_08 Decimal(65,10),
     ADD visitdur_2020_09 Decimal(65,10),
     ADD visitdur_2020_10 Decimal(65,10),
     ADD visitdur_2020_11 Decimal(65,10),
     ADD visitdur_2020_12 Decimal(65,10),
     ADD visitdur_2021_01 Decimal(65,10),
     ADD visitdur_2021_02 Decimal(65,10),
     ADD visitdur_2021_03 Decimal(65,10),
     ADD visitdur_2021_04 Decimal(65,10),
     ADD visitdur_2021_05 Decimal(65,10),
     ADD visitdur_2021_06 Decimal(65,10),
     ADD visitdur_2021_07 Decimal(65,10),
     ADD visitdur_2021_08 Decimal(65,10),
     ADD visitdur_2021_09 Decimal(65,10),
     ADD visitdur_2021_10 Decimal(65,10),
     ADD visitdur_2021_11 Decimal(65,10),
     ADD visitdur_2021_12 Decimal(65,10),
     ADD visitdur_2022_01 Decimal(65,10),
     ADD visitdur_2022_02 Decimal(65,10),
     ADD visitdur_2022_03 Decimal(65,10),
     
     ADD visits_Q3_2020 INT(8),
     ADD visits_Q4_2020 INT(8),
     ADD visits_Q1_2021 INT(8),
     ADD visits_Q2_2021 INT(8),
     ADD visits_Q3_2021 INT(8),
     ADD visits_Q4_2021 INT(8),
     ADD visits_Q1_2022 INT(8),
     
     ADD patients_Q3_2020 INT(8),
     ADD patients_Q4_2020 INT(8),
     ADD patients_Q1_2021 INT(8),
     ADD patients_Q2_2021 INT(8),
     ADD patients_Q3_2021 INT(8),
     ADD patients_Q4_2021 INT(8),
     ADD patients_Q1_2022 INT(8),
     
     ADD amount_Q3_2020 Decimal(65,10),
     ADD amount_Q4_2020  Decimal(65,10),
     ADD amount_Q1_2021  Decimal(65,10),
     ADD amount_Q2_2021  Decimal(65,10),
     ADD amount_Q3_2021  Decimal(65,10),
     ADD amount_Q4_2021  Decimal(65,10),
     ADD amount_Q1_2022  Decimal(65,10),

     
     ADD visitdur_Q3_2020  Decimal(65,10),
     ADD visitdur_Q4_2020  Decimal(65,10),
     ADD visitdur_Q1_2021  Decimal(65,10),
     ADD visitdur_Q2_2021  Decimal(65,10),
     ADD visitdur_Q3_2021  Decimal(65,10),
     ADD visitdur_Q4_2021  Decimal(65,10),
     ADD visitdur_Q1_2022  Decimal(65,10);



     
  SELECT * from  PROTOSUMM;    
      
SET SQL_SAFE_UPDATES = 0;      
UPDATE PROTOSUMM
SET   visits_2020_07=0,  patients_2020_07=0, amount_2020_07=0, visitdur_2020_07=0,
      visits_2020_08=0,  patients_2020_08=0, amount_2020_08=0, visitdur_2020_08=0,
      visits_2020_09=0,  patients_2020_09=0, amount_2020_09=0, visitdur_2020_09=0,
      visits_2020_10=0,  patients_2020_10=0, amount_2020_10=0, visitdur_2020_10=0,
      visits_2020_11=0,  patients_2020_11=0, amount_2020_11=0, visitdur_2020_11=0,
      visits_2020_12=0,  patients_2020_12=0, amount_2020_12=0, visitdur_2020_12=0,
      visits_2021_01=0,  patients_2021_01=0, amount_2021_01=0, visitdur_2021_01=0,
      visits_2021_02=0,  patients_2021_02=0, amount_2021_02=0, visitdur_2021_02=0,
      visits_2021_03=0,  patients_2021_03=0, amount_2021_03=0, visitdur_2021_03=0,
      visits_2021_04=0,  patients_2021_04=0, amount_2021_04=0, visitdur_2021_04=0,
      visits_2021_05=0,  patients_2021_05=0, amount_2021_05=0, visitdur_2021_05=0,
      visits_2021_06=0,  patients_2021_06=0, amount_2021_06=0, visitdur_2021_06=0,
      visits_2021_07=0,  patients_2021_07=0, amount_2021_07=0, visitdur_2021_07=0,
      visits_2021_08=0,  patients_2021_08=0, amount_2021_08=0, visitdur_2021_08=0,
      visits_2021_09=0,  patients_2021_09=0, amount_2021_09=0, visitdur_2021_09=0,
      visits_2021_10=0,  patients_2021_10=0, amount_2021_10=0, visitdur_2021_10=0,
      visits_2021_11=0,  patients_2021_11=0, amount_2021_11=0, visitdur_2021_11=0,
      visits_2021_12=0,  patients_2021_12=0, amount_2021_12=0, visitdur_2021_12=0,
      visits_2022_01=0,  patients_2022_01=0, amount_2022_01=0, visitdur_2022_01=0,
      visits_2022_02=0,  patients_2022_02=0, amount_2022_02=0, visitdur_2022_02=0,
      visits_2022_03=0,  patients_2022_03=0, amount_2022_03=0, visitdur_2022_03=0,
      
      visits_Q3_2020=0,  patients_Q3_2020=0,  amount_Q3_2020=0,  visitdur_Q3_2020=0, 
	  visits_Q4_2020=0,  patients_Q4_2020=0,  amount_Q4_2020=0,  visitdur_Q4_2020=0, 
	  visits_Q1_2021=0,  patients_Q1_2021=0,  amount_Q1_2021=0,  visitdur_Q1_2021=0, 
      visits_Q2_2021=0,  patients_Q2_2021=0,  amount_Q2_2021=0,  visitdur_Q2_2021=0, 
      visits_Q3_2021=0,  patients_Q3_2021=0,  amount_Q3_2021=0,  visitdur_Q3_2021=0, 
      visits_Q4_2021=0,  patients_Q4_2021=0,  amount_Q4_2021=0,  visitdur_Q4_2021=0, 
      visits_Q1_2022=0,  patients_Q1_2022=0,  amount_Q1_2022=0,  visitdur_Q1_2022=0; 

      
      

UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_07=lu.nVisits,  ps.patients_2020_07=lu.nPatients, amount_2020_07=lu.Amount, visitdur_2020_07=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-07';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_08=lu.nVisits,  ps.patients_2020_08=lu.nPatients, amount_2020_08=lu.Amount, visitdur_2020_08=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-08';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_09=lu.nVisits,  ps.patients_2020_09=lu.nPatients, amount_2020_09=lu.Amount, visitdur_2020_09=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-09';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_10=lu.nVisits,  ps.patients_2020_10=lu.nPatients, amount_2020_10=lu.Amount, visitdur_2020_10=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-10';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_11=lu.nVisits,  ps.patients_2020_11=lu.nPatients, amount_2020_11=lu.Amount, visitdur_2020_11=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-11';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2020_12=lu.nVisits,  ps.patients_2020_12=lu.nPatients, amount_2020_12=lu.Amount, visitdur_2020_12=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2020-12';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_01=lu.nVisits,  ps.patients_2021_01=lu.nPatients, amount_2021_01=lu.Amount, visitdur_2021_01=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-01';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_02=lu.nVisits,  ps.patients_2021_02=lu.nPatients, amount_2021_02=lu.Amount, visitdur_2021_02=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-02';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_03=lu.nVisits,  ps.patients_2021_03=lu.nPatients, amount_2021_03=lu.Amount, visitdur_2021_03=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-03';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_04=lu.nVisits,  ps.patients_2021_04=lu.nPatients, amount_2021_04=lu.Amount, visitdur_2021_04=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-04';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_05=lu.nVisits,  ps.patients_2021_05=lu.nPatients, amount_2021_05=lu.Amount, visitdur_2021_05=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-05';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_06=lu.nVisits,  ps.patients_2021_06=lu.nPatients, amount_2021_06=lu.Amount, visitdur_2021_06=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-06';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_07=lu.nVisits,  ps.patients_2021_07=lu.nPatients, amount_2021_07=lu.Amount, visitdur_2021_07=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-07';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_08=lu.nVisits,  ps.patients_2021_08=lu.nPatients, amount_2021_08=lu.Amount, visitdur_2021_08=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-08';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_09=lu.nVisits,  ps.patients_2021_09=lu.nPatients, amount_2021_09=lu.Amount, visitdur_2021_09=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-09';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_10=lu.nVisits,  ps.patients_2021_10=lu.nPatients, amount_2021_10=lu.Amount, visitdur_2021_10=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-10';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_11=lu.nVisits,  ps.patients_2021_11=lu.nPatients, amount_2021_11=lu.Amount, visitdur_2021_11=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-11';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2021_12=lu.nVisits,  ps.patients_2021_12=lu.nPatients, amount_2021_12=lu.Amount, visitdur_2021_12=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2021-12';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_01=lu.nVisits,  ps.patients_2022_01=lu.nPatients, amount_2022_01=lu.Amount, visitdur_2022_01=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-01';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_02=lu.nVisits,  ps.patients_2022_02=lu.nPatients, amount_2022_02=lu.Amount, visitdur_2022_02=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-02';
UPDATE PROTOSUMM ps, PROTOSUMMlu lu SET ps.visits_2022_03=lu.nVisits,  ps.patients_2022_03=lu.nPatients, amount_2022_03=lu.Amount, visitdur_2022_03=lu.visitdur WHERE ps.ProtocolID=lu.ProtocolID and Month='2022-03';


UPDATE PROTOSUMM
SET 
 visits_Q3_2020= visits_2020_07+visits_2020_08+visits_2020_09,
 visits_Q4_2020= visits_2020_10+visits_2020_11+visits_2020_12,
 visits_Q1_2021= visits_2021_01+visits_2021_02+visits_2021_03,
 visits_Q2_2021= visits_2021_04+visits_2021_05+visits_2021_06,
 visits_Q3_2021= visits_2021_07+visits_2021_08+visits_2021_09,
 visits_Q4_2021= visits_2021_10+visits_2021_11+visits_2021_12,
 visits_Q1_2022= visits_2022_01+visits_2022_02+visits_2022_03,
 patients_Q3_2020= patients_2020_07+patients_2020_08+patients_2020_09,
 patients_Q4_2020= patients_2020_10+patients_2020_11+patients_2020_12,
 patients_Q1_2021= patients_2021_01+patients_2021_02+patients_2021_03,
 patients_Q2_2021= patients_2021_04+patients_2021_05+patients_2021_06,
 patients_Q3_2021= patients_2021_07+patients_2021_08+patients_2021_09,
 patients_Q4_2021= patients_2021_10+patients_2021_11+patients_2021_12,
 patients_Q1_2022= patients_2022_01+patients_2022_02+patients_2022_03,
 amount_Q3_2020= amount_2020_07+amount_2020_08+amount_2020_09,
 amount_Q4_2020 = amount_2020_10+amount_2020_11+amount_2020_12,
 amount_Q1_2021 = amount_2021_01+amount_2021_02+amount_2021_03,
 amount_Q2_2021 = amount_2021_04+amount_2021_05+amount_2021_06,
 amount_Q3_2021 = amount_2021_07+amount_2021_08+amount_2021_09,
 amount_Q4_2021 = amount_2021_10+amount_2021_11+amount_2021_12,
 amount_Q1_2022 = amount_2022_01+amount_2022_02+amount_2022_03,
 visitdur_Q3_2020 = visitdur_2020_07+visitdur_2020_08+visitdur_2020_09,
 visitdur_Q4_2020 = visitdur_2020_10+visitdur_2020_11+visitdur_2020_12,
 visitdur_Q1_2021 = visitdur_2021_01+visitdur_2021_02+visitdur_2021_03,
 visitdur_Q2_2021 = visitdur_2021_04+visitdur_2021_05+visitdur_2021_06,
 visitdur_Q3_2021 = visitdur_2021_07+visitdur_2021_08+visitdur_2021_09,
 visitdur_Q4_2021 = visitdur_2021_10+visitdur_2021_11+visitdur_2021_12,
 visitdur_Q1_2022 = visitdur_2022_01+visitdur_2022_02+visitdur_2022_03;
 
 
drop table If existS ProtoQTRSumm;
CREATE TABLE ProtoQTRSumm as
SELECT  ProtocolID,
		CRCNumber,
        PI_NAME,
        Title,
		visits_Q3_2020,
		visits_Q4_2020,
		visits_Q1_2021,
        visits_Q2_2021,
        visits_Q3_2021,
        visits_Q4_2021,
        visits_Q1_2022,
        
        patients_Q3_2020,
        patients_Q4_2020,
        patients_Q1_2021,
        patients_Q2_2021,
        patients_Q3_2021,
        patients_Q4_2021,
        patients_Q1_2022,
        
        amount_Q3_2020,
        amount_Q4_2020,
        amount_Q1_2021,
        amount_Q2_2021,
        amount_Q3_2021,
        amount_Q4_2021,
        amount_Q1_2022,