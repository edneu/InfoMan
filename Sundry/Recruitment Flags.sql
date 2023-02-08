## SEE ALL THE VALUES OF RECRUITMENT METHOD - It is a compound text field
select Distinct Recruitment_Method from brian.match;

#### ADD  indicators for HealthStreet, Social Media, and Recruitment Center (which may not be an option 

Alter TABLE brian.match
	ADD HealthStreet int(1),
	ADD SocialMedia int(1),
    ADD RecruitCtr int(1);


### Initalize indicators
SET SQL_SAFE_UPDATES = 0;
UPDATE brian.match
SET HealthStreet=0,
	SocialMedia=0,
    RecruitCtr=0;

### Set Indicator to 1     
UPDATE brian.match 
	SET HealthStreet=1
    WHERE Recruitment_Method LIKE '%Health%Street%';
    
UPDATE brian.match 
	SET SocialMedia=1
    WHERE Recruitment_Method LIKE '%Social%';    
    
UPDATE brian.match 
	SET RecruitCtr=1
    WHERE Recruitment_Method LIKE '%Recruit%C%';      
    
### Dr. Flood-Grady will only be interested in the flagged records.
### For historical purposes we may want to flag the entire IRB data set, I believe this includes only the newly approved, or not previously reported.
### 

    
    