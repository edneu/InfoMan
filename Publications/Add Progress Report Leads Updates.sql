

DESC pubs.PUB_CORE;

SELECT pubmaster_id2,PMID,Citation FROM pubs.PUB_CORE
WHERE pubmaster_id2 IN 
(52,166,172,178,271,297,358,393,
456,464,482,487,503,508,509,510,512,518,526,528,534,535,555,562,572,573,580,582,
593,600,611,614,616,619,620,622,631,637,639,640,641,648,652,656,657,660,665,670,
671,673,679,683,687,689,690,695,701,702,703,706,708,711,719,720,721,722,723,730);

CREATE TABLE plan.PUBCORE_BACKUP AS select * from pubs.PUB_CORE;
/*
drop table if exists pubs.PUB_CORE ;
CREATE TABLE pubs.PUB_CORE AS Select * from plan.PUBCORE_BACKUP;
*/

ALTER TABLE pubs.PUB_CORE
ADD ProgReptSource varchar(120),
ADD ProgRLead_LAST varchar(45),
ADD ProgRLead_FIRST varchar(45),
ADD ProfRLead_EMAIL varchar(45);

SET SQL_SAFE_UPDATES = 0;

     UPDATE pubs.PUB_CORE SET ProgReptSource=NULL;

     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='26980742';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28039796';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='28132157';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='28197299';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='28263877';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='28265968';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='28280351';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='28306618';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='28346068';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28351962';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28361470';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28412015';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28421563';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28452909';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28533295';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28542029';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28566193';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28587997';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28621562';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28657816';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='28662587';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28668374';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28668774';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='28669194';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28675819';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28681310';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='28693421';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28701941';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28734680';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28737599';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='28742646';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28754232';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28767013';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28822983';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28824913';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28827010';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28837829';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28837829';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28842637';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28850830';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28862882';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28882635';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28882635';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='28899020';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28914267';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='28923194';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28940643';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='28944303';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28954878';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28960154';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='28970488';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='28983423';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29020472';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29027967';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29043938';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29045273';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29046635';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29049133';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29053983';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29060496';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29060866';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29066167';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29077960';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29081362';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29088914';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29097251';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29097388';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29102571';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29102571';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29110740';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29122535';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29124438';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29129554';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29148710';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29150307';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='29153592';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='29160173';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29165692';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29167654';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29186491';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29192967';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29199394';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29204728';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29206922';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29214005';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29216598';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29239141';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29254836';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29258398';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29262725';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Service Center - Institutionally Supported Pilots and Vouchers' WHERE PMID='29305959';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE PMID='29308457';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29313802';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29313802';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29315506';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29323025';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29326035';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29340590';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29343948';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29351371';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29351371';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29351495';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29370524';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29381390';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29381390';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29384654';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29392728';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29398575';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29416498';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29428994';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29440987';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29450404';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29451398';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE PMID='29461126';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29462669';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29468775';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29471813';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29485296';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29489489';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29494332';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29511334';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29511334';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29515435';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29515435';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29523524';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29523524';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29535047';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29535639';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29541533';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29542875';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29544199';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29560807';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29562298';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29569517';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29569517';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29597874';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29603088';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29607241';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29607241';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29615060';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE PMID='29621886';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29629236';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29629615';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29631777';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='29634314';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29642909';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29650502';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29650764';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29658388';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29669081';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29678072';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29697553';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Informatics - CTSI-IT and REDCap ' WHERE PMID='29701153';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29702223';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29704573';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='29714124';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE PMID='29714568';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29731719';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29731719';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29781843';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29789016';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29790196';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29805773';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29848365';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29854151';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSA FSU' WHERE PMID='29872540';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE PMID='29884075';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='29908056';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29925376';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='29935347';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29950986';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29957870';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE PMID='29966341';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 Community Eng - HealthStreet and CAB' WHERE PMID='29977980';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE PMID='29986848';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='29987845';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30009204';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30016565';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30020606';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30026117';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30026679';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30026679';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='30034270';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Personalized Medicine Program' WHERE PMID='30042363';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='30056039';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30059539';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30066651';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30066655';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30066664';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30067089';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30075352';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Informatics - CTSI-IT and REDCap ' WHERE PMID='30076274';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30081463';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='30089431';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30100713';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='30105161';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE PMID='30111190';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE PMID='30116286';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 BERD' WHERE PMID='30118949';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE PMID='30119627';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30138228';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30165769';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30165855';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30179709';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30190102';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30211840';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30216360';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30218116';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Regulatory Knowledge and Support' WHERE PMID='30221182';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE PMID='30221182';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30237584';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30244377';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30252228';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30264205';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE PMID='30279155';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30280868';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30289819';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD KL2' WHERE PMID='30293456';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Regulatory Knowledge and Support' WHERE PMID='30336683';


## ONLINE LINK

     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://link.springer.com/article/10.1007/s11227-018-2359-9';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2698083';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://www.semanticscholar.org/paper/Ontology-of-Cancer-Related-Social-Ecological-Balasubramanian-Khan/eb00ab352f9281821ae23af3a8e21bd2305107f2';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://ieeexplore.ieee.org/document/8411681';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://ieeexplore.ieee.org/document/8411682';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='http://proceedings.mlr.press/v90/yang18a.html';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://aaai.org/ocs/index.php/FLAIRS/FLAIRS18/paper/view/17679';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://www.semanticscholar.org/paper/Toward-Constructing-the-National-Cancer-Institute-(-Hicks/ee0b3f274c34b4edf8464df374ee6cd6388947c1';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI - Biomedical Informatics' WHERE OnlineLink='https://aran.library.nuigalway.ie/handle/10379/7429';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Informatics - CTSI-IT and REDCap ' WHERE OnlineLink='https://zenodo.org/record/1346321#.W9mvtmNRfcs';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Informatics - CTSI-IT and REDCap ' WHERE OnlineLink='https://zenodo.org/record/1346326#.W9mvdWNRfcs';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='http://meeting.physanth.org/program/2018/session01/fuller-2018-depression-in-african-americans-using-genetic-and-social-network-data-to-investigate-variation-in-symptoms-of-depression.html';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='https://www.guilford.com/books/Conducting-Personal-Network-Research/McCarty-Lubbers-Vacca-Molina/9781462538386';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='https://www.tandfonline.com/doi/abs/10.1080/17565529.2017.1301861?journalCode=tcld20';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='http://sa-ijas.stat.unipd.it/sites/sa-ijas.stat.unipd.it/files/10.26398-IJAS.0030-003.pdf';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='https://www.sciencedirect.com/science/article/pii/S0378873316300831';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Network Science Program' WHERE OnlineLink='https://www.bebr.ufl.edu/networks/journal-article/flexible-labors-work-mobility-female-sex-workers-fsws-post-socialist-china';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE OnlineLink='https://link.springer.com/protocol/10.1007/978-1-4939-6946-3_13';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE OnlineLink='https://link.springer.com/article/10.1007/s11306-017-1280-1';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE OnlineLink='https://link.springer.com/article/10.1007/s11306-018-1340-1';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI SECIM' WHERE OnlineLink='https://www.researchgate.net/publication/326900307_Optimization_of_Folch_Bligh-Dyer_and_Matyash_Sample-to-Extraction_Solvent_Ratios_for_Human_Plasma-Based_Lipidomics_Studies';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Regulatory Knowledge and Support' WHERE OnlineLink='https://www.cambridge.org/core/journals/journal-of-clinical-and-translational-science/article/best-practices-in-social-and-behavioral-research-a-multisite-pilot-evaluation-of-the-good-clinical-practice-online-training-course/8EB75C6578AF512758BFD7A5FE40BBE3';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI Translational Communication Program ' WHERE OnlineLink='http://journals.sagepub.com/doi/10.1177/1046878118799472';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE OnlineLink='https://nsuworks.nova.edu/tqr/vol23/iss8/15/';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE OnlineLink='https://nsuworks.nova.edu/tqr/vol23/iss8/6/';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE OnlineLink='https://www.cambridge.org/core/journals/journal-of-clinical-and-translational-science/article/best-practices-in-social-and-behavioral-research-a-multisite-pilot-evaluation-of-the-good-clinical-practice-online-training-course/8EB75C6578AF512758BFD7A5FE40BBE3';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE OnlineLink='https://www.cambridge.org/core/journals/journal-of-clinical-and-translational-science/article/clinical-research-coordinators-instructional-preferences-for-competency-content-delivery/70684C96BB9F5191BF4408107FDCF00E';
     UPDATE pubs.PUB_CORE SET ProgReptSource='2018 CTSI TWD Combined' WHERE OnlineLink='https://www.tandfonline.com/doi/full/10.1080/13611267.2017.1403579?src=recsys';

##################

SELECT DISTINCT ProgReptSrce from pubs.PUB_CORE;
PUB_CORESELECT DISTINCT ProgReptSource from pubs.PUB_CORE;


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
