### CRC Resumption Survey Deveopment


select * from crc.crcsurvmaster;
desc crc.crcsurvmaster; 

;

## CREATE CONTACT TABLE WITH HEADER VARIABLES
DROP TABLE IF EXISTS crc.SurvContact;
Create table crc.SurvContact AS
SELECT Email, LastName, FirstName,max(span) as nSPAN
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

##########################################################################################################
###########################################################################################################
###########################################################################################################
######### LOAD RESULTS 
## UPDATE crc.crcsurvmaster with SurveyResults

DROP TABLE IF EXISTS crc.SurveyRslt;
CREATE TABLE crc.SurveyRslt AS
SELECT * FROM crc.uf_ctsi_crc_study_status_survey;


ALTER TABLE crc.crcsurvmaster
	ADD StudyClosed VARCHAR(5),
	ADD AprvSponsor VARCHAR(5),
	ADD AprvOCRUFR VARCHAR(5),
	ADD SeePartic VARCHAR(5),
	ADD AtCRC VARCHAR(5),
	ADD AntStart VARCHAR(250),
    ADD AntStartDate DATETIME;  
    


UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q3, sc.AprvSponsor=lu.Q4, sc.AprvOCRUFR=lu.Q5, sc.SeePartic=lu.Q6, sc.AtCRC=lu.Q7, sc.AntStart=lu.Q8  WHERE sc.Email=lu.RecipientEmail AND sc.Span=1;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q10, sc.AprvSponsor=lu.Q11, sc.AprvOCRUFR=lu.Q12, sc.SeePartic=lu.Q13, sc.AtCRC=lu.Q14, sc.AntStart=lu.Q15  WHERE sc.Email=lu.RecipientEmail AND sc.Span=2;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q17, sc.AprvSponsor=lu.Q18, sc.AprvOCRUFR=lu.Q19, sc.SeePartic=lu.Q20, sc.AtCRC=lu.Q21, sc.AntStart=lu.Q22  WHERE sc.Email=lu.RecipientEmail AND sc.Span=3;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q24, sc.AprvSponsor=lu.Q25, sc.AprvOCRUFR=lu.Q26, sc.SeePartic=lu.Q27, sc.AtCRC=lu.Q28, sc.AntStart=lu.Q29  WHERE sc.Email=lu.RecipientEmail AND sc.Span=4;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q31, sc.AprvSponsor=lu.Q32, sc.AprvOCRUFR=lu.Q33, sc.SeePartic=lu.Q34, sc.AtCRC=lu.Q35, sc.AntStart=lu.Q36  WHERE sc.Email=lu.RecipientEmail AND sc.Span=5;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q38, sc.AprvSponsor=lu.Q39, sc.AprvOCRUFR=lu.Q40, sc.SeePartic=lu.Q41, sc.AtCRC=lu.Q42, sc.AntStart=lu.Q43  WHERE sc.Email=lu.RecipientEmail AND sc.Span=6;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q45, sc.AprvSponsor=lu.Q46, sc.AprvOCRUFR=lu.Q47, sc.SeePartic=lu.Q48, sc.AtCRC=lu.Q49, sc.AntStart=lu.Q50  WHERE sc.Email=lu.RecipientEmail AND sc.Span=7;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q52, sc.AprvSponsor=lu.Q53, sc.AprvOCRUFR=lu.Q54, sc.SeePartic=lu.Q55, sc.AtCRC=lu.Q56, sc.AntStart=lu.Q57  WHERE sc.Email=lu.RecipientEmail AND sc.Span=8;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q59, sc.AprvSponsor=lu.Q60, sc.AprvOCRUFR=lu.Q61, sc.SeePartic=lu.Q62, sc.AtCRC=lu.Q63, sc.AntStart=lu.Q64  WHERE sc.Email=lu.RecipientEmail AND sc.Span=9;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q66, sc.AprvSponsor=lu.Q67, sc.AprvOCRUFR=lu.Q68, sc.SeePartic=lu.Q69, sc.AtCRC=lu.Q70, sc.AntStart=lu.Q71  WHERE sc.Email=lu.RecipientEmail AND sc.Span=10;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q73, sc.AprvSponsor=lu.Q74, sc.AprvOCRUFR=lu.Q75, sc.SeePartic=lu.Q76, sc.AtCRC=lu.Q77, sc.AntStart=lu.Q78  WHERE sc.Email=lu.RecipientEmail AND sc.Span=11;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q80, sc.AprvSponsor=lu.Q81, sc.AprvOCRUFR=lu.Q82, sc.SeePartic=lu.Q83, sc.AtCRC=lu.Q84, sc.AntStart=lu.Q85  WHERE sc.Email=lu.RecipientEmail AND sc.Span=12;
UPDATE crc.crcsurvmaster sc, crc.SurveyRslt lu SET sc.StudyClosed=lu.Q87, sc.AprvSponsor=lu.Q88, sc.AprvOCRUFR=lu.Q89, sc.SeePartic=lu.Q90, sc.AtCRC=lu.Q91, sc.AntStart=lu.Q92  WHERE sc.Email=lu.RecipientEmail AND sc.Span=13;

UPDATE crc.crcsurvmaster SET AntStartDate=STR_TO_DATE(AntStart, '%Y-%m-%d %H:%i:%s') where AntStart is not null;



DROP TABLE IF EXISTS crc.SurveyComments;
CREATE TABLE crc.SurveyComments AS
SELECT 	RecipientLastName AS LastName,
		RecipientFirstName AS FirstName,
        RecipientEmail AS Email,
		Q93 As SurvComment
FROM crc.SurveyRslt
WHERE Q93 IS NOT NULL;  ##May Be Blanks;


select * from crc.crcsurvmaster;
select * from  crc.SurveyComments;

