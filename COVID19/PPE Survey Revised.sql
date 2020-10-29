select * from work.ppeoutraw;

################################################
### Create work table  Raw CSV from RedCap
### Work Table work.ppesurvey
################################################
DROP TABLE IF EXISTS work.ppesurvey;
Create table work.ppesurvey as 
select * from work.ppeoutraw;

################################################
## CREATE TABLE with one record per oder, 
## respondent information repeated on each row
################################################

DROP TABLE IF EXISTS work.ppesurvey1;
Create table work.ppesurvey1 as 
SELECT  record_id AS redcap_record_id,
        redcap_survey_identifier AS redcap_survey_identifier,
        ppe_request_form_v3_timestamp AS SurveyDate,
        lastnamerq AS ReqLastName,
        firstnamerq AS ReqFirstName,
        ufidrq AS ReqUFID,
        deptnamerq AS ReqDept,
        emailrq AS ReqEmail,
        phonerq AS ReqPhone,
        rqstselfproj AS RegSelfProj,
        isproject1 AS IsProj,
        pifirst1 AS PIFirstName,
        pilast1 AS PiLastName,
        pi_ufid1 AS PIUFID,
        type_of_project_funding1 AS FundType,
        fedfun1 AS FedFund,
        oncore1 AS OnCOreUFNum,
        n95mask1 AS n95mask,
        nclothmask1 AS nclothmask,
        nsurgmask1 AS nsurgmask,
        ngowns1 AS ngowns,
        ngloves1 AS ngloves,
        nshields1 AS nshields,
        neyewear1 AS neyewear,
        nhandsan1 AS nhandsan,
        ndisinfect1 AS ndisinfect,
        1 AS  KeepRec
FROM work.ppesurvey
UNION ALL
SELECT  record_id AS redcap_record_id,
        redcap_survey_identifier AS redcap_survey_identifier,
        ppe_request_form_v3_timestamp AS SurveyDate,
        lastnamerq AS ReqLastName,
        firstnamerq AS ReqFirstName,
        ufidrq AS ReqUFID,
        deptnamerq AS ReqDept,
        emailrq AS ReqEmail,
        phonerq AS ReqPhone,
        rqstselfproj AS RegSelfProj,
        1 AS IsProj,
        pifirst2 AS PIFirstName,
        pilast2 AS PiLastName,
        pi_ufid2 AS PIUFID,
        type_of_project_funding2 AS FundType,
        fedfun2 AS FedFund,
        oncore2 AS OnCOreUFNum,
        n95mask2 AS n95mask,
        nclothmask2 AS nclothmask,
        nsurgmask2 AS nsurgmask,
        ngowns2 AS ngowns,
        ngloves2 AS ngloves,
        nshields2 AS nshields,
        neyewear2 AS neyewear,
        nhandsan2 AS nhandsan,
        ndisinfect2 AS ndisinfect,
        anotherproject1 AS KeepRec
FROM work.ppesurvey
UNION ALL
SELECT  record_id AS redcap_record_id,
        redcap_survey_identifier AS redcap_survey_identifier,
        ppe_request_form_v3_timestamp AS SurveyDate,
        lastnamerq AS ReqLastName,
        firstnamerq AS ReqFirstName,
        ufidrq AS ReqUFID,
        deptnamerq AS ReqDept,
        emailrq AS ReqEmail,
        phonerq AS ReqPhone,
        rqstselfproj AS RegSelfProj,
        1 AS IsProj,
        pifirst3 AS PIFirstName,
        pilast3 AS PiLastName,
        pi_ufid3 AS PIUFID,
        type_of_project_funding3 AS FundType,
        fedfun3 AS FedFund,
        oncore3 AS OnCOreUFNum,
        n95mask3 AS n95mask,
        nclothmask3 AS nclothmask,
        nsurgmask3 AS nsurgmask,
        ngowns3 AS ngowns,
        ngloves3 AS ngloves,
        nshields3 AS nshields,
        neyewear3 AS neyewear,
        nhandsan3 AS nhandsan,
        ndisinfect3 AS ndisinfect,
        anotherproject2 AS KeepRec
FROM work.ppesurvey        
UNION ALL
SELECT  record_id AS redcap_record_id,
        redcap_survey_identifier AS redcap_survey_identifier,
        ppe_request_form_v3_timestamp AS SurveyDate,
        lastnamerq AS ReqLastName,
        firstnamerq AS ReqFirstName,
        ufidrq AS ReqUFID,
        deptnamerq AS ReqDept,
        emailrq AS ReqEmail,
        phonerq AS ReqPhone,
        rqstselfproj AS RegSelfProj,
        1 AS IsProj,
        pifirst4 AS PIFirstName,
        pilast4 AS PiLastName,
        pi_ufid4 AS PIUFID,
        type_of_project_funding4 AS FundType,
        fedfun4 AS FedFund,
        oncore4 AS OnCOreUFNum,
        n95mask4 AS n95mask,
        nclothmask4 AS nclothmask,
        nsurgmask4 AS nsurgmask,
        ngowns4 AS ngowns,
        ngloves4 AS ngloves,
        nshields4 AS nshields,
        neyewear4 AS neyewear,
        nhandsan4 AS nhandsan,
        ndisinfect4 AS ndisinfect,
        anotherproject3 AS KeepRec
FROM work.ppesurvey        
UNION ALL
SELECT  record_id AS redcap_record_id,
        redcap_survey_identifier AS redcap_survey_identifier,
        ppe_request_form_v3_timestamp AS SurveyDate,
        lastnamerq AS ReqLastName,
        firstnamerq AS ReqFirstName,
        ufidrq AS ReqUFID,
        deptnamerq AS ReqDept,
        emailrq AS ReqEmail,
        phonerq AS ReqPhone,
        rqstselfproj AS RegSelfProj,
        1 AS IsProj,
        pifirst5 AS PIFirstName,
        pilast5 AS PiLastName,
        pi_ufid5 AS PIUFID,
        type_of_project_funding5 AS FundType,
        fedfun5 AS FedFund,
        oncore5 AS OnCOreUFNum,
        n95mask5 AS n95mask,
        nclothmask5 AS nclothmask,
        nsurgmask5 AS nsurgmask,
        ngowns5 AS ngowns,
        ngloves5 AS ngloves,
        nshields5 AS nshields,
        neyewear5 AS neyewear,
        nhandsan5 AS nhandsan,
        ndisinfect5 AS ndisinfect,
        anotherproject4 AS KeepRec
FROM work.ppesurvey ;     


################################################
## Add Labels to Choice Fields
################################################

ALTER TABLE  work.ppesurvey1
	ADD RegSelfProjFmt varchar(40),
	ADD FundTypeFmt varchar(40),
	ADD Fedfundfmt varchar(5),

	ADD ReqLastNameFmt varchar(45),
	ADD ReqFirstNameFmt varchar(45),
	ADD ReqDeptIDFmt  varchar(12),
	ADD ReqDeptNameFmt  varchar(45),
	ADD PIFirstNameFmt  varchar(45),
	ADD PILastNameFmt  varchar(45),
	ADD PIDeptIDFmt  varchar(12),
	ADD PIDetpNameFmt varchar(45);
        


## FIX UFIDS
ALTER TABLE work.ppesurvey1 MODIFY COLUMN ReqUFID varchar(12) Null,
			                MODIFY COLUMN PIUFID varchar(12) Null;

UPDATE work.ppesurvey1 SET ReqUFID=NULL WHERE ReqUFID IN (""," ","0",0); 
UPDATE work.ppesurvey1 SET ReqUFID=REPLACE(UFID,"-",""); 
UPDATE work.ppesurvey1 SET ReqUFID=REPLACE(UFID," ","");
UPDATE work.ppesurvey1 SET ReqUFID=LPAD(UFID,8,"0");

UPDATE work.ppesurvey1 SET PIUFID=NULL WHERE PIUFID IN (""," ","0",0); 
UPDATE work.ppesurvey1 SET PIUFID=REPLACE(UFID,"-",""); 
UPDATE work.ppesurvey1 SET PIUFID=REPLACE(UFID," ","");
UPDATE work.ppesurvey1 SET PIUFID=LPAD(UFID,8,"0");


### Create UFID LOOKUP TABLE

DROP TABLE IF EXISTS work.PPEallUFIDs;
Create table work.PPEallUFIDs AS
SELECT DISTINCT ReqUFID AS UFID from work.ppesurvey1
WHERE ReqUFID IS NOT NULL
UNION ALL
SELECT DISTINCT PIUFID AS UFID from work.ppesurvey1
WHERE PIUFID IS NOT NULL;


DROP TABLE IF EXISTS work.PPEUfidLookup;
Create table work.PPEUfidLookup AS
SELECT UF_UFID AS UFID,
	   UF_LAST_NM AS LastName,
       UF_FIRST_NM AS FirstName,
       UF_DEPT AS DeptID,
       UF_DEPT_NM AS DeptName
FROM lookup.ufids
WHERE UF_UFID IN (SELECT DISTINCT UFID FROM work.PPEallUFIDs);


UPDATE work.PPEUfidLookup pp, lookup.Employees lu
SET pp.DeptID=lu.Department_Code,
	pp.DeptName=lu.Department
WHERE pp.UFID=lu.Employee_ID;    


###########################################################################
###########################################################################
####UPDATE USER SUPPLIED VALUES
UPDATE work.ppesurvey1 pp, ork.PPEUfidLookup lu
SET pp.ReqLastNameFmt=lu.LastName ,
	pp.ReqFirstNameFmt=lu.FirstName,
	pp.ReqDeptIDFmt=lu.DeptID,
	pp.ReqDeptNameFmt=lu.DeptName
WHERE pp.ReqUFID=lu.UFID;

UPDATE work.ppesurvey1 pp, ork.PPEUfidLookup lu
SET pp.PINameFmt=lu.LastName ,
	pp.PIFirstNameFmt=lu.FirstName,
	pp.PIDeptIDFmt=lu.DeptID,
	pp.PiDeptNameFmt=lu.DeptName
WHERE pp.PIUFID=lu.UFID;

## Ned code to put oold values in FMT vlaues if they dont exist
UPDATE work.ppesurvey1 SET ReqLastNameFmt=ReqLastName WHERE ReqLastNameFmt IN ("",Null," ");
UPDATE work.ppesurvey1 SET ReqFirstNameFmt=ReqFirstName WHERE ReqFIrstNameFmt IN ("",Null," ");
UPDATE work.ppesurvey1 SET ReqDeptIDFmt=ReqDeptID WHERE ReqDeptIDFmt IN ("",Null," ");
UPDATE work.ppesurvey1 SET ReqDeptNameFmt=ReqDeptName WHERE ReqDeptNameFmt IN ("",Null," ");

UPDATE work.ppesurvey1 SET PILastNameFmt=PILastName WHERE PILastNameFmt IN ("",Null," ");
UPDATE work.ppesurvey1 SET PIFirstNameFmt=PIFirstName WHERE PIFIrstNameFmt IN ("",Null," ");

     

###########################################################################
#### LABEL RECORDS
###########################################################################
SET SQL_SAFE_UPDATES = 0;

UPDATE work.ppesurvey1
     SET RegSelfProjFmt =
              CASE
                  WHEN RegSelfProj=1 THEN 'Requesting PPE for myself'
                  WHEN RegSelfProj=2 THEN 'Requesting PPE for a Research Team'
              END;
     
     
UPDATE work.ppesurvey1
     SET FundTypeFmt =
              CASE
                  WHEN FundType=1 THEN 'Internal Funding'
                  WHEN FundType=2 THEN 'External Funding'
                  WHEN FundType=2 THEN 'Both Internal And External Funding'
              END;
	
    
UPDATE work.ppesurvey1
     SET Fedfundfmt =
              CASE
                  WHEN Fedfund=1 THEN 'Federal'
                  WHEN Fedfund=2 THEN 'Non_Federal'
              END;


################################################
## Create output tables with labels
################################################

DROP TABLE IF EXISTS work.ppesurveyOUT;
Create table work.ppesurveyOUT as
SELECT  redcap_record_id,
        redcap_survey_identifier,
        SurveyDate,
        ReqLastNameFmt,
        ReqFirstNameFmt,
        ReqUFID,
        ReqDeptFmt,
        ReqEmailFmt,
        ReqPhone,
        RegSelfProjFmt as ReqSelfProj,
        IsProj,
        PIFirstNameFmt,
        PILastNameFmt,
        PIUFID,
        PIDeptIDFmt,
        PIDeptNameFmt,
        FundTypeFmt AS FundType,
        Fedfundfmt AS Fedfund,
        OnCoreUFNum,
        n95mask,
        nclothmask,
        nsurgmask,
        ngowns,
        ngloves,
        nshields,
        neyewear,
        nhandsan,
        ndisinfect
FROM work.ppesurvey1
WHERE KeepRec=1;        



     

###############################################################################
############### EOF  ##########################################################
###############################################################################

desc work.ppesurveyOUT;
