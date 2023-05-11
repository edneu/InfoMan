## Please review for $1,875.00 for crc 1785 that was done in January 2023.

Select UNIQUEFIELD, protocol from ctsi_webcamp_pr.protocol WHERE protocol='1785';
protocol = 1664

select * from ctsi_webcamp_pr.protocolbilling ;##where protocol=1664;

select * from ctsi_webcamp_pr.setup;

select distinct LabTest from ctsi_webcamp_pr.labtest;

select * from ctsi_webcamp_adhoc.VisitRoomCore where  ProtocolID=1664;

select * from ctsi_webcamp_pr.labtestcost;  
labtst 190, 338

select * from ctsi_webcamp_pr.coreservice where protocol=1664 and labtest in (190,338);