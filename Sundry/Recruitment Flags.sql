## SEE ALL THE VALUES OF RECRUITMENT METHOD - It is a compound text field
select Distinct Recruitment_Method from brian.match;

#### ADD  indicators for HealthStreet, Social Media, and Recruitment Center (which may not be an option 

Alter TABLE brian.match
	ADD HealthStreet int(1),
	ADD SocialMedia int(1),
    ADD RecruitCtr int(1);


### Initalize indicators
SET SQL_SAFE_UPDATES = 0;
UPDATE work.myirb
SET HealthStreet=0,
	SocialMedia=0,
    RecruitCtr=0;

### Set Indicator to 1     
UPDATE brian.match 
	SET HealthStreet=1
    WHERE (Recruitment_Method LIKE '%Health%Street%');

    
UPDATE brian.match 
	SET SocialMedia=1
    WHERE (Recruitment_Method LIKE '%Social%')    ;

       
UPDATE brian.match 
	SET RecruitCtr=1
    WHERE (Recruitment_Method LIKE '%Recruit%Center%');
   
    
### Dr. Flood-Grady will only be interested in the flagged records.
### For historical purposes we may want to flag the entire IRB data set, I believe this includes only the newly approved, or not previously reported.
### 

## REPORT FOR Biz
drop table if exists work.myirb;
create table work.myirb as
Select * from lookup.myirb_202302;

select distinct Method_Other_Desc from work.myirb;
select distinct Recruitment_Method_ from work.myirb;

Alter TABLE work.myirb
	ADD HealthStreet int(1),
	ADD SocialMedia int(1);




### Initalize indicators
SET SQL_SAFE_UPDATES = 0;

UPDATE work.myirb
SET HealthStreet=0,
	SocialMedia=0;


### Set Indicator to 1     
UPDATE work.myirb 
	SET HealthStreet=1
    WHERE (Recruitment_Method_ LIKE '%Health%Street%') ;

    
UPDATE work.myirb 
	SET SocialMedia=1
    WHERE Recruitment_Method_ LIKE '%Social%M%';

DROP TABLE IF EXISTS work.temp;      
create table work.temp as       
select Distinct Recruitment_Method_ from work.myirb where Healthstreet=1;

select * from work.myirb;

Select Count(*) as nRecs, count(Distinct ID) as nUndup from work.myirb;

SELECT 	Date_Originally_Approved,Year(Date_Originally_Approved) AS Orig_appr_yr from work.myirb;

/*
drop table if exists work.ud_irb;
create table work.ud_irb as
SELECT 	Year(Date_Originally_Approved) AS Orig_appr_yr,
		ID,
        max(HealthStreet) as HealthStreet,
        max(SocialMedia) as SocialMedia
FROM work.myirb
WHERE Year(Date_Originally_Approved) IS NOT NULL
GROUP BY Year(Date_Originally_Approved),ID   ;      
*/

drop table if exists work.out_irb;
create table work.out_irb as
SELECT 	Year(Date_Originally_Approved) AS Orig_appr_yr,
		Count(Distinct ID) as nProtocols,
        SUM(HealthStreet) as HealthStreet,
        SUM(SocialMedia) as SocialMedia
FROM work.myirb    
WHERE Year(Date_Originally_Approved) IS NOT NULL
GROUP BY  Orig_appr_yr;
       

drop table if exists work.out2_irb;
create table work.out2_irb as
SELECT 	* 
FROM work.myirb  
WHERE Year(Date_Originally_Approved) IS NOT NULL      
AND (HealthStreet=1 OR SocialMedia=1);
        
    
    