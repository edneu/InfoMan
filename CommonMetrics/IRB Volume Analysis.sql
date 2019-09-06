

select min(Approval_Date),max(Approval_Date) from lookup.myIRB;

select min(Date_Originally_Approved),max(Date_Originally_Approved) from lookup.myIRB;

#### nRECs ALL COMMITTEE AND REVIEW TYPES

SELECT YEAR(Approval_Date),Count(*) AS NumApp
FROM lookup.myIRB
GROUP BY YEAR(Approval_Date)
ORDER BY YEAR(Approval_Date);


SELECT YEAR(Date_Originally_Approved),Count(*) AS NumApp
FROM lookup.myIRB
GROUP BY YEAR(Date_Originally_Approved)
ORDER BY YEAR(Date_Originally_Approved);



#### n RECs IRB01, All REVIEW TYPES

SELECT YEAR(Approval_Date),Count(*) AS NumApp
FROM lookup.myIRB
WHERE Committee="IRB-01"
GROUP BY YEAR(Approval_Date)
ORDER BY YEAR(Approval_Date)
;


SELECT YEAR(Date_Originally_Approved),Count(*) AS NumApp
FROM lookup.myIRB
WHERE Committee="IRB-01"
GROUP BY YEAR(Date_Originally_Approved)
ORDER BY YEAR(Date_Originally_Approved);


#### nRECS, IRB01, Full Board

SELECT YEAR(Approval_Date),Count(*) AS NumApp
FROM lookup.myIRB
WHERE Committee="IRB-01"
AND Review_Type='Full IRB Review'
GROUP BY YEAR(Approval_Date)
ORDER BY YEAR(Approval_Date)
;



SELECT YEAR(Date_Originally_Approved),Count(*) AS NumApp
FROM lookup.myIRB
WHERE Committee="IRB-01"
AND Review_Type='Full IRB Review'
GROUP BY YEAR(Date_Originally_Approved)
ORDER BY YEAR(Date_Originally_Approved);



#### Number of IDS , IRB01, Full Board

SELECT YEAR(Approval_Date),Count(DISTINCT ID) AS NumIDs
FROM lookup.myIRB
WHERE Committee="IRB-01"
AND Review_Type='Full IRB Review'
GROUP BY YEAR(Approval_Date)
ORDER BY YEAR(Approval_Date)
;



SELECT YEAR(Date_Originally_Approved),Count(DISTINCT ID) AS NumIDs
FROM lookup.myIRB
WHERE Committee="IRB-01"
AND Review_Type='Full IRB Review'
GROUP BY YEAR(Date_Originally_Approved)
ORDER BY YEAR(Date_Originally_Approved);


SELECT COUNT(*) from lookup.myIRB;
SELECT COUNT(DISTINCT ID) from lookup.myIRB;


SELECT DISTINCT substr(ID,1,3) from lookup.myIRB;


########### CEDED 
SELECT substr(ID,1,3) AS CEDIRB,
       YEAR(Approval_Date),
       Count(DISTINCT ID) AS NumIDs
FROM lookup.myIRB
WHERE Committee="IRB-01"
#AND Review_Type='Full IRB Review'
GROUP BY substr(ID,1,3) ,YEAR(Approval_Date)
ORDER BY substr(ID,1,3) ,YEAR(Approval_Date);


SELECT substr(ID,1,3) AS CEDIRB,
       YEAR(Date_Originally_Approved),
       Count(DISTINCT ID) AS NumIDs
FROM lookup.myIRB
WHERE Committee="IRB-01"
#AND Review_Type='Full IRB Review'
GROUP BY substr(ID,1,3) ,YEAR(Date_Originally_Approved)
ORDER BY substr(ID,1,3) ,YEAR(Date_Originally_Approved);

select substr(ID,1,3) AS CEDIRB,Committee,Review_Type from lookup.myIRB group by substr(ID,1,3),Committee,Review_Type;

#
SELECT substr(ID,1,3) AS CEDIRB,
       YEAR(Date_Originally_Approved),
       avg(IRB_APPROVAL_TIME) AVGAPPDAYS
FROM lookup.myIRB
WHERE Committee="IRB-01"
AND substr(ID,1,3)="CED"
#AND Review_Type='Full IRB Review'
GROUP BY substr(ID,1,3) ,YEAR(Date_Originally_Approved)
ORDER BY substr(ID,1,3) ,YEAR(Date_Originally_Approved);


######################

SELECT Date_IRB_Received,First_Review_Date,Date_Originally_Approved,Approval_Date,PreReview_Days,IRB_APPROVAL_TIME
FROM work.myIRB
WHERE Committee="IRB-01"
AND substr(ID,1,3)="CED";


drop table if exists work.myIRB;
create table work.myIRB AS select * from lookup.myIRB;

UPDATE work.myIRB
SET IRB_APPROVAL_TIME_NOPRESCREEN = datediff(First_Review_Date, Date_IRB_Received),
    IRB_APPROVAL_TIME = datediff(First_Review_Date, Date_IRB_Received)-PreReview_Days
WHERE substr(ID,1,3)="CED"
AND Date_Originally_Approved<Date_IRB_Received;
