DROP TABLE IF EXISTS ctsi_webcamp_adhoc.LizOut;
CREATE TABLE ctsi_webcamp_adhoc.LizOut AS
SELECT 	CORESERVICE.UNIQUEFIELD,
	CORESERVICE.LAB AS LabUF,
	CORESERVICE.PROTOCOL AS ProtUF,
 	VIS.VisProt AS ProtUF2,
    VIS.UF AS VisitID,
	CORESERVICE.STARTDATE AS sd,
	CORESERVICE.ENDDATE AS ed,
	RELATED_TO AS rt,
	LABTEST.LABTEST AS sv,
	LABTEST.UNIQUEFIELD AS svuf,
	LAB.LAB AS la,
    STATUS AS st,
	CORESERVICE.TIMEIN AS ti,
	CORESERVICE.TIMEOUT AS tt,
	TOTAL_TIME AS vl,
	ALLVISITS.SD AS vd,
	ALLVISITS.TIMEIN AS vi,
	ALLVISITS.TIMEOUT AS vo,
	P1.LASTNAME AS P1LastName,
	P1.FIRSTNAME AS P1FirstName,
	P1.MIDDLE AS P1Middle,
	CONCAT(COALESCE(PN.LASTNAME,''),', ',COALESCE(PN.FIRSTNAME,''),' ',COALESCE(PN.MIDDLE,'')) AS pn,
	CONCAT(COALESCE(PN2.LASTNAME,''),', ',COALESCE(PN2.FIRSTNAME,''),' ',COALESCE(PN2.MIDDLE,'')) AS pn2,
	PROTOCOL.PROTOCOL AS pr,
	PROT2.PROTOCOL AS pr2 
FROM (( ((( ((( ( ((((((CORESERVICE LEFT OUTER JOIN LABTEST ON CORESERVICE.LABTEST=LABTEST.UNIQUEFIELD) 
			LEFT OUTER JOIN CORESERVICE_REQUESTINFO ON CORESERVICE_REQUESTINFO.CORESERVICE=CORESERVICE.UNIQUEFIELD)
			LEFT OUTER JOIN LAB ON CORESERVICE.LAB=LAB.UNIQUEFIELD) 
			LEFT OUTER JOIN PROTOCOL ON CORESERVICE.PROTOCOL=PROTOCOL.UNIQUEFIELD)
			LEFT OUTER JOIN (SELECT 1 AS VT,
					 ADMISSIO.UNIQUEFIELD AS UF,
					 LB.LAB,
					 LB.UNIQUEFIELD,
					 ADMISSIO.PROTOCOL AS VisProt 
						FROM 	ADMISSIO,
							LAB LB 
						WHERE ADMISSIO.LAB=LB.UNIQUEFIELD 
						UNION 
					SELECT 2 AS VT,
					 OPVISIT.UNIQUEFIELD AS UF,
					 LB.LAB,
					 LB.UNIQUEFIELD,
					 OPVISIT.PROTOCOL AS VisProt 
						FROM 	OPVISIT,
							LAB LB 
						WHERE OPVISIT.LAB=LB.UNIQUEFIELD
						UNION
					SELECT 3 AS VT,
					 SBADMISSIO.UNIQUEFIELD AS UF,
					 LB.LAB,
					 LB.UNIQUEFIELD,
					 SBADMISSIO.PROTOCOL AS VisProt
						 FROM 	SBADMISSIO,
							LAB LB 
						 WHERE SBADMISSIO.LAB=LB.UNIQUEFIELD)  
							VIS ON VIS.VT=CORESERVICE.RELATED_TO 
						 AND (VIS.UF=CORESERVICE.ADMISSIO OR VIS.UF=CORESERVICE.OPVISIT OR 
							VIS.UF=CORESERVICE.SBADMISSIO)) 
							LEFT OUTER JOIN PROTOCOL PROT2 ON VIS.VisProt=PROT2.UNIQUEFIELD) 
							LEFT OUTER JOIN 
								(SELECT VIS.UNIQUEFIELD,
									1 AS VT,
									ADMITDATE AS SD,
									PATIENT.PATIENT AS PT,
									PATIENT.LASTNAME,
									PATIENT.FIRSTNAME,
									PATIENT.MIDDLE,
									DISCHDATE AS ED,
									TIMEIN,
									TIMEOUT,
									VIS.CATEGORY
								 FROM (	ADMISSIO VIS INNER JOIN PATIENT ON VIS.PATIENT=PATIENT.UNIQUEFIELD)
							     UNION
								SELECT 	VIS.UNIQUEFIELD,
									2 AS VT,
									VISITDATE AS SD,
									PATIENT.PATIENT AS PT,
									PATIENT.LASTNAME,
									PATIENT.FIRSTNAME,
									PATIENT.MIDDLE,
									VISITDATE AS ED,
									TIMEIN,
									TIMEOUT,
									VIS.CATEGORY 
								FROM (OPVISIT VIS INNER JOIN PATIENT ON VIS.PATIENT=PATIENT.UNIQUEFIELD)
							  UNION
								SELECT 	VIS.UNIQUEFIELD,
									3 AS VT,
									ADMITDATE AS SD,
									PATIENT.PATIENT AS PT,
									PATIENT.LASTNAME,
									PATIENT.FIRSTNAME,
									PATIENT.MIDDLE,
									DISCHDATE AS ED,
									TIMEIN,
									TIMEOUT,
									'?' AS CATEGORY
								FROM (SBADMISSIO VIS INNER JOIN PATIENT 
									ON VIS.PATIENT=PATIENT.UNIQUEFIELD))
							 			ALLVISITS ON ALLVISITS.VT=CORESERVICE.RELATED_TO 
									    AND (ALLVISITS.UNIQUEFIELD=CORESERVICE.ADMISSIO 
									     OR ALLVISITS.UNIQUEFIELD=CORESERVICE.OPVISIT 
									     OR ALLVISITS.UNIQUEFIELD=CORESERVICE.SBADMISSIO))
								   LEFT OUTER JOIN (SELECT 	MIN(UNIQUEFIELD) AS FirstRec,
												CORESERVICE FROM CORESERVICE_PERSONPROVIDER
											 GROUP BY CORESERVICE) 
								  FIRSTRESPONSIBLEPERSONREC
									ON FIRSTRESPONSIBLEPERSONREC.CORESERVICE=CORESERVICE.UNIQUEFIELD) 
								LEFT OUTER JOIN CORESERVICE_PERSONPROVIDER 
									ON CORESERVICE_PERSONPROVIDER.UNIQUEFIELD=FIRSTRESPONSIBLEPERSONREC.FirstRec) 
								LEFT OUTER JOIN PERSON P1 
									ON CORESERVICE_PERSONPROVIDER.PERSON=P1.UNIQUEFIELD) 
								LEFT OUTER JOIN (SELECT MIN(UNIQUEFIELD) AS UF,
											CORESERVICE 
										  FROM CORESERVICE_PERSONRECIPIENT 
										  WHERE PERSON_REQUESTER=PERSON
										  GROUP BY CORESERVICE) 
									FIRSTREQUESTER ON FIRSTREQUESTER.CORESERVICE=CORESERVICE.UNIQUEFIELD)
								 LEFT OUTER JOIN (SELECT CORESERVICE_PERSONRECIPIENT.UNIQUEFIELD,
										 	 PERSON,
											 CORESERVICE,
											 ACADEMICTITLE.ACADEMICTITLE,
											 OTHERACADEMICTITLE 
										  FROM CORESERVICE_PERSONRECIPIENT 
										       LEFT OUTER JOIN ACADEMICTITLE 
											 ON CORESERVICE_PERSONRECIPIENT.ACADEMICTITLE=ACADEMICTITLE.UNIQUEFIELD)
											 REQUESTERS ON REQUESTERS.UNIQUEFIELD=FIRSTREQUESTER.UF)
										 LEFT OUTER JOIN (SELECT PERSON.UNIQUEFIELD,
													 TITLE,
													 LASTNAME,
													 FIRSTNAME,
													 MIDDLE,
													 INSTITUTION.INSTITUTION,
													 PHONE,
													 EMAIL,
													 DEPT.DEPT,
													 DIVISION.DIVISION 
												   FROM ((PERSON LEFT OUTER JOIN INSTITUTION 
															ON PERSON.INSTITUTION=INSTITUTION.UNIQUEFIELD)
														 LEFT OUTER JOIN DEPT 
															ON PERSON.DEPT=DEPT.UNIQUEFIELD)
														 LEFT OUTER JOIN DIVISION 
															ON PERSON.DIVISION=DIVISION.UNIQUEFIELD) PR 
															ON REQUESTERS.PERSON=PR.UNIQUEFIELD) 
														 LEFT OUTER JOIN (SELECT PERSON.UNIQUEFIELD AS PIUF,
																 LASTNAME,
																 FIRSTNAME,
																 MIDDLE,
																 PROTOCOL,
																 AREAOFEXPERTISE.AREAOFEXPERTISE,
																 DEPT.DEPT,
																 DIVISION.DIVISION,
																 INSTITUTION.INSTITUTION,
																 EMAIL,
																 PHONE,
																 TITLE,
																 ERACOMMONS_USERNAME,
																 PERSON.INSTITUTION AS InstUF,
																 PERSON.DEPT AS DeptUF
												 FROM (((((PERSON INNER JOIN PERSONPROT ON PERSON.UNIQUEFIELD=PERSONPROT.PERSON)
													   LEFT OUTER JOIN AREAOFEXPERTISE ON PERSON.AREAOFEXPERTISE=AREAOFEXPERTISE.UNIQUEFIELD)
													   LEFT OUTER JOIN DEPT ON PERSON.DEPT=DEPT.UNIQUEFIELD)
													   LEFT OUTER JOIN DIVISION ON PERSON.DIVISION=DIVISION.UNIQUEFIELD) 
													   LEFT OUTER JOIN INSTITUTION ON PERSON.INSTITUTION=INSTITUTION.UNIQUEFIELD) 
												WHERE INVTYPE='P' AND PERSONPROT.INACTIVE=0 ) PN ON PN.PROTOCOL=CORESERVICE.PROTOCOL) 
													   LEFT OUTER JOIN (SELECT 	PERSON.UNIQUEFIELD AS PIUF,
																   	LASTNAME,
																	FIRSTNAME,
																	MIDDLE,
																	PROTOCOL,
																	AREAOFEXPERTISE.AREAOFEXPERTISE,
																	DEPT.DEPT,
																	DIVISION.DIVISION,
																	INSTITUTION.INSTITUTION,
																	EMAIL,
																	PHONE,
																	TITLE,
																	ERACOMMONS_USERNAME,
																	PERSON.INSTITUTION AS InstUF,
																	PERSON.DEPT AS DeptUF
																 FROM (((((PERSON 	INNER JOIN PERSONPROT ON PERSON.UNIQUEFIELD=PERSONPROT.PERSON) 
																			LEFT OUTER JOIN AREAOFEXPERTISE ON PERSON.AREAOFEXPERTISE=AREAOFEXPERTISE.UNIQUEFIELD)
																			LEFT OUTER JOIN DEPT ON PERSON.DEPT=DEPT.UNIQUEFIELD) 
																			LEFT OUTER JOIN DIVISION ON PERSON.DIVISION=DIVISION.UNIQUEFIELD) 
																			LEFT OUTER JOIN INSTITUTION ON PERSON.INSTITUTION=INSTITUTION.UNIQUEFIELD) 
																WHERE INVTYPE='P' 
																  AND PERSONPROT.INACTIVE=0 ) PN2 ON PN2.PROTOCOL=VIS.VisProt) 
																			      WHERE LAB.LABLOCATION=1 
																				AND (CORESERVICE.ENDDATE IS NOT NULL 
																					AND CORESERVICE.ENDDATE <= {d '2020-10-31'} 
																					AND CORESERVICE.ENDDATE >= {d '2017-07-01'}) 
																					AND (CORESERVICE.LAB=12) 
																					AND (VIS.UNIQUEFIELD=12) 
																					AND (CORESERVICE.Status=2) 
																					AND (CORESERVICE.OPVISIT IS NOT NULL 
																					AND CORESERVICE.LABTEST NOT IN (SELECT UNIQUEFIELD FROM LABTEST WHERE LABTEST= 'CTRB: Outpatient Visit (Actual) '));
                                                                                    


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.StaffRoom1;
CREATE TABLE ctsi_webcamp_adhoc.StaffRoom1 AS
SELECT 	concat(YEAR(lo.vd),"-",LPAD(MONTH(lo.vd),2,"0")) AS MONTH,
		lo.VisitID,
		lo.vd AS VisitDate,
        STR_TO_DATE(concat(trim(lo.vi),"m"), '%h:%i %p') AS VisitStartTIme,
        STR_TO_DATE(concat(trim(lo.vo),"m"), '%h:%i %p') AS VisitEndTIme,
        TimeDiff(STR_TO_DATE(concat(trim(lo.vo),"m"), '%h:%i %p'),STR_TO_DATE(concat(trim(lo.vi),"m"), '%h:%i %p')) AS VisitLength,
        lo.sv AS Service,
        lo.P1LastName AS StaffLast,
        lo.P1FirstName AS StaffFirst,
        lo.pn AS PI_NAME,
        lo.ProtUF As Protocol,
        pt.Protocol AS CRCNum,
        pt.LONGTITLE AS StudyTitle
FROM ctsi_webcamp_adhoc.LizOut lo
LEFT JOIN ctsi_webcamp_pr.protocol pt ON lo.ProtUF=pt.UNIQUEFIELD;

DROP TABLE IF EXISTS ctsi_webcamp_adhoc.RoomLookup; 
CREATE TABLE ctsi_webcamp_adhoc.RoomLookup As
SELECT DISTINCT VisitID from ctsi_webcamp_adhoc.StaffRoom1;

ALTER TABLE ctsi_webcamp_adhoc.RoomLookup
ADD BedID bigint(20),
ADD Bed VARCHAR(15),
ADD RoomID bigint(20),
ADD Room varchar(12);


SET SQL_SAFE_UPDATES = 0;

UPDATE ctsi_webcamp_adhoc.RoomLookup rl, ctsi_webcamp_pr.opvisit lu
SET rl.BedID=lu.bed
WHERE rl.VisitID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.RoomLookup rl, ctsi_webcamp_pr.bed lu
SET rl.RoomID=lu.room,
    RL.Bed=lu.bed
WHERE rl.BedID=lu.UNIQUEFIELD;

UPDATE ctsi_webcamp_adhoc.RoomLookup rl, ctsi_webcamp_pr.room lu
SET rl.Room=lu.room
WHERE rl.RoomID=lu.UNIQUEFIELD;

ALTER TABLE ctsi_webcamp_adhoc.StaffRoom1  ADD Room varchar(12);

UPDATE ctsi_webcamp_adhoc.StaffRoom1 sr, ctsi_webcamp_adhoc.RoomLookup lu
SET sr.Room=lu.room
WHERE sr.VisitID=lu.VisitID;


DROP TABLE IF Exists ctsi_webcamp_adhoc.StaffRoom;
CREATE TABLE ctsi_webcamp_adhoc.StaffRoom AS
SELECT 	MONTH,
		VisitDate,
		Room,
		VisitStartTime,
		VisitEndTIme,
		VisitLength,
		Service,
		StaffLast,
		StaffFirst,
		CRCNum,
		Protocol,
		PI_NAME,
		StudyTitle,
		VisitID
FROM ctsi_webcamp_adhoc.StaffRoom1
ORDER BY MONTH, VisitDate,VisitStartTIme,StaffLast;        
 

SELECT * FROM ctsi_webcamp_adhoc.StaffRoom;
#desc ctsi_webcamp_adhoc.StaffRoom;


##################################################################################
##################################################################################
##################################################################################
##################################################################################
##################################################################################
##################################################################################
############# scratch
/*
SELECT  SEC_TO_TIME( SUM( TIME_TO_SEC( `timeSpent` ) ) ) AS timeSum  
FROM YourTableName 
*/

select Month,Room,count(distinct VISITID) as nVISITS
FROM ctsi_webcamp_adhoc.StaffRoom
WHERE Room like "%1250%"
GROUP BY MONTH,ROOM;




SELECT DISTINCT TABLE_NAME 
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA='ctsi_webcamp_pr' 
    AND COLUMN_NAME LIKE '%room%';
      
      
      
SELECT DISTINCT TABLE_NAME 
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA='ctsi_webcamp_pr' 
    AND COLUMN_NAME LIKE '%bed%';
    
    
    
                                                                                    
select * from ctsi_webcamp_adhoc.LizOut;       

select sv,svuf from ctsi_webcamp_adhoc.LizOut group by Sv,svuf;  
 
select pr,pr2 from ctsi_webcamp_adhoc.LizOut group by pr,pr2;
  
select pr,pr2 from ctsi_webcamp_adhoc.LizOut 
;

select * from  ctsi_webcamp_adhoc.LizOut;

sELECT distinct LabUF from  ctsi_webcamp_adhoc.LizOut;    


########
SELECT Bed,INOROUT from ctsi_webcamp_pr.bed_ioro 
WHERE bed IN (SELECT distinct BedID from ctsi_webcamp_adhoc.RoomLookup
WHERE Room like "%1250%");


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.temp ;
CREATE TABLE ctsi_webcamp_adhoc.temp As
SELECT rl.Room,rl.Bed,rl.BedID,rl.RoomID,bi.INOROUT
FROM ctsi_webcamp_adhoc.RoomLookup rl
LEFT JOIN ctsi_webcamp_pr.bed_ioro bi ON
rl.BedID=bi.bed
WHERE rl.Room like "%1250%"
GROUP BY rl.Room,rl.Bed,rl.BedID,rl.RoomID,bi.INOROUT ;


DROP TABLE IF EXISTS ctsi_webcamp_adhoc.temp ;
CREATE TABLE ctsi_webcamp_adhoc.temp As
SELECT rl.Room,rl.Bed,rl.BedID,rl.RoomID,bi.INOROUT
FROM ctsi_webcamp_adhoc.RoomLookup rl
LEFT JOIN ctsi_webcamp_pr.bed_ioro bi ON
rl.BedID=bi.bed
WHERE bi.INOROUT<>2
GROUP BY rl.Room,rl.Bed,rl.BedID,rl.RoomID,bi.INOROUT ;
