


## Extract Key Contact Information from Pilots_Master;


DROP TABLE IF EXISTS  pilots.Contact1_2020;
CREATE TABLE pilots.Contact1_2020 AS
SELECT 	Email,
		PI_First AS FirstName,
        PI_Last as LastName,
        Award_Year,
        AwardLetterDate,
        Category,
        AwardType,
        Award_Amt,
        Pilot_ID,
        Status,
        Title
FROM pilots.PILOTS_MASTER
WHERE Status='Completed';


##################################################################
######### ADD Pilot Publicationa nd Grant Counter
##################################################################

ALTER TABLE pilots.Contact1_2020
	ADD nPubs int(2),
    ADD nAwds int(2);
    

  
SET SQL_SAFE_UPDATES = 0;    
    
UPDATE pilots.Contact1_2020 
		SET nPubs=0,    
			nAwds=0;


DROP TABLE IF EXISTS work.nPUBS;
CREATE TABLE work.nPUBS AS
SELECT Pilot_ID,
       COUNT(*) as nPubs
FROM pilots.PILOTS_PUB_MASTER
GROUP BY Pilot_ID;
      
DROP TABLE IF EXISTS work.nAWDS;
CREATE TABLE work.nAWDS AS
SELECT Pilot_ID,
       COUNT(*) as nAwds
FROM pilots.PILOTS_ROI_MASTER
GROUP BY Pilot_ID;


UPDATE pilots.Contact1_2020 pc, work.nPUBS lu
SET pc.nPubs=lu.nPubs
WHERE pc.Pilot_ID=lu.Pilot_ID;
        
UPDATE pilots.Contact1_2020 pc, work.nAWDS lu
SET pc.nAwds=lu.nAwds
WHERE pc.Pilot_ID=lu.Pilot_ID;

###
select distinct Status FROM pilots.PILOTS_MASTER;
select *  from pilots.Contact1_2020;
Select Max(nPubs), max(nAwds) from pilots.Contact1_2020;		
##

### Add fields for up to 8 previous attributed Awards and 3 publcations

ALTER TABLE pilots.Contact1_2020
		ADD AWD1 varchar(4000),
 		ADD AWD2 varchar(4000),
		ADD AWD3 varchar(4000),
		ADD AWD4 varchar(4000),
		ADD AWD5 varchar(4000),
		ADD AWD6 varchar(4000),
		ADD AWD7 varchar(4000),
		ADD AWD8 varchar(4000),
		ADD PUB1 varchar(4000),
        ADD PUB2 varchar(4000),
        ADD PUB3 varchar(4000);


/*
### CONTACT FILE
Email	FirstName	LastName	Award_Year	Category	AwardType	Award_Amt	Pilot_ID	PubYear	GrantYear	Title
*/

DROP TABLE IF EXISTS work.PilotAwds;
CREATE TABLE work.PilotAwds AS
SELECT Pilot_ID,
       Concat(CLK_AWD_PROJ_NAME,'     Sponsor: ',REPORTING_SPONSOR_NAME,"     Award ID: ",CLK_AWD_ID) AS AwdText
FROM pilots.PILOTS_ROI_MASTER
WHERE AggLevel="Award"
UNION ALL
SELECT Pilot_ID,
       Concat(CLK_AWD_PROJ_NAME,'     Sponsor: ',REPORTING_SPONSOR_NAME,"     Project ID: ",CLK_AWD_PROJ_ID) AS AwdText
FROM pilots.PILOTS_ROI_MASTER
WHERE AggLevel="Project";
;



####################


Drop table if exists work.AwdRank ;
Create table work.AwdRank as
Select t1.Pilot_ID,
       t1.AwdText,
	   count(*) as Span
from work.PilotAwds AS t1
join work.PilotAwds AS t2 
     on (t2.AwdText, t2.Pilot_ID ) >= (t1.AwdText, t1.Pilot_ID)
     and t1.Pilot_ID = t2.Pilot_ID
Group by t1.Pilot_ID, t1.AwdText
Order by t1.Pilot_id, Span;


UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD1=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=1;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD2=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=2;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD3=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=3;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD4=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=4;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD5=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=5;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD6=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=6;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD7=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=7;
UPDATE pilots.Contact1_2020 pc, work.AwdRank lu SET pc.AWD8=lu.AwdText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=8;


###############################################

### PUBLICSTIONS

#####
# UPDATE NOW COMPLIANT
Update pilots.PILOTS_PUB_MASTER SET PMCID='PMC7147813' , Citation='Brown S, Pistiner J, Adjei IM, Sharma B. Nanoparticle Properties for Delivery to Cartilage: The Implications of Disease State, Synovial Fluid, and Off-Target Uptake. Mol Pharm. 2019 Feb 4;16(2):469-479. doi: 10.1021/acs.molpharmaceut.7b00484. Epub 2018 Dec 31. PMID: 28669194; PMCID: PMC7147813' WHERE pub_master_id=66;
Update pilots.PILOTS_PUB_MASTER SET PMCID='PMC6572720' , Citation='Strekalova YA. When Trust Is Not Enough: A Serial Mediation Model Explaining the Effect of Race Identity, eHealth Information Efficacy, and Information Behavior on Intention to Participate in Clinical Research. Health Educ Behav. 2018 Dec;45(6):1036-1042. doi: 10.1177/1090198118757822. Epub 2018 Feb 24. PMID: 29478354; PMCID: PMC6572720' WHERE pub_master_id=78;

######



#####################
DROP TABLE IF EXISTS work.PilotPubs;
CREATE TABLE work.PilotPubs AS
SELECT Pilot_ID,
       Concat(Citation, "    COMPLIANT with NIH Open Access Policy") as PubText
FROM pilots.PILOTS_PUB_MASTER
WHERE PMCID NOT IN ('')
UNION ALL
SELECT Pilot_ID,
       Concat(Citation, "    NOT COMPLIANT with NIH Open Access Policy") as PubText
FROM pilots.PILOTS_PUB_MASTER
WHERE PMCID IN ('');

select * from work.PilotPubs where Pilot_ID=302;

Drop table if exists work.PubRank ;
Create table work.PubRank as
Select t1.Pilot_ID,
       t1.PubText,
	   count(*) as Span
from work.PilotPubs AS t1
join work.PilotPubs AS t2 
     on (t2.PubText, t2.Pilot_ID ) >= (t1.PubText, t1.Pilot_ID)
     and t1.Pilot_ID = t2.Pilot_ID
Group by t1.Pilot_ID, t1.PubText
Order by t1.Pilot_id, Span;


Select t1.Pilot_ID,
       t1.AwdText,
	   count(*) as Span
from work.PilotAwds AS t1
join work.PilotAwds AS t2 
     on (t2.AwdText, t2.Pilot_ID ) >= (t1.AwdText, t1.Pilot_ID)
     and t1.Pilot_ID = t2.Pilot_ID
Group by t1.Pilot_ID, t1.AwdText
Order by t1.Pilot_id, Span;








UPDATE pilots.Contact1_2020 pc, work.PubRank lu SET pc.PUB1=lu.PubText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=1;
UPDATE pilots.Contact1_2020 pc, work.PubRank lu SET pc.PUB2=lu.PubText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=2;
UPDATE pilots.Contact1_2020 pc, work.PubRank lu SET pc.PUB3=lu.PubText WHERE pc.Pilot_ID=lu.Pilot_ID AND lu.Span=3;

#############################################

select * from pilots.PILOTS_PUB_MASTER where Pilot_ID=302;
delete from pilots.PILOTS_PUB_MASTER where pub_master_id=71;