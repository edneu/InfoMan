

select * from work.covidpilotnoaward;

Select * from work.covidprop;

Alter table work.covidprop ADD PIMatch varchar(45);


SET SQL_SAFE_UPDATES = 0;
UPDATE work.covidprop  SET PIMatch="";


UPDATE work.covidprop cp, work.covidpilotnoaward lu
SET cp.PIMatch=concat("|",cp.PIMatch,lu.PilotRFA)
WHERE  LOCATE(lu.PI_Name,CLK_PI_NAME )<>0;