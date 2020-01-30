
DROP TABLE IF EXists work.temp; 
create table work.temp as
SELECT 	ID,
		Date_Originally_Approved,
        Approval_Date,
        Expiration_Date,
        Actual_Enrollment_Number,
        Approved_Number_Of_Subjects
from lookup.myIRB
WHERE ID in  (
             'CED000000133',
             'CED000000147',
             'CED000000209',
             'IRB201700936',
             'IRB201701577',
             'IRB201701792',
             'IRB201702025',
             'IRB201800554',
             'IRB201901369')
ORDER BY ID
             ;
             
 
DROP TABLE IF Exists work.temp2; 
create table work.temp2 as            
 select `Protocol_#`,
		`Inst._Tracking__#`,
         Approval_Date,
         Expiration_Date,
         datediff(Expiration_Date,Approval_Date) AS StudyLen,
         datediff(curdate(),Approval_Date) AS StudyElapsed,
         Active_Subjects,
         Panel 
         from lookup.wirb
 WHERE `Protocol_#` in
 (          '20121563',
            '20150020',
            '20151196',
            '20152436',
            '20152456',
            '20152521',
            '20162718',
            '20162735',
            '20170137',
            '20170246',
            '20170663',
            '20170672',
            '20170883',
            '20170941',
            '20171094',
            '20171670',
            '20172179',
            '20172631',
            '20172640',
            '20172800',
            '20172831',
            '20172935',
            '20180123',
            '20180259',
            '20180327',
            '20180584',
            '20180608',
            '20180944',
            '20180945',
            '20181390',
            '20181517',
            '20181824',
            '20182308',
            '20182519',
            '20182520',
            '20182521',
            '20190431',
            '20190486',
            '20191534',
            '20191743',
            '20192106',
            '20192109'
)
ORDER BY `Protocol_#`;
             
             

select * from lookup.myIRB;


select distinct year from lookup.blueridge_medicine;

select * from ERACommons where Name Like "%Rasmussen%";



#####################################################################################################
#####################################################################################################
select * from work.fill_ocr;

#### WIRB?
DROP TABLE IF Exists work.temp2; 
create table work.temp2 as            
 select `Protocol_#`,
		`Inst._Tracking__#`,
         Approval_Date,
         Expiration_Date,
         datediff(Expiration_Date,Approval_Date) AS StudyLen,
         datediff(curdate(),Approval_Date) AS StudyElapsed,
         Active_Subjects,
         Panel 
         from lookup.wirb
 WHERE `Protocol_#` in  (SELECT DISTINCT IRBNUM from work.fill_ocr WHERE substr(trim(IRBNUM),1,1) NOT IN ("C","I")
)
ORDER BY `Protocol_#`;



DROP TABLE IF Exists work.temp2; 
create table work.temp2 as            
 select `Protocol_#`,
		`Inst._Tracking__#`,
         Approval_Date,
         Expiration_Date,
         datediff(Expiration_Date,Approval_Date) AS StudyLen,
         datediff(curdate(),Approval_Date) AS StudyElapsed,
         Active_Subjects,
         Panel 
         from lookup.wirb
 WHERE `Protocol_#` in  (
         '20183052',
         '20190431',
         '20190486',
         '20190852',
         '20191379',
         '20191534',
         '20191743',
         '20192106',
         '20192109'
#####etc.
         
)
ORDER BY `Protocol_#`;



DROP TABLE IF Exists work.temp2; 
create table work.temp2 as            
 select `Protocol_#`,
		`Inst._Tracking__#`,
         Approval_Date,
         Expiration_Date,
         datediff(Expiration_Date,Approval_Date) AS StudyLen,
         datediff(curdate(),Approval_Date) AS StudyElapsed,
         Active_Subjects,
         Panel 
         from lookup.wirb
 WHERE `Protocol_#` in  ( )
ORDER BY `Protocol_#`;

select distinct panel from lookup.wirb;


     '20180924',
     '20151386',
     '20183095',
     '20181983',
     '20181890',
     '20172623',
     '20190637',


select min(Approval_Date), Max(Approval_Date) from lookup.myIRB;

select * from work.irb_ocr38;
SET SQL_SAFE_UPDATES = 0;
UPDATE work.irb_ocr38 SET IRB=trim(IRB);


DROP TABLE IF Exists work.temp2; 
create table work.temp2 as      
select 
ID,
Committee,
Review_Type,
Date_Originally_Approved,
Approval_Date,
Expiration_Date,
Date_First_Subject_Signed_ICF,
Actual_Enrollment_Number,
Approved_Number_Of_Subjects,
NCT_Number,
PI_Last_Name
from lookup.myIRB
WHERE ID in (select distinct IRB from  work.irb_ocr38);

select distinct IRB from  work.irb_ocr38;



select * from lookup.awards_history WHERE work.IRB18;


select * from lookup.myIRB WHERE ID ="CED000000110";


SELECT * from lookup.wirb where `Protocol_#` ="20170440";


SELECT * from lookup.Employees Where Name like "schneider%M%";

drop table if exists work.temp9;
create table work.temp9 as
Select * from lookup.wirb where `Protocol_#` IN
(     '20161353',
     '20170344',
     '20170440',
     '20172089',
     '20172226',
     '20172818',
     '20180018'
)
ORDER BY  `Protocol_#` ;

select * from lookup.awards_history WHERE CLK_AWD_PROJ_NAME like "%ABCD%";



select year, count(distinct Person_KEY)  
from lookup.roster
WHERE STD_PROGRAM="FSU"
GROUP BY year;


select year, count(distinct Person_KEY)  
from lookup.roster
WHERE Affiliation="FSU"
AND YEAr>=2015
GROUP BY year;


select Year,count(distinct Department)  
from lookup.roster
WHERE Affiliation="FSU"
AND YEAr>=2015
GROUP BY year;


Select Department,COunt(distinct Person_Key)
from lookup.roster
WHERE Affiliation="FSU"
AND YEAr>=2015
GROUP BY Department;


create table loaddata.BU_ROSTER_20200130 as select * from lookup.roster;

select Affiliation, count(distinct Person_Key) from lookup.roster 
WHERE STD_PROGRAM="FSU" 
group by Affiliation;

