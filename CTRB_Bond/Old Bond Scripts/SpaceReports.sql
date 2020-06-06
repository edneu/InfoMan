## SUNDRY DIAGNOSTICS
## Check for bad awardIDs ( usually provided Project ID Instead

select distinct Award_ID 
FROM space.space_survey_supplement ss
where Award_ID not in (select distinct Award_ID from space.BondMaster);



#  Find Project ID For OMITS prodvided as AwardID
select AWARD_ID,PS_PROJECT FROM space.SRM_ROOT
WHERE AWARD_ID IN (select distinct PROJECT_ID 
                   from space.omit_projects
                    where PROJECT_ID NOT IN (SELECT DISTINCT PS_PROJECT  FROM space.SRM_ROOT)); 



select PS_PROJECT,AWARD_INV 
from space.project_reference
where PS_PROJECT In (SELECT DISTINCT PROJECT_ID from space. OMIT_projects)
group by PS_PROJECT,AWARD_INV;


############ END OF DIAGNOSTICS







DROP TABLE space.PIs_REPORTED;
CREATE Table space.PIs_REPORTED AS
select PI,
       SUM(CTRB_Activity_Amount) as CTRB_Activity_Amount,
       SUM(Total_Award) as Total_Award_Amount,
       SUM(CTRB_Activity_Amount) / SUM(Total_Award) AS PCT_CTSB
from space.BondMaster 
where PctCTRB is not NULL
GROUP BY PI
UNION
select "Overall" as PI,
       SUM(CTRB_Activity_Amount) as CTRB_Activity_Amount,
       SUM(Total_Award) as Total_Award_Amount,
       SUM(CTRB_Activity_Amount) / SUM(Total_Award) AS PCT_CTSB
from space.BondMaster 
where PctCTRB is not NULL;


DROP TABLE space.Sponser_type;
CREATE Table space.Sponser_type AS
select SponsorType,
       SUM(CTRB_Activity_Amount) as CTRB_Activity_Amount,
       SUM(Total_Award) as Total_Award_Amount,
       SUM(CTRB_Activity_Amount) / SUM(Total_Award) AS PCT_CTSB
from space.BondMaster 
where PctCTRB is not NULL
GROUP BY SponsorType
UNION
select "Overall" as SponsorType,
       SUM(CTRB_Activity_Amount) as CTRB_Activity_Amount,
       SUM(Total_Award) as Total_Award_Amount,
       SUM(CTRB_Activity_Amount) / SUM(Total_Award) AS PCT_CTSB
from space.BondMaster 
where PctCTRB is not NULL;


DROP TABLE space.Sponser_type_all;
CREATE Table space.Sponser_type_all AS
select SponsorType,
       SUM(Total_Award) as Total_Award_Amount
from space.BondMaster 
GROUP BY SponsorType
UNION
select "Overall" as SponsorType,
       SUM(Total_Award) as Total_Award_Amount
from space.BondMaster ;
###############################################################################
###############################################################################
## TeresaL Lists

drop table space.awd_rsch;
create table space.awd_rsch as
SELECT PI,
       AWARD_ID_TYPE,
       AWARD_ID,
       PI_email,
       PI_phone, 
       Title,
       SponsorName,
       Total_Award,
       PctCTRB,       
       span,
       AWARD_INV_UFID
  from space.bondmaster
where PctCTRB=0
#and AWARD_ID NOT IN (SELECT DISTINCT AWARDID FROM space.zero_batch zb        where zb.ZeroBatch IN (1,2));
;


drop table space.proj_rsch;
create table space.proj_rsch as
select sl.Room,
	   sl.Department,
       pr.Award_ID_TYPE,
       pr.AWARD_ID,
       pr.PS_Project AS Project_id,
       pr.Project_PI_UFID as Project_UFID,
       pr.Project_PI,
       pr.Project_email,
       pr.Project_Phone,
       pr.Title,
       pr.Project_Begin_Date,
       pr.Project_End_Date,
       pr.Omit_PROJECT
from space.spacelist sl LEFT JOIN space.project_reference pr ON sl.Project_ID=pr.PS_Project
where AWARD_ID in (select distinct Award_ID from space.awd_rsch)
  AND OMIT_PROJECT=0;

### MAKE TIDY FILES

drop table space.Research_awd;
create table space.Research_awd
SELECT AWARD_ID,
       Award_ID_Type,
	   PI,
       PI_email,
       PI_Phone,
       Title,
       SponsorName,
       Total_Award,
       PctCTRB as PCT_in_CTSB,
       span,
       el.Link
       AWARD_INV_UFID
from space.awd_rsch ar LEFT JOIN space.email_links el
on ar.PI_email=el.email
order by AWARD_ID;

drop table space.Research_proj;
create table space.Research_proj as
select AWARD_ID,
       Project_ID,
       Project_PI,
       Project_email,
       Project_Phone,
       Department,
       Room,
       min(Project_Begin_Date) as Project_Begin,
       max(Project_End_Date) as Project_End
from space.proj_rsch 
Group BY  AWARD_ID,
       Project_ID,
       Project_PI,
       Project_email,
       Project_Phone,
       Department,
       Room
order by AWARD_ID;



#SELECT DISTINCT AWARD_ID from space.Research_awd;


drop table space.awd_rsch;
drop table space.proj_rsch;

###################################################################
###################################################################
## List of People who DID NOT RESPOND

DROP TABLE space.PIs_NOT_REPORTED;
CREATE Table space.PIs_NOT_REPORTED AS
select bm.PI,
	   bm.PI_email,
       bm.PI_phone,
       max(bm.span) as Num_of_Awards,
       sum(bm.Total_Award) as Total_Awarded,
       max(el.Link) as SurveyLink
from space.BondMaster bm
LEFT JOIN space.email_links el
on bm.PI_email=el.email
where PctCTRB is NULL
GROUP BY PI, PI_email, PI_phone 
ORDER BY PI;


DROP TABLE space.PIs_NOT_REPORTED_REF;
CREATE Table space.PIs_NOT_REPORTED_REF AS
select bm.PI,
	   bm.PI_email,
       bm.PI_phone,
       bm.AWARD_ID,
       bm.Title,
       bm.Total_Award
from space.BondMaster bm
LEFT JOIN space.email_links el
on bm.PI_email=el.email
where PctCTRB is NULL
ORDER BY PI;





###################################################################
###################################################################
## List of Non_federal Grants
DROP TABLE space.NON_FED;
CREATE Table space.NON_FED AS
SELECT AWARD_ID_TYPE,
       AWARD_ID,
       PI,
       Title,
       SponsorType, 
       SponsorName,
       SponsorID,
       Total_Award,
       PI_email,
       PI_phone 
FROM space.bondmaster
WHERE SponsorType IN ("FOUNDATIONS & SOCIETIES","CORPORATIONS & COMPANIES","ALL OTHER SOURCES")
ORDER BY AWARD_ID ;   
       

DROP TABLE space.Project_PI_LIST;
CREATE TABLE space.Project_PI_LIST AS
Select PS_Project AS Project_ID,
       Project_PI,
       max(Title) as Title
 from space.project_reference
GROUP BY PS_Project, Project_PI
Order By Project_PI;

DROP TABLE space.RED_ZONE;
CREATE TABLE space.RED_ZONE AS
SELECT SUM(Total_Award) AS Total_Award,
       SUM(SubAwardAmt) AS SubAwards,
	   SUM(AdjAwardAmt) as Adjusted_Award,
       SUM(CTRB_Activity_Amount) as CTRB_Activity_Amount,
	   SUM(CTRB_GoodUse_Amt) as Good_Use,
       SUM(CTRB_GoodUse_Amt) / SUM(CTRB_Activity_Amount) AS Good_Use_Proportion
from space.bondmaster;






select count(*) from space.SRM_ROOT WHERE OMIT_PROJECT=0;
select count(distinct PS_PROJECT) from space.SRM_ROOT WHERE OMIT_PROJECT=1;

select count(*) from space.SRM_ROOT;

select distinct SponsorType from space.bondmaster;


select Safe_Harbor_use, IntelProp, Count(*)
from space.bondmaster
GROUP BY Safe_Harbor_use, IntelProp;

drop table adhoc.nonmon;
create table adhoc.nonmon As
Select AWARD_ID,PI,Title,PI_email,PI_phone,SponsorName,SponsorType,span, NonMont
from space.bondmaster
where NonMont=1;

drop table adhoc.first3;
create table adhoc.first3 As
Select AWARD_ID,
       PI,
       PI_email,
       PI_phone,
       min(HaveCTRBOffice) as HaveCTRBOffice,
	   min(UseOtherCTRB) as UseOtherCTRB,
       min(PctCRTBOverall) as PctCRTBOverall
from space.bondmaster
GROUP BY AWARD_ID, PI, PI_email;



