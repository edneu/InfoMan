/*

This is the SQL to create the Bondmaster File

Data and Working Files are in “C:\Users\edneu\Dropbox\CTSI\CTSI Projects\CTRB Bond\Bond2016”
INFOMAN Schema = space.

Input Files Required space2016: (this is the "Project" Space survey file for the CTRB (Source Jodi Chase: UF Planning Design and Construction

 Files used in INFOMAN:   lookup.Grants_SRM  (Grants Data)
                          lookup.ufids (Personnel Data)  

*/


## LOAD TABLE FROM SPACE SURVEY
## May need adjustment for final formats;

DROP TABLE if exists work.spacelist;
CREATE TABLE work.spacelist AS
Select BLDG AS Building,
         FL AS Floor,
         ROOM as Room,
         PRJNUM AS ProjectID 
FROM space.ctrb_projects_2020;
  
## Create an extract of the grants data for these projects


DROP TABLE IF EXISTS work.SRMWORK;
Create table work.SRMWORK AS
SELECT * FROM lookup.awards_history
WHERE CLK_AWD_PROJ_ID IN (SELECT DISTINCT ProjectID from work.spacelist)
and CLK_AWD_PRJ_START_DT<=STR_TO_DATE(concat('06,30,',year(curdate())),'%m,%d,%Y')
and CLK_AWD_PRJ_END_DT>=STR_TO_DATE(concat('07,01,',year(curdate())-1),'%m,%d,%Y');


/*   The AwardID Table with Deine the Investigator to Contact for the survey
     The AwardID in initialized with the Contract_PI_UFID, then updated for project not havinf a PS_Contract ID
*/
/*
DROP TABLE work.AwardID;
create table work.AwardID AS
select PS_PROJECT,
       PS_CONTRACT,
       PI_UFID,
       CoPI_UFID,
       Contract_PI_UFID,
       Project_PI_UFID,
       "Contract" AS Award_ID_TYPE,  
       PS_CONTRACT AS Award_ID,
       Contract_PI_UFID AS AWARD_INV_UFID,
       0 AS SPACE_SOURCE
FROM work.SRMWORK;
*/

DROP TABLE if exists work.AwardID;
create table work.AwardID AS
select CLK_AWD_PROJ_ID,
       CLK_AWD_ID,
       CLK_PI_UFID,
       CLK_AWD_PI,
       CLK_AWD_PROJ_MGR_UFID,
       CLK_AWD_PROJ_MGR,
       "Contract" AS Award_ID_TYPE,  
       CLK_AWD_ID AS Award_ID,
       CLK_PI_UFID AS AWARD_INV_UFID,
       0 AS SPACE_SOURCE
FROM work.SRMWORK;


select * from  work.AwardID ;


## POPULATE AWARD_ID INformation for projects without PS_CONTRACT IDs

SET SQL_SAFE_UPDATES = 0;

UPDATE work.AwardID awd
       SET awd.AWARD_INV_UFID=CLK_AWD_PROJ_MGR_UFID,
           awd.Award_ID=CLK_AWD_PROJ_ID,
           awd.SPACE_SOURCE=2,
           awd.Award_ID_TYPE="Project"
        WHERE Award_ID="";

## Create SPACE.AwardID Table (not in work schema)

DROP TABLE space.AwardID;
CREATE TABLE space.AwardID as
SELECT Award_ID_TYPE,
       Award_ID,
       AWARD_INV_UFID
FROM work.AwardID
GROUP BY Award_ID_TYPE,
         Award_ID,
         AWARD_INV_UFID;


## Create space.Project_Not_found for reporting

drop table space.Project_Not_found;
create table space.Project_Not_found as 
select distinct ProjectID 
       from work.spacelist 
       where ProjectID NOT IN (SELECT DISTINCT CLK_AWD_PROJ_ID FROM lookup.awards_history); 


## Add in the AWARD INVESTIGATOR EMAIL AND PHONE NUMBER, FIrst NAME AND LAST NAME

ALTER TABLE space.AwardID ADD PI_LAST_NAME varchar(45),
                          ADD PI_FIRST_NAME varchar(45),   
                          ADD PI_EMAIL varchar(45),
                          ADD PI_PHONE varchar(45), 
                          ADD PI_DEPTID varchar(24),
                          ADD PI_DEPT varchar(132);


 UPDATE space.AwardID awd, lookup.ufids uf
      SET awd.PI_LAST_NAME = uf.UF_LAST_NM,
          awd.PI_FIRST_NAME = uf.UF_FIRST_NM,
          awd.PI_EMAIL = uf.UF_EMAIL, 
          awd.PI_PHONE = uf.UF_TELEPHONE,
          awd.PI_DEPTID = uf.UF_DEPT,
          awd.PI_DEPT  = uf.UF_DEPT_NM
      WHERE awd.AWARD_INV_UFID=uf.UF_UFID;

select * from space.AwardID;



select * from space.AwardID WHERE PI_EMAIL IS NULL OR  PI_EMAIL="";
## Fix Missing Emails  emails not in lookup.ufid
###ATE space.AwardID  SET PI_EMAIL='ashizawa@ufl.edu' WHERE AWARD_INV_UFID='18909231';

##################################################################


## REMOVE AGING RESEARCH
 
## select PI_DEPTID, PI_DEPT   from space.AwardID group by PI_DEPTID, PI_DEPT ;
## select distinct substr(PI_DEPTID,1,4) from space.AwardID;
DELETE FROM space.AwardID where PI_DEPTID IN ('29310000','29310100','29310200','29310201','29310202');


#######################################################################################################################################################
#######################################################################################################################################################
##########################################################################################################################  EDITED TO HERE ############
#######################################################################################################################################################

select * from work.SRMWORK;
select * from space.AwardID;
## Create Bondmaster File (work schema)

DROP TABLE if exists work.bondmaster;
create table work.bondmaster AS
SELECT awd.AWARD_ID_TYPE,
	   awd.AWARD_INV_UFID,
       awd.AWARD_ID,
       awd.AWARD_ID AS AWARD_ID_Number,
       CONCAT('UFirst Award#: ',awd.AWARD_ID) AS AwardText,
       max(awd.PI_LAST_NAME) AS PI_LAST_NAME ,
       max(awd.PI_FIRST_NAME) AS PI_FIRST_NAME,
       max(awd.PI_EMAIL) AS PI_EMAIL,
       max(awd.PI_PHONE) AS PI_PHONE ,
       max(awd.PI_DEPTID) AS PI_DEPTID,
       max(awd.PI_DEPT) AS PI_DEPT,
       max(srm.REPORTING_SPONSOR_NAME) AS SponsorName,
       max(REPORTING_SPONSOR_CUSTID) AS SponsorID,
       max(srm.REPORTING_SPONSOR_CAT) AS Prime_Sponsor_Type,
       max((case srm.CLK_AWD_FULL_TITLE when "" then CLK_AWD_PROJ_NAME else srm.CLK_AWD_FULL_TITLE end)) as Title,       
       sum(SPONSOR_AUTHORIZED_AMOUNT) as Total_Award
from space.AwardID awd, work.SRMWORK srm
WHERE awd.AWARD_ID_TYPE="Contract"
  AND awd.AWARD_ID=srm.CLK_AWD_ID
GROUP BY awd.AWARD_ID_TYPE,
	     awd.AWARD_INV_UFID,
         awd.AWARD_ID
UNION ALL
SELECT awd.AWARD_ID_TYPE,
	   awd.AWARD_INV_UFID,
       awd.AWARD_ID,
       awd.AWARD_ID AS AWARD_ID_Number,
       CONCAT('UFirst Award#: ',awd.AWARD_ID) AS AwardText,
       max(awd.PI_LAST_NAME) AS PI_LAST_NAME ,
       max(awd.PI_FIRST_NAME) AS PI_FIRST_NAME,
       max(awd.PI_EMAIL) AS PI_EMAIL,
       max(awd.PI_PHONE) AS PI_PHONE ,
       max(awd.PI_DEPTID) AS PI_DEPTID,
       max(awd.PI_DEPT) AS PI_DEPT,
       max(srm.REPORTING_SPONSOR_NAME) AS SponsorName,
       max(REPORTING_SPONSOR_CUSTID) AS SponsorID,
       max(srm.REPORTING_SPONSOR_CAT) AS Prime_Sponsor_Type,
       max((case srm.CLK_AWD_FULL_TITLE when "" then CLK_AWD_PROJ_NAME else srm.CLK_AWD_FULL_TITLE end)) as Title,  
       sum(SPONSOR_AUTHORIZED_AMOUNT) as Total_Award
from space.AwardID awd, work.SRMWORK srm
WHERE awd.AWARD_ID_TYPE="Project"
  AND awd.AWARD_ID=srm.CLK_AWD_PROJ_ID
GROUP BY awd.AWARD_ID_TYPE,
	     awd.AWARD_INV_UFID,
         awd.AWARD_ID
;

ALTER TABLE work.bondmaster ADD Sponsor_Type Varchar(10);
UPDATE work.bondmaster SET Sponsor_Type="Private";

###SELECT DISTINCT Prime_Sponsor_Type, Sponsor_Type from work.bondmaster group by Prime_Sponsor_Type, Sponsor_Type;

select Prime_Sponsor_Type,SponsorName,count(*) as N from work.bondmaster group by Prime_Sponsor_Type,SponsorName;

UPDATE work.bondmaster SET Sponsor_Type="Public"
 WHERE Prime_Sponsor_Type IN ("Federal Agencies",
                              "Non-Florida Government",
                              "Florida Government",
                              "University of FlaFoundation",
                              "University of Florida",
                              "UF DSO and Related HSC Affilia"   );  

###SELECT DISTINCT Prime_Sponsor_Type, Sponsor_Type from work.bondmaster group by Prime_Sponsor_Type, Sponsor_Type;

## ADD IP_USAGE (preliminary Safe Harbor)
Alter Table work.bondmaster Add IP_USAGE varchar(4);
SET SQL_SAFE_UPDATES = 0;

UPDATE work.bondmaster bm
SET bm.IP_USAGE="Good"
WHERE Sponsor_Type="Public";




###### Populate SAFE HARBOR DETERMINATION with Previously Determined Values
UPDATE work.bondmaster bm, space.bondmaster2019 sh
SET bm.IP_USAGE=sh.IP_USAGE
WHERE bm.Award_ID_Number=sh.Award_ID_Number;



select * from work.bondmaster;

select * from work.bondmaster;
select * from space.bondmaster;
#######################################################################################################################################################
#######################################################################################################################################################
##########################################################################################################################  EDITED TO HERE ############
#######################################################################################################################################################

## ADD UPDATE WITH CTRB_PCT AND CTRB PCT FROM PREVIOUS YEAR
ALTER TABLE work.bondmaster ADD CTRB_PCT_PREV integer; 
ALTER TABLE work.bondmaster ADD CTRB_PCT integer;  

UPDATE work.bondmaster bm, space.bondmaster2019 sly
SET bm.IP_USAGE=sly.IP_USAGE,
    bm.CTRB_PCT_PREV=sly.CTRB_PCT
WHERE bm.Award_ID_Number=sly.Award_ID_Number;

### Create exclusion Flag
Alter Table work.bondmaster ADD Include_Award Integer(1);

UPDATE work.bondmaster SET Include_Award=1;


/*
UPDATE space.bondmaster SET Include_Award=0
WHERE AWARD_ID_Number IN ("00082491","00092523");
*/



### Create Sequence (RANKS)

Drop table if exists work.SpaceRank ;
Create table work.SpaceRank as
Select t1.AWARD_INV_UFID,
       t1.AWARD_ID,	
	   count(*) as Span
from work.bondmaster AS t1
join work.bondmaster AS t2 
     on (t2.AWARD_ID, t2.AWARD_INV_UFID) >= (t1.AWARD_ID, t1.AWARD_INV_UFID)
    and t1.AWARD_INV_UFID = t2.AWARD_INV_UFID
Group by t1.AWARD_INV_UFID, t1.AWARD_ID
Order by t1.AWARD_INV_UFID, Span;

select * from work.bondmaster;


DESC work.bondmaster;
ALTER TABLE work.bondmaster MODIFY PI_DEPT varchar(45),
							MODIFY Total_Award decimal(20,2),
                            MODIFY Title Text;

## Create space.bondmaster

Drop Table space.bondmaster;
create table space.bondmaster AS
SELECT    0 AS bondmaster_key,
          bm.AWARD_ID_TYPE,
	      bm.AWARD_INV_UFID,
          sr.Span,
          bm.AWARD_ID AS AWARD_ID_Number,
          bm.AwardText AS Award_ID,
          bm.PI_LAST_NAME as LastName,
          bm.PI_FIRST_NAME as FirstName,
          bm.PI_EMAIL as EMAIL,
          bm.PI_PHONE,
          bm.PI_DEPTID,
          bm.PI_DEPT,
          bm.SponsorName,
          bm.SponsorID,
          bm.Prime_Sponsor_Type,
          bm.Sponsor_Type,
          bm.Title,
          bm.Total_Award,
          bm.IP_USAGE,
          CTRB_PCT,
          CTRB_PCT_PREV,
		  Include_Award	
          
from work.bondmaster bm
     join work.SpaceRank sr
on  (bm.AWARD_INV_UFID = sr.AWARD_INV_UFID)
and (bm.AWARD_ID = sr.AWARD_ID)
ORDER BY bm.AWARD_INV_UFID, sr.Span;


#####
select * from space.bondmaster;


###Add Index
SELECT @i:=0;
UPDATE space.bondmaster SET bondmaster_key = @i:=@i+1;


###### ADD REPORTING FIELDS TO space.bondmaster

Alter Table space.bondmaster Add Research_Revenue integer(15);
Alter Table space.bondmaster Add CTRB_Research_Revenue integer(15);
Alter Table space.bondmaster Add Good_Research_Revenue integer(15);
Alter Table space.bondmaster Add Bad_Research_Revenue integer(15);

UPDATE space.bondmaster
       SET Research_Revenue=Total_Award,
           CTRB_Research_Revenue=0,
           Good_Research_Revenue=0,
           Bad_Research_Revenue=0; 


Alter Table space.bondmaster Add IncludeInSurv integer(1);
UPDATE space.bondmaster SET IncludeInSurv=1;

select * from space.bondmaster where Lastname="Byrne" and CTRB_PCT_PREV IS NOT NULL;





select LastName, max(SPAN) from space.bondmaster group by LastName order by Max(SPAN) DESC;




## SHENKMAN PCORI
##UPDATE work.bondmaster SET IP_USAGE=NULL WHERE AWARD_ID_Number='00098554';
##UPDATE space.bondmaster SET IP_USAGE=NULL WHERE AWARD_ID_Number='00098554';
### INITIAL space.bondmaster complete   -   Next Add Survey Data
############################################################################################################# AFTER SURVEY
#######################################################################################################################################################
#######################################################################################################################################################
##########################################################################################################################  EDITED TO HERE ############
#######################################################################################################################################################





select max(length(Title)) from work.bondmaster;

