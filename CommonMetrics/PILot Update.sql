

INSERT INTO `lookup`.`pilots`

###########################
drop table if exists work.crclookup;
create table work.crclookup AS
SELECT	UF_UFID,
		UF_LAST_NM,
		UF_FIRST_NM,
		UF_EMAIL,
		UF_USER_NM,
        "" AS ERACOMMONS,
		UF_DEPT,
		UF_DEPT_NM,	
		UF_WORK_TITLE
from lookup.ufids
WHERE 
(UF_LAST_NM='Allen' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Alnuaimat' AND UF_FIRST_NM LIKE 'H%') OR 
(UF_LAST_NM='Anton' AND UF_FIRST_NM LIKE 'S%') OR 
(UF_LAST_NM='Atkinson' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Bartley' AND UF_FIRST_NM LIKE 'E%') OR 
(UF_LAST_NM='Borum' AND UF_FIRST_NM LIKE 'P%') OR 
(UF_LAST_NM='Brantly' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Bril' AND UF_FIRST_NM LIKE 'F%') OR 
(UF_LAST_NM='Bubb' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Buford' AND UF_FIRST_NM LIKE 'T%') OR 
(UF_LAST_NM='Bulitta' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Byrne' AND UF_FIRST_NM LIKE 'B%') OR 
(UF_LAST_NM='Cardel' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Carson' AND UF_FIRST_NM LIKE 'T%') OR 
(UF_LAST_NM='Cavallari' AND UF_FIRST_NM LIKE 'L%') OR 
(UF_LAST_NM='Cohen' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM='Cohen' AND UF_FIRST_NM LIKE 'R%') OR 
(UF_LAST_NM='Conrad' AND UF_FIRST_NM LIKE 'K%') OR 
(UF_LAST_NM='Corti' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Cusi' AND UF_FIRST_NM LIKE 'K%') OR 
(UF_LAST_NM='Dang' AND UF_FIRST_NM LIKE 'N%') OR 
(UF_LAST_NM='Dayton' AND UF_FIRST_NM LIKE 'K%') OR 
(UF_LAST_NM='Derendorf' AND UF_FIRST_NM LIKE 'H%') OR 
(UF_LAST_NM='Duarte' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Ebner' AND UF_FIRST_NM LIKE 'N%') OR 
(UF_LAST_NM='Elie' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Fillingim' AND UF_FIRST_NM LIKE 'R%') OR 
(UF_LAST_NM='Forsmark' AND UF_FIRST_NM LIKE 'C%') OR 
(UF_LAST_NM='George' AND UF_FIRST_NM LIKE 'S%') OR 
(UF_LAST_NM='Haller' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Heldermon' AND UF_FIRST_NM LIKE 'C%') OR 
(UF_LAST_NM='Kaye' AND UF_FIRST_NM LIKE 'F%') OR 
(UF_LAST_NM='KHANNA' AND UF_FIRST_NM LIKE 'A%') OR 
(UF_LAST_NM='Lascano' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Lemas' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM='Lott' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM='Maegawa' AND UF_FIRST_NM LIKE 'G%') OR 
(UF_LAST_NM='Manini' AND UF_FIRST_NM LIKE 'T%') OR 
(UF_LAST_NM='McFarland' AND UF_FIRST_NM LIKE 'N%') OR 
(UF_LAST_NM='Miller' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Mitchell' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM='Mohandas' AND UF_FIRST_NM LIKE 'R%') OR 
(UF_LAST_NM='Nelson' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM LIKE'O%Dell' AND UF_FIRST_NM LIKE 'W%') OR 
(UF_LAST_NM='Price' AND UF_FIRST_NM LIKE 'C%') OR 
(UF_LAST_NM='Rahman' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Rajasekhar' AND UF_FIRST_NM LIKE 'A%') OR 
(UF_LAST_NM='Rashidi' AND UF_FIRST_NM LIKE 'P%') OR 
(UF_LAST_NM='Riley' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Sattari' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Schatz' AND UF_FIRST_NM LIKE 'D%') OR 
(UF_LAST_NM='Segal' AND UF_FIRST_NM LIKE 'M%') OR 
(UF_LAST_NM='Sibille' AND UF_FIRST_NM LIKE 'K%') OR 
(UF_LAST_NM='Silverstein' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Smith' AND UF_FIRST_NM LIKE 'B%') OR 
(UF_LAST_NM='Stacpoole' AND UF_FIRST_NM LIKE 'P%') OR 
(UF_LAST_NM='Subramony' AND UF_FIRST_NM LIKE 'S%') OR 
(UF_LAST_NM='Tyndall' AND UF_FIRST_NM LIKE 'J%') OR 
(UF_LAST_NM='Vandenborne' AND UF_FIRST_NM LIKE 'K%') OR 
(UF_LAST_NM='Wang' AND UF_FIRST_NM LIKE 'G%') OR 
(UF_LAST_NM='Wilson' AND UF_FIRST_NM LIKE 'C%') OR 
(UF_LAST_NM='Winesett' AND UF_FIRST_NM LIKE 'S%') OR 
(UF_LAST_NM='Woods' AND UF_FIRST_NM LIKE 'A%') OR 
(UF_LAST_NM='Wynn' AND UF_FIRST_NM LIKE 'T%') OR 
(UF_LAST_NM='Yaghjyan' AND UF_FIRST_NM LIKE 'L%') OR 
(UF_LAST_NM='Zori' AND UF_FIRST_NM LIKE 'R%') ;

;
		

select max(pilot_ID) from lookup.pilots;
select * from lookup.standard_programs;



INSERT INTO `lookup`.`pilots`
(`Pilot_ID`,`Award_Year`,`Category`,`Awarded`,`AwardLetterDate`,`Award_Amt`,`UFID`,`Email`,`PI_First`,`PI_Last`,`Title`,`PI_DEPT`,`PI_DEPTID`,`PI_DEPTNM`)
VALUES
(380,2017,'Clinical',     'Awarded','2017-01-25 00:00:00',19575.1,'63430860','bleser@ufl.edu','Tana','Carson','Treatment for Auditory Hyper-Reactivity Behavior in Children with Autism Using Exposure and Response Prevention Principles','HP-OCCUPATIONAL THERAPY','33030000','HP-OCCUPATIONAL THERAPY'),
(381,2017,'Clinical',     'Awarded','2017-02-02 00:00:00',8154.72,'00251675','nseraphin@ufl.edu','Marie','Seraphin','Post-immigration return trips and tuberculosis disease risk among Haitians','MD-INFECTIOUS DISEASES','29050800','MD-INFECTIOUS DISEASES'),
(382,2016,'Communication','Awarded','2016-12-19 00:00:00',  5000, '43602181','carlalfisher@ufl.edu','Carla','Fischer','Using the mother-daughter story to humanize & enhance breast cancer care: Blending arts & sciences in psychosocial-oncology intervention development','CJC-ADVERSTISING-GENERAL','23020100','CJC-ADVERSTISING-GENERAL'),
(383,2016,'Communication','Awarded','2016-12-19 00:00:00',  7050,'21161434' ,'djlemas@ufl.edu','Dominick','Lemas','Recruitment and retention of pregnant and lactating mothers for longitudinal clinical microbiome studies','MD-HOBI-GENERAL','29240101','MD-HOBI-GENERAL'),
(384,2016,'Communication','Awarded','2016-12-19 00:00:00', 10000,'27707570','nicole.cacho@peds.ufl.edu','Nicole','Cacho','Preparing parents for neonatal intensive care unit (NICU) admission: A video-based educational module','MD-PEDS-NEONATOLOGY','29091700','MD-PEDS-NEONATOLOGY'),
(385,2017,'Translational','Awarded','2017-07-17 00:00:00', 14871,'30697200','dfedele@ufl.edu','David','Fedele','Engaging Rural Communities in Asthma Care','HP-CLINICAL / HLTH PSYCHOLOGY','33070000','HP-CLINICAL / HLTH PSYCHOLOGY'),
(386,2017,'Translational','Awarded','2017-08-23 00:00:00', 14728,'92968945','yulias@ufl.edu','Yulia','Strekalova','Stakeholder Engagement and Patient Centered Communication in Leukemia','CJC-GRADUATE STUDIES / RESEARC','23010200','CJC-GRADUATE STUDIES / RESEARC'),
(387,2017,'Translational','Awarded','2017-09-07 00:00:00', 50000,'37296173','janicekrieger@jou.ufl.edu','Janice','Krieger','Optimizing processes and decisional support for Consent2Share to improve enrollment, decision quality, and participation in clinical research','CJC-ADVERTISING','23020000','CJC-ADVERTISING'),
(388,2017,'Translational','Awarded','2017-11-27 00:00:00', 50000,'35055720','SLampotang@anest.ufl.edu','Samsun','Lampotang','Pragmatic Clinical Trial of Race-Specific Response to Propofol Infusion Titrated to Effect for Procedural Sedation During Endoscopy','MD-ANESTHESIOLOGY-GENERAL','29040100','MD-ANESTHESIOLOGY-GENERAL'),
(389,2017,'Translational','Awarded','2017-06-21 00:00:00', 50000,'46694753','rlucero@ufl.edu','Robert','Lucero','Identifying Predictive Algorithms using Electronic Health Record Data to Inform the Development of a Point-of-Care Early Warning System for Hospital-Acquired Falls','NR-FCH-FAMLY COMM HLTH SYS SCI','31020000','NR-FCH-FAMLY COMM HLTH SYS SCI')
;


######################################################################