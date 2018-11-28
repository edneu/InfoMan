drop table if exists ctsi_webcamp_adhoc.temp;
create table ctsi_webcamp_adhoc.temp AS
select * from ctsi_webcamp.protocolpatent;

drop table if exists ctsi_webcamp_adhoc.temp;
create table ctsi_webcamp_adhoc.temp AS
select * from ctsi_oldwebcamp.protocol;