select * from ctsi_webcamp_adhoc.VisitRoomCore;


SELECT Month,count(distinct ProtocolID) as nProtocols
from ctsi_webcamp_adhoc.VisitRoomCore
WHERE Month IN ('2019-06','2020-06','2021-06')
GROUP BY Month;