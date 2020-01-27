
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


