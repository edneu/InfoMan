##  Find Titles for Protocols for BOND Certification

drop table if exists ctsi_webcamp_adhoc.temp;
create table ctsi_webcamp_adhoc.temp AS
SELECT PROTOCOL,LONGTITLE,TITLE
FROM ctsi_webcamp_pr.PROTOCOL
WHERE PROTOCOL IN (Select DISTINCT `CRC#` from ctsi_webcamp_adhoc.crc_black)
UNION ALL
SELECT PROTOCOL,LONGTITLE,TITLE
FROM ctsi_webcamp_pr.PROTOCOL
WHERE PROTOCOL IN (Select DISTINCT `CRC#` from ctsi_webcamp_adhoc.crc_black2);


select * from ctsi_webcamp_pr.PROTOCOL where PROTOCOL LIKE ('%6035%');