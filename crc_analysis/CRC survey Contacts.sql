### CRC Resumption Survey Deveopment


select * from crc.crcsurvmaster;
desc crc.crcsurvmaster; 

;

## CREATE CONTACT TABLE WITH HEADER VARIABLES
DROP TABLE IF EXISTS crc.SurvContact;
Create table crc.SurvContact AS
SELECT Email, LastName, FirstName
from crc.crcsurvmaster
GROUP BY Email, LastName, FirstName;

## ADD SPAN VARIABLE
ALTER TABLE crc.SurvContact
      ADD crcid1 varchar(12),
      ADD irb1 varchar(25),
      ADD title1 varchar(400),

      ADD crcid2 varchar(12),
      ADD irb2 varchar(25),
      ADD title2 varchar(400),

      ADD crcid3 varchar(12),
      ADD irb3 varchar(25),
      ADD title3 varchar(400),

      ADD crcid4 varchar(12),
      ADD irb4 varchar(25),
      ADD title4 varchar(400),

      ADD crcid5 varchar(12),
      ADD irb5 varchar(25),
      ADD title5 varchar(400),

      ADD crcid6 varchar(12),
      ADD irb6 varchar(25),
      ADD title6 varchar(400),

      ADD crcid7 varchar(12),
      ADD irb7 varchar(25),
      ADD title7 varchar(400),

      ADD crcid8 varchar(12),
      ADD irb8 varchar(25),
      ADD title8 varchar(400),

      ADD crcid9 varchar(12),
      ADD irb9 varchar(25),
      ADD title9 varchar(400),

      ADD crcid10 varchar(12),
      ADD irb10 varchar(25),
      ADD title10 varchar(400),

      ADD crcid11 varchar(12),
      ADD irb11 varchar(25),
      ADD title11 varchar(400),

      ADD crcid12 varchar(12),
      ADD irb12 varchar(25),
      ADD title12 varchar(400),

      ADD crcid13 varchar(12),
      ADD irb13 varchar(25),
      ADD title13 varchar(400);
      

### POPULATE SPANS
SET SQL_SAFE_UPDATES = 0;      
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid1=lu.CRCID, sc.irb1=lu.IRB, title1=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=1;   
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid2=lu.CRCID, sc.irb2=lu.IRB, title2=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=2;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid3=lu.CRCID, sc.irb3=lu.IRB, title3=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=3;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid4=lu.CRCID, sc.irb4=lu.IRB, title4=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=4;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid5=lu.CRCID, sc.irb5=lu.IRB, title5=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=5;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid6=lu.CRCID, sc.irb6=lu.IRB, title6=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=6;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid7=lu.CRCID, sc.irb7=lu.IRB, title7=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=7;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid8=lu.CRCID, sc.irb8=lu.IRB, title8=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=8;
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid9=lu.CRCID, sc.irb9=lu.IRB, title9=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=9;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid10=lu.CRCID, sc.irb10=lu.IRB, title10=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=10;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid11=lu.CRCID, sc.irb11=lu.IRB, title11=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=11; 
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid12=lu.CRCID, sc.irb12=lu.IRB, title12=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=12;  
UPDATE crc.SurvContact sc, crc.crcsurvmaster lu SET sc.crcid13=lu.CRCID, sc.irb13=lu.IRB, title13=lu.Title WHERE sc.EMAIL=lu.EMAIL and lu.Span=13;


## Make Corrections:
UPDATE crc.SurvContact SET Email='Marcus.Muehlbauer@medicine.ufl.edu' WHERE Email='Alexandra.Emile-Reynolds@medicine.ufl.edu';
DELETE FROM  crc.SurvContact WHERE Email='Brian.Weiner@medicine.ufl.edu';

desc crc.SurvContact;  
select * from crc.SurvContact;  
