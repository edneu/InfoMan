


## CREATE WORK TABLE
DROP TABLE IF EXISTS clinical.ct_work;
CREATE TABLE clinical.ct_work AS
SELECT * from clinical.ctgov20230222; 

ALTER TABLE clinical.ct_work
	ADD keep_date int(1),
	ADD UF int(1),
	ADD FSU int(1),
    ADD nSites int(5),
    ADD Lead_Institution varchar(255),
    ADD Lead_ERACommons varchaR(25),
    ADD Lead_EIN varchar(12),
    ADD Duration_months int(5);


## Initialize Flags
SET SQL_SAFE_UPDATES = 0;
UPDATE clinical.ct_work 
	SET Keep_date=0,
		UF=0,
        FSU=0,
        nSites=0,
        Lead_Institution=NULL,
        Lead_ERACommons=NULL,
        Lead_EIN=NULL,
        Duration_months=NULL;

## Define Start Date Restrictions
UPDATE 	clinical.ct_work 
		SET keep_date=1
WHERE 	Start_Date>=str_to_date('12,01,2022','%m,%d,%Y')      ## START DATE OF TAGET PERIOD
AND 	Start_Date<=str_to_date('05,31,2023','%m,%d,%Y');     ## END DATE OF TAGET PERIOD

### Define Location Restrictions
## UF
UPDATE 	clinical.ct_work
		SET UF=1
WHERE  Locations LIKE ('%UNIVERSITY OF FLORIDA%')     
   OR  Locations LIKE ('%UF HEALTH%'); 

## FSU
UPDATE 	clinical.ct_work
		SET FSU=1
WHERE  Locations LIKE ('%FLORIDA STATE UNIVERSITY%');     


###Single or MultiSite  Number of Sites
### Sites are delimited by Pipes ('|').   The number of sites equalt the number of pipes +1

UPDATE 	clinical.ct_work
		SET nSites=(LENGTH(Locations)-LENGTH( REPLACE ( Locations, "|", "") ) )+1;

##################################################################################################################################
#### Sponsor Institution
#### Number of Sites
## Mulitsite
UPDATE clinical.ct_work
SET Lead_Institution=TRIM(SUBSTR(`Sponsor/Collaborators`,1,LOCATE("|",`Sponsor/Collaborators`)-1))
WHERE LOCATE("|",`Sponsor/Collaborators`)>0;

## Single Site 
UPDATE clinical.ct_work
SET Lead_Institution=TRIM(`Sponsor/Collaborators`)
WHERE LOCATE("|",`Sponsor/Collaborators`)=0;

##Use Contact Institution (curated)
Update clinical.ct_work SET Lead_Institution='University of South Florida' WHERE NCT_Number='NCT04291703';
Update clinical.ct_work SET Lead_Institution='Cornell University' WHERE NCT_Number='NCT05534984';
Update clinical.ct_work SET Lead_Institution='University of California San Francisco' WHERE NCT_Number='NCT05574335';
Update clinical.ct_work SET Lead_Institution='University of California, San Diego' WHERE NCT_Number='NCT05453578';
Update clinical.ct_work SET Lead_Institution='University of California San Francisco' WHERE NCT_Number='NCT05201469';
##################################################################################################################################
##################################################################################################################################
##################################################################################################################################

#####
## Study Duration in Months

UPDATE clinical.ct_work
SET Duration_months=ROUND(DATEDIFF(greatest(Primary_Completion_Date,Completion_Date),Start_Date)/30.25,0);



#################################################################
#################################################################
### LEAD INSTITUTION ERA COMMONS AND EIN
UPDATE clinical.ct_work ct, clinical.institution_ids lu
SET ct.Lead_ERACommons=lu.ERACommons,
    ct.Lead_EIN=lu.EIN
WHERE ct.Lead_Institution=TRIM(lu.Institution);    





select * from clinical.ct_work;



select * from clinical.ct_work
WHERE keep_date=1
AND (UF=1 OR FSU=1);

#################################################################
## Format Output  Table


select  NCT_Number,
		Interventions,
        Phases,
        nSites,
        Lead_Institution,
        Lead_ERACommons,
        Lead_EIN,
        Funded_Bys,  ## REVISE Contract, Grant, Institutional
        Duration_months,
        Enrollment,
        Outcome_Measures
from clinical.ct_work
WHERE keep_date=1
AND (UF=1 OR FSU=1);
########################################################################################
/*
xCT ID1
xStudy Title
xIntervention/ Treatment/ Diagnostic
xTrial Phase2
xSingle or Multi-site3 
xPrimary Site Institution (as listed in eRA)
xPrimary Site eRA Commons Institutional Profile No.
xPrimary Site Institution EIN or DUNS Number
REVISE Funding Source4
Months from Actual Start/ Completion Date
Actual Cumulative Enrollment
Primary Endpoint Result Indication
*/
#####################################################################################################
#####################################################################################################
#####################################################################################################
############################ EOF ####################################################################
#####################################################################################################
##### VERIFY
#####  Select `Sponsor/Collaborators`,Lead_Institution from clinical.ct_work;
#######################################################
## Verify Dates
SELECT 	MIN(Start_Date) as FromDate,
		MAX(Start_Date) as ToDate,
        DATEDIFF(MAX(Start_Date), MIN(Start_Date)) as Diff
from clinical.ct_work  
WHERE keep_date=1;  
##########################################################



/*
UPDATE clinical.institution_ids
SET ERACommons="N/A"
WHERE ERACommons IS NULL
AND Institution NOT LIKE 'National Institute of%'; 
*/

##### Check for missing Instutional IDS to add to clinical.institution_ids table
## CREATE TABLE FOR Instituition Indentifier Curation

DROP TABLE IF EXISTS clinical.curateInstID ;
Create table clinical.curateInstID as
select Lead_Institution,Lead_ERACommons, Lead_EIN, COUNT(*) as nTrials
FROM clinical.ct_work
WHERE keep_date=1
AND (UF=1 OR FSU=1)
AND  (Lead_ERACommons IS NULL OR Lead_EIN IS NULL)
GROUP BY  Lead_Institution,Lead_ERACommons, Lead_EIN; 


select NCT_Number,Lead_Institution,Lead_ERACommons, Lead_EIN, COUNT(*) as nTrials
FROM clinical.ct_work
WHERE keep_date=1
AND (UF=1 OR FSU=1)
AND  (Lead_ERACommons IS NULL OR Lead_EIN IS NULL)
GROUP BY NCT_Number, Lead_Institution,Lead_ERACommons, Lead_EIN; 

Select max(institution_ids_id)+1 from clinical.institution_ids;

## Curate NIH Leads
/*Select NCT_Number,URL, Lead_Institution, `Sponsor/Collaborators`, Locations from clinical.ct_work
WHERE  Lead_Institution IN
('National Institute of Allergy and Infectious Diseases (NIAID)',
'National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK)');
*/






#################################################################
#################################################################

