



##CREATE TABLE plan.PUBCORE_BACKUP AS select * from pubs.PUB_CORE;
/*
drop table if exists pubs.PUB_CORE ;
CREATE TABLE pubs.PUB_CORE AS Select * from plan.PUBCORE_BACKUP;
*/

ALTER TABLE pubs.PUB_CORE
ADD ProgRLead_LAST varchar(45),
ADD ProgRLead_FIRST varchar(45),
ADD ProfRLead_EMAIL varchar(45);

SET SQL_SAFE_UPDATES = 0;


##################

SELECT DISTINCT ProgReptSrce from pubs.PUB_CORE;
SELECT DISTINCT ProgReptSource from pubs.PUB_CORE;


ALTER TABLE pubs.PUB_CORE DROP  ProgReptSource;

SELECT DISTINCT ProgReptSrce from pubs.PUB_CORE;

UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Morris' , ProgRLead_FIRST='Holly', ProfRLead_EMAIL='hlmorris@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Service Center - Institutionally Supported Pilots and Vouchers';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Pearson' , ProgRLead_FIRST='Thomas', ProfRLead_EMAIL='tapearson@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI TWD Combined';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Pearson' , ProgRLead_FIRST='Thomas', ProfRLead_EMAIL='tapearson@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI TWD KL2';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE ProgReptSrce='2018Oct CTSI SECIM';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Cottler' , ProgRLead_FIRST='Linda', ProfRLead_EMAIL='lbcottler@ufl.edu' WHERE ProgReptSrce='2018Oct Community Eng - HealthStreet and CAB';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE ProgReptSrce='2018Oct BERD';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Hogan' , ProgRLead_FIRST='William', ProfRLead_EMAIL='hoganwr@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI - Biomedical Informatics';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Johnson' , ProgRLead_FIRST='Julie', ProfRLead_EMAIL='julie.johnson@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Personalized Medicine Program';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Winterstein' , ProgRLead_FIRST='Almut', ProfRLead_EMAIL='almut@cop.ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Regulatory Knowledge and Support';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='McCarty' , ProgRLead_FIRST='Christopher', ProfRLead_EMAIL='ufchris@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Network Science Program';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Kreiger' , ProgRLead_FIRST='Janice', ProfRLead_EMAIL='janicekrieger@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Translational Communication Program';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Jeffrey' , ProgRLead_FIRST='Joyce', ProfRLead_EMAIL='Jeffrey.Joyce@med.fsu.edu' WHERE ProgReptSrce='2018Oct CTSA FSU';
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Barnes' , ProgRLead_FIRST='Christopher', ProfRLead_EMAIL='cpb@ufl.edu' WHERE ProgReptSrce='2018Oct CTSI Informatics - CTSI-IT and REDCap';




UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Elder' , ProgRLead_FIRST='Jennifer', ProfRLead_EMAIL='elderjh@ufl.edu' WHERE pubmaster_id2=641;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Shenkman' , ProgRLead_FIRST='Elizabeth', ProfRLead_EMAIL='eshenkman@ufl.edu' WHERE pubmaster_id2=620;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Hogan' , ProgRLead_FIRST='William', ProfRLead_EMAIL='hoganwr@ufl.edu' WHERE pubmaster_id2=503;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Kreiger' , ProgRLead_FIRST='Janice', ProfRLead_EMAIL='janicekrieger@ufl.edu' WHERE pubmaster_id2=508;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Kreiger' , ProgRLead_FIRST='Janice', ProfRLead_EMAIL='janicekrieger@ufl.edu' WHERE pubmaster_id2=509;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Kreiger' , ProgRLead_FIRST='Janice', ProfRLead_EMAIL='janicekrieger@ufl.edu' WHERE pubmaster_id2=510;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Kreiger' , ProgRLead_FIRST='Janice', ProfRLead_EMAIL='janicekrieger@ufl.edu' WHERE pubmaster_id2=297;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Cottler' , ProgRLead_FIRST='Linda', ProfRLead_EMAIL='lbcottler@ufl.edu' WHERE pubmaster_id2=358;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Cottler' , ProgRLead_FIRST='Linda', ProfRLead_EMAIL='lbcottler@ufl.edu' WHERE pubmaster_id2=528;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Cottler' , ProgRLead_FIRST='Linda', ProfRLead_EMAIL='lbcottler@ufl.edu' WHERE pubmaster_id2=535;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE pubmaster_id2=573;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE pubmaster_id2=631;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE pubmaster_id2=665;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE pubmaster_id2=616;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Qiu' , ProgRLead_FIRST='Peihua', ProfRLead_EMAIL='pqiu@ufl.edu' WHERE pubmaster_id2=172;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Fillingim' , ProgRLead_FIRST='Roger', ProfRLead_EMAIL='RFillingim@dental.ufl.edu' WHERE pubmaster_id2=648;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE pubmaster_id2=762;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE pubmaster_id2=720;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE pubmaster_id2=721;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE pubmaster_id2=730;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Yost' , ProgRLead_FIRST='Richard', ProfRLead_EMAIL='ryost@chem.ufl.edu' WHERE pubmaster_id2=614;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Pearson' , ProgRLead_FIRST='Thomas', ProfRLead_EMAIL='tapearson@ufl.edu' WHERE pubmaster_id2=615;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Pearson' , ProgRLead_FIRST='Thomas', ProfRLead_EMAIL='tapearson@ufl.edu' WHERE pubmaster_id2=735;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='Pearson' , ProgRLead_FIRST='Thomas', ProfRLead_EMAIL='tapearson@ufl.edu' WHERE pubmaster_id2=619;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='McCarty' , ProgRLead_FIRST='Christopher', ProfRLead_EMAIL='ufchris@ufl.edu' WHERE pubmaster_id2=622;
UPDATE pubs.PUB_CORE SET ProgRLead_LAST='McCarty' , ProgRLead_FIRST='Christopher', ProfRLead_EMAIL='ufchris@ufl.edu' WHERE pubmaster_id2=178;




drop table if exists work.needlead;
Create table work.needlead as 
select * from pubs.PUB_CORE 
WHERE NIHMS_Status NOT IN  ('PMC Compliant','Conference Presentation','Book Chapter','In Process','Removed NIHMS')
AND ProgRLead_LAST IS NULL
AND EXCLUDED=0
AND YEAR(PubDate)<=2017;

SELECT distinct NIHMS_Status from  pubs.PUB_CORE;




drop table if exists work.pubcompout;
Create table work.pubcompout as 
select 	pubmaster_id2,
		PMID,
		NIHMS_Status,
		May18Grant,
		PilotPub,
		ProgReptSrce,
		ProgRLead_LAST,
		ProgRLead_FIRST,
		ProfRLead_EMAIL,
		PI_LAST,
		PI_FIRST,
		email AS PI_EMAIL,
		PubDate,
		Grant_Numbers
		CTSI_GRANT,
		Citation
from pubs.PUB_CORE 
WHERE NIHMS_Status NOT IN  ('PMC Compliant','Conference Presentation','Book Chapter','In Process','Removed NIHMS')
AND EXCLUDED=0;
##AND YEAR(PubDate)<=2017;
