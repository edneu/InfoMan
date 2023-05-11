DROP TABLE IF Exists ctsi_webcamp_adhoc.Chartout;
CREATE TABLE ctsi_webcamp_adhoc.Chartout AS
SELECT 
MONTH,
COUNT(DISTINCT VisitID) as nVISITS,
Count(Distinct PIPersonID) as nPIs,
COUNT(DISTINCT ProtocolID) as nProtocols,
COUNT(DISTINCT PatientID) as nPatients,
COUNT(Distinct Service) as nServiceType,
SUM(Amount) as TotalCost,
SUM(Amount)/COUNT(Distinct Service) as CostPerServiceType,  # Using Cheaper Services?
COUNT(Distinct CoreSvcID)/COUNT(DISTINCT VisitID) as AvgSrvPerVisit,
SUM(Amount)/COUNT(DISTINCT VisitID) as AvgAmtPerVisit,
COUNT(DISTINCT VisitID)/COUNT(DISTINCT ProtocolID) AS VisitsPerProtocol,
COUNT(DISTINCT VisitID)/Count(Distinct PIPersonID) AS VisitsPerPI,
SUM(Amount)/COUNT(DISTINCT ProtocolID) AS CostPerProtocol,
SUM(Amount)/Count(Distinct PIPersonID) AS CostPerPI
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus=2 
AND CoreSvcStatus=2
AND  VisitStart>=str_to_date('07,01,2018','%m,%d,%Y')
GROUP BY MONTH
ORDER BY MONTH;

DROP TABLE IF Exists ctsi_webcamp_adhoc.SVCout1;
CREATE TABLE ctsi_webcamp_adhoc.SVCout1 AS
SELECT SFY,
       SERVICE,
       BillingUnitSrvc,
       SUM(Amount) as Amount
FROM ctsi_webcamp_adhoc.VisitRoomCore
WHERE VisitStatus=2 
AND CoreSvcStatus=2
AND  VisitStart>=str_to_date('07,01,2018','%m,%d,%Y') 
and  AMOUNT<>0
GROUP BY  SFY,
       SERVICE,
       BillingUnitSrvc;     

       
DROP TABLE IF Exists ctsi_webcamp_adhoc.SVCout;
CREATE TABLE ctsi_webcamp_adhoc.SVCout AS      
select distinct SERVICE
from ctsi_webcamp_adhoc.SVCout1;       
       
select DISTINCT SFY FROM  ctsi_webcamp_adhoc.SVCout1;   

alter table ctsi_webcamp_adhoc.SVCout
add SFY_2018_2019 DECIMAL(65,10),
add SFY_2019_2020 DECIMAL(65,10),
add SFY_2020_2021 DECIMAL(65,10),
add SFY_2021_2022 DECIMAL(65,10),
add SFY_2022_2023 DECIMAL(65,10);  
    
    
SET SQL_SAFE_UPDATES = 0;

update ctsi_webcamp_adhoc.SVCout sv, ctsi_webcamp_adhoc.SVCout1 lu SET sv.SFY_2018_2019=lu.Amount WHERE sv.Service=lu.Service AND lu.SFY='SFY 2018-2019' ;
update ctsi_webcamp_adhoc.SVCout sv, ctsi_webcamp_adhoc.SVCout1 lu SET sv.SFY_2019_2020=lu.Amount WHERE sv.Service=lu.Service AND lu.SFY='SFY 2019-2020' ;
update ctsi_webcamp_adhoc.SVCout sv, ctsi_webcamp_adhoc.SVCout1 lu SET sv.SFY_2020_2021=lu.Amount WHERE sv.Service=lu.Service AND lu.SFY='SFY 2020-2021' ;
update ctsi_webcamp_adhoc.SVCout sv, ctsi_webcamp_adhoc.SVCout1 lu SET sv.SFY_2021_2022=lu.Amount WHERE sv.Service=lu.Service AND lu.SFY='SFY 2021-2022' ;
update ctsi_webcamp_adhoc.SVCout sv, ctsi_webcamp_adhoc.SVCout1 lu SET sv.SFY_2022_2023=lu.Amount WHERE sv.Service=lu.Service AND lu.SFY='SFY 2022-2023' ;

select * FROM ctsi_webcamp_adhoc.SVCout;
SFY_2019_2020
SFY_2020_2021
SFY_2021_2022
SFY_2022_2023        
       
       
'SFY 2018-2019'
'SFY 2019-2020'
'SFY 2020-2021'
'SFY 2021-2022'
'SFY 2022-2023'
    