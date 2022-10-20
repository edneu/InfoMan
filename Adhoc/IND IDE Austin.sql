########################################################################################
########################################################################################
########################################################################################
### SHELIA AUSTIN 2022-10-13 Request

## IDE IND ROSTER
drop table if exists work.temp;
create table work.temp as
Select Year,ORIG_PROGRAM,Person_key,LastName,FirstName,Department,count(*) as nRECS from lookup.roster 
WHERE ORIG_PROGRAM LIKE "IDE%"
GROUP BY Year,ORIG_PROGRAM,Person_key,LastName,FirstName,Department
ORDER BY Year,LastName,FirstName;

/*
Investigators Specified by Shelia
Chenggou Xing,  30015156  PH-MEDICINAL CHEMISTRY
Carol Mathews 49516418  MD-PSYCHIATRY
Tanja Taivassalo 49118463 MD-PHYSIOLOGY FUNCTIONAL GENOM

*/

### EXTRACT AWARDS OF WITH SPECIFIED INVESTIGATORS AS PI
drop table if exists work.SA_awards;
create table work.SA_awards as
SELECT * from lookup.awards_history
WHERE 	CLK_PI_UFID='30015156' OR 
		CLK_PI_UFID='49516418' OR 
        CLK_PI_UFID='49118463';

### Create summary by Award
drop table if exists work.SA_AWD_Summ;
create table work.SA_AWD_Summ as
SELECT 	CLK_PI_UFID,
		CLK_AWD_PI,
        CLK_AWD_ID,
        REPORTING_SPONSOR_NAME,
        REPORTING_SPONSOR_AWD_ID,
        max(CLK_AWD_FULL_TITLE) As Award_Title,
        SUM(DIRECT_AMOUNT) AS Direct,
        SUM(INDIRECT_AMOUNT) AS Indirect,
        SUM(SPONSOR_AUTHORIZED_AMOUNT) AS TotalAmt,
        MIN(FUNDS_ACTIVATED) As EarliestAwdDte,
        MAX(FUNDS_ACTIVATED) As LatestAwdDte
FROM  work.SA_awards
Group BY CLK_PI_UFID,
		CLK_AWD_PI,
        CLK_AWD_ID,
        REPORTING_SPONSOR_NAME,
        REPORTING_SPONSOR_AWD_ID
ORDER BY CLK_AWD_PI,EarliestAwdDte;      
   
   
########################################################################################
########################################################################################
########################################################################################
####################################  EOF   ############################################

select * from lookup.college where Standard_College like "med%";